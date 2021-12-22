Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826B0C433F5
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 07:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E6EF415D5;
	Wed, 22 Dec 2021 07:02:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E6eGTMPTx6iZ; Wed, 22 Dec 2021 07:02:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 92DD3415D4;
	Wed, 22 Dec 2021 07:02:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 293CDC001E;
	Wed, 22 Dec 2021 07:02:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 023DEC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E38AD60EE0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="R/ohit3W";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="g65YuLU/"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qp6LNeQFzSzv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:02:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED58960C0A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:02:39 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BM2YF88004573; 
 Wed, 22 Dec 2021 07:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Fq9tKPZ1bAy9SSJkB8uWEw+oYTSLw+CTd3IAIgfmgBY=;
 b=R/ohit3WMw4f1KeN6WEXMd1o8DISJw4RcSOWWkF8TmPCRXDmYlbirrXunAl1dZmPAl5R
 qgdiYuli1CDXjc3UfW5G9YPcDs4aU6rSMw+OI07MkWVpsyHQiy9jt9uj2eaXwkIWxG+S
 cMOKx4ZXIGeziVRH0SJqyJGG396TxBs0VdgoIrUCwB0QTK41O+xChTx0MCYXK1cpgN7g
 JULzQ6ydu7VyP3i3kge8EAQvgweEQzyG06b9t29YVjzK7iTIqqcZYNf4yD+ZZaUQleny
 cSZn6z+RJGDoSW7M5/pCK5jBMO+IABGGcwWIekqSjZ4oTr0+Yoyiu1ZlwHEfGp2e0jMG AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d3f4mt704-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 07:02:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BM7113C117726;
 Wed, 22 Dec 2021 07:02:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
 by userp3030.oracle.com with ESMTP id 3d14rwu13e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 07:02:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBigYZMWfXXZHXUA5hQhYZA4OHIn/yIekloANMCWlJ67scXp5+3z7YnnXcAGbQmYzbYrIs7KQ7IzgVaSx8N1fL0USOEyeVn6jJrVttUIZFxBzbdkSy3T7MBPEvlF9CbSOYA5RSLBjTcDQaOXGxnzJD6mnXmbDMedosx2jeVCI3t1nQNc4povIZksR2WGF/XwX/sHiL00cnxYlXKiina/1I0ViSf7yR4+5gLnQGyXmQPx4wIum0Nye+8WIHAr4rhBv/9OCxCX6oSvgtrXNC9JOPm3l1CBRa6oFqINO/rill/uOojL1G+Vz3b2qjcuFmM83xIGIc3yjSB+4XKNLMfTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq9tKPZ1bAy9SSJkB8uWEw+oYTSLw+CTd3IAIgfmgBY=;
 b=C2PVJQKAJqqbqqFe5GHwYG+uo5JkRAEho9vcGA1dsQdD1ge4qSbZCSkREdo/DsCcM9sOzgs6J95cSfO7ktFAJgpuxtAO6PuzvVnx1vkxFTP4EY+txF4FL04nymTiySff1GZega9/AMuOCtMiEuubjSQ7p+7XBc+0Q6bjqGF59x+d2lhkMob0qS0NozW0rktj3K23QO/ll6USGYDFmR6gWfQIpo5OmuMEkrtPrlBcbs6Urwkm20BKuKnTFSaJiui+0hJsqPHQ8chjf5onSckqaWRTtw82JBmluzz0Oc6kS359mZPBAubBXGTsxR3tbnc1bLsYEnEGLTHybZhBa9mT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq9tKPZ1bAy9SSJkB8uWEw+oYTSLw+CTd3IAIgfmgBY=;
 b=g65YuLU/MZwT78CY+Qo4eBfD5D4R2VqbZABqgz1TQaCNTJxPYYEZZDm5CByXvAU3Ihd36yL4hBFW+NdCDVHRKvfJ8OOMMhcdKv9fVjB7YlG4NgDzSmKuqTNaqJrWHs33vJGrDoWFXmXFPw3WUrP2QIm75mR6Pxu0cjqhbfHXeiM=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4195.namprd10.prod.outlook.com (2603:10b6:a03:201::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 07:02:35 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 07:02:35 +0000
Message-ID: <ad34007e-45e8-3a39-f42a-1a4b572bc0d1@oracle.com>
Date: Tue, 21 Dec 2021 23:02:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-11-elic@nvidia.com>
 <e98dfbaf-8a2d-4cd6-c875-b4780137b0f8@oracle.com>
 <PH0PR12MB54816A7E1D045997B797961BDC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB54816A7E1D045997B797961BDC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: SN4PR0501CA0093.namprd05.prod.outlook.com
 (2603:10b6:803:22::31) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 358fa03d-7cb9-4fc8-ad99-08d9c5190847
X-MS-TrafficTypeDiagnostic: BY5PR10MB4195:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB419519F2D2763B115B6B2698B17D9@BY5PR10MB4195.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39e7w0wyXjZvNzXo3Jbb0XWS/SMKHPBANFwlVyRGTwkGj2n8Lp9oSy1UBYetxchsnr/FAvmW13nhOOW9qpX+Vzd8Plu+bo2Zk+khebFnzc5wM4X9XTkflhQ0otbWNbzXuqH3AUZRWVt8Ah6UsX5rMli5otNt3gqkCVpG+7T6xewyp83lTL3OrlrNkJGNKRqZtnXtqKfDK/hV/4V0X3qMsqLbVmBPiXwB9u2pjN6i8nxrsp6GNY6MlPi9qVzJLUYV/4VYjvfRcuUgMjUhXl8bwgGswYPQh4ZNJH/5PwavGhbRV5dj6WoowuhLotGOKh08eRrjJZ/jczthc4njhSL2dW48YqZjGf8fkdCIrZnEZ4YGo7YzN+KXiiEUl3s8omZwyvlyYDd7uq6tQTyBm3dUCD66zcz96LXhIIzGAA62QwfjcX9ax/b08FFNWg/QAlJ/sqxTuy7X3AzNtmZnfkUOsR3VrfKvev2/Qkn172RzYkx6YPFXi8hnmMW0K8Q97efN+n4/OfSYCERiDB4/1ZkeLmpq7/aB/mC/I/APTNb8rfGUEcORW3oLA230atmr8ghQTlTI/TsGRvE4ENsiuLnN43fKBkuuThaFSHqv49CPTwdweER2MpRY/48XsiDjask7Ux6Ju1kfwNM9p1f03Xh2NixVzA5ShUVG2gy+xIhy+XuY4BiiIEd3WAQYqHJdGmhEJe9j5XPRK4hp6jM5T2Cqg102cz3nazm49nyA3CP8Sjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(54906003)(5660300002)(31686004)(53546011)(86362001)(6666004)(2616005)(2906002)(6506007)(110136005)(316002)(26005)(186003)(83380400001)(8676002)(4326008)(6486002)(36756003)(36916002)(8936002)(6512007)(66946007)(31696002)(66476007)(66556008)(508600001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0t3eXBPRGNVVnJKTi9CM0IvdE9NTTRLNTRLQTFrUmdZaWNnWnhKUnhZUmM3?=
 =?utf-8?B?YVRJVTZ1YS8zWmc1ZkhUcUtCa3JxQ3RhZ2cyZlhhQVN4K2prSitIU0g5N2Zo?=
 =?utf-8?B?Ynl3T0pWdWxVcUQ1Z0ticytYc2NxRk9oTkoyUG9aWnhCWlN2ZlNGaU1PL0N3?=
 =?utf-8?B?ZEJKc3JMOEpuRi94cXhzZHlHeURySW40bG5GcVo4K2dKMkthTXRUVm1sbkJM?=
 =?utf-8?B?dVM0a3oxNXdMekFOOUx4ZzIrTlFjRjVBY2dPeGZTRWNlRjJWVE1lcmpLT2Z4?=
 =?utf-8?B?YkNxbVVQTDVsbGY2R1RQYnYwa1N0TEhKSUVJR3I2aEZJbWpseHlsOXRyWEZS?=
 =?utf-8?B?MUErdHRIV0t1S1QyZFlFZ2NFdE53bHE1VlRqaDIrTU9QUEhXQ1ZTV3J5UStQ?=
 =?utf-8?B?b2I5c0d4WGVVdnB2THlsTS9YUGRLblUwN1dXc2dQMHhySGlFdTFaTEpqTnAx?=
 =?utf-8?B?T0hSUnkxL09OSFBhUUVRNENKQUVMWlBNQWdCUjZjam5RaFl2VGtMakhiZkJa?=
 =?utf-8?B?c3E4TC9kT0Z3eW9vcTlVWnJ4V2s4YkhrZDdXdS83akgxUE40MEhBeG1SWlRw?=
 =?utf-8?B?SW95Snk4N2lYOUhBaUFleE1xeGdCQjJYdzBOOGp0emY4OEVmQ0s5VmpENFVm?=
 =?utf-8?B?TVB2VHdxb0lNbFBpNGh4WGJsU0pwL2RLUFZERFJ5ek0wVXZHNUM4UGUzZFRI?=
 =?utf-8?B?RjkrL1Z6SDQ1VWJoK3h2OE1DQWZwclBiTVM4UWZ3VThZaWszS0gvV296am9m?=
 =?utf-8?B?N1NpVmVmS1VHb1AyYVE4cFBtblY3anpiNnBqTGxNOU5oZGFqNFMrOVp4STdV?=
 =?utf-8?B?UFpTR3VJTVA5VjZDVW1XcU0wRHlmZytwRlpMWFA3MjNmNGEyRXd2SWc0Zm9L?=
 =?utf-8?B?VUhoUzRFYUxLRjMybjhHS0FQWnFZamhlK0crNEtkYTdoTEI5dFdRSEs1WS9W?=
 =?utf-8?B?QUYvSno1d3phUlFUKzRsanphMnlITHo5TkExWnBmZmIyelFIczJBZUlGTnFr?=
 =?utf-8?B?aVdvTEdLTU4yUlRoOVp4VHdueUUyVjk2SXVFcHJicEdIb3JRaS9OMU96SzFa?=
 =?utf-8?B?WXhLWHphLzI4VTc3V3Z3TXpxUzhwSnBneExIOXZOdzBNWm85OHE5SEFlL3Fm?=
 =?utf-8?B?V2JSSjZ6S0lzeGorMmsyajNJdW5NUnFiQjJFUmpBR0lxL1lXa1JuQ0JaRW9R?=
 =?utf-8?B?R3M1cStXMmMrVXk1Sk5Pa0l4S2ZEazV3K1E2S2lUNzlCRFdkbnE4REFvK0lr?=
 =?utf-8?B?eU5sZXpiMFUyYWhJeGhRRXlMZE5VSTgxQVc1MHA0ZTE2OFU4L1V1RDdjNzVK?=
 =?utf-8?B?MVpJdlJiazUwT0tRZ2czZmgvT0xkbFhOMlNCNmF0anR6UlZBOXRoSmRDa3k5?=
 =?utf-8?B?cFJQb1VLd21MSGRtNWZlK3lkd2tEMy9zYWh2MVR5Z0tsSzY3YkI2VTRLL2dF?=
 =?utf-8?B?K2VJaXNRRkdENEhuY0o5OWliRUxEdWVhSWI3OG5GZjZhNlMrczBsbzM1UjVz?=
 =?utf-8?B?anRaWk0rbC9CWERQL0J4VGlxdWEzZjByd0lNakpuZDY1UW1qNmprN00veXpQ?=
 =?utf-8?B?aGI2ZHV3V3BCaDFjUm9iQWVGT1lpdDJkaGUyWUtjWkNrRHdHMkZPd1hnbGd3?=
 =?utf-8?B?K3hGWTRjTHM0Qmw4YkNaNzJHTitUTlkzUWZGNGlxaklBNVpqOG1ZeVd3S3Ba?=
 =?utf-8?B?eTFvSFJ2SHFLb1p3L0g2NlRabnJZdDhielRUMjJ5WjM1Um40WkEraTlMbzg0?=
 =?utf-8?B?c0tTc0RCSktRS3JjeGw2Ni9OaXc0VVAvc0thM2hWemhLYWJqVlhxSTg4ZUdP?=
 =?utf-8?B?eVNDTllWQ1NRei9LaHdVVEEzQXFUUjcrNDdQcU5WcHV5QmR0aXd4Y1FVdytZ?=
 =?utf-8?B?YjY4YzBMNkE3aFZqOERLVkhCVis3TW03dE05Rm1pbm02L0k3YWtkRkcxOFYv?=
 =?utf-8?B?dnZEUWppdDdDbTFBOHVLY1VESjU4OGUxZTVWZVZNbzNFUUEwRWRaVEw2Mito?=
 =?utf-8?B?OU1MTUM1RjZCYnNNRW8wbE44U2RtSkxSZEZ4Z3gvYXg0eUFNYmozSmFPTm44?=
 =?utf-8?B?Ri9kd25iSXFnZW1La093NGR2MlZEV0lFRjZweVBVemVLa1VJMHFQeXkxMWIr?=
 =?utf-8?B?NlZYeFh6MC9yUUo4bFpTV3Fxa05LVit1b3dSRE8zNXYxaVdlMngzOUxSWWR1?=
 =?utf-8?Q?m1FXdavrMzJBwFLAq01/hw4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358fa03d-7cb9-4fc8-ad99-08d9c5190847
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 07:02:35.5280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOkL+XHo7KUBWuB9dLRxzf9jcj82gYMq9nE4+t1bMBlPDeueXFoeph01tPDqu5hz7hnCBoiLuHGbth+Ndqv/Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4195
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112220041
X-Proofpoint-ORIG-GUID: u8Ij1LW2i562Bl3a0IUXZLstmIOfkIZB
X-Proofpoint-GUID: u8Ij1LW2i562Bl3a0IUXZLstmIOfkIZB
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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



On 12/21/2021 9:06 PM, Parav Pandit wrote:
>
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Wednesday, December 22, 2021 7:31 AM
>>
>> On 12/21/2021 9:20 AM, Eli Cohen wrote:
>>> Add max_supported_vqs field to struct vdpa_mgmt_dev. Upstream drivers
>>> need to feel this value according to the device capabilities.
>>>
>>> This value is reported back in a netlink message when showing
>>> management devices.
>>>
>>> Example:
>>>
>>> $ vdpa dev show
>> s/dev/mgmtdev/
>>
>> and,
>>> vdpa mgmtdev show
>> remove this line.
>>> auxiliary/mlx5_core.sf.1:
>>>     supported_classes net
>>>     max_supported_vqs 256
> It should be in same line.
> Also please show the JSON output.
>
>> Not consistent with the example in patch #11 in the series.
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/vdpa.c       | 3 +++
>>>    include/linux/vdpa.h      | 1 +
>>>    include/uapi/linux/vdpa.h | 1 +
>>>    3 files changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>>> eb223bec5209..4b649125a038 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -507,6 +507,9 @@ static int vdpa_mgmtdev_fill(const struct
>> vdpa_mgmt_dev *mdev, struct sk_buff *m
>>>    		err = -EMSGSIZE;
>>>    		goto msg_err;
>>>    	}
>>> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
>>> +			mdev->max_supported_vqs))
>> It still needs a default value when the field is not explicitly filled in by the
>> driver.
>>
> Unlikely. This can be optional field to help user decide device max limit.
> When max_supported_vqs is set to zero. Vdpa should omit exposing it to user space.
That'd be okay. I thought this field might also be useful for user to 
tell if the parent can support mq.

-Siwei

>
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -447,6 +447,7 @@ struct vdpa_mgmt_dev {
>>>    	const struct vdpa_mgmtdev_ops *ops;
>>>    	const struct virtio_device_id *id_table;
>>>    	u64 config_attr_mask;
>>> +	u16 max_supported_vqs;
> This breaks the natural alignment and create holes in the struct.
> Please move it at the last entry in the struct after list.
>
> There has been some talk/patches of rdma virtio device.
> I anticipate such device to support more than 64K queues by nature of rdma.
> It is better to keep max_supported_vqs as u32.
>
>>>    	struct list_head list;
>>>    };
>>>
>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>> index db3738ef3beb..995257c6bf2a 100644
>>> --- a/include/uapi/linux/vdpa.h
>>> +++ b/include/uapi/linux/vdpa.h
>>> @@ -44,6 +44,7 @@ enum vdpa_attr {
>>>    	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
>>>
>>>    	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>>> +	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u16 */
>>>    	/* new attributes must be added above here */
>>>    	VDPA_ATTR_MAX,
>>>    };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
