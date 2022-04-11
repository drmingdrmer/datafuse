// Copyright 2022 Datafuse Labs.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

use super::InFunction;
use super::IsNotNullFunction;
use super::IsNullFunction;
use crate::scalars::FunctionFactory;
use crate::scalars::IfFunction;

#[derive(Clone)]
pub struct ConditionalFunction;

impl ConditionalFunction {
    pub fn register(factory: &mut FunctionFactory) {
        factory.register_typed("if", IfFunction::desc());
        factory.register_typed("isNull", IsNullFunction::desc());
        factory.register_typed("isNotNull", IsNotNullFunction::desc());
        factory.register_typed("in", InFunction::<false>::desc());
        factory.register_typed("not_in", InFunction::<true>::desc());
    }
}
