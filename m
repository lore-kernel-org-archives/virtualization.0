Return-Path: <SRS0=eOzH=J7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F24C433B4
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 18:45:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2363613B3
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 18:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2363613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 564EB40498;
	Tue,  4 May 2021 18:45:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nnda4o8ojI80; Tue,  4 May 2021 18:45:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B1B84033F;
	Tue,  4 May 2021 18:45:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F29CC000E;
	Tue,  4 May 2021 18:45:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB657C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 18:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC32D40130
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 18:45:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="VbvpUcdD";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="KZpSmFHK"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TiCe0s7gSGPJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 18:45:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94B0640119
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 18:45:47 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144IU28w073151;
 Tue, 4 May 2021 18:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4VwvkRxCpp/032lvteci5YMh2LK6YtiZtkzwGUEEn10=;
 b=VbvpUcdDJV13063lXaIIFjXF+MbMAbAGpp7CFpHeWttovIMItIrs6Ski8yQTPQZ8r7R6
 lGUv5FaV49N9IGa6fMCfsWEE9VNlPTFtUcIhoWlf5HSSVRri3qvK8UnKshpVTiy2cC5F
 v07tDSFf6Wm73M639QRPPK6U9dTPd4FZChRIkibwl/P0nfl6bap9EmQ/ELRXcexZ1eg8
 pdiyEz1D6jO0FL4Lm/O9FhDVuX9/hjFxHe2hV0O4lIPT90lGesRkoqKiFEkdpsRuqTul
 dIQijVtrK0Zfud9iRvdOmknj6f3yNJpLQz/YSwxlkVdR2EOY5EOOHfki4+l6MHvcGUEG fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 388xds02rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 May 2021 18:45:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144IVPIS055238;
 Tue, 4 May 2021 18:45:44 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
 by aserp3030.oracle.com with ESMTP id 388w1ed8t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 May 2021 18:45:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4Jzvps41wVYt794552Zi/ydELsbKjpvz3P5NVg6Od8k4uRLaB/22lLDublsYHkJEhen6SrMTOSKQmmhu460tnrvhMap65g00Wo3eFHGAzXH4LG1Wjccz5urzsSoUBJIdjCFrUp0VeLGA4iuy19edQ2UQHTkIwu2ZPM+mhhK4OnofNNWWo8xyPFeZfwTg2TKFh+ewNJ4DcEIoiaqWZChx7tGtDFC1T31K3HTewm1OQAO41GXcHPBdMw1T7V2leXER71lhNQHw83YOfG8UAe5AxI62jv7uO/8XpwqYR7FDQ9MSKOUAsujNC/R10HkOlGw/4CWGySdbqYYuIENCJuiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VwvkRxCpp/032lvteci5YMh2LK6YtiZtkzwGUEEn10=;
 b=jnvgv0apKPqezI65hOhsLq0GLVFHT/r83g7gRPDUVMuAd7HfWETu929bsk15sKLpZ4yVt1PrDDCUtLb2oMZOQ4u298wrVLFgtiEGAKBz83wUYYO1JMLKp13lgmoCUIhChybhy76vuEELfwOhDCyN8bK90QVwBbemDLZSqjPKdu0DdNSwN2iVuJe6/UUtQQkFuuJlwGpQ4sVNBL0euw9d/sJ3AdV5owS/8xuPrrPA0/awXSr49x7PL+G9fxoP51/X8Ykvng5dh0hgU+9+m2IqhWqrxb+G91M6HDfsWM4jDpZ54YOPCxGaYS737G5LLYjk5pQdwVP26YlK26qd65Nx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VwvkRxCpp/032lvteci5YMh2LK6YtiZtkzwGUEEn10=;
 b=KZpSmFHKKu9I7rdSMDO3Mu3tRFI8pLyfkzKv6JAs1VoKUfE4vJUGsjP4jSmWeOhg8zZxqWCzk4HAd4BoEFOZU9nsHnqSFkLYzZWLrcM0NGcFcbZ0W8w1CuWy7xjZkJU9BSsPap1+Qq9EXxaMX3/5pIPQ+7G/QOaooDXnhXTCz6c=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB4001.namprd10.prod.outlook.com (2603:10b6:a03:1f9::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 18:45:42 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 18:45:42 +0000
Subject: Re: [PATCH RFC 11/14] vhost: allow userspace to create workers
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210428223714.110486-1-michael.christie@oracle.com>
 <20210428223714.110486-13-michael.christie@oracle.com>
 <20210504153021.afrnjo7l2szkvbi3@steredhat>
From: Mike Christie <michael.christie@oracle.com>
Message-ID: <ed98878a-c154-bd11-44a3-3c6568d9ee05@oracle.com>
Date: Tue, 4 May 2021 13:45:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210504153021.afrnjo7l2szkvbi3@steredhat>
Content-Language: en-US
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:3:117::14) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [20.15.0.204] (73.88.28.6) by
 DM5PR13CA0052.namprd13.prod.outlook.com (2603:10b6:3:117::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.8 via Frontend Transport; Tue, 4 May 2021 18:45:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a2dc198-d20a-4703-4fa4-08d90f2cd181
X-MS-TrafficTypeDiagnostic: BY5PR10MB4001:
X-Microsoft-Antispam-PRVS: <BY5PR10MB40012F509C17B8FD38755F76F15A9@BY5PR10MB4001.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODnJ+4UPmahncPqC5zgAfYBQ9L0tJq8wsYUQYQjQ26wzQnKLwmT++Zry26gWBnYE5I0bBdmFR9X3J1Vu83+udDsc/RpfQZeFEQ6e7fAHkZreLPnOnehMRRvi+O2j6g592Z7GsDciLhnfdaAbYNEfyWBqPpaYSBb5wLMjZIQLGpU40hAx42+knGAsCCJsnAlKynJSR+41q690YabWqEvydngrQEzWcxCJX7yeh3mclkkkCjIQ8D0mRrOIdsI8Gife+E/kvEdGp+AIXXGOa4ZWv1TZ0tTk+BuXZGanSZnRFzBVfks3Cpl7UlImu0DgtoUC91Ci7dkhFOAsvc/r6IjK/04MV+6Lb0dwPhzpcAOD1xPWZu7TTB5dd3rYgf3+H4CfN4S189BBd7kjn9fYuKqDmHGyHPeuxjtCtgGq7yA2+mEMXmxVB1bfZSVhKKPp+uK5cELUnH1wUBIYkqR55nUstHwtLjssgDXC0xCBo1ld/Etosn/M304tFug4JGCzI0/axHONH13tk6lfbzvEEZgq3estJy+a72bnSZny/BBgR1Ox7LF4WWlOjQt9v/rXILnGM0hmtXLwYRbEA/Xr/zz9BUW+5Lk4XRRqW3CPw0Bo3Hnt3VDXTNM6PKV84lvJmLhwBVlHZKw4ZAJBAK+76KMhvbNDgW3IrbaygkMJVrSa6JQG7sxzbo1sQGjdfOg1nTlCm/S0+dGtZdzg2UVDh8O3FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(346002)(136003)(396003)(39860400002)(376002)(36756003)(26005)(66946007)(6916009)(6706004)(6486002)(2616005)(31686004)(53546011)(86362001)(4326008)(2906002)(956004)(5660300002)(66556008)(16526019)(316002)(8676002)(66476007)(31696002)(186003)(83380400001)(38100700002)(16576012)(8936002)(478600001)(78286007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RnIxRGJHbTFQWUJBVUxoR3ltMjdRNDAxbXgzYWRoUnl3VzNlemw4SnBZZzBw?=
 =?utf-8?B?cE1wY3N4bUY3c3JUQkFacEdiV0IzM0h6NXRhMEdJQ1IxbGdseVlpdjBHYWVB?=
 =?utf-8?B?NkNPRGZaQk5QMFlZQTd0SzBGbmNxVjBybnlTY2xJU2EraVhIanEvcmduR1or?=
 =?utf-8?B?M2FNS2xJRm51QmpUT2c3VlUzRXBWb2tLUVl2Mng3OXdXK3RwaGRndWg3V003?=
 =?utf-8?B?WGxwdExVM2ZHOC9VS3B1RFozU0hRRW0zOW9sR2IwYzg2S1J2OXl0aE9Zb3dp?=
 =?utf-8?B?Y3NqZUh5cjNRUjhnOTIxMnRUUGZSTEhydzAyNm9mdlg2cmd2Ky9kOUI2TnNX?=
 =?utf-8?B?eVBqMHN6R2VEbnRSdE5FdWpCNzdIU2xEdVR5WGRlejUvaVNueVdUM0VFYmpJ?=
 =?utf-8?B?M0NxMmJpN3RQb2YvM3NsMXlKUmpvRXZLWlV2UHp6WDJkQ3N4Y2loMWVmNlVC?=
 =?utf-8?B?aysxUDNRSkd0WkNCYWFXMGtGV0Evc3pLSUcwNmJPYmh3MzYvblNSS2I3VFRY?=
 =?utf-8?B?NHMrb1FiSVlhaXR5RE5tWlE4SVdZZWRLVEdUT25mVkM3QlZvMWxxcFlNckNY?=
 =?utf-8?B?VTRQTHJ3UEFtN1ZZRVFtRDF6SVA3SXlWSDB4U0hsbGxvQm1iTHlKck04Nkpn?=
 =?utf-8?B?VTlLWk9SNXNXMFViUlZMZWhVSE5mMER2RlFSQ2ZHd3RKckUrQ2lRWmdONEx6?=
 =?utf-8?B?cTQyNi9TVE03Tm4ybnFlcThQSWxmcEFUU1JpQmZVQVVXVlRyZjlGUmVJUlNI?=
 =?utf-8?B?LzR0YzZMMmIycXkzRG54Z0dEUFpUa2RtMGZYb1Z4WXdmcytOZjI5cTdtcEU2?=
 =?utf-8?B?aGdPZUYwdUVQTkozQllkcDJzMG91R0FKU3VBZmJYOXMwdytHd1h0Ni80YWJn?=
 =?utf-8?B?b0pjUUdXNUZwZmhTcURXQlBwdGg1WEcvVVYrRkRvNC9iUUJrVTZmWkROQVho?=
 =?utf-8?B?c1h4aWdJaVVTV1F4cmo5S08zbHA0ZHc3a1VkeGVSUndsOWdXeGJUa2VhWkM5?=
 =?utf-8?B?WVZmRmp2WkFRT2RqZXoxRjJrNldxQUUwWkR1R0JKTk9Ja0YxZE9yY0hFcnhq?=
 =?utf-8?B?ejBnR1p1NXZhazBFdExocVhLVHlPNENLUEJOMG5sNXlzSkRpdDZhK21yZnhJ?=
 =?utf-8?B?anRiL2dBdm81ejFMUnlwd05RYTJoMG1PUDJObGNoOG9SR0tYcXhHa0grOUdM?=
 =?utf-8?B?ZEp6eVdjQmdZOS9KVXl2bXozVk1MTmtCa0dYT09DTjFwYUxSY0JrZzloaVZK?=
 =?utf-8?B?QlVHak1PeGZvenlvTFM5SEswYUFDZStvYkUySW5pUzRsVUwxTVB6aHRVbW9z?=
 =?utf-8?B?NmlmYUpSRm5CMU8vYlUvckdmVmJYc0NHeG4zb1loRjRqQVh5ODI0VDhGck1L?=
 =?utf-8?B?K1Q1VTE2UXVka1B2WFBjbWRnUTBJcnkzdEZsdmhaU2RhNFp4RXVWSEU0aS9k?=
 =?utf-8?B?eFY2aElrVGQzeTdqRC96Z2JEVmlQdFNFYWdURnRMYWZZdnZ2WHVzaHVxS1VG?=
 =?utf-8?B?NnB3NnRiUkhER2NVclowaml4NU1IY3JXdVV6cHFyVFMrNjRPM2UzdWxuTjF2?=
 =?utf-8?B?d2VCblhlaE5nR3BMaTNRWThQeWszR2xrQWdzWHQ4L1JGK0IyNVdyazcxZE9D?=
 =?utf-8?B?THZBendqa1QrOWdtNEZOL1ZPOXpVaUJ5K3VXQlJWNi9aQitIRFZYTzM5ZWhp?=
 =?utf-8?B?TVd3VzFOZHhIdUxoanEzMC9HWWdxZzJWeWtzMVNTWEF0Qjhxc2pUdmJTU28x?=
 =?utf-8?Q?KapJz/zA4++L2yS3Hw0v0rSzJJGjRzEH7L2WnMQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2dc198-d20a-4703-4fa4-08d90f2cd181
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 18:45:41.8375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IP1L6+U9s3OtYdyjliF23gSk/DYws0+sRQEQf/vK3R0b04oGR9Oen/QI/8IMczHPsNZ1F8FdmClwtbb3WPsTU8yiNVRhg7jeFwiovMqEu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4001
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040122
X-Proofpoint-ORIG-GUID: Uqw0GZbgmI3bTWvFnFan2fqiKh9Z10Ej
X-Proofpoint-GUID: Uqw0GZbgmI3bTWvFnFan2fqiKh9Z10Ej
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040122
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, mst@redhat.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNS80LzIxIDEwOjMwIEFNLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24gV2VkLCBB
cHIgMjgsIDIwMjEgYXQgMDU6Mzc6MTFQTSAtMDUwMCwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPj4g
VGhpcyBwYXRjaCBhbGxvd3MgdXNlcnNwYWNlIHRvIGNyZWF0ZSB3b3JrZXJzIGFuZCBiaW5kIHRo
ZW0gdG8gdnFzLCBzbyB5b3UKPj4gY2FuIGhhdmUgTiB3b3JrZXJzIHBlciBkZXYgYW5kIGFsc28g
c2hhcmUgTiB3b3JrZXJzIHdpdGggTSB2cXMuIFRoZSBuZXh0Cj4+IHBhdGNoIHdpbGwgYWxsb3cg
c2hhcmluZyBhY3Jvc3MgZGV2aWNlcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTWlrZSBDaHJpc3Rp
ZSA8bWljaGFlbC5jaHJpc3RpZUBvcmFjbGUuY29tPgo+PiAtLS0KPj4gZHJpdmVycy92aG9zdC92
aG9zdC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDk1ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystCj4+IGRyaXZlcnMvdmhvc3Qvdmhvc3QuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDMgKwo+PiBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaMKgwqDCoMKgwqDCoCB8wqAgNiAr
Kwo+PiBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCB8wqAgOSArKysKPj4gNCBmaWxl
cyBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+PiBp
bmRleCAzNDVhZGUwYWYxMzMuLmZlY2RhZTBkMThjNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92
aG9zdC92aG9zdC5jCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+PiBAQCAtNDIsNiAr
NDIsOSBAQCBtb2R1bGVfcGFyYW0obWF4X2lvdGxiX2VudHJpZXMsIGludCwgMDQ0NCk7Cj4+IE1P
RFVMRV9QQVJNX0RFU0MobWF4X2lvdGxiX2VudHJpZXMsCj4+IMKgwqDCoMKgIk1heGltdW0gbnVt
YmVyIG9mIGlvdGxiIGVudHJpZXMuIChkZWZhdWx0OiAyMDQ4KSIpOwo+Pgo+PiArc3RhdGljIExJ
U1RfSEVBRCh2aG9zdF93b3JrZXJzX2xpc3QpOwo+PiArc3RhdGljIERFRklORV9TUElOTE9DSyh2
aG9zdF93b3JrZXJzX2xvY2spOwo+PiArCj4+IGVudW0gewo+PiDCoMKgwqDCoFZIT1NUX01FTU9S
WV9GX0xPRyA9IDB4MSwKPj4gfTsKPj4gQEAgLTYxNyw4ICs2MjAsMTYgQEAgc3RhdGljIHZvaWQg
dmhvc3RfZGV0YWNoX21tKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPj4gwqDCoMKgwqBkZXYtPm1t
ID0gTlVMTDsKPj4gfQo+Pgo+PiAtc3RhdGljIHZvaWQgdmhvc3Rfd29ya2VyX2ZyZWUoc3RydWN0
IHZob3N0X3dvcmtlciAqd29ya2VyKQo+PiArc3RhdGljIHZvaWQgdmhvc3Rfd29ya2VyX3B1dChz
dHJ1Y3Qgdmhvc3Rfd29ya2VyICp3b3JrZXIpCj4+IHsKPj4gK8KgwqDCoCBzcGluX2xvY2soJnZo
b3N0X3dvcmtlcnNfbG9jayk7Cj4+ICvCoMKgwqAgaWYgKCFyZWZjb3VudF9kZWNfYW5kX3Rlc3Qo
Jndvcmtlci0+cmVmY291bnQpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmdmhv
c3Rfd29ya2Vyc19sb2NrKTsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4gK8KgwqDCoCB9
Cj4+ICvCoMKgwqAgbGlzdF9kZWwoJndvcmtlci0+bGlzdCk7Cj4+ICvCoMKgwqAgc3Bpbl91bmxv
Y2soJnZob3N0X3dvcmtlcnNfbG9jayk7Cj4+ICsKPj4gwqDCoMKgwqBXQVJOX09OKCFsbGlzdF9l
bXB0eSgmd29ya2VyLT53b3JrX2xpc3QpKTsKPj4gwqDCoMKgwqBrdGhyZWFkX3N0b3Aod29ya2Vy
LT50YXNrKTsKPj4gwqDCoMKgwqBrZnJlZSh3b3JrZXIpOwo+PiBAQCAtNjMyLDcgKzY0Myw3IEBA
IHN0YXRpYyB2b2lkIHZob3N0X3dvcmtlcnNfZnJlZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4+
IMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4KPj4gwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgZGV2
LT5udW1fd29ya2VyczsgaSsrKQo+PiAtwqDCoMKgwqDCoMKgwqAgdmhvc3Rfd29ya2VyX2ZyZWUo
ZGV2LT53b3JrZXJzW2ldKTsKPj4gK8KgwqDCoMKgwqDCoMKgIHZob3N0X3dvcmtlcl9wdXQoZGV2
LT53b3JrZXJzW2ldKTsKPj4KPj4gwqDCoMKgwqBrZnJlZShkZXYtPndvcmtlcnMpOwo+PiDCoMKg
wqDCoGRldi0+bnVtX3dvcmtlcnMgPSAwOwo+PiBAQCAtNjUyLDYgKzY2Myw4IEBAIHN0YXRpYyBz
dHJ1Y3Qgdmhvc3Rfd29ya2VyICp2aG9zdF93b3JrZXJfY3JlYXRlKHN0cnVjdCB2aG9zdF9kZXYg
KmRldikKPj4gwqDCoMKgwqB3b3JrZXItPmlkID0gZGV2LT5udW1fd29ya2VyczsKPj4gwqDCoMKg
wqB3b3JrZXItPmRldiA9IGRldjsKPj4gwqDCoMKgwqBpbml0X2xsaXN0X2hlYWQoJndvcmtlci0+
d29ya19saXN0KTsKPj4gK8KgwqDCoCBJTklUX0xJU1RfSEVBRCgmd29ya2VyLT5saXN0KTsKPj4g
K8KgwqDCoCByZWZjb3VudF9zZXQoJndvcmtlci0+cmVmY291bnQsIDEpOwo+Pgo+PiDCoMKgwqDC
oHRhc2sgPSBrdGhyZWFkX2NyZWF0ZSh2aG9zdF93b3JrZXIsIHdvcmtlciwgInZob3N0LSVkIiwg
Y3VycmVudC0+cGlkKTsKPj4gwqDCoMKgwqBpZiAoSVNfRVJSKHRhc2spKQo+PiBAQCAtNjY0LDYg
KzY3Nyw5IEBAIHN0YXRpYyBzdHJ1Y3Qgdmhvc3Rfd29ya2VyICp2aG9zdF93b3JrZXJfY3JlYXRl
KHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPj4gwqDCoMKgwqBpZiAocmV0KQo+PiDCoMKgwqDCoMKg
wqDCoCBnb3RvIHN0b3Bfd29ya2VyOwo+Pgo+PiArwqDCoMKgIHNwaW5fbG9jaygmdmhvc3Rfd29y
a2Vyc19sb2NrKTsKPj4gK8KgwqDCoCBsaXN0X2FkZF90YWlsKCZ3b3JrZXItPmxpc3QsICZ2aG9z
dF93b3JrZXJzX2xpc3QpOwo+PiArwqDCoMKgIHNwaW5fdW5sb2NrKCZ2aG9zdF93b3JrZXJzX2xv
Y2spOwo+PiDCoMKgwqDCoHJldHVybiB3b3JrZXI7Cj4+Cj4+IHN0b3Bfd29ya2VyOgo+PiBAQCAt
NjczLDYgKzY4OSw3MSBAQCBzdGF0aWMgc3RydWN0IHZob3N0X3dvcmtlciAqdmhvc3Rfd29ya2Vy
X2NyZWF0ZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4+IMKgwqDCoMKgcmV0dXJuIE5VTEw7Cj4+
IH0KPj4KPj4gK3N0YXRpYyBzdHJ1Y3Qgdmhvc3Rfd29ya2VyICp2aG9zdF93b3JrZXJfZmluZChz
dHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHBpZF90IHBpZCkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3Qg
dmhvc3Rfd29ya2VyICp3b3JrZXI7Cj4+ICsKPj4gK8KgwqDCoCAvKiBUT0RPIGhhc2ggb24gcGlk
PyAqLwo+PiArwqDCoMKgIHNwaW5fbG9jaygmdmhvc3Rfd29ya2Vyc19sb2NrKTsKPj4gK8KgwqDC
oCBsaXN0X2Zvcl9lYWNoX2VudHJ5KHdvcmtlciwgJnZob3N0X3dvcmtlcnNfbGlzdCwgbGlzdCkg
ewo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHdvcmtlci0+dGFzay0+cGlkICE9IHBpZCkKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIC8q
IHRtcCAtIG5leHQgcGF0Y2ggYWxsb3dzIHNoYXJpbmcgYWNyb3NzIGRldnMgKi8KPj4gK8KgwqDC
oMKgwqDCoMKgIGlmICh3b3JrZXItPmRldiAhPSBkZXYpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3Bpbl91bmxvY2soJnZob3N0X3dvcmtlcnNfbG9jayk7Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBOVUxMOwo+PiArwqDCoMKgwqDCoMKgwqAgfQo+PiArCj4+ICvCoMKg
wqDCoMKgwqDCoCByZWZjb3VudF9pbmMoJndvcmtlci0+cmVmY291bnQpOwo+PiArwqDCoMKgwqDC
oMKgwqAgc3Bpbl91bmxvY2soJnZob3N0X3dvcmtlcnNfbG9jayk7Cj4+ICvCoMKgwqDCoMKgwqDC
oCByZXR1cm4gd29ya2VyOwo+PiArwqDCoMKgIH0KPj4gK8KgwqDCoCBzcGluX3VubG9jaygmdmhv
c3Rfd29ya2Vyc19sb2NrKTsKPj4gK8KgwqDCoCByZXR1cm4gTlVMTDsKPiAKPiBJIHdvdWxkIGxp
a2UgdG8gaGF2ZSBhIHNpbmdsZSBwb2ludCB3aGVyZSB3ZSByZWxlYXNlIHRoZSBsb2NrIHRvIGF2
b2lkCj4gZnV0dXJlIGlzc3VlcywgaG93IGFib3V0IGNoYW5naW5nIHZob3N0X3dvcmtlcl9maW5k
KCkgdG86Cj4gCj4gc3RhdGljIHN0cnVjdCB2aG9zdF93b3JrZXIgKnZob3N0X3dvcmtlcl9maW5k
KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgcGlkX3QgcGlkKQo+IHsKPiDCoMKgwqDCoHN0cnVjdCB2
aG9zdF93b3JrZXIgKndvcmtlciwgKmZvdW5kX3dvcmtlciA9IE5VTEw7Cj4gCj4gwqDCoMKgwqBz
cGluX2xvY2soJnZob3N0X3dvcmtlcnNfbG9jayk7Cj4gwqDCoMKgwqBsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KHdvcmtlciwgJnZob3N0X3dvcmtlcnNfbGlzdCwgbGlzdCkgewo+IMKgwqDCoMKgwqDCoMKg
IGlmICh3b3JrZXItPnRhc2stPnBpZCA9PSBwaWQpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qIHRtcCAtIG5leHQgcGF0Y2ggYWxsb3dzIHNoYXJpbmcgYWNyb3NzIGRldnMgKi8KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICh3b3JrZXItPmRldiAhPSBkZXYpCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm91
bmRfd29ya2VyID0gd29ya2VyOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVmY291bnRfaW5j
KCZmb3VuZF93b3JrZXItPnJlZmNvdW50KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Owo+IMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoH0KPiDCoMKgwqDCoHNwaW5fdW5sb2NrKCZ2
aG9zdF93b3JrZXJzX2xvY2spOwo+IMKgwqDCoMKgcmV0dXJuIGZvdW5kX3dvcmtlcjsKPiB9CgpO
aWNlLiBXaWxsIGRvLgoKPiAKPj4gK30KPj4gKwo+PiArLyogQ2FsbGVyIG11c3QgaGF2ZSBkZXZp
Y2UgbXV0ZXggKi8KPj4gK3N0YXRpYyBpbnQgdmhvc3RfdnFfc2V0X3dvcmtlcihzdHJ1Y3Qgdmhv
c3RfdmlydHF1ZXVlICp2cSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3Qgdmhvc3RfdnJpbmdfd29ya2VyICppbmZvKQo+PiArewo+PiArwqDCoMKgIHN0cnVj
dCB2aG9zdF9kZXYgKmRldiA9IHZxLT5kZXY7Cj4+ICvCoMKgwqAgc3RydWN0IHZob3N0X3dvcmtl
ciAqd29ya2VyOwo+PiArCj4+ICvCoMKgwqAgaWYgKHZxLT53b3JrZXIpIHsKPj4gK8KgwqDCoMKg
wqDCoMKgIC8qIFRPRE8gLSBzdXBwb3J0IGNoYW5naW5nIHdoaWxlIHdvcmtzIGFyZSBydW5uaW5n
ICovCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVCVVNZOwo+PiArwqDCoMKgIH0KPj4gKwo+
PiArwqDCoMKgIGlmIChpbmZvLT5waWQgPT0gLTEpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHdvcmtl
ciA9IHZob3N0X3dvcmtlcl9jcmVhdGUoZGV2KTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghd29y
a2VyKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPj4gKwo+PiAr
wqDCoMKgwqDCoMKgwqAgaW5mby0+cGlkID0gd29ya2VyLT50YXNrLT5waWQ7Cj4+ICvCoMKgwqAg
fSBlbHNlIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHdvcmtlciA9IHZob3N0X3dvcmtlcl9maW5kKGRl
diwgaW5mby0+cGlkKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghd29ya2VyKQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8Kg
wqDCoCBpZiAoIWRldi0+d29ya2Vycykgewo+PiArwqDCoMKgwqDCoMKgwqAgZGV2LT53b3JrZXJz
ID0ga2NhbGxvYyh2cS0+ZGV2LT5udnFzLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVjdCB2aG9zdF93b3JrZXIgKiksCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBHRlBfS0VSTkVMKTsKPj4g
K8KgwqDCoMKgwqDCoMKgIGlmICghZGV2LT53b3JrZXJzKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHZob3N0X3dvcmtlcl9wdXQod29ya2VyKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FTk9NRU07Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+ICvCoMKgwqAgfQo+PiAr
Cj4+ICvCoMKgwqAgdnEtPndvcmtlciA9IHdvcmtlcjsKPj4gKwo+PiArwqDCoMKgIGRldi0+d29y
a2Vyc1tkZXYtPm51bV93b3JrZXJzXSA9IHdvcmtlcjsKPj4gK8KgwqDCoCBkZXYtPm51bV93b3Jr
ZXJzKys7Cj4+ICvCoMKgwqAgcmV0dXJuIDA7Cj4+ICt9Cj4+ICsKPj4gLyogQ2FsbGVyIG11c3Qg
aGF2ZSBkZXZpY2UgbXV0ZXggKi8KPj4gc3RhdGljIGludCB2aG9zdF93b3JrZXJfdHJ5X2NyZWF0
ZV9kZWYoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+PiB7Cj4+IEBAIC0xNjgwLDYgKzE3NjEsNyBA
QCBsb25nIHZob3N0X3ZyaW5nX2lvY3RsKHN0cnVjdCB2aG9zdF9kZXYgKmQsIHVuc2lnbmVkIGlu
dCBpb2N0bCwgdm9pZCBfX3VzZXIgKmFyZwo+PiDCoMKgwqDCoHN0cnVjdCBldmVudGZkX2N0eCAq
Y3R4ID0gTlVMTDsKPj4gwqDCoMKgwqB1MzIgX191c2VyICppZHhwID0gYXJncDsKPj4gwqDCoMKg
wqBzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cTsKPj4gK8KgwqDCoCBzdHJ1Y3Qgdmhvc3RfdnJp
bmdfd29ya2VyIHc7Cj4+IMKgwqDCoMKgc3RydWN0IHZob3N0X3ZyaW5nX3N0YXRlIHM7Cj4+IMKg
wqDCoMKgc3RydWN0IHZob3N0X3ZyaW5nX2ZpbGUgZjsKPj4gwqDCoMKgwqB1MzIgaWR4Owo+PiBA
QCAtMTc5NCw2ICsxODc2LDE1IEBAIGxvbmcgdmhvc3RfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0
X2RldiAqZCwgdW5zaWduZWQgaW50IGlvY3RsLCB2b2lkIF9fdXNlciAqYXJnCj4+IMKgwqDCoMKg
wqDCoMKgIGlmIChjb3B5X3RvX3VzZXIoYXJncCwgJnMsIHNpemVvZihzKSkpCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgciA9IC1FRkFVTFQ7Cj4+IMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiAr
wqDCoMKgIGNhc2UgVkhPU1RfU0VUX1ZSSU5HX1dPUktFUjoKPj4gK8KgwqDCoMKgwqDCoMKgIGlm
IChjb3B5X2Zyb21fdXNlcigmdywgYXJncCwgc2l6ZW9mKHcpKSkgewo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByID0gLUVGQVVMVDsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7
Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+ICvCoMKgwqDCoMKgwqDCoCByID0gdmhvc3RfdnFfc2V0
X3dvcmtlcih2cSwgJncpOwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFyICYmIGNvcHlfdG9fdXNl
cihhcmdwLCAmdywgc2l6ZW9mKHcpKSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IC1F
RkFVTFQ7Cj4+ICvCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gwqDCoMKgwqBkZWZhdWx0Ogo+PiDC
oMKgwqDCoMKgwqDCoCByID0gLUVOT0lPQ1RMQ01EOwo+PiDCoMKgwqDCoH0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaCBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+PiBpbmRl
eCA5NzM4ODllYzdkNjIuLjY0ZGMwMDMzNzM4OSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aG9z
dC92aG9zdC5oCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+PiBAQCAtMTQsNiArMTQs
NyBAQAo+PiAjaW5jbHVkZSA8bGludXgvYXRvbWljLmg+Cj4+ICNpbmNsdWRlIDxsaW51eC92aG9z
dF9pb3RsYi5oPgo+PiAjaW5jbHVkZSA8bGludXgvaXJxYnlwYXNzLmg+Cj4+ICsjaW5jbHVkZSA8
bGludXgvcmVmY291bnQuaD4KPj4KPj4gc3RydWN0IHZob3N0X3dvcms7Cj4+IHR5cGVkZWYgdm9p
ZCAoKnZob3N0X3dvcmtfZm5fdCkoc3RydWN0IHZob3N0X3dvcmsgKndvcmspOwo+PiBAQCAtMjgs
NiArMjksOCBAQCBzdHJ1Y3Qgdmhvc3Rfd29yayB7Cj4+IHN0cnVjdCB2aG9zdF93b3JrZXIgewo+
PiDCoMKgwqDCoHN0cnVjdCB0YXNrX3N0cnVjdMKgwqDCoCAqdGFzazsKPj4gwqDCoMKgwqBzdHJ1
Y3QgbGxpc3RfaGVhZMKgwqDCoCB3b3JrX2xpc3Q7Cj4+ICvCoMKgwqAgc3RydWN0IGxpc3RfaGVh
ZMKgwqDCoCBsaXN0Owo+PiArwqDCoMKgIHJlZmNvdW50X3TCoMKgwqDCoMKgwqDCoCByZWZjb3Vu
dDsKPj4gwqDCoMKgwqBzdHJ1Y3Qgdmhvc3RfZGV2wqDCoMKgICpkZXY7Cj4+IMKgwqDCoMKgaW50
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZDsKPj4gfTsKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9saW51eC92aG9zdC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmgKPj4gaW5kZXgg
Yzk5ODg2MGQ3YmJjLi42MWE1N2Y1MzY2ZWUgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9s
aW51eC92aG9zdC5oCj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oCj4+IEBAIC03
MCw2ICs3MCwxMiBAQAo+PiAjZGVmaW5lIFZIT1NUX1ZSSU5HX0JJR19FTkRJQU4gMQo+PiAjZGVm
aW5lIFZIT1NUX1NFVF9WUklOR19FTkRJQU4gX0lPVyhWSE9TVF9WSVJUSU8sIDB4MTMsIHN0cnVj
dCB2aG9zdF92cmluZ19zdGF0ZSkKPj4gI2RlZmluZSBWSE9TVF9HRVRfVlJJTkdfRU5ESUFOIF9J
T1coVkhPU1RfVklSVElPLCAweDE0LCBzdHJ1Y3Qgdmhvc3RfdnJpbmdfc3RhdGUpCj4+ICsvKiBD
cmVhdGUvYmluZCBhIHZob3N0IHdvcmtlciB0byBhIHZpcnRxdWV1ZS4gSWYgcGlkID4gMCBhbmQg
bWF0Y2hlcyBhbiBleGlzdGluZwo+PiArICogdmhvc3Rfd29ya2VyIHRocmVhZCBpdCB3aWxsIGJl
IGJvdW5kIHRvIHRoZSB2cS4gSWYgcGlkIGlzIC0xLCB0aGVuIGEgbmV3Cj4gCj4gV2hhdCBhYm91
dCBhZGRpbmcgYSBtYWNybyBmb3IgLTE/IChlLmcuIFZIT1NUX1ZSSU5HX05FV19XT1JLRVIpCgpZ
ZWFoLCB0aGF0IGlzIG5pY2VyIHRoYW4gYSBtYWdpYyBudW1iZXIuIFdpbGwgZG8uCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
