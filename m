Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26595C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 02:30:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F2764E4B
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 02:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F2764E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C5D26F581
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 02:30:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p_PkMv2P51f6 for <virtualization@archiver.kernel.org>;
	Wed, 10 Feb 2021 02:30:23 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id E78D76F5A8; Wed, 10 Feb 2021 02:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A2366F531;
	Wed, 10 Feb 2021 02:30:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48398C0174;
	Wed, 10 Feb 2021 02:30:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0439C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 02:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9ABD36F531
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 02:30:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z39QipEFSPa7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 02:30:12 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 52BB06F558; Wed, 10 Feb 2021 02:30:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A8D86F546
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 02:30:10 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A2Tuct005119;
 Wed, 10 Feb 2021 02:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Or2jmmlYiNXd2tTj0RQNVkDfZM+1wpjCjO6ANL1Cifc=;
 b=Olnl0Ikm7+lcl5t97nSVYwlR96wD+mwt7MuNHQHrl2p6mz+RKkOC6vVgS/vjjCQgoFLu
 txO7atdueo9LTRahi8ACWrvZ0zCHjpMrB8jzDLEiFUKnUGoMsx/6KWHM8tSXT46/DxJv
 zj2X+lfUGeQsUYjIXzFhE+UZSGvFQvG/uizZrt9QC26M8Pr2h9e1AHUAnjb7D+sAxcnR
 zMeTZRlVYcvzQRaau9EM+gl+rKNJOZUmllors55X9uzUiZMP5FhT0cxYzw/zqBpI0HlT
 oLhh6L2NupJYix982ew9juL3LyP/kij1QHn28KdYwWSKg7z0nJ3nvtcw/c1Ya6qT4nec OQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 36hgmaht0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Feb 2021 02:30:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A2OejQ117026;
 Wed, 10 Feb 2021 02:30:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by userp3020.oracle.com with ESMTP id 36j4vs73pa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Feb 2021 02:30:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp2O15Iv8cmzwyV/n8mNNtfvG4sPBcw0CMHk/pPxCntRLwdlrIDzQhcGPiW5RPMWzuVJl/Tc9K6c8By707sOQlxm3hGR7Kmj55z9wiPeo51qI2A8esjmhPK8xXO3oqcNp9Joys1vQ3XBo4jDDJIr+Ccl1W0wOs3wBBZvdebNcv+oD+PuQ608tklSNW2AR4wLod17uYPAl216wp7D9kvZ3+PTHvoooaDQiJQWr1XKias5GNC350fHV06PGm98rIjmjIx9EAPqz/XJZlQlbU97Kx4uqw4U0/87kMraPcLwNVa5NHlkI0JJoDAGuKI0kCKProfa0Pw8LaWm47v0SMtYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or2jmmlYiNXd2tTj0RQNVkDfZM+1wpjCjO6ANL1Cifc=;
 b=CmU+6orvVem6VEoGmlUoGDJ/xzuqqAOJzsASgeJEmOgnXAlj/pGVdO1ZnWYCWRYCMg4GsbDkCswHq8Si14CZ/cK2W+j5qrxACB9BleTXuox3puoY0hCPLSYUqt/5JgPD/5ZbRgN2PKGHyRPcCIzBIh7IOZbcZGI3rMa5yxOWkVVPUSThLmv+OKSXlBTP7Nqmd2HEovNPESFVjdEnI9PDM5CbaVqGLy/9cgglvORxkRAiGTvWqYs3t9W8uj+9cYf617odsk63jZvYpBfWphJXeXv0hP5Oirh3IHBEo0Lmf7FklI4FPKAtGsc6/lkBahFLgbY4zDMfcLT7FQIX5BsjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or2jmmlYiNXd2tTj0RQNVkDfZM+1wpjCjO6ANL1Cifc=;
 b=ZvR1dnSeaTZTG+76vZSZTiXgBI3MEXyreBLPXyO1nvJ8bDFISYT/7qCX3iHHWO7RVaozfr6OsIZpeglBlcZexhPbhnVlycDOHFWhNTE9S4YPQxs+7zHn9rW61G83vAYWwm2aCzHXfFLRfqbXlBov4UWQdES8zBYytsfNAaUmr0E=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3128.namprd10.prod.outlook.com (2603:10b6:a03:14e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 02:30:05 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359%5]) with mapi id 15.20.3846.026; Wed, 10 Feb 2021
 02:30:05 +0000
Subject: Re: [PATCH v1] vdpa/mlx5: Restore the hardware used index after
 change map
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20210204073618.36336-1-elic@nvidia.com>
 <81f5ce4f-cdb0-26cd-0dce-7ada824b1b86@oracle.com>
 <f2206fa2-0ddc-1858-54e7-71614b142e46@redhat.com>
 <20210208063736.GA166546@mtl-vdi-166.wap.labs.mlnx>
 <0d592ed0-3cea-cfb0-9b7b-9d2755da3f12@redhat.com>
 <20210208100445.GA173340@mtl-vdi-166.wap.labs.mlnx>
 <379d79ff-c8b4-9acb-1ee4-16573b601973@redhat.com>
 <20210209061232.GC210455@mtl-vdi-166.wap.labs.mlnx>
 <411ff244-a698-a312-333a-4fdbeb3271d1@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
Message-ID: <a90dd931-43cc-e080-5886-064deb972b11@oracle.com>
Date: Tue, 9 Feb 2021 18:30:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <411ff244-a698-a312-333a-4fdbeb3271d1@redhat.com>
Content-Language: en-US
X-Originating-IP: [73.189.186.83]
X-ClientProxiedBy: BY3PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::14) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (73.189.186.83) by
 BY3PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend
 Transport; Wed, 10 Feb 2021 02:30:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 661e1df6-3f60-49d9-974c-08d8cd6bc66b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3128:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3128B45624432CDE38FB12E4B18D9@BYAPR10MB3128.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjHLI6qLU9FS2oiyhWzquUQn8jG1iznw8MXKBKBj6GlA5OdEiPZPL3MbDPux638H35YKpoo90RhOOhj5wpoLBN8jL9vxmnxttEeTaod1/Ti2TlHbKskGV77AyA1JAoodVeD0Hoe4u8Sx8dK6eepxSIbNuz9xj5Vc0RQ4D6yiexxrWg2HsDb3+Shg2ttXGduMfsThiaInW/zVTUHIRLZvtqMyi2FSNGr1LCk/kf5jr9MILnT9w2osdZAkumKrJ81ZSTSCkXmLxnoTl/E+gU15cMSaHNTOCb/d9FTZL7WTWpW7/3XXbVzJ63Gw1T6q+UL6l9fmVkO48V22NDefXLBRmrr8av958hOlVnyj/vZOIIeRzFpMlhqLJzgwLYxU+LXBtPeVE0gneQy5FE3Zc6JoKAmAOzMJy321vEPCP+3SB47jeGSsAh2lEthN+dAInjm8tbMrGIXUhCSOwMm8pNJosUUtxCqBG/dKtFzUR0bPixtN/kGPFdCkFRkNapm4Y5BJW8SCZtg5BqET30TnUgUG5OgNzkAFAJq1nEpb1aDhJtxvhYpsWJ8jVX/G7Du/0QKGvhDwpudLIKZ4jmlLkDcoam8SWmXbr/L5nG6SWTRQBp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(31686004)(6486002)(53546011)(83380400001)(5660300002)(26005)(8936002)(86362001)(16526019)(2616005)(316002)(36916002)(110136005)(186003)(2906002)(16576012)(8676002)(4326008)(956004)(36756003)(478600001)(66476007)(31696002)(66946007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?alZwcEd1MnJvVEErWWFGY1hzaXFOZ2VVbnJKaEdVb0lQcjZDWW9EeFBPalR4?=
 =?utf-8?B?TnRpMDNjWXN0RE1MaTVteWgzUHpLVVNhdGthZlpXNlZsTG1CNG9WS004aFh1?=
 =?utf-8?B?QzRleHprUGNsdmRkaERQVW5NczNwT1U4ZnJJUnpIb0xYVXA1VStOWXBHQ3BF?=
 =?utf-8?B?Qmt0WEVaVTRmVjRmazhjaEJmNENRQi9zbXdlei9jakcyOEw2cnhCZGFlRDNy?=
 =?utf-8?B?Nk02YXNrSTlHRmppYnlxZHlrR0dsdlFPamVtYlh2bTAwNGQ0a0tScWVmR2N2?=
 =?utf-8?B?R1p2Qnp3Q3ZEc0tQaGkrQm9DUEJlUGZXRFZvcG1VWXpzZWZ6ME5vTHRQbDA2?=
 =?utf-8?B?SDB4M21RajIybTQrM1dwL1hueXcybW00MTBWeHpPZWozSHU0aTJ3bEJJcXly?=
 =?utf-8?B?c1BvS2o0RG9KU2RES0RiZkdhbG5lU3RBQkdKUkJMNFFkUWtOQlFXa2Q1SjVO?=
 =?utf-8?B?eGdNWXBnNDVITGFnNy9INWdpR2M1MDhRSGVtenB3RWl1S3BEVkoxdmVOaUJh?=
 =?utf-8?B?NGI2dEtNQTdkVTh2RVdlS1J0aTkySGxVQ1BsY3Q1YUJsVE13SGFrVHBST3dk?=
 =?utf-8?B?LzVqV0toVStLditYd1QrdXVHdzNUeXV1Nm5vTlhYV2k2TDBLR3gzaEtpWmZT?=
 =?utf-8?B?WW1qbkMwMkJTZS96ZmFxRGtVUmhtS25jVkxSQmhBaHY4S2VHVEN1V1NNLzZR?=
 =?utf-8?B?Wm5ubVVnU3RreG1QVVpWT3VsQThoTVN1OEZaeGUrV0ZjNHczekY5T2xkR0lM?=
 =?utf-8?B?WDJOVjZDNUNZaWxEbkkzV21kWWh1elFNR2dWa2tDckcwV0MwR2VtWkRxMGpT?=
 =?utf-8?B?dUZNVjZXajRQVEpVbGFQSW1MaHpKdFFyL2RpbmtWLzA4aVRhZHJLQnZHYmFY?=
 =?utf-8?B?L2dQenQ5MjBNL3ExM0Q1aTlDeE8zMFJWYnJKTzZKLzJ4RzVtbFdxYTBRcUgy?=
 =?utf-8?B?OWd6WGNZYmNXRG9XbHdTcU5oa25FaEtydnpOZ0JQTHNnbmZJR1dWS1dZTSsw?=
 =?utf-8?B?ME0rQzd2MHo4Z1FQTlBCU01MZWRKSmFTbWZSZmFFVFZYNGhNZGpoWFNWOE9T?=
 =?utf-8?B?eTlKVEFuM2dEMWpWZGdxY2dKalRPdzRxVTFFcHdHM0ZpaU1iV25GVysvSjBp?=
 =?utf-8?B?bkZucjg5dEVXenUrZHowWXJMQ1p0cUFtdDFmVzV1bEM4UU1RNFpOdmxCOVM3?=
 =?utf-8?B?K1hHUzZvMTJpVHptUitONWgvdklkZktudTlKZVJvd2Vud3paRzhHcjNFMndy?=
 =?utf-8?B?dFRRbFlKZ1g0aFZlT1NUSElUQStYNXpMb3VjZ3F4RFR0bW5lRTRmTHdqeWFw?=
 =?utf-8?B?YzYzbmZVRTl4cTF5N3M5dSttNjhDNmxwakR0c1c5NTVIMU1jaVZTcTZxdC9Z?=
 =?utf-8?B?ZFEyVHdxVThFRHJTV1IrOWR2SElPTnpEWElTZFpKWTNHNmxtNmVGYkZvOGQ4?=
 =?utf-8?B?QVFtUFJQTU1tc3liSGpOaFdUQm5QRkRTNzQ4UkFxWTBhYnpoRHJ0TkV5Q1NO?=
 =?utf-8?B?Um83SW5UODY2VWk5Q3ZWTnA0UlMvUFM2RlBHcGswU2JSTitWZTZYNTRuTFp3?=
 =?utf-8?B?dDRVbGtvU3RodVY4ZUdMaVk2MDR6Q1I0dm0zRnQ1ZGd3M1ZhZENiNGE2SVFQ?=
 =?utf-8?B?VVltczlNcUd0YVVmRCtFQW9lODZYTit2NUVSSEtmZmZITUQ5Qk12L2pjalNI?=
 =?utf-8?B?UzhyUjFDSkJzM3hQR3NKdVIxV0ZpcGFHSFZGSE9wS2dPVm1nMVQ4c1FvMzNm?=
 =?utf-8?Q?sLUkGM5Hpa98x9So+POtaQcRhO4eNc7qYAQjm4i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661e1df6-3f60-49d9-974c-08d8cd6bc66b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 02:30:04.9468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4f7/8KYrefICQdZic4K7FEr4flUwS9lZrZtRkZfIBcuLSpdj20YPanVnjRwlq8c69PrTyeQQw4hMJBhW66Pdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100023
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100024
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, lulu@redhat.com, mst@redhat.com
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

CgpPbiAyLzgvMjAyMSAxMDozNyBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IE9uIDIwMjEvMi85
IOS4i+WNiDI6MTIsIEVsaSBDb2hlbiB3cm90ZToKPj4gT24gVHVlLCBGZWIgMDksIDIwMjEgYXQg
MTE6MjA6MTRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+IE9uIDIwMjEvMi84IOS4i+WN
iDY6MDQsIEVsaSBDb2hlbiB3cm90ZToKPj4+PiBPbiBNb24sIEZlYiAwOCwgMjAyMSBhdCAwNTow
NDoyN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+PiBPbiAyMDIxLzIvOCDkuIvljYgy
OjM3LCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+PiBPbiBNb24sIEZlYiAwOCwgMjAyMSBhdCAxMjoy
NzoxOFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+IE9uIDIwMjEvMi82IOS4iuWN
iDc6MDcsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+Pj4+IE9uIDIvMy8yMDIxIDExOjM2IFBNLCBF
bGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4+PiBXaGVuIGEgY2hhbmdlIG9mIG1lbW9yeSBtYXAgb2Nj
dXJzLCB0aGUgaGFyZHdhcmUgcmVzb3VyY2VzIGFyZSAKPj4+Pj4+Pj4+IGRlc3Ryb3llZAo+Pj4+
Pj4+Pj4gYW5kIHRoZW4gcmUtY3JlYXRlZCBhZ2FpbiB3aXRoIHRoZSBuZXcgbWVtb3J5IG1hcC4g
SW4gc3VjaCAKPj4+Pj4+Pj4+IGNhc2UsIHdlIG5lZWQKPj4+Pj4+Pj4+IHRvIHJlc3RvcmUgdGhl
IGhhcmR3YXJlIGF2YWlsYWJsZSBhbmQgdXNlZCBpbmRpY2VzLiBUaGUgZHJpdmVyIAo+Pj4+Pj4+
Pj4gZmFpbGVkIHRvCj4+Pj4+Pj4+PiByZXN0b3JlIHRoZSB1c2VkIGluZGV4IHdoaWNoIGlzIGFk
ZGVkIGhlcmUuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gQWxzbywgc2luY2UgdGhlIGRyaXZlciBhbHNv
IGZhaWxzIHRvIHJlc2V0IHRoZSBhdmFpbGFibGUgYW5kIHVzZWQKPj4+Pj4+Pj4+IGluZGljZXMg
dXBvbiBkZXZpY2UgcmVzZXQsIGZpeCB0aGlzIGhlcmUgdG8gYXZvaWQgcmVncmVzc2lvbiAKPj4+
Pj4+Pj4+IGNhdXNlZCBieQo+Pj4+Pj4+Pj4gdGhlIGZhY3QgdGhhdCB1c2VkIGluZGV4IG1heSBu
b3QgYmUgemVybyB1cG9uIGRldmljZSByZXNldC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBGaXhlczog
MWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCAK
Pj4+Pj4+Pj4+IG1seDUKPj4+Pj4+Pj4+IGRldmljZXMiKQo+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogRWxpIENvaGVuPGVsaWNAbnZpZGlhLmNvbT4KPj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+Pj4gdjAg
LT4gdjE6Cj4+Pj4+Pj4+PiBDbGVhciBpbmRpY2VzIHVwb24gZGV2aWNlIHJlc2V0Cj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4gwqDCoCDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAx
OCArKysrKysrKysrKysrKysrKysKPj4+Pj4+Pj4+IMKgwqAgwqAgMSBmaWxlIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKykKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+Pj4gaW5kZXggODhkZGUzNDU1YmZkLi5iNWZlNmQyYWQyMmYg
MTAwNjQ0Cj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+
Pj4gQEAgLTg3LDYgKzg3LDcgQEAgc3RydWN0IG1seDVfdnFfcmVzdG9yZV9pbmZvIHsKPj4+Pj4+
Pj4+IMKgwqAgwqDCoMKgwqDCoCB1NjQgZGV2aWNlX2FkZHI7Cj4+Pj4+Pj4+PiDCoMKgIMKgwqDC
oMKgwqAgdTY0IGRyaXZlcl9hZGRyOwo+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIHUxNiBhdmFp
bF9pbmRleDsKPj4+Pj4+Pj4+ICvCoMKgwqAgdTE2IHVzZWRfaW5kZXg7Cj4+Pj4+Pj4+PiDCoMKg
IMKgwqDCoMKgwqAgYm9vbCByZWFkeTsKPj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCBzdHJ1Y3Qg
dmRwYV9jYWxsYmFjayBjYjsKPj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCBib29sIHJlc3RvcmU7
Cj4+Pj4+Pj4+PiBAQCAtMTIxLDYgKzEyMiw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVl
IHsKPj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCB1MzIgdmlydHFfaWQ7Cj4+Pj4+Pj4+PiDCoMKg
IMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXY7Cj4+Pj4+Pj4+PiDCoMKgIMKg
wqDCoMKgwqAgdTE2IGF2YWlsX2lkeDsKPj4+Pj4+Pj4+ICvCoMKgwqAgdTE2IHVzZWRfaWR4Owo+
Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIGludCBmd19zdGF0ZTsKPj4+Pj4+Pj4+IMKgwqAgwqAg
wqDCoMKgwqDCoCAvKiBrZWVwIGxhc3QgaW4gdGhlIHN0cnVjdCAqLwo+Pj4+Pj4+Pj4gQEAgLTgw
NCw2ICs4MDYsNyBAQCBzdGF0aWMgaW50IGNyZWF0ZV92aXJ0cXVldWUoc3RydWN0IAo+Pj4+Pj4+
Pj4gbWx4NV92ZHBhX25ldAo+Pj4+Pj4+Pj4gKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1
ZQo+Pj4+Pj4+Pj4gwqDCoCDCoCDCoMKgwqDCoMKgIG9ial9jb250ZXh0ID0gTUxYNV9BRERSX09G
KGNyZWF0ZV92aXJ0aW9fbmV0X3FfaW4sIGluLAo+Pj4+Pj4+Pj4gb2JqX2NvbnRleHQpOwo+Pj4+
Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIE1MWDVfU0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9j
b250ZXh0LCAKPj4+Pj4+Pj4+IGh3X2F2YWlsYWJsZV9pbmRleCwKPj4+Pj4+Pj4+IG12cS0+YXZh
aWxfaWR4KTsKPj4+Pj4+Pj4+ICvCoMKgwqAgTUxYNV9TRVQodmlydGlvX25ldF9xX29iamVjdCwg
b2JqX2NvbnRleHQsIGh3X3VzZWRfaW5kZXgsCj4+Pj4+Pj4+PiBtdnEtPnVzZWRfaWR4KTsKPj4+
Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCBNTFg1X1NFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpf
Y29udGV4dCwKPj4+Pj4+Pj4+IHF1ZXVlX2ZlYXR1cmVfYml0X21hc2tfMTJfMywKPj4+Pj4+Pj4+
IGdldF9mZWF0dXJlc18xMl8zKG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcykpOwo+Pj4+Pj4+
Pj4gwqDCoCDCoMKgwqDCoMKgIHZxX2N0eCA9IE1MWDVfQUREUl9PRih2aXJ0aW9fbmV0X3Ffb2Jq
ZWN0LCBvYmpfY29udGV4dCwKPj4+Pj4+Pj4+IHZpcnRpb19xX2NvbnRleHQpOwo+Pj4+Pj4+Pj4g
QEAgLTEwMjIsNiArMTAyNSw3IEBAIHN0YXRpYyBpbnQgY29ubmVjdF9xcHMoc3RydWN0IG1seDVf
dmRwYV9uZXQKPj4+Pj4+Pj4+ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbQo+
Pj4+Pj4+Pj4gwqDCoCDCoCBzdHJ1Y3QgbWx4NV92aXJ0cV9hdHRyIHsKPj4+Pj4+Pj4+IMKgwqAg
wqDCoMKgwqDCoCB1OCBzdGF0ZTsKPj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCB1MTYgYXZhaWxh
YmxlX2luZGV4Owo+Pj4+Pj4+Pj4gK8KgwqDCoCB1MTYgdXNlZF9pbmRleDsKPj4+Pj4+Pj4+IMKg
wqAgwqAgfTsKPj4+Pj4+Pj4+IMKgwqAgwqAgwqAgc3RhdGljIGludCBxdWVyeV92aXJ0cXVldWUo
c3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIAo+Pj4+Pj4+Pj4gc3RydWN0Cj4+Pj4+Pj4+PiBt
bHg1X3ZkcGFfdmlydHF1ZXVlICptdnEsCj4+Pj4+Pj4+PiBAQCAtMTA1Miw2ICsxMDU2LDcgQEAg
c3RhdGljIGludCBxdWVyeV92aXJ0cXVldWUoc3RydWN0Cj4+Pj4+Pj4+PiBtbHg1X3ZkcGFfbmV0
ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1Cj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKg
wqAgbWVtc2V0KGF0dHIsIDAsIHNpemVvZigqYXR0cikpOwo+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDC
oMKgIGF0dHItPnN0YXRlID0gTUxYNV9HRVQodmlydGlvX25ldF9xX29iamVjdCwgCj4+Pj4+Pj4+
PiBvYmpfY29udGV4dCwgc3RhdGUpOwo+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIGF0dHItPmF2
YWlsYWJsZV9pbmRleCA9IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3QsCj4+Pj4+Pj4+PiBv
YmpfY29udGV4dCwgaHdfYXZhaWxhYmxlX2luZGV4KTsKPj4+Pj4+Pj4+ICvCoMKgwqAgYXR0ci0+
dXNlZF9pbmRleCA9IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIAo+Pj4+Pj4+Pj4gb2Jq
X2NvbnRleHQsCj4+Pj4+Pj4+PiBod191c2VkX2luZGV4KTsKPj4+Pj4+Pj4+IMKgwqAgwqDCoMKg
wqDCoCBrZnJlZShvdXQpOwo+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+
Pj4+Pj4gwqDCoCDCoCBAQCAtMTUzNSw2ICsxNTQwLDE2IEBAIHN0YXRpYyB2b2lkIAo+Pj4+Pj4+
Pj4gdGVhcmRvd25fdmlydHF1ZXVlcyhzdHJ1Y3QKPj4+Pj4+Pj4+IG1seDVfdmRwYV9uZXQgKm5k
ZXYpCj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqAgfQo+Pj4+Pj4+Pj4gwqDCoCDCoCB9Cj4+Pj4+
Pj4+PiDCoMKgIMKgICtzdGF0aWMgdm9pZCBjbGVhcl92aXJ0cXVldWVzKHN0cnVjdCBtbHg1X3Zk
cGFfbmV0ICpuZGV2KQo+Pj4+Pj4+Pj4gK3sKPj4+Pj4+Pj4+ICvCoMKgwqAgaW50IGk7Cj4+Pj4+
Pj4+PiArCj4+Pj4+Pj4+PiArwqDCoMKgIGZvciAoaSA9IG5kZXYtPm12ZGV2Lm1heF92cXMgLSAx
OyBpID49IDA7IGktLSkgewo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIG5kZXYtPnZxc1tpXS5h
dmFpbF9pZHggPSAwOwo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIG5kZXYtPnZxc1tpXS51c2Vk
X2lkeCA9IDA7Cj4+Pj4+Pj4+PiArwqDCoMKgIH0KPj4+Pj4+Pj4+ICt9Cj4+Pj4+Pj4+PiArCj4+
Pj4+Pj4+PiDCoMKgIMKgIC8qIFRPRE86IGNyb3NzLWVuZGlhbiBzdXBwb3J0ICovCj4+Pj4+Pj4+
PiDCoMKgIMKgIHN0YXRpYyBpbmxpbmUgYm9vbCBtbHg1X3ZkcGFfaXNfbGl0dGxlX2VuZGlhbihz
dHJ1Y3QgCj4+Pj4+Pj4+PiBtbHg1X3ZkcGFfZGV2Cj4+Pj4+Pj4+PiAqbXZkZXYpCj4+Pj4+Pj4+
PiDCoMKgIMKgIHsKPj4+Pj4+Pj4+IEBAIC0xNjEwLDYgKzE2MjUsNyBAQCBzdGF0aWMgaW50IHNh
dmVfY2hhbm5lbF9pbmZvKHN0cnVjdAo+Pj4+Pj4+Pj4gbWx4NV92ZHBhX25ldCAqbmRldiwgc3Ry
dWN0IG1seDVfdmRwYV92aXJ0cXUKPj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiBlcnI7Cj4+Pj4+Pj4+PiDCoMKgIMKgIMKgwqDCoMKgwqAgcmktPmF2YWlsX2luZGV4ID0g
YXR0ci5hdmFpbGFibGVfaW5kZXg7Cj4+Pj4+Pj4+PiArwqDCoMKgIHJpLT51c2VkX2luZGV4ID0g
YXR0ci51c2VkX2luZGV4Owo+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIHJpLT5yZWFkeSA9IG12
cS0+cmVhZHk7Cj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqAgcmktPm51bV9lbnQgPSBtdnEtPm51
bV9lbnQ7Cj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqAgcmktPmRlc2NfYWRkciA9IG12cS0+ZGVz
Y19hZGRyOwo+Pj4+Pj4+Pj4gQEAgLTE2NTQsNiArMTY3MCw3IEBAIHN0YXRpYyB2b2lkIHJlc3Rv
cmVfY2hhbm5lbHNfaW5mbyhzdHJ1Y3QKPj4+Pj4+Pj4+IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4+
Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+Pj4+Pj4+
Pj4gwqDCoCDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgbXZxLT5hdmFpbF9pZHggPSByaS0+YXZhaWxf
aW5kZXg7Cj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgbXZxLT51c2VkX2lkeCA9IHJpLT51c2Vk
X2luZGV4Owo+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgbXZxLT5yZWFkeSA9IHJp
LT5yZWFkeTsKPj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgIG12cS0+bnVtX2VudCA9
IHJpLT5udW1fZW50Owo+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgbXZxLT5kZXNj
X2FkZHIgPSByaS0+ZGVzY19hZGRyOwo+Pj4+Pj4+Pj4gQEAgLTE3NjgsNiArMTc4NSw3IEBAIHN0
YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdAo+Pj4+Pj4+Pj4gdmRwYV9kZXZp
Y2UgKnZkZXYsIHU4IHN0YXR1cykKPj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCBpZiAoIXN0YXR1
cykgewo+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgbWx4NV92ZHBhX2luZm8obXZk
ZXYsICJwZXJmb3JtaW5nIGRldmljZSByZXNldFxuIik7Cj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKg
wqDCoMKgwqDCoCB0ZWFyZG93bl9kcml2ZXIobmRldik7Cj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqAgY2xlYXJfdmlydHF1ZXVlcyhuZGV2KTsKPj4+Pj4+Pj4gVGhlIGNsZWFyaW5nIGxvb2tzIGZp
bmUgYXQgdGhlIGZpcnN0IGdsYW5jZSwgYXMgaXQgYWxpZ25zIHdpdGggCj4+Pj4+Pj4+IHRoZSBv
dGhlcgo+Pj4+Pj4+PiBzdGF0ZSBjbGVhbnVwcyBmbG9hdGluZyBhcm91bmQgYXQgdGhlIHNhbWUg
cGxhY2UuIEhvd2V2ZXIsIHRoZSAKPj4+Pj4+Pj4gdGhpbmcgaXMKPj4+Pj4+Pj4gZ2V0X3ZxX3N0
YXRlKCkgaXMgc3VwcG9zZWQgdG8gYmUgY2FsbGVkIHJpZ2h0IGFmdGVyIHRvIGdldCAKPj4+Pj4+
Pj4gc3luYydlZCB3aXRoCj4+Pj4+Pj4+IHRoZSBsYXRlc3QgaW50ZXJuYWwgYXZhaWxfaW5kZXgg
ZnJvbSBkZXZpY2Ugd2hpbGUgdnEgaXMgCj4+Pj4+Pj4+IHN0b3BwZWQuIFRoZQo+Pj4+Pj4+PiBp
bmRleCB3YXMgc2F2ZWQgaW4gdGhlIGRyaXZlciBzb2Z0d2FyZSBhdCB2cSBzdXNwZW5zaW9uLCBi
dXQgCj4+Pj4+Pj4+IGJlZm9yZSB0aGUKPj4+Pj4+Pj4gdmlydHEgb2JqZWN0IGlzIGRlc3Ryb3ll
ZC4gV2Ugc2hvdWxkbid0IGNsZWFyIHRoZSBhdmFpbF9pbmRleCAKPj4+Pj4+Pj4gdG9vIGVhcmx5
Lgo+Pj4+Pj4+IEdvb2QgcG9pbnQuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGVyZSdzIGEgbGltaXRhdGlv
biBvbiB0aGUgdmlydGlvIHNwZWMgYW5kIHZEUEEgZnJhbWV3b3JrIHRoYXQgCj4+Pj4+Pj4gd2Ug
Y2FuIG5vdAo+Pj4+Pj4+IHNpbXBseSBkaWZmZXIgZGV2aWNlIHN1c3BlbmRpbmcgZnJvbSBkZXZp
Y2UgcmVzZXQuCj4+Pj4+Pj4KPj4+Pj4+IEFyZSB5b3UgdGFsa2luZyBhYm91dCBsaXZlIG1pZ3Jh
dGlvbiB3aGVyZSB5b3UgcmVzZXQgdGhlIGRldmljZSBidXQKPj4+Pj4+IHN0aWxsIHdhbnQgdG8g
a25vdyBob3cgZmFyIGl0IHByb2dyZXNzZWQgaW4gb3JkZXIgdG8gY29udGludWUgCj4+Pj4+PiBm
cm9tIHRoZQo+Pj4+Pj4gc2FtZSBwbGFjZSBpbiB0aGUgbmV3IFZNPwo+Pj4+PiBZZXMuIFNvIGlm
IHdlIHdhbnQgdG8gc3VwcG9ydCBsaXZlIG1pZ3JhdGlvbiBhdCB3ZSBuZWVkOgo+Pj4+Pgo+Pj4+
PiBpbiBzcmMgbm9kZToKPj4+Pj4gMSkgc3VzcGVuZCB0aGUgZGV2aWNlCj4+Pj4+IDIpIGdldCBs
YXN0X2F2YWlsX2lkeCB2aWEgZ2V0X3ZxX3N0YXRlKCkKPj4+Pj4KPj4+Pj4gaW4gdGhlIGRzdCBu
b2RlOgo+Pj4+PiAzKSBzZXQgbGFzdF9hdmFpbF9pZHggdmlhIHNldF92cV9zdGF0ZSgpCj4+Pj4+
IDQpIHJlc3VtZSB0aGUgZGV2aWNlCj4+Pj4+Cj4+Pj4+IFNvIHlvdSBjYW4gc2VlLCBzdGVwIDIg
cmVxdWlyZXMgdGhlIGRldmljZS9kcml2ZXIgbm90IHRvIGZvcmdldCB0aGUKPj4+Pj4gbGFzdF9h
dmFpbF9pZHguCj4+Pj4+Cj4+Pj4gSnVzdCB0byBiZSBzdXJlLCB3aGF0IHJlYWxseSBtYXR0ZXJz
IGhlcmUgaXMgdGhlIHVzZWQgaW5kZXguIAo+Pj4+IEJlY3Vhc2UgdGhlCj4+Pj4gdnJpcXR1ZXVl
IGl0c2VsZiBpcyBjb3BpZWQgZnJvbSB0aGUgc3JjIFZNIHRvIHRoZSBkZXN0IFZNLiBUaGUgCj4+
Pj4gYXZhaWxhYmxlCj4+Pj4gaW5kZXggaXMgYWxyZWF5IHRoZXJlIGFuZCB3ZSBrbm93IHRoZSBo
YXJkd2FyZSByZWFkcyBpdCBmcm9tIHRoZXJlLgo+Pj4KPj4+IFNvIGZvciAibGFzdF9hdmFpbF9p
ZHgiIEkgbWVhbnQgdGhlIGhhcmR3YXJlIGludGVybmFsIGF2YWlsIGluZGV4LiAKPj4+IEl0J3Mg
bm90Cj4+PiBzdG9yZWQgaW4gdGhlIHZpcnRxdWV1ZSBzbyB3ZSBtdXN0IG1pZ3JhdGUgaXQgZnJv
bSBzcmMgdG8gZGVzdCBhbmQgCj4+PiBzZXQgdGhlbQo+Pj4gdGhyb3VnaCBzZXRfdnFfc3RhdGUo
KS4gVGhlbiBpbiB0aGUgZGVzdGluYXRpb24sIHRoZSB2aXJ0cXVldWUgY2FuIGJlCj4+PiByZXN0
YXJ0ZWQgZnJvbSB0aGF0IGluZGV4Lgo+Pj4KPj4gQ29uc2lkZXIgdGhpcyBjYXNlOiBkcml2ZXIg
cG9zdGVkIGJ1ZmZlcnMgdGlsbCBhdmFpbCBpbmRleCBiZWNvbWVzIHRoZQo+PiB2YWx1ZSA1MC4g
SGFyZHdhcmUgaXMgZXhlY3V0aW5nIGJ1dCBtYWRlIGl0IHRpbGwgMjAgd2hlbiB2aXJ0cXVldWUg
d2FzCj4+IHN1c3BlbmRlZCBkdWUgdG8gbGl2ZSBtaWdyYXRpb24gLSB0aGlzIGlzIGluZGljYXRl
ZCBieSBoYXJkd2FyZSB1c2VkCj4+IGluZGV4IGVxdWFsIDIwLgo+Cj4KPiBTbyBpbiB0aGlzIGNh
c2UgdGhlIHVzZWQgaW5kZXggaW4gdGhlIHZpcnRxdWV1ZSBzaG91bGQgYmUgMjA/IAo+IE90aGVy
d2lzZSB3ZSBuZWVkIG5vdCBzeW5jIHVzZWQgaW5kZXggaXRzZWxmIGJ1dCBhbGwgdGhlIHVzZWQg
ZW50cmllcyAKPiB0aGF0IGlzIG5vdCBjb21taXR0ZWQgdG8gdGhlIHVzZWQgcmluZy4KCkluIG90
aGVyIHdvcmQsIGZvciBtbHg1IHZkcGEgdGhlcmUncyBubyBzdWNoIGludGVybmFsIGxhc3RfYXZh
aWxfaWR4IApzdHVmZiBtYWludGFpbmVkIGJ5IHRoZSBoYXJkd2FyZSwgcmlnaHQ/IEFuZCB0aGUg
dXNlZF9pZHggaW4gdGhlIAp2aXJ0cXVldWUgaXMgYWx3YXlzIGluIHN5bmMgd2l0aCB0aGUgaGFy
ZHdhcmUgdXNlZF9pbmRleCwgYW5kIGhhcmR3YXJlIAppcyBzdXBwb3NlZCB0byBjb21taXQgcGVu
ZGluZyB1c2VkIGJ1ZmZlcnMgdG8gdGhlIHJpbmcgd2hpbGUgYnVtcGluZyB1cCAKdGhlIGhhcmR3
YXJlIHVzZWRfaW5kZXggKGFuZCBhbHNvIGNvbW1pdHRlZCB0byBtZW1vcnkpIGFsdG9nZXRoZXIg
cHJpb3IgCnRvIHN1c3BlbnNpb24sIGlzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVjdCBoZXJlPyBE
b3VibGUgY2hlY2tpbmcgaWYgdGhpcyAKaXMgdGhlIGV4cGVjdGVkIHNlbWFudGljcyBvZiB3aGF0
IAptb2RpZnlfdmlydHF1ZXVlKE1MWDVfVklSVElPX05FVF9RX09CSkVDVF9TVEFURV9TVVNQRU5E
KSBzaG91bGQgYWNoaWV2ZS4KCklmIHRoZSBhYm92ZSBpcyB0cnVlLCB0aGVuIGl0IGxvb2tzIHRv
IG1lIGZvciBtbHg1IHZkcGEgd2Ugc2hvdWxkIHJlYWxseSAKcmV0dXJuIGgvdyB1c2VkX2lkeCBy
YXRoZXIgdGhhbiB0aGUgbGFzdF9hdmFpbF9pZHggdGhyb3VnaCAKZ2V0X3ZxX3N0YXRlKCksIGlu
IG9yZGVyIHRvIHJlY29uc3RydWN0IHRoZSB2aXJ0IHF1ZXVlIHN0YXRlIHBvc3QgbGl2ZSAKbWln
cmF0aW9uLiBGb3IgdGhlIHNldF9tYXAgY2FzZSwgdGhlIGludGVybmFsIGxhc3RfYXZhaWxfaWR4
IHJlYWxseSAKZG9lc24ndCBtYXR0ZXIsIGFsdGhvdWdoIGJvdGggaW5kaWNlcyBhcmUgc2F2ZWQg
YW5kIHJlc3RvcmVkIAp0cmFuc3BhcmVudGx5IGFzLWlzLgoKLVNpd2VpCgo+Cj4KPj4gTm93IHRo
ZSB2cml0cXVldWUgaXMgY29waWVkIHRvIHRoZSBuZXcgVk0gYW5kIHRoZQo+PiBoYXJkd2FyZSBu
b3cgaGFzIHRvIGNvbnRpbnVlIGV4ZWN1dGlvbiBmcm9tIGluZGV4IDIwLiBXZSBuZWVkIHRvIHRl
bGwKPj4gdGhlIGhhcmR3YXJlIHZpYSBjb25maWd1cmluZyB0aGUgbGFzdCB1c2VkX2luZGV4Lgo+
Cj4KPiBJZiB0aGUgaGFyZHdhcmUgY2FuIG5vdCBzeW5jIHRoZSBpbmRleCBmcm9tIHRoZSB2aXJ0
cXVldWUsIHRoZSBkcml2ZXIgCj4gY2FuIGRvIHRoZSBzeW5jaHJvbml6YXRpb24gYnkgbWFrZSB0
aGUgbGFzdF91c2VkX2lkeCBlcXVhbHMgdG8gdXNlZCAKPiBpbmRleCBpbiB0aGUgdmlydHF1ZXVl
Lgo+Cj4gVGhhbmtzCj4KPgo+PiDCoCBTbyB3aHkgZG9uJ3Qgd2UKPj4gcmVzdG9yZSB0aGUgdXNl
ZCBpbmRleD8KPj4KPj4+PiBTbyBpdCBwdXp6bGVzIG1lIHdoeSBpcyBzZXRfdnFfc3RhdGUoKSB3
ZSBkbyBub3QgY29tbXVuaWNhdGUgdGhlIHNhdmVkCj4+Pj4gdXNlZCBpbmRleC4KPj4+Cj4+PiBX
ZSBkb24ndCBkbyB0aGF0IHNpbmNlOgo+Pj4KPj4+IDEpIGlmIHRoZSBoYXJkd2FyZSBjYW4gc3lu
YyBpdHMgaW50ZXJuYWwgdXNlZCBpbmRleCBmcm9tIHRoZSB2aXJ0cXVldWUKPj4+IGR1cmluZyBk
ZXZpY2UsIHRoZW4gd2UgZG9uJ3QgbmVlZCBpdAo+Pj4gMikgaWYgdGhlIGhhcmR3YXJlIGNhbiBu
b3Qgc3luYyBpdHMgaW50ZXJuYWwgdXNlZCBpbmRleCwgdGhlIGRyaXZlciAKPj4+IChlLmcgYXMK
Pj4+IHlvdSBkaWQgaGVyZSkgY2FuIGRvIHRoYXQuCj4+Pgo+Pj4gQnV0IHRoZXJlJ3Mgbm8gd2F5
IGZvciB0aGUgaGFyZHdhcmUgdG8gZGVkdWNlIHRoZSBpbnRlcm5hbCBhdmFpbCAKPj4+IGluZGV4
IGZyb20KPj4+IHRoZSB2aXJ0cXVldWUsIHRoYXQncyB3aHkgYXZhaWwgaW5kZXggaXMgc3ljbmVk
Lgo+Pj4KPj4+IFRoYW5rcwo+Pj4KPj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
