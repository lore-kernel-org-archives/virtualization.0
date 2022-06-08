Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E899C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 00:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C379461036;
	Wed,  8 Jun 2022 00:22:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2dq9uJs3ylsR; Wed,  8 Jun 2022 00:22:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CB9261021;
	Wed,  8 Jun 2022 00:22:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17ED1C0032;
	Wed,  8 Jun 2022 00:22:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55BD5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 00:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3711F845BC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 00:22:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="QVglu5qu";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="WU4ThGpV"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 44lGRinED6c9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 00:22:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDD89845AE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 00:21:59 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257MqjEZ018341;
 Wed, 8 Jun 2022 00:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=w80ux8zG+5ZBAmDmBySLEGVLCJWo5qTbzsi/K+6m+h4=;
 b=QVglu5quFT80Fqj3worfQh2fin1DjZxRDqa37JAMj3gk1myzvN7mndoAlSI16K5rezDg
 VeIoYTcIiikimH2HvXa/5XFPX0FzcLkSM4sTkzsob5AB2DAuoq7T6bcor3meafXkhPGY
 jG8KV/Ek+MROTngbrZjBk9XppB4QdoYndTMBkKb0zZQ6qPZq8NXLRorERYnSc/Isx3XL
 5D+3Pkhm5UTLoVm7wb2hD3M6HEbUgMq7wrQDZODRLWbCwrReyH/fuF818xHjneCsxQIJ
 nJ2gYF2MV4f3CSurh2P81LFhoRC3oaCHjTGSJFM82+bISR1w8cToK/ZkQ7kGPNcKJ3B5 iQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekf275-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Jun 2022 00:21:58 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 2580Gm5O023613; Wed, 8 Jun 2022 00:21:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3gfwu31yrq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Jun 2022 00:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcmtRVhTV5P+eNtOOtNuSMZ7mXqHU0AeEl8iU0D1Y5FBZ3ONRXLOgbXwa2ksurYT0mXWieRuVHq9kuorDcLTduS2uS9IpfOYdBmcpgz537amcC9elRHnOZlDKecsDdvQXJ2j9wtocMF33vNCo0qUdcKXYRHFtRMcFhAJg4g0gdLiLrJUAMX3+HObmoPnHWuoRjISseKAL5cyMGCOC4hGGYTGnf7QMzSCJOiQNLkBP3KWSXX8aEZeDbepiMendzxBVCgD8OvJK02wZLUkmCnbrKCYVB5ya0AXY8AXdAPnD2LzOODpYAnAaUJ6uIsAlF8q19WDShTfftS2V8UoL3LWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w80ux8zG+5ZBAmDmBySLEGVLCJWo5qTbzsi/K+6m+h4=;
 b=lG50IOCQWojJ794OjcxUgSWludRe9GWoXPv1fw5dAs+NdUjsbgLLGbNCqJxC2jfzB17brHDaQ4mBSHgay7wa81QhlxqVi1vvVOgXnQxEA6hjUKnxPlEGiiUVuj/Pmv66xJbx/axRsPo8yuHAl2bFxAT6L2ViyUy2UgEo2GYxybekdHab+Ldqe6imIZM3fxRW1aI0KNnpck5qosFOeBxfFnu8hUxfMhBRt/xWuzrqzAmndduX4SEv074Exb0MpHc69fu2FnSCCxbqEtYzDiRbqZupkYyQyh3ZfFdA5nefBWd2+JW5fNCLnHEYWL17kojXA4kbqWwJzEz0wD9ZjioZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w80ux8zG+5ZBAmDmBySLEGVLCJWo5qTbzsi/K+6m+h4=;
 b=WU4ThGpVPxLcV5YYP7aY+38ewTlgBANC22wD0gLUxp9POw07U/AXB0cuRu6XI59ckWRrKF7y5GafS6NJLuLlvDkMaNfSFyqHFxGkli7ZUEL6AfIaVru4SC5oT5OVofx9Cn+AdHraAEQZ36ogmNpWK370Vl/RiwE6KeRoMPXt7h0=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS7PR10MB5056.namprd10.prod.outlook.com (2603:10b6:5:3aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 00:21:55 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 00:21:55 +0000
Message-ID: <c54271aa-076d-f3c2-d064-bbd0399a70dd@oracle.com>
Date: Tue, 7 Jun 2022 17:21:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] vdpa/mlx5: clean up indenting in handle_ctrl_vlan()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <Yp71IYMP+QfuCJ8t@kili>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Yp71IYMP+QfuCJ8t@kili>
X-ClientProxiedBy: DM5PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:3:5d::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f494c92d-313d-45c9-6ad7-08da48e4e4c8
X-MS-TrafficTypeDiagnostic: DS7PR10MB5056:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5056FA9E9DC7450BBB73863AB1A49@DS7PR10MB5056.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzzgUx5i54Fke6xr1R5S8MrJrRkIaqTM5yss9GaWDA4l2L5n1qM4Zg5+3ONgyLj8N7O3M2XwkeMjpSfGZLCyIyyCKKH32RmvQqjibTpZquo+319WIG5fG6Nvrj/puDYB3ezr3wEAAxCHd6Cw/K6O6aopIAe17tamE3nTFBqKujkP4AF8kfB2A+5WfCPqGATxTciGE7wSQY97sxOVd4vcqlaTt/aOe8VMT55aLdDAdkl5MWvsHRko09A7Rpe0KGEl+eMaTB8Jg4A6MyF3DMN9SoJRIujC+kJ/SSdyBpYR7vP4wzG8f1lkMQBETBusyrsVC5hZ2AOo+uJtMbtyQ+nYxlhqSt+qnyo+ntVRYfu7myJsrydL5yDYZIfyls0c6M6mLYuZa+VtSS8aRe0mbFMR8/0oOhWgcEEALxo3Qx43FytNWppzAnQX+TBcMUAMTnma+Y+srS3jgoBIAR6aLe1QfC7rhrjhmHGMcHwTTVd2LC6faQ9lhjMe4/u/YesDjLSsvHbEbOyUM7aDxnll1liPdlwE41jxEsY7kKVu4ERJNbwH02opkNTPBzgOg+noeSRcxJP8GMbhgTZuTz33t9/H9IykFt2ji+QTZ0aVwJDMGGsdMIsOEowCM4m9DYZTlx1yfphz5MHG3Y5oU90O+dbQK76NW60QT2rEBRNy5l5JbARMZ2yZBMT1EVoKR3RgzWHMJ/qFwjFY/WlcdsJ1Av8TieGdtXoIAWik9okks6TK4eNTB6TAyMxtTpdFFVu4zHm4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(2906002)(66556008)(2616005)(8936002)(5660300002)(36756003)(186003)(26005)(316002)(83380400001)(31686004)(6512007)(110136005)(54906003)(4744005)(8676002)(38100700002)(31696002)(66476007)(66946007)(6506007)(53546011)(36916002)(6486002)(86362001)(4326008)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0VMajVZMmFIZFdsMTVXU2ltaUxoZkJlUzNaVzdQNGxvZEtDWjA3RjkyV29i?=
 =?utf-8?B?WXFsQlVIU0NhTHdtR1hKTGJKTzQvUThGanhML3Z5T1NUUCtkWk5SZlRUVkVz?=
 =?utf-8?B?Y0xoWTZub01vZE5Tb3Zsa09Ra202WnVTanZaQW5ubUlxeHZJanFqTFYwVjQ1?=
 =?utf-8?B?eWk4eDFlSm5ITmNFd2NLRlZtc1hJS2l5bVBvQVVWdTBnVEpQbFdJTGxTeHdV?=
 =?utf-8?B?U2pRTnVZQXNMOUhrQXVScVNxSC83bFc5dkhCK2JTSlZkMzh2VVpQNDdTUzA3?=
 =?utf-8?B?RGxUeU03dEZUYWFxZzJGUHZoVzcxcG1hRjNjUVZNTndWOXRvTk1ZUjc1OWRS?=
 =?utf-8?B?UkRLNytuWWhhN0pIakdWV0RvVG15enRmRUFMY2pvalg5T1VmSGNXYW1tZ043?=
 =?utf-8?B?QTdZSTMwMkNURkszYWRyQ1Z0Q2tLb3U5M0UwMTk3cUdGMUhMcG1rRUlMRmdO?=
 =?utf-8?B?QVRFR1YzRXAxWmRRMEo1bVVDL1IzZDRram5aZFc1c2FJZlByQllnbkdpUWhP?=
 =?utf-8?B?bHN1K0h4NDZlL3R6a213bXdhRlMyS3JQaDJMNEZqbGtiTkJHL2x2OFE0V1pP?=
 =?utf-8?B?Z0hUcnhsbTl1YUF0ZGIwSWcyVytBalJpOGlpazB5NFFnS0RyS1NiUnJMaHlW?=
 =?utf-8?B?QUVIVnNYQ2JuUWdBb1Jlcm1ndmk5d05HcklUK24vWXl3MXU0dlJoUFB0U3ho?=
 =?utf-8?B?LzJ4N3JDYkNZQWlhUmoya3o4Y0lZVmtFYUFCK0t0d213TGMvSlY0a3NPVms2?=
 =?utf-8?B?NkI0bXB1Smlza29MOGdMQkVONk4yQWRFZlRocWtWWGdEeG5DRnRNOG1wTC85?=
 =?utf-8?B?NXF5U3luMUVZMHMvamMwMUJONFFaeGFCSmQ2ZVQwWjBOT3l3ZnQwdStCOHJh?=
 =?utf-8?B?U1VMNWxFUll1Ym5XMUtqNDN0RTBsc0pUSWdQeEZEaEFmVDJHdnl2RC8rZzBU?=
 =?utf-8?B?Q2J0MlR6MklBVnhpZXNYSUxndURJVUFRL1QzZzlrWkZFRERKbFZsUkxNblFt?=
 =?utf-8?B?S0k5K3IvNEQvVjd0OGdZSDBIQlAvT3FhQ1VEUEo4b3JUc29KUTljUTdyaWZv?=
 =?utf-8?B?QU9icVl3dk5pYjhFUjVra2k0djNwUlFzY1UxVXlGTXFveHFMbzNnQVFYYTZ2?=
 =?utf-8?B?d2lHdkNwcnhPNkgxMzh3Sk5pVTY0V3grU2ZoOUtsdW9BTkxiVllOb0VsVEFH?=
 =?utf-8?B?eHhqbDU5QkJ3cUdDWENxM1Jzc2VZelZMdjBnQjRQanB2WHB3Q1JGb2k2M0VZ?=
 =?utf-8?B?ZjlGNmlCOFlIRE5mT0t5T1pOVExyS1pxYktDZWpPTlVGTHY5VnprbHBYZEZj?=
 =?utf-8?B?UTl2eWdKdjRDQ2ZMdzBLa3N6TktyVzJhekVXbkl6VHIwM1JUK3I1Wkx5Vm1E?=
 =?utf-8?B?NlJ6N3ZCWlZDc0JhdnNuLzRLOFJTN1lkb21OVm5wUXorREFYSUZxMmRvQ2R4?=
 =?utf-8?B?ZnRPdUtjdUVyd0JGVmFVNVhIY3ZQTEhFZ1NrYjJ1OSs5WTU1VnBiKzVZSklI?=
 =?utf-8?B?ajlhQWhLZ0Q5MG1BZzVqNXp3VmNtM2xDcG1oRjZaN296NUhYMVdmQThGYU9X?=
 =?utf-8?B?TDk4SkhqRC9MUzFQZ1c5czh6ZHQ2Z1EwbHNXckNIWHNTWXFJUGl1YmVsNXBh?=
 =?utf-8?B?MlVNd1dFYUtFL20wcE9USFNTYU5UN3pReUdaOGVXaG5iVzU2VEJWNlVoM2Jk?=
 =?utf-8?B?OU5NbFhvR242ZG0yRXc3L2IzM2lxT2xNVHBkd1ZOTXgyb0pzWUtkemlnMVc2?=
 =?utf-8?B?ZTJpRUNXVzJwVDdOM3VwbVpueHRyZk9NVmFLdGVYbmlLcDZFWUovSk8rcEpu?=
 =?utf-8?B?N0tRTFFQWStxUzZHTU9jVW8xajhsY0gzbTVVRzRZMldaUWxUY3FvY1owWTZ6?=
 =?utf-8?B?VzhmNEUrNGdGRmpmS3Vlanh4MmRqQVdFT3RyUTV2YzZhS1JtSldJSUxqcmYr?=
 =?utf-8?B?NlhIWWxUaE8zQ3BhcjVpbENNeDlKRFpOdm1CWTlOQlY0cnJvL1l6V3BSdTh0?=
 =?utf-8?B?RDdqOHV6Wjl3ZC9nc1IzeWsxb0crQzd5cC95ZkFrUzNxYlp6T1M1RXNpTGFp?=
 =?utf-8?B?dWpqdEtlN2R0ekdCR08zL1dlSGtQbFFpVzczZTNyY2JMZnUxMTRmS2hFa0xS?=
 =?utf-8?B?bW5QNjdkbmxNNnJHRXdhTVMySjNzYXg1UVdaNy9zN2pmUWFHMWRQR2FBdWxJ?=
 =?utf-8?B?Q3RwSU1ZSU9SbWtqdFgyemtlVDVLZitCOTQxT0UwdGV5TVFJN3NhWXkxUHRq?=
 =?utf-8?B?NHVWSk8rWmRybndaOHNDWU9ZTXZKWVVXRFQzMnpiRVJ1ZUthOEpCOWNpWG5i?=
 =?utf-8?B?WXZDbUZTY0FaelVoVndLc2RBYXRjQ1VneGNJTmhDaGtUbmliZ2xVSnlnMFZ2?=
 =?utf-8?Q?XgjOeZLTQIUZ7n3g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f494c92d-313d-45c9-6ad7-08da48e4e4c8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 00:21:55.6616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9Vehr2zQ/ymXk8F0QlPBzxdHpS+Y3pu7BODndYcciTkXth56QkEGnr5vlRSL1fGBoXSzlAp+bh1iLhFH6FhJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5056
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.874
 definitions=2022-06-07_11:2022-06-07,
 2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080000
X-Proofpoint-GUID: uWO8HzxJYhetebUK28H3sdHD-tn-QHOC
X-Proofpoint-ORIG-GUID: uWO8HzxJYhetebUK28H3sdHD-tn-QHOC
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 6/6/2022 11:50 PM, Dan Carpenter wrote:
> These lines were supposed to be indented.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index c964f4161d7f..83607b7488f1 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1817,10 +1817,10 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>   		status = VIRTIO_NET_OK;
>   		break;
>   	default:
> -	break;
> -}
> +		break;
> +	}
>   
> -return status;
> +	return status;
>   }
>   
>   static void mlx5_cvq_kick_handler(struct work_struct *work)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
