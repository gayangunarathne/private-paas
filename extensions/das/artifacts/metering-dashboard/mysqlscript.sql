/*
 * Copyright 2005-2015 WSO2, Inc. (http://wso2.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
CREATE DATABASE ANALYTICS_PROCESSED_DATA_STORE;
CREATE TABLE ANALYTICS_PROCESSED_DATA_STORE.MEMBER_STATUS(Time long, ApplicationId VARCHAR(150), ClusterAlias VARCHAR(150), MemberId VARCHAR(150), MemberStatus VARCHAR(50));
CREATE TABLE ANALYTICS_PROCESSED_DATA_STORE.MEMBER_COUNT(Time long, ApplicationId VARCHAR(150), ClusterAlias VARCHAR(150), CreatedInstanceCount int, InitializedInstanceCount int, ActiveInstanceCount int, TerminatedInstanceCount int);
CREATE TABLE ANALYTICS_PROCESSED_DATA_STORE.MEMBER_INFORMATION(MemberId VARCHAR(150), InstanceType VARCHAR(150), ImageId VARCHAR(150), HostName VARCHAR(150), PrivateIPAddresses VARCHAR(150), PublicIPAddresses VARCHAR(150), Hypervisor VARCHAR(150), CPU VARCHAR(10) , RAM VARCHAR(10), OSName VARCHAR(150), OSVersion VARCHAR(150));
