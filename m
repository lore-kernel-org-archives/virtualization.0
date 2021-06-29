Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C037EC11F67
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 16:54:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584A661988
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 16:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584A661988
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FDB8404E3;
	Tue, 29 Jun 2021 16:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQbtxxEUNOMz; Tue, 29 Jun 2021 16:54:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 99930404F1;
	Tue, 29 Jun 2021 16:54:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76047C0010;
	Tue, 29 Jun 2021 16:54:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E838EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 16:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA3B66081C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 16:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="mjSrYom/";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Ysj1NwFD"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXr_hh8U14XO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 16:53:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C76C6062C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 16:53:57 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15TGq83G022257; Tue, 29 Jun 2021 16:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BzxtDvxCCJ78MOhOdtgN3Tjz/f9QTECpJvlbCO6INlc=;
 b=mjSrYom/VOJ4ojGVTn+5AtWgKkRWdaRTpDarMzvzOHdUYCko0zyAOhXSPbEwE+s3u5rD
 d/JaxQiOs++PBqOFY8SHKTuFwf+OcpjOi2Bhu/V/hEMCr9yQMPxXmdYg7wDVh5F47ICW
 IRjKNqKgXtttpw0TAemGEulIC8y9pyW4Nb80aT93gKrCYnXrXTKbE0anfpt8ULWhlGqz
 ZlYU7bB7XCJYMmcOjMaChOFtoBz/R4dQptN9fax5t+DGbg62JvuTYOodqI+Ha5EqsPxQ
 MeDko/G2+WvdGhHJqYi5rpmM1dpGknkpXilB0gfcDNIIxnUsNRXwmlKHzxqG1sUA8Whz /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 39f6pqc41v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Jun 2021 16:53:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15TGjtPx185214;
 Tue, 29 Jun 2021 16:53:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by userp3020.oracle.com with ESMTP id 39ee0v8rj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Jun 2021 16:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpu1HD259zyw37McYxR5LZCiZNS2lvsVAL/BblQzQ+LWuhdEi9s3BU8ztUKKg9S5rSXQReaxxzl/fBgEbEPiynLlPOJBcMV7OgNO/jiZp1O3MB0oyA2S/XPj/RzrsVEG+GCEgxLtiCOXx5QK8NQj6XS7I8/Esgkfl9AVX0csXPeZMznomhy8iL2YewCPQNfjozzynNhZmyiLqpCTwrOuwYmvFP1ARwnmGrhSuUbhsLKwSV3jysAdlX4nfTEgnIo+9JRTOGBEdZJcKvV399SWM6XP+1iOofejnhtU4J72IHPHeDygrI8AJj0uoZ1v0PyVvJGQsfSCkbulMC2bypl34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzxtDvxCCJ78MOhOdtgN3Tjz/f9QTECpJvlbCO6INlc=;
 b=UJ1gemFkkrpnTx1uB/3YpPf30lY18ynT+/LU70S2dsL7Wn7SmzXo38HL0JYzBCiwyqfep+78/K+ZrsQ18p0YQaGpSWmnLVzXCnFV4BY0Jn17LhOAroaqGQBhxWvHYmVLsdkiSuBHSU57VsUPy8Dv+wF3qvBbZWlguvrQQZ+M7whsDSEI/FgVhLlPFyGQyePbgxj/2JynFGUcL9kK5cbC4PK8pBb+NUHJDZajasQUaynrHuX3uNmYLQONz9zrsm6PLyTkK2iNryh42LoVFSJNL5rqwO29XdjT5Z4fbI+n+y7V2cDbIHXrWrYicgjxI81W/nJItPqN7zLHGEj9gHTs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzxtDvxCCJ78MOhOdtgN3Tjz/f9QTECpJvlbCO6INlc=;
 b=Ysj1NwFD//pAA/2vGazeS16aef63b/9Qu0Dyz4/PuU9Ztd2qH2R7bpYS8912ymKu/wwLRIIlTQNTDEGuA28lJszjjpa03RU7ZIi/azbDkF0wXJiARrxMKtv/KVIxFXPR25+oQu1PqcjI6hLfbGX7e828m5Udl9AYgGyAo+IABmI=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 16:53:42 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0%7]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 16:53:42 +0000
Subject: Re: [PATCH 2/3] kernel/fork, cred.c: allow copy_process to take user
To: Christian Brauner <christian.brauner@ubuntu.com>
References: <20210624030804.4932-1-michael.christie@oracle.com>
 <20210624030804.4932-3-michael.christie@oracle.com>
 <20210629130450.tvrweqy7z2hlwsbh@wittgenstein>
From: Mike Christie <michael.christie@oracle.com>
Message-ID: <6927dc85-6f8d-c1f5-f92d-9bcd36cce2bb@oracle.com>
Date: Tue, 29 Jun 2021 11:53:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629130450.tvrweqy7z2hlwsbh@wittgenstein>
Content-Language: en-US
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM6PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::27) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [20.15.0.204] (73.88.28.6) by
 DM6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:5:1b3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19 via Frontend Transport; Tue, 29 Jun 2021 16:53:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e89cabde-0332-40f1-aead-08d93b1e7375
X-MS-TrafficTypeDiagnostic: BY5PR10MB4307:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4307B01432998546C232BD77F1029@BY5PR10MB4307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WeG8DDcyQEF5JnkMjU1xCclYOqHBf2UcYN53VbeeC5V1HWFPxK383oOVqMnuM8hn4i5Zy1pZvoEHb5OOOTB1jpQvLFXmyQth4gJD5KHGiQeCeOMVg8K8A3cV6rrWj1b6DobYzPFYf2DPaE1gJmzfaNAa16aX2RUbXOx3cVOVOxNowecB4J9vOR945xvFIM5854tUG5SI5soKQbbIhLkiDfdPR/yP4+irXZ4veJ8HF1MLjqNDzY/JCsN0T9RANDgl4YwYu4jVdxm0QcK1Wa0WzH7VY+FM2lOyGGVfQ6cNR83KO5cUawcnDqtuK70woPbR7TCL/frl5RPYGRiLntMdcd7qipri+reMbKinBy4IIK0ELT3TCUZapy1f8543sX7G0EHRUtvNuDEKCKUBLDg9sOXe056Fjw3wL/hntHYDzgwntro8oFXnVamoLL7k3awHpIre0KoIaXr/EFb4C0fLYJ21XGpzK2FSP3ojHUuMeV1Lnf/hLGJPen8bj0Od/vDIEe6vaa+aEWVXm8OKvy9SrG7NPGiPmAK7uJAKKwqskKgLsh+gvf/8VgHya4kW+xHLUD9lKJOby7Mn/gEyxUZ81V8WyE5RHAJFou7RIbqgPZ52CztA5kHgIq0Q9wc1JpQ22pT4elKuidmIEN2kzbym6N/FqsBkcpqeNCixPVxQPhDwtj8e/L3+RUHZkggj61L3NVQQsPnHOmTzhlBv5GkmuuRBf5WCHFwNXrKHZJxlR2MDL1vTNE1Zr3k9+Yc9h9gu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(396003)(39860400002)(366004)(136003)(346002)(186003)(38100700002)(4326008)(16576012)(316002)(31696002)(86362001)(36756003)(2906002)(53546011)(31686004)(16526019)(6486002)(26005)(83380400001)(66476007)(66946007)(5660300002)(956004)(478600001)(6706004)(6916009)(8936002)(7416002)(66556008)(2616005)(8676002)(78286007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlRmZVpCM3dtS0xTTzBJWlk4TEZTdEM2RUlwdE1zbE8rTmV6eWxzOTV0aUVJ?=
 =?utf-8?B?dDR3QmZ3aGVGMlRrOVFROWthU2VCRENTM1c3YzNBNkNhZFVHLzJzc1NiekZX?=
 =?utf-8?B?cDZOclkyNmdwcWZoU25rajkyUmkvb2ZLM0h0NnJJRFJvVHN6d2Z0YXEyaHpr?=
 =?utf-8?B?MGh2L0tTenpHN3RFSmRPSlhQT1gzQlBQQkFRREtrN3E3b0dyRnZONzlyc3pu?=
 =?utf-8?B?ZmNMOHF0V0VYSVNUa29RdG9obkZJNDhhazAyRjc1RmMwOWxPNzQ4K1d6TEVE?=
 =?utf-8?B?bkU1OGZiRkE4bVhFWEx4eXZwWlZxUFljVHRRVjgrZ3Y4b3VIN3Fhc2toeFgv?=
 =?utf-8?B?Z05YdGFrNHBPeG9VcmF6UEpwOXAwa05HdjZ0eFFGL1lLRms4Rnh4N3Urd01o?=
 =?utf-8?B?VXZCUTV5c0M1VkxycFEvMVRCeVNQd1RJWDJWVjNKTzhDeWgvOE1janMrUWJr?=
 =?utf-8?B?N1hrOWJ6ZjdMWHA5bnNBdHhQSm5Zdjh5czRRSW5Sc3RVd1Y1dU1lcWFDRjUx?=
 =?utf-8?B?Q2MyZFhQOERoQm56VG1mNzdxSU43WERneEZ2VVd3Y0ZCRHFWQWxjUTViY3po?=
 =?utf-8?B?RW40Mm1BNUJ2K0FFeGlXZUNVcy9tZml6R3lpMVRyblhwVWZVSW1hNGFCM1JE?=
 =?utf-8?B?d1lTQ2NhQkk1MTcxaDc0Vkh6aGR1RmduNTV1TlR3ekNheTV0dHFGUDIwK2tU?=
 =?utf-8?B?SG5NUUNwMjUyREg0Z1puZ0ozVHhWajJGMDZYUVh4YmNQc1lPN0NhS3pwUm9N?=
 =?utf-8?B?ekRtRzR4NUMrRXpqaWZ1QUIwQ2IyWWNhakt2cVdyRmRza1VPK0YwT21ueWxX?=
 =?utf-8?B?SVQrYmdCTURmQnBlbkVwMHFVd0hVWHU3OVNUcms4Z1B0ekhJd2NxYUpWcmZx?=
 =?utf-8?B?cGRmNTExZi9IeXIrZjErZlRVUXZCcjhwSS90UVhSNitQUjJYMXVQYktBVXgr?=
 =?utf-8?B?VWsxTlZ6d1BQVnJicWZUVWo1NVRmMjQ1SHNCb3lTRi9SNHNrRUxEUklib2Qw?=
 =?utf-8?B?dThxRDVOZzJiQ3A3YVJrdUR5RVhaelZub1hwVVBRRnY0bjdvM3hSQjNSb3VW?=
 =?utf-8?B?aW1RREVJUUpiSGNPdDFqVnRSZHNVSzZEaXArVGhXUGJxbm9JM0R6YStHK05s?=
 =?utf-8?B?VnpvK01ISG81bkpIVmVRU3hBRmx2eG9BWnlqUTV6d3JSRmJ3V25LcEJoWi9W?=
 =?utf-8?B?eEduZHpKL05DWkpDSThYREYvQmFKZHg2V093b2ExaVdsS2JiaU15Ui9HcjF0?=
 =?utf-8?B?dDVUVjdKeFZwcGNIdGIyVlJ2YUZPajBuZFZnb3g0b25OVjB4ei9NWDVncjlo?=
 =?utf-8?B?NWtqKzU5YlI2eUtzNVIzNkh3VG54Rjh4SUhWcklxbi9GQnJMMnE2UGc3V2d5?=
 =?utf-8?B?N3RvZEtWTExJYW10VURxQmZyMTlWZVdna3RtemNhZlpIZzhQQ2pJR2tYNDNS?=
 =?utf-8?B?eGk2anFvZWtnT0lrcG5vV21yZGlPdFlieVMveDVwU3RqZE94c0xSOVh2bHJ4?=
 =?utf-8?B?ZmhuamxhcndtNGIxajJHWmVwclBZNFdpcFNiUUJuSjYrS0Fsc2pvSkpLN1Nr?=
 =?utf-8?B?ejJMVVhCRTFFNXA3REJNbEsvRE1qdm5rN1FPMUJocm9DTmZPZG5BYUp0SURj?=
 =?utf-8?B?ZXhBZWMyVUxheTZKNWVVNk1VTmtHaUhWbnJyOEswM3lYOGVVOXZPQ2tvS0hY?=
 =?utf-8?B?YmtiSXJlWncxcUV4d2dKYVFmRURSODY3dUVzZGttSzJmU0h5cUxBV2lQdVFG?=
 =?utf-8?Q?UaQGCUvJhnHNgJfeepFcM96W9irYTJWBsfLawZL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89cabde-0332-40f1-aead-08d93b1e7375
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 16:53:42.2745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndKGDM4dg0t8jU+zqDVlGiaJ0SSRK0sBATTXN5gHSQ+A4sDkmWfgSamhndamnP1GJY98nFWQG3Mo3pxLOCcBwdXF8paMH3cerHPgG3fJyLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290105
X-Proofpoint-GUID: qOmyQLDzpxlv-2BYMmY0V6u5oei_Nxf0
X-Proofpoint-ORIG-GUID: qOmyQLDzpxlv-2BYMmY0V6u5oei_Nxf0
Cc: mst@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 akpm@linux-foundation.org, christian@brauner.io
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

On 6/29/21 8:04 AM, Christian Brauner wrote:
> On Wed, Jun 23, 2021 at 10:08:03PM -0500, Mike Christie wrote:
>> This allows kthread to pass copy_process the user we want to check for the
>> RLIMIT_NPROC limit for and also charge for the new process. It will be used
>> by vhost where userspace has that driver create threads but the kthreadd
>> thread is checked/charged.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
>>  include/linux/cred.h |  3 ++-
>>  kernel/cred.c        |  7 ++++---
>>  kernel/fork.c        | 12 +++++++-----
>>  3 files changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/cred.h b/include/linux/cred.h
>> index 14971322e1a0..9a2c1398cdd4 100644
>> --- a/include/linux/cred.h
>> +++ b/include/linux/cred.h
>> @@ -153,7 +153,8 @@ struct cred {
>>  
>>  extern void __put_cred(struct cred *);
>>  extern void exit_creds(struct task_struct *);
>> -extern int copy_creds(struct task_struct *, unsigned long);
>> +extern int copy_creds(struct task_struct *, unsigned long,
>> +		      struct user_struct *);
>>  extern const struct cred *get_task_cred(struct task_struct *);
>>  extern struct cred *cred_alloc_blank(void);
>>  extern struct cred *prepare_creds(void);
>> diff --git a/kernel/cred.c b/kernel/cred.c
>> index e1d274cd741b..e006aafa8f05 100644
>> --- a/kernel/cred.c
>> +++ b/kernel/cred.c
>> @@ -330,7 +330,8 @@ struct cred *prepare_exec_creds(void)
>>   * The new process gets the current process's subjective credentials as its
>>   * objective and subjective credentials
>>   */
>> -int copy_creds(struct task_struct *p, unsigned long clone_flags)
>> +int copy_creds(struct task_struct *p, unsigned long clone_flags,
>> +	       struct user_struct *user)
>>  {
>>  	struct cred *new;
>>  	int ret;
>> @@ -351,7 +352,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>>  		kdebug("share_creds(%p{%d,%d})",
>>  		       p->cred, atomic_read(&p->cred->usage),
>>  		       read_cred_subscribers(p->cred));
>> -		atomic_inc(&p->cred->user->processes);
>> +		atomic_inc(&user->processes);
> 
> Hey Mike,
> 
> This won't work anymore since this has moved into ucounts. So in v5.14
> atomic_inc(&p->cred->user->processes);
> will have been replaced by
> inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
> 
Will do.

> From what I can see from your code vhost will always create this kthread
> for current. So you could e.g. add an internal flag/bitfield entry to
> struct kernel_clone_args that you can use to tell copy_creds() that you
> want to charge this thread against current's process limit.

If I understood you, I don't think a flag/bit will work. When vhost does
a kthread call we do kthread_create -> __kthread_create_on_node. This creates
a tmp kthread_create_info struct and adds it to the kthread_create_list list.
It then wakes up the kthreadd thread. kthreadd will then loop over the list,
and do the:

kernel_thread -> kernel_clone -> copy_process ->  copy_creds

So copy_creds sees current == kthreadd.

I think I would have to add a task_struct pointer to kernel_clone_args
and kthread_create_info. If copy_creds sees kernel_clone_args->user_task
then it would use that.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
