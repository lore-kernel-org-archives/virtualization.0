Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD3BC433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 12:10:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3225F60F48
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 12:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3225F60F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD3CD834C6;
	Fri, 15 Oct 2021 12:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pse4QrVojGQP; Fri, 15 Oct 2021 12:09:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4409483486;
	Fri, 15 Oct 2021 12:09:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20671C000F;
	Fri, 15 Oct 2021 12:09:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87A52C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 12:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7650560789
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 12:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="jX/3gj5H";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="HwYwpbSz"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id awE8UCRxWxC3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 12:09:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F4B76076B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 12:09:56 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FAM8W1029661; 
 Fri, 15 Oct 2021 12:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Vw9AgNf5NiCrxNnhzXcyxEQ9SMs8DzXtUxSszAPYgww=;
 b=jX/3gj5Hx5MdNgXmBpa2CLA9D91KCzDfOCCjFCdc9IcUfiQ/VFNOnwIGRGqJVFzCXm4+
 itR27FiHnzNSaAaDqugjodZ7a8+F5keluestWl3rJPuCmrZroJCoQqZEV9oiGfuVbfUV
 g9FMmaesGlsH20Ng61HCs063DJ5nj38hGqWrLAVOi+V74wLFWUyXk0YmO6AB9FFzPmhY
 MqH8Iwu14psNrVKWO/mmqCN9liaD1ihmClpnF3Y3EwH8DxCO25O42JspTNpFk6ZFYIwb
 CRRlW/2tZ7wlZtXnQc5Xjc0F88BHlCGBr10XfoNcyxHFCV3WVjmxEYTLjVzkk7ZGpgZS 3A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bphhuf9mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Oct 2021 12:09:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19FC5Iqf037196;
 Fri, 15 Oct 2021 12:09:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by userp3020.oracle.com with ESMTP id 3bkyvfms05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Oct 2021 12:09:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4g51k45zQYT0+ZI+2qzXLinKhZ8OD/xTG07Rxyepi2ocs+Fp/lkLQ5aei9a5vtkLEDIuGxSjLxOrO4UZPTgL0xImTooqsG1a/tuHHXf40eoeR60DLcL4esyn3fjD1B3s8kGcx4hnY5wBv4/dRRJZ6dpdZ+OQ42UI/VfhEW0osm8xasCcVtURQe2vT1eUu+MIwvaBMsqw9CeyoBCu3cldIhXDha91PzHgeGSmfZ0rmq1maRjzFf8YJSgWJDA9aN32bx8u+QbgyIbFOa6XAsoKb9/wa0HCZ2Lfx7dgoyzyZ+XG2f4yE1WHuq70Se6D86hco2cXiovBjpS44xo4WL5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw9AgNf5NiCrxNnhzXcyxEQ9SMs8DzXtUxSszAPYgww=;
 b=Tx5pryEVS2eMJD3yCRaPV4Ze7iRRzxg+SGlY14dVwZN8Yc1cbFHvTpBok1M3oSa75p1dra/aHxgjqZ+QV/HPjzrwZ7E+Kg3UyxywR2GvMDR0WmJlFcY1D++z3MGBVH1ea68dQNedaNw2fbLyOfd15Cheboz/xHa9bhgQILA1yL+Llf/5q68w16taCe8FUkrNDJzhG9a+C+xe4+3paFR8HhCivxw8yGmkogJWA3+H+IzKekimjivRmlVinG2KdhcTipVWgsZni8XVhsWs6aWsSsUt0B4gRvT4yZsJjF0AkzIGenYjHZZG6s5v35T6Gr9dd01Uq/N0GeXQOOS49fd0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw9AgNf5NiCrxNnhzXcyxEQ9SMs8DzXtUxSszAPYgww=;
 b=HwYwpbSzkX9XuWvsS+DGpc5bVYNXTb7/+ADVZka/fyXNv4yL0eAkbAvpaw9mreBuu9ZcO7Hsp7ZT1kK9mwY1tKamIKMAJdly957LE0llFXB01YgQagsu67JHkjegf4TCkhxbZE1vrfQD6xtyYYLP7ROHjmzH1mYZPC7Zzr6l93U=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BYAPR10MB2616.namprd10.prod.outlook.com (2603:10b6:a02:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 12:09:40 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::2848:63dc:b87:8021]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::2848:63dc:b87:8021%7]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 12:09:40 +0000
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
To: Jason Wang <jasowang@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-7-jasowang@redhat.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <c6641b6a-6204-2b41-e775-ad329314711c@oracle.com>
Date: Fri, 15 Oct 2021 05:09:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20211012065227.9953-7-jasowang@redhat.com>
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45)
 To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:400:7446:8000::58] (2606:b400:8301:1010::16aa)
 by BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.14 via Frontend Transport; Fri, 15 Oct 2021 12:09:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34cc950f-2821-4c2e-f775-08d98fd4aa13
X-MS-TrafficTypeDiagnostic: BYAPR10MB2616:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB26165F88842F8A0F2235CEC8F0B99@BYAPR10MB2616.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKLJKVX9lT4ZO3Fg08diwfMPhimC3Yc/U1ElT3KYYb+mWWgXo+/yJu5B4Z8Y+xTvV9X7bR7P7FYDEDEc0xR5v/CroyH9G4y45YFr4P28NBMHYSmG2AXBQSkmuTrcvJCuj/D9gw3mMrlIoyZ7s/84XvnXiSPGe7XLy2xAR4Fk6lYE/tlZU628OUfn8uEOeIN5VyjbsMp4s9pwboZaWk/hoYoEG04sEKGf1ofnuUwfxvqsZLBvpH7hc3NCIbyKzlLt8C+PNxsLZam/stNkQ8dZAxHKqOyC2kqpfv5nUnu/WExO9E8yGHzgwT73I3CVHr+LuSqfXUvEDqmain2QY0dW11LcDMZg6c3CSXMvkRj2nIO/6lGiMQya41I6i2mQ1D9oTvVk6iVBP0m9DsXtmBLSWLuA2hOgcp/dZd4Y99SQHZ/ly9dtVjmKQ9yj2YrKETP8dyErklhSsV4URA5a2SfdHHmJ6Qh1lmQTVsSWtBvwr8IPxcINM6nXRrdXWmSaUV69vZSxFxRk+fNuJicEMVUNUNadPGyUMWqU28l6Njb9rjkZ8HqvT4bkxLXGe0K9Uy8okydOpumSbrlXjHWJzMoJxjp+owX0wO+8v3ELtpj0SiRD1sQRx6SrSY7im/DaCFpUzig+c28G2FHsZuOKZGO6o90VttHZ3CIuaEtRX2poWafa4NEl+BurdNtVxi5IW2OuQvU7NBdb8mRmha0QcpYNrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(2616005)(86362001)(6486002)(6916009)(316002)(31696002)(38100700002)(4326008)(8676002)(5660300002)(508600001)(8936002)(31686004)(2906002)(36756003)(44832011)(66946007)(186003)(53546011)(54906003)(66476007)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWRrQ1ZuWUhSenJOVm5MaWFRc1JHbFJ4RkhrTFpPSHVKQ2FqNTY1RWErSnZ3?=
 =?utf-8?B?dVRYc1RscXUveUNHYWtIVVVXeXNhOGg3NG00c1RlclltMi9sVDNYTTR5MzBj?=
 =?utf-8?B?VEtJOGdpcHVQZFUyalJ5aHY3dlJZQlg5dU52QUcyR28yU0ViaTVRWThJdnVk?=
 =?utf-8?B?UzdUWEpHMVVFWDdWeXQ3QmRuQUluMjNoTjVFVTRaVmFsUXhPV1B4aTJYTE4w?=
 =?utf-8?B?Q1dXZjE1dU9JRENTb1I5UWRBZ2w1WGVjemFEZEl5TC9kSmZFNkVaVjNoWGRU?=
 =?utf-8?B?YXhBazhVM3czdmd0aEtNekVQYWtac3JLWDhkZStPMW1LUGVjbUR6OEM5SWtk?=
 =?utf-8?B?d3Q5L2cyQUNTbmdYWlJ2NlBtTnVKb3c1V1F4ZUlvblpVQzBqczA5UEUwc2h0?=
 =?utf-8?B?dDA5WVhDNXFmM05YNVFkTzlhZHlnK016WlVRK1FKQlg4cWQyODl5UXF3SW9T?=
 =?utf-8?B?aUNKMjFmSXhuSStwWlN5TkpYTElOQWxzNGw1VWR1aW5XUXVxa25EcDVlTXMx?=
 =?utf-8?B?S21WNHA5TjRqd2liQjh1dmlXVWYzenlCL1hRemhndkszSCswZ2lpZCtQdUgw?=
 =?utf-8?B?RGxKaHZsNHpHYmJFVFFzYVQyZzdJL1g3WjQ5YzRLcTJOaVlHcitRbnd1eGxy?=
 =?utf-8?B?QlZKR2Q1ZDcxY3N3SHlPeHU5c1ltZkpXenR6TXN6Y3JxcjBRS0doeVNFYUl0?=
 =?utf-8?B?aGdnQVZGMzBDNnE5bU9FZnQ1MGpXKzVjK2xheHZib3l0L3ZHNHg2aTdwZFEx?=
 =?utf-8?B?OXhiWTY3WVArTmVMNlg2a3VRallYRmdLbmR4bWJxb3lzOTZIcnRkcC9pQlcw?=
 =?utf-8?B?bllVV0UxQU1OZks1MDVHeGIrNkNOMFAyMGlHUUZ0SUNROUEvUTNCSFpEQ1VS?=
 =?utf-8?B?Q0tuTDNxT29Ka25nSHRCWFVsSDVTZnpKSjFnTGpWY2J3aEVWMmNYV0ZIcUFG?=
 =?utf-8?B?ekhUVjNjcW1IWjR2VTNrUUNhVkxkUXBLdUlqVDJWL3ZRN1Z0U1FLYUVjcnZH?=
 =?utf-8?B?bmhDa3dkVytVVnRkeUpoZ3g5SVA2VEtHUFdCcDdJUlF3VkxZL0hxVEZicDhl?=
 =?utf-8?B?U0g4UG93YnA4b3p4K0pTWVBqZ2dQdDFMVnVqUTREVjJIczlOUzJiUjBDOVkz?=
 =?utf-8?B?S0IzSEF1eVp2VG4zNUpKNjBCL1VNNXg1RDdISzJrZjVDWUVqWDU5N3dSbk9u?=
 =?utf-8?B?M005eFFGSjE5SThtUy9sWW40VTY4cXBJNzZoQVlRbHY1aDRiU2hWdXY0cVA3?=
 =?utf-8?B?aWRtOEtNVTVGMXRadDd5d0FEeGdjRjU3T0hWWlNHRE1rckNqRTkxR0R6a2J0?=
 =?utf-8?B?bEhadnIxZFNnKzJMNzNGeThyTlFvRzlTT3FxaG5rVW9hVzlmRGtrRFZzckhv?=
 =?utf-8?B?dmVKNHorOFBnTWpLMU52TmYrZE9zZldoY3ZIRUxlVWd4VnNmRXh0SzFUaUNR?=
 =?utf-8?B?OFltYkdXSXo3R21RU2pFcmVqTkR3eC9ZZGR2Z2FkOHZvY2tLclAvU2s1MEJr?=
 =?utf-8?B?ejZjWnpSSU1RWnFMNGpTd3p4UUtFSnQxb3NlNis1Q290WFI3NkRkSWFOUDBX?=
 =?utf-8?B?QmtFcjR1VFZaZHNUbk9QQWxPUDlQb1UzZEI4UVlGU0hqYjh5ZktCUldHcVNI?=
 =?utf-8?B?T2g1b2RTZXlMM2NMMUlNV1R6QVhPYlRhcnpNWWNzeFl1YWFhVENMV1Z2NUZz?=
 =?utf-8?B?Y0Qxb1liazZjMW5PVGFROUU1VCtQOFk2RlI0NHZraHhveFFya2RyMjRMbWln?=
 =?utf-8?B?TitGb1hkZ08ra1pMV2VuQnNVSXlxWGpNVUt1R2dBZUtiU0Nidng0bVVWbzJy?=
 =?utf-8?Q?GXTCEnC6j64p+kPSnAtwlS+qjpYBqVmjIxCHA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cc950f-2821-4c2e-f775-08d98fd4aa13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 12:09:40.1398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfiAKjBw6zTkCd+EV/QTqFvRiAZ7014TMhMpfe06wlEAzctRG6SmbVBLSSQ422pQOfK/obCwDAOs9ZakYgoILA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2616
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10137
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150074
X-Proofpoint-ORIG-GUID: GblfkXhp5JmsG8RdgCzz_w0KIL3zYF3l
X-Proofpoint-GUID: GblfkXhp5JmsG8RdgCzz_w0KIL3zYF3l
Cc: "Paul E . McKenney" <paulmck@kernel.org>, david.kaplan@amd.com,
 konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>,
 f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mst@redhat.com,
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

Hi Jason,

On 10/11/21 11:52 PM, Jason Wang wrote:
> We used to synchronize pending MSI-X irq handlers via
> synchronize_irq(), this may not work for the untrusted device which
> may keep sending interrupts after reset which may lead unexpected
> results. Similarly, we should not enable MSI-X interrupt until the

About "unexpected results", while you mentioned below in v1 ...

"My understanding is that e.g in the case of SEV/TDX we don't trust the
hypervisor. So the hypervisor can keep sending interrupts even if the
device is reset. The guest can only trust its own software interrupt
management logic to avoid call virtio callback in this case."

.. and you also mentioned to avoid the panic (due to untrusted device) in as
many scenarios as possible.


Here is my understanding.

The reason we do not trust hypervisor is to protect (1) data/code privacy for
most of times and sometimes (2) program execution integrity.

The bad thing is: the hypervisor is able to panic/destroy the VM in the worst case.

It is reasonable to re-configure/recover if we assume there is BUG at
hypervisor/device side. That is, the hypervisor/device is buggy, but not malicious.

However, how about to just detect and report the hypervisor/device is malicious
and shutdown/panic the VM immediately? If we have detected the malicious
hypervisor, we should avoid running VMs on the malicious hypervisor further. At
least how about to print error message to reminder users that the hypervisor is
malicious?


About "unexpected results", it should not be hang/panic. I suggest ...

Assuming SEV/TDX is involved, the hypervisor should never be able to derive the
VM privacy (at least secure memory data) by providing malicious configuration,
e.g., num_queues=0. If we detect hypervisor is malicious, the VM is
panic/shutdown immediately. At least how about to print error message to
reminder users.


BTW, while I always do care about the loss of interrupt issue, the malicious
device is able to hang a VM by dropping a single interrupt on purpose for
virtio-scsi :)


Thank you very much!

Dongli Zhang

> device is ready. So this patch fixes those two issues by:
> 
> 1) switching to use disable_irq() to prevent the virtio interrupt
>    handlers to be called after the device is reset.
> 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> 
> This can make sure the virtio interrupt handler won't be called before
> virtio_device_ready() and after reset.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
>  drivers/virtio/virtio_pci_common.h |  6 ++++--
>  drivers/virtio/virtio_pci_legacy.c |  5 +++--
>  drivers/virtio/virtio_pci_modern.c |  6 ++++--
>  4 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index b35bb2d57f62..0b9523e6dd39 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
>  		 "Force legacy mode for transitional virtio 1 devices");
>  #endif
>  
> -/* wait for pending irq handlers */
> -void vp_synchronize_vectors(struct virtio_device *vdev)
> +/* disable irq handlers */
> +void vp_disable_vectors(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
> @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>  		synchronize_irq(vp_dev->pci_dev->irq);
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> -		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> +		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> +}
> +
> +/* enable irq handlers */
> +void vp_enable_vectors(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	int i;
> +
> +	if (vp_dev->intx_enabled)
> +		return;
> +
> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> +		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
>  }
>  
>  /* the notify function used when creating a virt queue */
> @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
>  		 "%s-config", name);
>  	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> -			  vp_config_changed, 0, vp_dev->msix_names[v],
> +			  vp_config_changed, IRQF_NO_AUTOEN,
> +			  vp_dev->msix_names[v],
>  			  vp_dev);
>  	if (err)
>  		goto error;
> @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
>  			 "%s-virtqueues", name);
>  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> -				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
> +				  vp_vring_interrupt, IRQF_NO_AUTOEN,
> +				  vp_dev->msix_names[v],
>  				  vp_dev);
>  		if (err)
>  			goto error;
> @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>  			 "%s-%s",
>  			 dev_name(&vp_dev->vdev.dev), names[i]);
>  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> -				  vring_interrupt, 0,
> +				  vring_interrupt, IRQF_NO_AUTOEN,
>  				  vp_dev->msix_names[msix_vec],
>  				  vqs[i]);
>  		if (err)
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index beec047a8f8d..a235ce9ff6a5 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
>  	return container_of(vdev, struct virtio_pci_device, vdev);
>  }
>  
> -/* wait for pending irq handlers */
> -void vp_synchronize_vectors(struct virtio_device *vdev);
> +/* disable irq handlers */
> +void vp_disable_vectors(struct virtio_device *vdev);
> +/* enable irq handlers */
> +void vp_enable_vectors(struct virtio_device *vdev);
>  /* the notify function used when creating a virt queue */
>  bool vp_notify(struct virtqueue *vq);
>  /* the config->del_vqs() implementation */
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d62e9835aeec..bdf6bc667ab5 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
>  	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
> +	/* Disable VQ/configuration callbacks. */
> +	vp_disable_vectors(vdev);
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  }
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> +	.ready		= vp_enable_vectors,
>  	.get		= vp_get,
>  	.set		= vp_set,
>  	.get_status	= vp_get_status,
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 30654d3a0b41..acf0f6b6381d 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	 */
>  	while (vp_modern_get_status(mdev))
>  		msleep(1);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
> +	/* Disable VQ/configuration callbacks. */
> +	vp_disable_vectors(vdev);
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
>  }
>  
>  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> +	.ready		= vp_enable_vectors,
>  	.get		= NULL,
>  	.set		= NULL,
>  	.generation	= vp_generation,
> @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> +	.ready		= vp_enable_vectors,
>  	.get		= vp_get,
>  	.set		= vp_set,
>  	.generation	= vp_generation,
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
