Return-Path: <SRS0=qgkY=OM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB34AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 21:50:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814D161211
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 21:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 814D161211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49E4A400EA;
	Wed, 22 Sep 2021 21:50:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wjIMaCU5DEQO; Wed, 22 Sep 2021 21:50:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DB44540599;
	Wed, 22 Sep 2021 21:50:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA3EDC000F;
	Wed, 22 Sep 2021 21:50:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1680C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 21:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 719A940613
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 21:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sfO2gcUSvdpU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 21:50:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27177400EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 21:50:02 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MKdIcV006465; 
 Wed, 22 Sep 2021 21:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rHcAdxv7gbw+A9E1/mIZdVxlid4Ee7MD5bGLZ8HFD04=;
 b=fpUHSf/roVyvHt+Hec9MQ/ViiNRlXTNzHP3KHSC1lhRlao1Reelk/XZ+pF+7/c103i8l
 U+5fJtAQV599A2LWDTLGT3AaLIP2nFIw6zH4vHoyyyDabNb64Uzf3ogRXEgzTaSzcyWP
 rXZ1pkmx3sEZO/nnnWgj2jRKrYuFVs+rvAVwCY4+hmU73tcLy4D5g41uLAno1aljGC/P
 Pur6WyzlDatOXp5dPpIBo7RBJrM8JRhZMr6irj67KDZXSBh/eEnNlt4/zFsMC3HlE2RC
 lb/yGf/5ZyGzoOWbBk6gpT21H20NobnkDudNYKYJoRJgBI9alOLOyR1IMswJyykOKfbW 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4p6yeh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 21:49:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MLjbPv137684;
 Wed, 22 Sep 2021 21:49:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
 by userp3030.oracle.com with ESMTP id 3b7q5nky3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 21:49:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6sDD+lMWBDo0XoDRoyJbSnJc+JmOSR9LlEi0tdQ5fKDCxvznq2+3ISEFc2iIizF0NsWpLs8/FGwbGc9QFpkhuMzmcermWqTuP7H4yihFMd/SLDlXV3UIziANsEmN1q44vDOq3+ql98Qj102bTfT3DShCNGp6U8ElzJKhHWdyug/s61GcZKpLYFp/FnsZG1TSg9HFGuuk9mQnvQW2A28TiknFZyO1jV3wFhwaBrNpgwJMIAMiUWEmRPqPJSqWmTkiuaOUmITyMENYPoluKSd+JYyazLNx5awFp3o5GrVcEGIuNIn4HB15U8uKrVCac1fQFea9/tMvOLgjs2YGyIL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=rHcAdxv7gbw+A9E1/mIZdVxlid4Ee7MD5bGLZ8HFD04=;
 b=Od0sSRXzQZtDw8wLn2/0YkY8XZHy2qGXsMYBz3kCPWnjB8kBWAUBEjz9B/aTY6wR4n+NgR5u+wnAOIKsjH8MnD9zIFIXG8KONu6vLn2wPnxQMG/xNGDVRYRYP+ZAm4opU0koVe/5lQS3cpB++U6AnnOY9kmBXUe3AIbpifyDagDjBZnAvhgFoLL67WVDHI5V2skjqAxhGkk5wlRZu8qqfozt/JR/G8P6CMJcvlOEZTzj/jvPEbfO5wGCj/U+kgtSiLeTdt1CDG4Kv409rivZHc/Dxz287KQGEpf8Wvh4pusf04X3oC7DTUEOn5ldGRWmJ4KPqQXsgLEiaBeZpWcXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHcAdxv7gbw+A9E1/mIZdVxlid4Ee7MD5bGLZ8HFD04=;
 b=uSmzAx/elnAawLOBOTAQfC6U2t2bykHR+naKy9LSrvKgEGJD5J+HcjTl3HCSsxy4rAVshxnPMdZYJrbacF/NhvAoEntAWOPSPoo4HNyqaf8JJSzYVGXn7A/pbakaHsq4IBQ2K8v58xhWGgGfE/Thij8H+E+YeyiCSKtN6TsqENg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BLAPR10MB4866.namprd10.prod.outlook.com (2603:10b6:208:325::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 21:49:34 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f520:b987:b36e:618f]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f520:b987:b36e:618f%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 21:49:34 +0000
Subject: Re: [PATCH v2 2/2] x86/xen: switch initial pvops IRQ functions to
 dummy ones
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20210922103102.3589-1-jgross@suse.com>
 <20210922103102.3589-3-jgross@suse.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <429cdc9b-b9f1-5393-8baf-cdd2046cd65a@oracle.com>
Date: Wed, 22 Sep 2021 17:49:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210922103102.3589-3-jgross@suse.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::28) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.85.221] (138.3.201.29) by
 MN2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:208:1a0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 21:49:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1527ffbc-fa05-4bd5-2c49-08d97e12ddad
X-MS-TrafficTypeDiagnostic: BLAPR10MB4866:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48664DAC5DC31EA29E5657A48AA29@BLAPR10MB4866.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBpIAUJr9JB5y9edz13noTVW4hM4VOmlYJjVgT6r5g6z5OhlHAvLh52CvbtJUx+cEI+NdYcYM8T/kBzt7JbUoi+VZZL9niFIHxnWsceJhR0m97thLqMu4f9fsAwBbACXv1t2OkpW1v+eknTjTjp9OSwGTonCOE/vsbm6g34wHLPDVsSgiSP8/oMIMDdCvLP4Hrgj5k94/2lp2q/unF4uDhowxLQvPY779bQzGh7bN3sKjdWCik7HmnyZpl25Y5foPV2HkVMcw8vav6Wp3HmvWXYjcgUNHWunPMujxbgSilgkZl5bGEYhFWoCjUX09rcvdZ810EG4RxnHK8mwvMH168zAPtg0kj3F5xyZFd1AXYaOXJEy/MOMCVal2UYgKEiedFL0/LACcsUAJv1Z+eA2BK7IVcy/6lSJtYpxMArrnWBpZg/gAEEfCsc5lOjJpO+fSRCq3ZYAB9StUDrbnzVoFeGR+y/BlTur/QAJtmAhj/pt9TFJO+C9STnY5JYUkPkE1G+JAQNI7VpClkSWK+pJSVxiD/gSr9A6o40uEJdO7WHX4tJKcnRvFMkSxaJJPTOnIbgsnJjxVUZ3+qJOzycS8K/1v/xz6AWFX5hLC56JKE2i4HV51AYYADm1blfoJfz4Abb9bm0M2BdrhXcUHD16vikONbYcoLXm3INxqgMcswWbWLnWxAwdY+6i8TgdG9jv0iYEbfry2Odi89nJKGpPO8szDA/wjMSjfAmHnjxtL/6fMHHmuFU6BeyOo3m3PVpf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(53546011)(66946007)(66476007)(2616005)(316002)(66556008)(8936002)(16576012)(508600001)(2906002)(31696002)(7416002)(38100700002)(54906003)(44832011)(8676002)(4326008)(26005)(36756003)(186003)(5660300002)(4744005)(6486002)(956004)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejV2eHdNcHRxcFd2N2gzRXNUR2hneVFrUTBNb0NlNWJoZHRlK1J0Y21rUWly?=
 =?utf-8?B?bS9CaVo1QlRCT2QrZFF1Qzg0bWxEbzZsTkM5UThINEFITVE1OHJOalhqMUV4?=
 =?utf-8?B?ZEtPSnROdnpUOWYxTmdOVUJVTFcyaSsyc2lneVM3czdvUDNKZmRxQ04zQ0lh?=
 =?utf-8?B?VlZoOU44eHBsVHlUVDY5Y2hreUl4bU9SR2pscld0Z2VzSkNjOVU4cStxcGUw?=
 =?utf-8?B?Q3FFTk9Ua09GNkVCdCtMWlF6b0RHeXJFRllmd0tJU2V4SlhWVCtGZFVJNDNp?=
 =?utf-8?B?WnUwT1hocWZtZDhkYVY0T0dPRGxkOXdEN1JRbWhtcXZJWCtGUXl0S2NSS1VO?=
 =?utf-8?B?WjB5OUJvZnFzdmRLTVlZQ0cyVERoSllzbWlBQk14aTNlSXI2OHBzSlNPbUNz?=
 =?utf-8?B?cXBRUlZqUmxkdzcrcE5mZDJZdmhsRVkwV2orRElzSkROM2NNcmhFMHdZNVAz?=
 =?utf-8?B?SGxRbXM5MjFTRVpsSGhBQzVJREwwMUJGM1p6UU4zTjI5QkhzcnJBanN3V0p0?=
 =?utf-8?B?dkI1SkxCSHUxTWd5YzhxaEN4Szk5VnZhSVlhMHJmcUNlSkhESTN5VzJHQkhI?=
 =?utf-8?B?Z1JkN3dsaWJKbFF0YWRKK3hMZkx2S3Z0UFBvZFJVUWxXRE9yVU1nbmFLRXFQ?=
 =?utf-8?B?WlY1ay8reHZtVUFoWDdUcDdHdFhaYUlrbWE1V0xKZ1Rhb0RpeCs5SlBLRTdm?=
 =?utf-8?B?Ukh1b3RGV2doYWVWZFlEL0RwVEEvUVhLZlN3N2d3QlErNVg2Q1F1cVNCaEJh?=
 =?utf-8?B?NUhIbTVuenljcURvQkNxT00xclVZZWhVcHA1QUNHNXhHaCtkZFgxN0FyelVV?=
 =?utf-8?B?TGpBV0VzSHIydVROUzQ3N0FnUXF0UVJrQkRES29yWWhvdE9sbWhqczEvVXl5?=
 =?utf-8?B?cldwejUwVlVhY01SQm80V0lCN2I5ekprTXUzTzBkRU5YaUh2ZURuQkl1UGdl?=
 =?utf-8?B?WjFJU2h0ei8ybDBKMVQ0RGpXVERQZ2ZxRXdhVXpiZ1ZVMWp2WjJreEVlQXFK?=
 =?utf-8?B?K3NyVUpoQzBObXQvRno1NlBOWWhmUWs2Rk9PaEpNUnoyUVpXQ2pFVWViMHRB?=
 =?utf-8?B?R2xlVk41Zll6TzZ0QWVYSWU5MXBxSkhwTm1YOWVwNGlVeTZHczBkbUFIcHkw?=
 =?utf-8?B?dzhLZnR1OGNYaytNWS9BV21iM2VxdXRTcXpIa09KRXlQNTVNaUx1ZWJaeUdX?=
 =?utf-8?B?UXFycEJMYXg0Zi9TTXdPTlVIZCtUSU5iemJPb1lmRGhUdlAyRTcwNjA0R01M?=
 =?utf-8?B?cS9TajRYdzM1YTRxaU9WbnMya1JYdm1uTjVjMVV6dktlV3UvdFNPUDgxS3Fy?=
 =?utf-8?B?S2FOeDdRS3NyazN6Zzg2MG5lMytKREhGVndId3VFMC9KTkMyekRDbmRYNlRK?=
 =?utf-8?B?eG52eDZ5QS83U055dXJxMDEzblBna0VVWGUvYUs5QjgrN2RMRXpoeHowdVJV?=
 =?utf-8?B?bWkydm9XdjJ3bUZCdVYzcjJlMEtxcUpRRElDVHRycjZpTCtyanpkZkhPdFgy?=
 =?utf-8?B?Zi9XWUZJb2RJbW83YndwdDVWVi9EVGY2Q2RjTkNBT3JsVWFHNUdqNVRmZ0Nx?=
 =?utf-8?B?WUg1dlBtTklYbU8vaVdFT3MyNDBlZFNQSWtHMVpyVk1ZRDJqb3R4cXlqZFJx?=
 =?utf-8?B?T01vMVh4WVVwUzFLWnY5TW13VnZJK3JyYVRTcXdsWjc2VnBuTEJpYi9hL0h1?=
 =?utf-8?B?cGhDeERYSUt2TEFIV0ZjSmQ3eHNOL1pjODdqcW5YZktQeEExaTV2dDBZbE0z?=
 =?utf-8?Q?aE9A5rw1Aj+3lnqQkJot4Ku1pxFIoBWH7T9Mt+0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1527ffbc-fa05-4bd5-2c49-08d97e12ddad
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 21:49:34.4903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Hvj0oHi00jglKU7oAxyceL+bKWWwR0WMuvXH1WtTryDwGvZbogiUL/8UoP+tMuEVGSsfhee4i02SauGgohzXIz2uPhCW+GfnnsWSo6yVDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4866
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=945
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220139
X-Proofpoint-GUID: FXW9w2_M-W0twU8OalnHWs6mbZqAVAql
X-Proofpoint-ORIG-GUID: FXW9w2_M-W0twU8OalnHWs6mbZqAVAql
Cc: Stefano Stabellini <sstabellini@kernel.org>, peterz@infradead.org, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


On 9/22/21 6:31 AM, Juergen Gross wrote:
> The initial pvops functions handling irq flags will only ever be called
> before interrupts are being enabled.
>
> So make the __init and switch them to be dummy functions:


What are you making __init?


>  
> +/* stub always return ing 0. */


"always returning"


-boris

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
