Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE98C433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 07:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46F8960F89;
	Wed, 22 Dec 2021 07:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-cehRPuH0ac; Wed, 22 Dec 2021 07:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D252660C0A;
	Wed, 22 Dec 2021 07:03:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A58DEC001E;
	Wed, 22 Dec 2021 07:03:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93A26C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7468841578
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="EXlUgz+0";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="AouzSdYI"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K1BvxHb7Mxnb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:03:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0DFE4156C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:03:23 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BM6xMTM006645; 
 Wed, 22 Dec 2021 07:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7OXcDe2bpt9hZWTWpVB9vEOBkP4ETROQNsldKIRRd+g=;
 b=EXlUgz+0+kivWMfY8RUrIUkfvT9LFrewAm3beUpWqaymQY9oUfUNh6cBCWuM9QHPPq8f
 kGIQbMOERd5ozw3aPDnpuaOGHjVqRcgO6wCGMdy9lSKk0IDo9+gS4CCAOwZal9W+J3DY
 BgYxqJorN6L6qr4akFe+tldvJxq9hV3pUHPVTND8sdtbXpv+lcB94ai9NxK0qWBpnlZ2
 VD9g3H127jTo3nsBOMt3CbPT9TEfdx3XtMP+wqPsNO+uBp/TdDbw6aO1OfbpUzN8Wb5d
 meznQGhBOoEiZZF/hiwihQeQ3ZtWGKMOd2A0D2YHXfZSv74VCb28jmtuw7erpcZpgSJE kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2qbqwfyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 07:03:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BM70UHq148159;
 Wed, 22 Dec 2021 07:03:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by userp3020.oracle.com with ESMTP id 3d193pbd88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 07:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLACYqHSuPS8VsOMNw216OcLHruMePHb/IbKYLLIre+YWIa7rXYqoO+ceMvpD23j1E9een767TAVxKmmf5iRmlAfTYXlRRKMcMyHamQZfOrHjVHRIQkj5uVhzRWy2kFP1rVjn4uJkXzdAaUhTlP74BjAqMdE2tg+HkgGnePAuUbBEGBxVyCzhzKaWpj/ltMtvP2lpXcJCwlUj9bVztDmh2/CRpsMfJmtjzcCSA2q4L1MyQqAJpK/Ev/v/nDR+zI3zbBrGZO3wShUFkmaOamAmaQGHK/bOqMNDE+/F13vvgoYxzARrM47yKb3sS3nARDW0xQibUxqKr69vSHDUX4VyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OXcDe2bpt9hZWTWpVB9vEOBkP4ETROQNsldKIRRd+g=;
 b=mzxa9u1UTIYFp2Yqoh+mYZQeC3P26OolTt27GTgkX4LbJDMsjKSLMEqMBvW6lGO5jBMzSZjsyqKEUmTGZB7q5//8alMvzmYcuTHIRPWBq5d8VS4JSLrAWEyLA0/3aB8zl8z2HCL8iCHeZ4z98a7JVJlDjOh0T3S+m48TX/OtEyrlodGuN/N0cIBWRoPL6yZsMhfy7gimC2evx1Qn+MZUNx3XVcHa2JPQ1jWwocTr6Ba/oPhPkM5ZIFRSCrw87EACjpOZ3C89nC1A/hzNDfiiU3IKEHdV5zyyMaKjOXKCLmU7y+0Itmgg0XpeqlQ/koplNCWLAeX6veZra5YocIoSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OXcDe2bpt9hZWTWpVB9vEOBkP4ETROQNsldKIRRd+g=;
 b=AouzSdYI3U4cQrlJRxkTcWPZsF4J6giRCPYx+1xm2GBHrUbN1/LGW7Pw7jT4sQV5g9DlYM7jPNIX+9RiNnbVrAn3ZlwwUr3EBsWTfhxNg5IBhS4nUCrbvU6yCoYO6KMFh3HjaxQS7DHmDu86CKrl7s/w8TX+g29K2wTn4cqmahU=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4195.namprd10.prod.outlook.com (2603:10b6:a03:201::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 07:03:19 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 07:03:19 +0000
Message-ID: <d50bb93e-04b2-345a-fe46-24947549d51f@oracle.com>
Date: Tue, 21 Dec 2021 23:03:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 04/13] vdpa: Read device configuration only if
 FEATURES_OK
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-5-elic@nvidia.com>
 <facae337-8e0b-6c14-32de-d7a2f9d48f2c@oracle.com>
 <20211222055518.GA210450@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211222055518.GA210450@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SN4PR0501CA0091.namprd05.prod.outlook.com
 (2603:10b6:803:22::29) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c716fb0-05f6-46b1-0939-08d9c5192230
X-MS-TrafficTypeDiagnostic: BY5PR10MB4195:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB419573961CCEA69D882DEC6AB17D9@BY5PR10MB4195.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQMmIpoON3pKMb2yF0p+WeeDuzHfXaTMYu73H59uuCIZGQ+v9FNC4ImortJfjssAjhoO4bJjLKDembzBLkJ6k1VoQql/mOPKJGly2afW2fMprXmclZWbkJMbJrjKAAcciA5+vFjVLPrPApSO8rv4HQcPmnmuiG4wh+cplMALE9pyDNiSYLx1NOltdASlNKjp2PJfRTu8vFOWzzgJn6IbCmYQ4xWtJoPR+0uxXFOYBCqD1TRWctjEt9cgVDLJS5lN8/sza49yBfqmmknnipfa8PyPSZ4SO6oU8mlQm8wo5xaOCZzLw1u7Oxg0Th3U826n7zyG951OWm2eD1NuVVuXVzsOjUNqhXXAJOROg3b3ltI86lT5yaDPVqbSaYtFZgL1mheCff0e9AhqSCEPP+qSiJxtT6o2XA3CgxZ+qHQlr+01jIzQffWzhSQepgd2K1f5I14J+el46HTHqM3s3pF+AvU+vTi+RwOD7JtNI4h1jrOLSBaMneVRhyCU5CQCD/VInkk6VjkD25RjBU0Ru8c7CBtq+1V85npzDWC4w/c+axd7XJUWF/hntGyiUcZCmTZLC/fSJdAxHUZCWBLZIfBPDVc+/H1z3dcqH0okVRmfiSxUbKmNkHVGIfSmbTObgk0CjVVPyj0cW6pdBlF5t20rQ52Nq6AqeKQrL+CvzeueSglLrswuBfpWBNLtI9Zra7Bm44O3gP0AyA4Wb4L7nFqT0c0omRrnGaR/uYkvq/oWtLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(5660300002)(31686004)(6916009)(53546011)(86362001)(6666004)(2616005)(2906002)(6506007)(316002)(26005)(186003)(83380400001)(8676002)(4326008)(6486002)(36756003)(36916002)(8936002)(6512007)(66946007)(31696002)(66476007)(66556008)(508600001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1pMbzFicGhyUHp1ZTQ0SFVzR0tiR1BxZ01vYWNTWHJQQTVoTVJaVkVtVEtu?=
 =?utf-8?B?VmtzdVB3eE11WU1oemE4RXpvRFVXVFhhOHlkZm9zL2t1UXk0NlZvZUlyd1RH?=
 =?utf-8?B?S1luTVQ3SmFaNmppZXVXUjN4cmVMdEJIbU00L3BWdWlMaTdJU1grbTRMb0c3?=
 =?utf-8?B?Wm5jRFQvZ1pybTc0UEhuMnlrbjY0UHkyUitRK0N0S1RUMTRYWkNOTmF2WDl1?=
 =?utf-8?B?OE5QaDY3dWVDVURCc3pGVnY0NldkTTh3OW9UV0s1cmtKUXpJeVJJYUZhczVl?=
 =?utf-8?B?RUJZMXAwM3JHMlY5a0tQeUorQXNqM2NoaWJ5NlAra2tIOGJMQW5NTDU0eGpz?=
 =?utf-8?B?dzJBRzR1bmIwNmJXRnRTOFNqc1VJTFJxdGJ0YWpLM3JyRlFzc1dQSzdOdE5i?=
 =?utf-8?B?aWtXakZ4OW1kY05RZnFHQTI2K1dXc3ZhOFJNdXgycUkxVmZkdHhDVnJ4VlNv?=
 =?utf-8?B?dzY4M1NJYUFqb0V4TFljUVA2R3padHQ1NjJjUnR3Um1MOVlvNzY4b0VIamZ6?=
 =?utf-8?B?SzMwQ05OeU5veitva2x1Y1VoOVp3UENOVTFCbEZKay9yL21tRjNBTk9QV1ND?=
 =?utf-8?B?dUF6dkxUOUVTTUFBcTZUV1BFbktqcGwwWlNWSTBzanhVWlNRUkdlYS83Z3J1?=
 =?utf-8?B?bGNqVnAwd2tKMzVVWXAyMVJBWCt6ODh0cGZrdWs3YmhVSTNVTXBLTHdBTzhH?=
 =?utf-8?B?RXU5NnhFM3NoeWsrWGg3RkZ4MFVFVHB1YWFEMy9rYkxiK3NxaDUybkZMcEFB?=
 =?utf-8?B?QWlybWVxcUxaQmJMb0U5dFdRV29pOEhvVWxuajJQckNjallHakhpWExHRXZY?=
 =?utf-8?B?aDVNcENuenNoNHJIbk1SaXJrYTd1YUI0bms1OEQ0N3JZa3psZWx4WXBXeHF3?=
 =?utf-8?B?dHhqVEpGSHEwNEJIU2p5UVlMNy9aOG1sK0w4dDYzRXEzOE5iYTArNzlCK2Qr?=
 =?utf-8?B?WFJKV3ljaWdOM3kyRS9mNTZrVjBQWUVRbXJ6VFRvcDZXOHZPOTZmUXU5NUcx?=
 =?utf-8?B?d3N3NW1TcTZWMmwzN3ZVYnV6T0hmSnFhUXhQSTVWMnRVT3JnUVBuUE9rL0Fh?=
 =?utf-8?B?a0V3WnNZeFBXa0c3MlJxSEt4MmMreW1FN1V1dzBOQW11MnhUREozNTJMck5n?=
 =?utf-8?B?YXZ5SEhxNUo0OWU0V0VWUmNlMHFxUEZrZDkzQjVOanVGSlhLLzhibWZ6anFB?=
 =?utf-8?B?S3BhcTJFMmxDcTg5WDZzVXhpd210MmhnSGdUV3p6QkN0eFl1REplS2xIZ2NC?=
 =?utf-8?B?ckh5YzFtSXdiZFBoMUxna2Y3ZU15TG1CalNrdDM2VC94M0hmSXA3SHhTSVpO?=
 =?utf-8?B?d2lNUDFEcEVVRzh4a1FRYWF4Q1FkM1l6c3ZacWM3SE5rSkdwOHp5Lyt0TlFz?=
 =?utf-8?B?T2dEd0JEWWtybmUraDgrTWkyTWQ2WS9iNVVDUXVsUVdxbFF0cFNlc0p5U2Vj?=
 =?utf-8?B?VXI1VGRlYlFMUUtaUk9OcW9lWCtvK0lUZmd3TlJkeE5kSGY2MWQzajEwK3Vw?=
 =?utf-8?B?TDNQSmJUa0Z2OU9Cb2tjd1VzMVR0Q0poN2xhNU9rVFNDemtMaUpLWXREVjlq?=
 =?utf-8?B?dmZvTTZscGpxQ1lwOGF6dVpPOE81aW5XRjJBY2VMS3hza3kzd3pNLzJmUysv?=
 =?utf-8?B?MVMyNG05Y0EzUHpUOXVQdE4yR2RGeS9BNXFXWWc0SmhzRkFES2FKV25IL0J1?=
 =?utf-8?B?R3pIUDAvckQ2ZzZEM1RjWGtQbkFZTjhtNHBsOEVlVkFqZFlmVGhLZDhXd2t0?=
 =?utf-8?B?S1pJZzJ3ZCtsSUo2Qml0eVhreGxnOXVuTkxkK2RCS25lckZ5RUxUTm1pZU0v?=
 =?utf-8?B?Vk9GSGdFc1pQdG1aRk5KMjE2K01vM2FxMmRyNDV5ZUpyVEFYSW1kbVM0Ym0r?=
 =?utf-8?B?Z0ZLWDQxS29iOVB6dmswSUpVUDVxQVJPdzlDelFkQVdyYUtaZGY5Qk5Gdlh5?=
 =?utf-8?B?NldvU1J2ZHpUclBqR0UxajVFNE5MOVhVSngxN0pSaFQ3M0xlT3BjK3ZXVDE0?=
 =?utf-8?B?cFhzTlh6QlNFZXE5Sk1KRnAzNDRDeUxKTTJmVHhTRDlKWjRJaUlUSGF1NGtP?=
 =?utf-8?B?RmxjcncrR0hoK0EzOUh1TjhQamlab1BWSDdCWHkwZmQ1cTBoeGQzcFBWVGx5?=
 =?utf-8?B?MXVFZlBQRy9iRGlqbWlzallnOTdDT1VDRWNPZmNaeDNkYlJhNFVpaVVpQURm?=
 =?utf-8?Q?dD8NdHD9XWM4br7lV/5EIEM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c716fb0-05f6-46b1-0939-08d9c5192230
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 07:03:18.9469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kui4xCm1zFIW6MEOS0ca1r+yryh4yrUWJpthJ8RXc+/rA49t8zeLb3sxkxH9nD0QcXyahJpEsBR1B68jB7o4ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4195
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220041
X-Proofpoint-ORIG-GUID: Y9d5UYa6TLJwYHsg7p6M_5ir2zgE35cp
X-Proofpoint-GUID: Y9d5UYa6TLJwYHsg7p6M_5ir2zgE35cp
Cc: lvivier@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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



On 12/21/2021 9:55 PM, Eli Cohen wrote:
> On Tue, Dec 21, 2021 at 05:55:56PM -0800, Si-Wei Liu wrote:
>>
>> On 12/21/2021 9:19 AM, Eli Cohen wrote:
>>> Avoid reading device configuration during feature negotiation. Read
>>> device status and verify that VIRTIO_CONFIG_S_FEATURES_OK is set.
>>>
>>> Otherwise, return -EAGAIN.
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/vdpa.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 5134c83c4a22..3285cebd89c0 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -838,8 +838,18 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>>>    {
>>>    	u32 device_id;
>>>    	void *hdr;
>>> +	u8 status;
>>>    	int err;
>>> +	mutex_lock(&vdev->cf_mutex);
>>> +	status = vdev->config->get_status(vdev);
>> Atomicity and data consistency not guaranteed against vdpa_get_config and
>> get_features in vdpa_dev_net_config_fill(). Need to use coarse locking.
> Your concern is that vdpa_get_config() is vdpa_dev_net_config_fill
> () is not being read under the lock?
Not exactly. vdpa_get_config() is already in the cf_mutex lock. However, 
the config data may become invalid getting out of the FEATURES_OK check, 
as theoretically it's possible the guest could change the config via 
set_config(), set_status(), or reset() in between. You'd need to use a 
single cf_mutex to protect almost the whole code block in 
vdpa_dev_config_fill() to ensure data consistency.

-Siwei
>
> I will put it under the lock.
>
>> -Siwei
>>> +	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "Features negotiation not completed");
>>> +		mutex_unlock(&vdev->cf_mutex);
>>> +		return -EAGAIN;
>>> +	}
>>> +	mutex_unlock(&vdev->cf_mutex);
>>> +
>>>    	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>>    			  VDPA_CMD_DEV_CONFIG_GET);
>>>    	if (!hdr)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
