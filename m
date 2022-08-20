Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51417C32772
	for <virtualization@archiver.kernel.org>; Sat, 20 Aug 2022 08:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFB2B60E0B;
	Sat, 20 Aug 2022 08:56:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFB2B60E0B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=HGFK7fr3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hDmPn9W/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBTJAO-06SXS; Sat, 20 Aug 2022 08:56:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4BEA60C2C;
	Sat, 20 Aug 2022 08:56:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4BEA60C2C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE343C0033;
	Sat, 20 Aug 2022 08:56:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C39BAC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Aug 2022 08:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C70B833D3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Aug 2022 08:56:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C70B833D3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=HGFK7fr3; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=hDmPn9W/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J21_nnPBtfsd
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Aug 2022 08:55:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8874383051
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8874383051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Aug 2022 08:55:57 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27K7iafJ014010;
 Sat, 20 Aug 2022 08:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yXSdLwQ8e93IJRZgUMR3j0/w1eZBFfA6OUC5pF9V/wo=;
 b=HGFK7fr3QmoHPRuQrRs1OwAT7Y8/ffKsmnWlTH+Hr8xl1+7nCztNAGWTZ46qiA3Scw4p
 dv4JPgtu9zQ8ryhU6SVINSR4jsubJzJaTRjAiREsVLUSHTS25EO02VYtUzGJ3WDPGH14
 68Cg3ZCgjHoyEaJshZ7Jq2WbBAuPlU7OTjNTs76/yvkWN0z/w7jdDlf0nP4KlQKmN2J0
 vHia6CSWQgV7h9k0kcEMmK8JY6BpKTVzYoKCgXYgc3vXqsSgNSNiSwfPRr3Qnc4iq/j2
 hEDKGB1dQ58qFASPYiDIYP96fQJv0TfvSi4PWslKuHmfP2K+YzSrHVBj7PZ6dVYfom4R Cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2ug2g4g8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Aug 2022 08:55:45 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27K8c2rh016810; Sat, 20 Aug 2022 08:55:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3j2p26dgn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Aug 2022 08:55:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YasqVDbP1iTxUdcmY8O8CPaHru5BH3CxW3I0Ex+w4+5eY9w8fk8zkGKbsIAFhORiGo/J4f48VnWLptQyczUXWJCibcoZjzWWpqfVa82zGu83Ua7yDrnpy7XyLDloLx8fzGcly0Nw3aSrhAIwPEAPtaKBM5qCNmHppPhQ+IDcJW8UQpiphYXHb7KhaUv2MAvVrcXiNl0remaRwB58mU6n4BHkpL+BPs8zd84N9ou4kbC982IhoCmpqjTj0I6Opf7PzMcx7FKCarSyCaoN1HOyPiPR16U7nSubX5kuUiLvchWLgvSRdHlr9h+5KLkmlqBmWKcPfGT6KjuPuVxVOIjZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXSdLwQ8e93IJRZgUMR3j0/w1eZBFfA6OUC5pF9V/wo=;
 b=EGBa3sdNM9efFrrcfir2OvYI7+EZRYQHKj1ICHLshAHS4tAgihrOUuekwyWxrLy1sltvUSY7uxREHm9p/T4V9+B3KS77bctmlV6QXbR94NWl5W/vgDuJu6EbCsWr3VBfKzY5Vt3vji4U/VAScGA1g1zjxOLNlxQl83Bkv6UVB/xJHGs2SnYd1beGkQhHOicZuxJkudzsVKC9Ci20Xu377Fdsh8WI7guMJWD9om2etVqK4/QG4KG5SsHrUI3/KevkCOqa+FXvV47Vxdz56g/ytyJJkLJT+nszSw7RoWcUwHIHcUAvVOBWkeXnx8c16Qed1pgp5GFuwl3T/eqziepblQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXSdLwQ8e93IJRZgUMR3j0/w1eZBFfA6OUC5pF9V/wo=;
 b=hDmPn9W/M+Hidc+NdqRpBXGZJ/umjSd1BBArvqiNJ3x/cMBaT8yZCMvwpyLgG5gubcye3oTUB1CweWpISZbhFxPvcmJNekwdUYZAjW1UVlZwIjzOWmDljTdfbzAXqPRAvfUGumXS961c1pZGPpFYVm7aDHtWiZtlO6bfqCvykck=
Received: from BN8PR10MB3283.namprd10.prod.outlook.com (2603:10b6:408:d1::28)
 by DM5PR10MB1274.namprd10.prod.outlook.com (2603:10b6:4:b::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Sat, 20 Aug 2022 08:55:40 +0000
Received: from BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::88d3:9d3:f63b:f644]) by BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::88d3:9d3:f63b:f644%7]) with mapi id 15.20.5546.019; Sat, 20 Aug 2022
 08:55:40 +0000
Message-ID: <4678fc51-a402-d3ea-e875-6eba175933ba@oracle.com>
Date: Sat, 20 Aug 2022 01:55:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
 <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
 <22e0236f-b556-c6a8-0043-b39b02928fd6@intel.com>
 <892b39d6-85f8-bff5-030d-e21288975572@oracle.com>
 <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
 <20220817045406-mutt-send-email-mst@kernel.org>
 <a91fa479-d1cc-a2d6-0821-93386069a2c1@intel.com>
 <20220817053821-mutt-send-email-mst@kernel.org>
 <449c2fb2-3920-7bf9-8c5c-a68456dfea76@intel.com>
 <20220817063450-mutt-send-email-mst@kernel.org>
 <54aa5a5c-69e2-d372-3e0c-b87f595d213c@redhat.com>
 <f0b6ea5c-1783-96d2-2d9f-e5cf726b0fc0@oracle.com>
 <CACGkMEumKfktMUJOTUYL_JYkFbw8qH331gGARPB2bTH=7wKWPg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEumKfktMUJOTUYL_JYkFbw8qH331gGARPB2bTH=7wKWPg@mail.gmail.com>
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To BN8PR10MB3283.namprd10.prod.outlook.com
 (2603:10b6:408:d1::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2ddf563-2a18-4b35-9d0c-08da8289c1f8
X-MS-TrafficTypeDiagnostic: DM5PR10MB1274:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0sNGhwiJ5To7IWfrVvuKVaHaLlyhvLyeoNZq3zW/p/br6G//LoQL8wlPFAik/HHJDuAJzPVKXqHxtyuukYmh0EBJd4pVQtQZDIjsqp8NKaVzppdnIzng23w3i+/30unKJpfEBCvMU4qh8g80sTdd6dlZryRGCqv3HpqKqxFDu5ER31970C1r+Q9MQYVvrHAI2WCIDk88ktZUZAohy2hkRNkAgYL+k+mW9dEa/iViOhcB1r1bqxjydnsOIgVd3G+sBgGzpJt2I7kGcXttbPsnO/OYnM3dmJH9TbqoPDBqs/hfPmF3sQM/cBoKKNi01q9okbwaOcQpmbK3cewB3At0OrLfttCGA2HX1yqkk/C541qqqnmL5+nFrBT9uz08dCIoqaLMbfJ+fq1CXbv8lf7hOPeRV073kS74XcnWo2QAR3Ip5iFJ15cvIti2SltVO6gvNP2WG/DmqBhq2N77k4NS0EZDoHUrEDZ/ZQZbSJ2PW2+p9kNYr8GybtntoYTmhAQBPQAUWYeXQgU1BQuOFzO5P6AiFKrDwzTUpHl4ouRXI+Mi0Xx9ngRAF57BBQVVUcm0W5RElOxtr9U8I4/a1ZooBVjTov110EeRVB/3UPvF9xsaEcvPikuSWZ6H87brQUBb6Ms5aLt+iy52ut13+FJn/QWK7ZQFrcrtlSmoo9mP3n4QshembpAZBRNgodrqmCZphaldgiUmLqG39odz+mBr6lHweTreb/uFQaFBQ6AxhGBcs9CYftAxBwJwZz7JE8uXPl495C5PasEFc+BvGLrkniMeOTlrwVCjYZBegG121Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR10MB3283.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(366004)(39860400002)(346002)(396003)(136003)(36916002)(6506007)(6666004)(53546011)(86362001)(6486002)(41300700001)(54906003)(478600001)(6916009)(316002)(31696002)(2616005)(186003)(38100700002)(6512007)(26005)(83380400001)(36756003)(4326008)(66946007)(66476007)(8676002)(5660300002)(31686004)(8936002)(66556008)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS9neG4yVnZPU3ZqYW53dTM3Sy9RS0k2MkpsU05TSDFRdzZJRmRzZWdtdkJO?=
 =?utf-8?B?S0dyZ2Jyc0QvMU1JWW5QRStONk50QTJZZTl3cXhJZUtVZVN3MWJxcy9Zd2tp?=
 =?utf-8?B?aFNsNk01VTBrWkVUVkdpdzczM291MUVUMHdDZVdySkx1WW4vQm4vUXJrVjVh?=
 =?utf-8?B?WjJtOFFhK05ZRVZJajhnOXB0ZGRLdmptVUs5amwrcS9UOGVTTjFLSWVHcHdL?=
 =?utf-8?B?K1hxQ0tsYjJVKzJVckpzODVWbGplWmZ0SHppWGM4WXM3bTVxWEorTEJNeFVr?=
 =?utf-8?B?cDViOE1TTW5Ua1hZWGk1QTZRc1FQQ3BBcG5UUmd5Z2Nld0lIRHN5OVBnMzU3?=
 =?utf-8?B?TnNtZW5Bb1RNZ1JSaFJEZ0lKTGJHYkFsZ1FiZWxBYzRTVjFsREVXTmxhbldU?=
 =?utf-8?B?N1B5NUg3dTE3eXNDTFJrWFNleVk0WDIyYkRtOHpDMDV5VDhMamhRdEdlNzlw?=
 =?utf-8?B?L1VzZUdVK0dYamIzZkZBZHErWUJNdGM4V1FiMEI5WVVsemxjeTR5cDFPYzVZ?=
 =?utf-8?B?dURoLzhjRGtmejRRNE93VkVSSFZFY2YxcFd6TXZBN0FnbWNDSWhzRDNncGph?=
 =?utf-8?B?aHZFT2JLMmVpRkJjVjVHTkNPV2hqZWN3aUtuKzZzMC90MkU4Z0xmcHA5Rm5W?=
 =?utf-8?B?d2M1dVBBWC9EejNSRzkyaWc2QzhHaUl0RUNtL1Rib2hSUzlDb253MzlDL3dF?=
 =?utf-8?B?V2hrRXNoVUJhdVVvdEwrUkJHZHV0WkZ4N1huOEptbXM4UWU0NWdyaUV6ZkVG?=
 =?utf-8?B?d2lFWFRMSTk5RFNaUEJieU1JS1RaSlFnbE8yczd3SUY4cS9rRW9KUUllcUVp?=
 =?utf-8?B?a3BreVFyaitLMVVOai83YkI2cTlKUTdvdWJqbnhMNGIwMStCcXJWS1YyS0dK?=
 =?utf-8?B?YThwY3M1NUhVNXo2M09LNUFJbnA1OUtsVkw0THg3UVJuaGg1b1c0OTVhOGd2?=
 =?utf-8?B?K1pxSUJqK1R3UTBqYUpvazQvbFF5a2JJZWlRMGF5blBnaWk0Z2lPenVFWlhl?=
 =?utf-8?B?UWZGM3ZoalBrZkcyT1pQSzVMMmtKZTBoWHlNTU1CTFRtTTJqa3R6N1BGR3pr?=
 =?utf-8?B?RTRWQyt2NXczU1lZL0k3OWd3VldIWjN1NzU3NUNsUnFwZEV2aFlxeTJBN1RV?=
 =?utf-8?B?ZmJGLzFuRU8vSjF0Q2ExOGxzbkVQMUNKUDR0WUh0QmZIYk8wRzJ4VWlsMDdD?=
 =?utf-8?B?eHZSbXg4bHJKYWFFbjhtMSs2TDZsb3JCcmhwRHAwZ0QvNVVRM3A3d0pLTlZG?=
 =?utf-8?B?b2JtK3JiYzZtTEU1amsyMjhtQmlHS3k4c3lDZTBqSWlleWhDVVV4R05qNFJI?=
 =?utf-8?B?SEdiVnhsVzZ2M2ZPbjNEVUF0Sk10bDJLYnUxNFd2YWlMN1Q3dlRPNDlCa2g0?=
 =?utf-8?B?TktIelpzRGJidDM5bmtzVWFSOVB1RzUrcS9KT1RzWUJpcHlucXM2WU55LzNU?=
 =?utf-8?B?SDgyb09KQWNkVVVOV2dCQ1NqamwrV2l2RGZNckM0NXg3amdWcUtlYXNobkFz?=
 =?utf-8?B?ejZpOVNrQTgzVnZFQUlVY2ZndDVPMnBQL2drSDdzRzFYU1F4amd6SSt4SUhi?=
 =?utf-8?B?VnhUN1NXdnJMNDBpS3JrQjZiNUc0T1VKSGtSdlFpYjZvL1pEVGxLSXN0dnYr?=
 =?utf-8?B?aG5aTm9aZ1RDc2gzM2l5WDVqR1hqZ3IyZ0FXSFhmV2FxY2xtUkY0YUQ2WmZa?=
 =?utf-8?B?WGJsVzBzK0l0K0lmNDVJaDkrVnUrZGpxTVkvWlRxcVdLNGhpZjNNa0JFY3pY?=
 =?utf-8?B?djVISzFCMFBoYUlDUmQ4alhUaVUzK0gyWDFPM1oyZzNHQXNYeWpBYzJ4QW10?=
 =?utf-8?B?WnFjSUdVM0UzTDE2WXZUTExNOEN4ZWgra1lLS2RCWGJJajhtUE80N2s2bVNZ?=
 =?utf-8?B?TEVFQnBtV0E3VjlndW9DTFNLcnBqcFFPZ2oyWHoybXVMZS9veXNHaEtPWU1s?=
 =?utf-8?B?Y3lQS3FYNkw3azhBQ2JZQ29QSUh2N292QkJrUlBjWjh3NDB4NjE3NUZZNEdw?=
 =?utf-8?B?dVN2Ty9HVkhDdTJ6VCt3SFFXRkROcG5rUVJoUFNjb1c1NmZIQTRHQVNjTjJW?=
 =?utf-8?B?NkYyUEk4Ni9pRXc2VGViOVZFL0QrTjlIbDg1YUxJVU00b0xpcVNuNWxwUlJu?=
 =?utf-8?Q?kbLKwk5rHtFphuCbYUjpr1YTv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ddf563-2a18-4b35-9d0c-08da8289c1f8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3283.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 08:55:40.5428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SF/eL8QvC3mbV8o2oQLAYFcghVcRCkXB7xdC4wPwQ98AtK3+FLmoQvOCJwpW0BoZyA8kJvMRPBESw9KUhgmCug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_05,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200035
X-Proofpoint-GUID: _3aaAMzj04opqg7d_7e2QhaMYwri-tUV
X-Proofpoint-ORIG-GUID: _3aaAMzj04opqg7d_7e2QhaMYwri-tUV
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiA4LzE4LzIwMjIgNTo0MiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBGcmksIEF1ZyAx
OSwgMjAyMiBhdCA3OjIwIEFNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3Jv
dGU6Cj4+Cj4+Cj4+IE9uIDgvMTcvMjAyMiA5OjE1IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4g
5ZyoIDIwMjIvOC8xNyAxODozNywgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPj4+PiBPbiBX
ZWQsIEF1ZyAxNywgMjAyMiBhdCAwNTo0MzoyMlBNICswODAwLCBaaHUsIExpbmdzaGFuIHdyb3Rl
Ogo+Pj4+PiBPbiA4LzE3LzIwMjIgNTozOSBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Pj4+Pj4gT24gV2VkLCBBdWcgMTcsIDIwMjIgYXQgMDU6MTM6NTlQTSArMDgwMCwgWmh1LCBMaW5n
c2hhbiB3cm90ZToKPj4+Pj4+PiBPbiA4LzE3LzIwMjIgNDo1NSBQTSwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+Pj4+Pj4+PiBPbiBXZWQsIEF1ZyAxNywgMjAyMiBhdCAxMDoxNDoyNkFNICsw
ODAwLCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+Pj4+Pj4+Pj4gWWVzIGl0IGlzIGEgbGl0dGxlIG1l
c3N5LCBhbmQgd2UgY2FuIG5vdCBjaGVjayBfRl9WRVJTSU9OXzEKPj4+Pj4+Pj4+IGJlY2F1c2Ug
b2YKPj4+Pj4+Pj4+IHRyYW5zaXRpb25hbCBkZXZpY2VzLCBzbyBtYXliZSB0aGlzIGlzIHRoZSBi
ZXN0IHdlIGNhbiBkbyBmb3Igbm93Cj4+Pj4+Pj4+IEkgdGhpbmsgdmhvc3QgZ2VuZXJhbGx5IG5l
ZWRzIGFuIEFQSSB0byBkZWNsYXJlIGNvbmZpZyBzcGFjZQo+Pj4+Pj4+PiBlbmRpYW4tbmVzcwo+
Pj4+Pj4+PiB0byBrZXJuZWwuIHZkcGEgY2FuIHJldXNlIHRoYXQgdG9vIHRoZW4uCj4+Pj4+Pj4g
WWVzLCBJIHJlbWVtYmVyIHlvdSBoYXZlIG1lbnRpb25lZCBzb21lIElPQ1RMIHRvIHNldCB0aGUg
ZW5kaWFuLW5lc3MsCj4+Pj4+Pj4gZm9yIHZEUEEsIEkgdGhpbmsgb25seSB0aGUgdmVuZG9yIGRy
aXZlciBrbm93cyB0aGUgZW5kaWFuLAo+Pj4+Pj4+IHNvIHdlIG1heSBuZWVkIGEgbmV3IGZ1bmN0
aW9uIHZkcGFfb3BzLT5nZXRfZW5kaWFuKCkuCj4+Pj4+Pj4gSW4gdGhlIGxhc3QgdGhyZWFkLCB3
ZSBzYXkgbWF5YmUgaXQncyBiZXR0ZXIgdG8gYWRkIGEgY29tbWVudCBmb3IKPj4+Pj4+PiBub3cu
Cj4+Pj4+Pj4gQnV0IGlmIHlvdSB0aGluayB3ZSBzaG91bGQgYWRkIGEgdmRwYV9vcHMtPmdldF9l
bmRpYW4oKSwgSSBjYW4gd29yawo+Pj4+Pj4+IG9uIGl0IGZvciBzdXJlIQo+Pj4+Pj4+Cj4+Pj4+
Pj4gVGhhbmtzCj4+Pj4+Pj4gWmh1IExpbmdzaGFuCj4+Pj4+PiBJIHRoaW5rIFFFTVUgaGFzIHRv
IHNldCBlbmRpYW4tbmVzcy4gTm8gb25lIGVsc2Uga25vd3MuCj4+Pj4+IFllcywgZm9yIFNXIGJh
c2VkIHZob3N0IGl0IGlzIHRydWUuIEJ1dCBmb3IgSFcgdkRQQSwgb25seQo+Pj4+PiB0aGUgZGV2
aWNlICYgZHJpdmVyIGtub3dzIHRoZSBlbmRpYW4sIEkgdGhpbmsgd2UgY2FuIG5vdAo+Pj4+PiAi
c2V0IiBhIGhhcmR3YXJlJ3MgZW5kaWFuLgo+Pj4+IFFFTVUga25vd3MgdGhlIGd1ZXN0IGVuZGlh
bi1uZXNzIGFuZCBpdCBrbm93cyB0aGF0Cj4+Pj4gZGV2aWNlIGlzIGFjY2Vzc2VkIHRocm91Z2gg
dGhlIGxlZ2FjeSBpbnRlcmZhY2UuCj4+Pj4gSXQgY2FuIGFjY29yZGluZ2x5IHNlbmQgZW5kaWFu
LW5lc3MgdG8gdGhlIGtlcm5lbCBhbmQKPj4+PiBrZXJuZWwgY2FuIHByb3BhZ2F0ZSBpdCB0byB0
aGUgZHJpdmVyLgo+Pj4KPj4+IEkgd29uZGVyIGlmIHdlIGNhbiBzaW1wbHkgZm9yY2UgTEUgYW5k
IHRoZW4gUWVtdSBjYW4gZG8gdGhlIGVuZGlhbgo+Pj4gY29udmVyc2lvbj8KPj4gY29udmVydCBm
cm9tIExFIGZvciBjb25maWcgc3BhY2UgZmllbGRzIG9ubHksIG9yIFFFTVUgaGFzIHRvIGZvcmNl
ZnVsbHkKPj4gbWVkaWF0ZSBhbmQgY292ZXJ0IGVuZGlhbm5lc3MgZm9yIGFsbCBkZXZpY2UgbWVt
b3J5IGFjY2VzcyBpbmNsdWRpbmcKPj4gZXZlbiB0aGUgZGF0YXBhdGggKGZpZWxkcyBpbiBkZXNj
cmlwdG9yIGFuZCBhdmFpbC91c2VkIHJpbmdzKT8KPiBGb3JtZXIuIEFjdHVhbGx5LCBJIHdhbnQg
dG8gZm9yY2UgbW9kZXJuIGRldmljZXMgZm9yIHZEUEEgd2hlbgo+IGRldmVsb3BpbmcgdGhlIHZE
UEEgZnJhbWV3b3JrLiBCdXQgdGhlbiB3ZSBzZWUgcmVxdWlyZW1lbnRzIGZvcgo+IHRyYW5zaXRp
b25hbCBvciBldmVuIGxlZ2FjeSAoZS5nIHRoZSBBbGkgRU5JIHBhcmVudCkuIFNvIGl0Cj4gY29t
cGxpY2F0ZXMgdGhpbmdzIGEgbG90Lgo+Cj4gSSB0aGluayBzZXZlcmFsIGlkZWFzIGhhcyBiZWVu
IHByb3Bvc2VkOgo+Cj4gMSkgWW91ciBwcm9wb3NhbCBvZiBoYXZpbmcgYSB2RFBBIHNwZWNpZmlj
IHdheSBmb3IKPiBtb2Rlcm4vdHJhbnNpdGlvbmFsL2xlZ2FjeSBhd2FyZW5lc3MuIFRoaXMgc2Vl
bXMgdmVyeSBjbGVhbiBzaW5jZSBlYWNoCj4gdHJhbnNwb3J0IHNob3VsZCBoYXZlIHRoZSBhYmls
aXR5IHRvIGRvIHRoYXQgYnV0IGl0IHN0aWxsIHJlcXVpcmVzCj4gc29tZSBraW5kIG9mIG1lZGlh
dGlvbiBmb3IgdGhlIGNhc2UgZS5nIHJ1bm5pbmcgQkUgbGVnYWN5IGd1ZXN0IG9uIExFCj4gaG9z
dC4KSW4gdGhlb3J5IGl0IHNlZW1zIGxpa2Ugc28sIHRob3VnaCBwcmFjdGljYWxseSBJIHdvbmRl
ciBpZiB3ZSBjYW4ganVzdCAKZm9yYmlkIEJFIGxlZ2FjeSBkcml2ZXIgZnJvbSBydW5uaW5nIG9u
IG1vZGVybiBMRSBob3N0LiBGb3IgdGhvc2Ugd2hvIApjYXJlIGFib3V0IGxlZ2FjeSBCRSBndWVz
dCwgdGhleSBtb3N0bHkgbGlrZSBjb3VsZCBhbmQgc2hvdWxkIHRhbGsgdG8gCnZlbmRvciB0byBn
ZXQgbmF0aXZlIEJFIHN1cHBvcnQgdG8gYWNoaWV2ZSBoYXJkd2FyZSBhY2NlbGVyYXRpb24sIGZl
dyBvZiAKdGhlbSB3b3VsZCBjb3VudCBvbiBRRU1VIGluIG1lZGlhdGluZyBvciBlbXVsYXRpbmcg
dGhlIGRhdGFwYXRoIAoob3RoZXJ3aXNlIEkgZG9uJ3Qgc2VlIHRoZSBiZW5lZml0IG9mIGFkb3B0
aW5nIHZEUEE/KS4gSSBzdGlsbCBmZWVsIHRoYXQgCm5vdCBldmVyeSBoYXJkd2FyZSB2ZW5kb3Ig
aGFzIHRvIG9mZmVyIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgCih0cmFuc2l0aW9uYWwgZGV2aWNl
KSB3aXRoIGxlZ2FjeSBpbnRlcmZhY2UvYmVoYXZpb3IgKEJFIGJlaW5nIGp1c3QgCm9uZSksIHRo
aXMgaXMgdW5saWtlIHRoZSBzaXR1YXRpb24gb24gc29mdHdhcmUgdmlydGlvIGRldmljZSwgd2hp
Y2ggaGFzIApsZWdhY3kgc3VwcG9ydCBzaW5jZSBkYXkgb25lLiBJIHRoaW5rIHdlIGV2ZXIgZGlz
Y3Vzc2VkIGl0IGJlZm9yZTogZm9yIAp0aG9zZSB2RFBBIHZlbmRvcnMgd2hvIGRvbid0IG9mZmVy
IGxlZ2FjeSBndWVzdCBzdXBwb3J0LCBtYXliZSB3ZSBzaG91bGQgCm1hbmRhdGUgc29tZSBmZWF0
dXJlIGZvciBlLmcuIFZFUlNJT05fMSwgYXMgdGhlc2UgZGV2aWNlcyByZWFsbHkgZG9uJ3QgCm9m
ZmVyIGZ1bmN0aW9uYWxpdHkgb2YgdGhlIG9wcG9zaXRlIHNpZGUgKCFWRVJTSU9OXzEpIGR1cmlu
ZyBuZWdvdGlhdGlvbi4KCkhhdmluZyBpdCBzYWlkLCBwZXJoYXBzIHdlIHNob3VsZCBhbHNvIGFs
bG93IHZlbmRvciBkZXZpY2UgdG8gaW1wbGVtZW50IApvbmx5IHBhcnRpYWwgc3VwcG9ydCBmb3Ig
bGVnYWN5LiBXZSBjYW4gZGVmaW5lICJyZXZlcnNlZCIgYmFja2VuZCAKZmVhdHVyZSB0byBkZW5v
dGUgc29tZSBwYXJ0IG9mIHRoZSBsZWdhY3kgaW50ZXJmYWNlL2Z1bmN0aW9uYWxpdHkgbm90IApn
ZXR0aW5nIGltcGxlbWVudGVkIGJ5IGRldmljZS4gRm9yIGluc3RhbmNlLCAKVkhPU1RfQkFDS0VO
RF9GX05PX0JFX1ZSSU5HLCBWSE9TVF9CQUNLRU5EX0ZfTk9fQkVfQ09ORklHLCAKVkhPU1RfQkFD
S0VORF9GX05PX0FMSUdORURfVlJJTkcsIFZIT1NUX0JBQ0tFTkRfTkVUX0ZfTk9fV1JJVEVBQkxF
X01BQywgCmFuZCBldCBhbC4gTm90IGFsbCBvZiB0aGVzZSBtaXNzaW5nIGZlYXR1cmVzIGZvciBs
ZWdhY3kgd291bGQgYmUgZWFzeSAKZm9yIFFFTVUgdG8gbWFrZSB1cCBmb3IsIHNvIFFFTVUgY2Fu
IHNlbGVjdGl2ZWx5IGVtdWxhdGUgdGhvc2UgYXQgaXRzIApiZXN0IHdoZW4gbmVjZXNzYXJ5IGFu
ZCBhcHBsaWNhYmxlLiBJbiBvdGhlciB3b3JkLCB0aGlzIGRlc2lnbiBzaG91bGRuJ3QgCnByZXZl
bnQgUUVNVSBmcm9tIG1ha2luZyB1cCBmb3IgdmVuZG9yIGRldmljZSdzIHBhcnRpYWwgbGVnYWN5
IHN1cHBvcnQuCgo+Cj4gMikgTWljaGFlbCBzdWdnZXN0cyB1c2luZyBWSE9TVF9TRVRfVlJJTkdf
RU5ESUFOIHdoZXJlIGl0IG1lYW5zIHdlCj4gbmVlZCBhIG5ldyBjb25maWcgb3BzIGZvciB2RFBB
IGJ1cywgYnV0IGl0IGRvZXNuJ3Qgc29sdmUgdGhlIGlzc3VlIGZvcgo+IGNvbmZpZyBzcGFjZSAo
YXQgbGVhc3QgZnJvbSBpdHMgbmFtZSkuIFdlIHByb2JhYmx5IG5lZWQgYSBuZXcgaW9jdGwKPiBm
b3IgYm90aCB2cmluZyBhbmQgY29uZmlnIHNwYWNlLgpZZXAgYWRkaW5nIGEgbmV3IGlvY3RsIG1h
a2VzIHRoaW5ncyBiZXR0ZXIsIGJ1dCBJIHRoaW5rIHRoZSBrZXkgaXMgbm90IAp0aGUgbmV3IGlv
Y3RsLiBJdCdzIHdoZXRoZXIgb3Igbm90IHdlIHNob3VsZCBlbmZvcmNlIGV2ZXJ5IHZEUEEgdmVu
ZG9yIApkcml2ZXIgdG8gaW1wbGVtZW50IGFsbCB0cmFuc2l0aW9uYWwgaW50ZXJmYWNlcyB0byBi
ZSBzcGVjIGNvbXBsaWFudC4gSWYgCndlIGFsbG93IHRoZW0gdG8gcmVqZWN0IHRoZSBWSE9TVF9T
RVRfVlJJTkdfRU5ESUFOwqAgb3IgClZIT1NUX1NFVF9DT05GSUdfRU5ESUFOIGNhbGwsIHdoYXQg
Y291bGQgd2UgZG8/IFdlIHdvdWxkIHN0aWxsIGVuZCB1cCAKd2l0aCBzYW1lIHNpdHVhdGlvbiBv
ZiBlaXRoZXIgZmFpbCB0aGUgZ3Vlc3QsIG9yIHRyeWluZyB0byAKbWVkaWF0ZS9lbXVsYXRlLCBy
aWdodD8KCk5vdCB0byBtZW50aW9uIFZIT1NUX1NFVF9WUklOR19FTkRJQU4gaXMgcmFyZWx5IHN1
cHBvcnRlZCBieSB2aG9zdCB0b2RheSAKLSBmZXcgZGlzdHJvIGtlcm5lbCBoYXMgQ09ORklHX1ZI
T1NUX0NST1NTX0VORElBTl9MRUdBQ1kgZW5hYmxlZCBhbmQgClFFTVUganVzdCBpZ25vcmVzIHRo
ZSByZXN1bHQuIHZob3N0IGRvZXNuJ3QgbmVjZXNzYXJpbHkgZGVwZW5kIG9uIGl0IHRvIApkZXRl
cm1pbmUgZW5kaWFubmVzcyBpdCBsb29rcy4KPgo+IG9yCj4KPiAzKSByZXZpc2l0IHRoZSBpZGVh
IG9mIGZvcmNpbmcgbW9kZXJuIG9ubHkgZGV2aWNlIHdoaWNoIG1heSBzaW1wbGlmeQo+IHRoaW5n
cyBhIGxvdApJIGFtIG5vdCBhY3R1YWxseSBhZ2FpbnN0IGZvcmNpbmcgbW9kZXJuIG9ubHkgY29u
ZmlnIHNwYWNlLCBnaXZlbiB0aGF0IAppdCdzIG5vdCBoYXJkIGZvciBlaXRoZXIgUUVNVSBvciBp
bmRpdmlkdWFsIGRyaXZlciB0byBtZWRpYXRlIG9yIAplbXVsYXRlLCBhbmQgZm9yIHRoZSBtb3N0
IHBhcnQgaXQncyBub3QgY29uZmxpY3Qgd2l0aCB0aGUgZ29hbCBvZiAKb2ZmbG9hZCBvciBhY2Nl
bGVyYXRpb24gd2l0aCB2RFBBLiBCdXQgZm9yY2luZyBMRSByaW5nIGxheW91dCBJTU8gd291bGQg
Cmp1c3Qga2lsbCBvZmYgdGhlIHBvdGVudGlhbCBvZiBhIHZlcnkgZ29vZCB1c2UgY2FzZS4gQ3Vy
cmVudGx5IGZvciBvdXIgCnVzZSBjYXNlIHRoZSBwcmlvcml0eSBmb3Igc3VwcG9ydGluZyAwLjku
NSBndWVzdCB3aXRoIHZEUEEgaXMgc2xpZ2h0bHkgCmxvd2VyIGNvbXBhcmVkIHRvIGxpdmUgbWln
cmF0aW9uLCBidXQgaXQgaXMgc3RpbGwgaW4gb3VyIFRPRE8gbGlzdC4KClRoYW5rcywKLVNpd2Vp
Cgo+Cj4gd2hpY2ggd2F5IHNob3VsZCB3ZSBnbz8KPgo+PiBJIGhvcGUKPj4gaXQncyBub3QgdGhl
IGxhdHRlciwgb3RoZXJ3aXNlIGl0IGxvc2VzIHRoZSBwb2ludCB0byB1c2UgdkRQQSBmb3IKPj4g
ZGF0YXBhdGggYWNjZWxlcmF0aW9uLgo+Pgo+PiBFdmVuIGlmIGl0cyB0aGUgZm9ybWVyLCBpdCdz
IGEgbGl0dGxlIHdlaXJkIGZvciB2ZW5kb3IgZGV2aWNlIHRvCj4+IGltcGxlbWVudCBhIExFIGNv
bmZpZyBzcGFjZSB3aXRoIEJFIHJpbmcgbGF5b3V0LCBhbHRob3VnaCBzdGlsbCBwb3NzaWJsZS4u
Lgo+IFJpZ2h0Lgo+Cj4gVGhhbmtzCj4KPj4gLVNpd2VpCj4+PiBUaGFua3MKPj4+Cj4+Pgo+Pj4+
PiBTbyBpZiB5b3UgdGhpbmsgd2Ugc2hvdWxkIGFkZCBhIHZkcGFfb3BzLT5nZXRfZW5kaWFuKCks
Cj4+Pj4+IEkgd2lsbCBkcm9wIHRoZXNlIGNvbW1lbnRzIGluIHRoZSBuZXh0IHZlcnNpb24gb2YK
Pj4+Pj4gc2VyaWVzLCBhbmQgd29yayBvbiBhIG5ldyBwYXRjaCBmb3IgZ2V0X2VuZGlhbigpLgo+
Pj4+Pgo+Pj4+PiBUaGFua3MsCj4+Pj4+IFpodSBMaW5nc2hhbgo+Pj4+IEd1ZXN0cyBkb24ndCBn
ZXQgZW5kaWFuLW5lc3MgZnJvbSBkZXZpY2VzIHNvIHRoaXMgc2VlbXMgcG9pbnRsZXNzLgo+Pj4+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
