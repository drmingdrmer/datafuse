//  Copyright 2022 Datafuse Labs.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

use common_expression::DataBlock;

/// Filter data of a Block, which itself is also a DataBlock.
///
/// Depending on the query conditions, columns of index data will be loaded on demand.
#[allow(dead_code)]
pub struct BlockFilter {
    // Before index mod is extracted from databend-query, we just keep the DataBlock here
    data: DataBlock,
}
