/**
 * The MIT License
 *
 *   Copyright (c) 2016, Mahmoud Ben Hassine (mahmoud.benhassine@icloud.com)
 *
 *   Permission is hereby granted, free of charge, to any person obtaining a copy
 *   of this software and associated documentation files (the "Software"), to deal
 *   in the Software without restriction, including without limitation the rights
 *   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *   copies of the Software, and to permit persons to whom the Software is
 *   furnished to do so, subject to the following conditions:
 *
 *   The above copyright notice and this permission notice shall be included in
 *   all copies or substantial portions of the Software.
 *
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *   THE SOFTWARE.
 */
package io.github.benas.jcql.core;

import com.github.javaparser.ast.body.FieldDeclaration;
import com.github.javaparser.ast.body.VariableDeclarator;
import io.github.benas.jcql.domain.FieldDao;
import io.github.benas.jcql.model.Field;

import java.util.List;

import static java.lang.reflect.Modifier.*;

    public class FieldIndexer {

    private FieldDao fieldDao;

    public FieldIndexer(FieldDao fieldDao) {
        this.fieldDao = fieldDao;
    }

    public void index(FieldDeclaration fieldDeclaration, int typeId) {
        int fieldModifiers = fieldDeclaration.getModifiers();
        List<VariableDeclarator> variables = fieldDeclaration.getVariables();
        for (VariableDeclarator variable : variables) {
            String name = variable.getId().getName();
            fieldDao.save(new Field(name, fieldDeclaration.getType().toString(),
                    isPublic(fieldModifiers), isStatic(fieldModifiers), isFinal(fieldModifiers), isTransient(fieldModifiers), typeId));
        }
    }

}
