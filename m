Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95618C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 12:14:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303BF60FC3
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 12:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 303BF60FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBE4560625;
	Wed, 11 Aug 2021 12:14:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D5LHFE8Jtoiv; Wed, 11 Aug 2021 12:14:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8A402605BC;
	Wed, 11 Aug 2021 12:14:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 560C0C001A;
	Wed, 11 Aug 2021 12:14:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 660E8C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 542F140393
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ManHzUln";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="TQUXHg4V";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Q5it2wF2"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fdt5JuSNRn1O
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:14:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A1F840172
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:13:59 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 17BC5t5D016345; Wed, 11 Aug 2021 12:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sH54Gtog3z9ZmDi/9dMjJkJPs/h1sinW52rCjPdRbOI=;
 b=ManHzUlntFA1e9aXlVitq/Y734gqum5m1QXD5SwnjGw4vfJakzNa/qZ+HqLmR2lBSus1
 1CgSjxcOkZAYI7qJIfT0BkOw/SHoV+eDAWTA7wtncKgo7Fpd6wc8lKnPAFhY/hjMiu4w
 e6OkIybiDr9WRgbRCRgxwjs3uH3wXW4+fwyNjO7Ql6MyRMan3v3KYWywBliMiUfJhvFU
 24riT1JtDrJyLbmXyhSQMLVA9rgXxVUaWmayZ1xXH5WgI3QpzXP1Rds+gMTo/F5gRs4A
 gs/FRI3BY16lc2w/0FUPltudP7FLfC9jcxb9MZjI57HnFhBsjHsyX03Lzp2KD0Q/Z00x dQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=sH54Gtog3z9ZmDi/9dMjJkJPs/h1sinW52rCjPdRbOI=;
 b=TQUXHg4VZe+unHDg7G/DoyHI8Gj6FO+3IWV+QoH0LU1Q19RRZcyw8gwnD+ZskpVDqknv
 Ug8LJEU67OuVPpM8Hw+elmowzu61M9UKU+T3auUc9LNaMA3rufArAKb7Vf6aXhutmUN8
 jIj1LR9hcssMj6ysyMx8DeHH48cSOW5xq7nTeilhEhVzpHwIZe+t2/X/VVqU5Ov+Hh5X
 jaNeznRa18XcP0V+UgKWntjs8bcIC3BI7/S99MZFC9MZbATfOxagDnyTXu1+U4tYBnCW
 PGBS/Uke5poQnwdnreRXLdakbTvRKNjTPcGZlFP0AORMXFGbXvSicpiF24s9eWrYqX7+ Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3abwqgsxq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Aug 2021 12:13:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BC6XB8035703;
 Wed, 11 Aug 2021 12:13:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by aserp3030.oracle.com with ESMTP id 3abx3vmj5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Aug 2021 12:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2q04bcaM2Q7HVQyO6+Pb64jaKcWuAjyGDBm1URpoqCoHVywbSj8+uJoUeLPZZPApNjvbolNIPubYZ85y4JJFBpcoTW3lwgQdreB4eEMS904C7NGHIgCGJmteyeEdp5F2km0Zp74+CN4OOTw/hI8L8Dz47/Ckhmuf7rZlyd+fdq7cAaJEeK60d8A9hHMcEMWbzG5QWlvh4E0fo4HHwmhJ2LgB/SDrU0n8a36vn8CFXdY7QkoKUHEPfj86y/e5yBles8DsJ7QJVSv6AJ8FTr5LT3XvnnT+sHEY4OknCsOuW5jUbKG4H3eTvLYu3MjVlXCL2nEMwauY8otgmWidrSOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH54Gtog3z9ZmDi/9dMjJkJPs/h1sinW52rCjPdRbOI=;
 b=B1Xo1CKDmpfuTDDA1dlkq16ayjbuaRoN4OhtyUKarGcpDX5q7gXeSImCMb9KkvIUAISayLJAPEwegC5VYb/qd3eUGTUi9zq3XpNASLsQvGJjrxAxJYVdpL2FMs6Sx12qucWwoCkGVRV6gsxI+4u/+tJFGwQCxLFu1WSl21pIkAwf7/B+ydS5PnnMeM7p/S3epqsPVyjh0DzngeMZI+3mluPB7XRWHNUgwmeDnWAg6xg6i2Pet8qMyVLNm2PRM1R0E8qFmpVrEfCKihmI4tqP/pWIEPc6iFmlX+bNu5SbQHwip7eT03I+cb4wxNVYrQ6KB8fblqpMJ0ppLqcpgBmMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH54Gtog3z9ZmDi/9dMjJkJPs/h1sinW52rCjPdRbOI=;
 b=Q5it2wF2d5s2isE4jx4hUHIHrlw4tQpVF38QJh1uGQSrrhL+PttJfq7xt4f0vkYjG6VvC40njm2B+Jy6StJT8wcajyZ3oVcOIk56xlNi9sgGFhBvKMTn5CQ0LpymC4JyUQ+QhPgvPMhJjtSRHX/kI1YQl0UrIho+dmKEyPVZMBI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1784.namprd10.prod.outlook.com
 (2603:10b6:910:b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 12:13:56 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::856c:c91e:aaf8:11d]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::856c:c91e:aaf8:11d%3]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 12:13:56 +0000
Date: Wed, 11 Aug 2021 15:13:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: jasowang@redhat.com
Subject: [bug report] vhost_net: basic polling support
Message-ID: <20210811121344.GA14245@kili>
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Wed, 11 Aug 2021 12:13:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8cd77ec-3fb2-4330-6b3a-08d95cc17dca
X-MS-TrafficTypeDiagnostic: CY4PR10MB1784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1784AD66D70121EC3EFBF1118EF89@CY4PR10MB1784.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dv1LARe8r5z1BSGDJu8VKRhd2CTD9hWVYoOAO1h/a1UQYoYdqD1dYWyXVO9OzqzRBT5v4C6FyPjBmkF/aDuBaZ3nbfXXYR5Lnd5QXZ7cilM3kihWRge241w7rJ14dzdttE4asupQD0QEOiqZcZ/Bf5RZD5eUd5i9iu3fblMCgZ2UxyoZFNv8bucQPydIusNeFL78nnpLeGn/xq7kiCzNg+roOrlun2Nl4arLFWHgekT4Ey9Pv/V9gO+6h8umQkOqVQOig3M4uDp7cYolojZauVrhIYJ8KH4TsKICOue0By8CwUBLDYccdLAzOyUq7KyYW8wvHupo2hxut8zMV5+1MP6VIsUuqPrCnIX0r9wmshyBCNTXCAPwF5K4bD20mUWjZRcRNyl+gfZflhNWLELLoT5L9+NR7efe+6V4MZzqoCl3C7H8WnCbCn4jO3jw4qTE6hmvuHcVmMWCV0lAOcawM8Yl4K42ihJJ6oHfSi64tW+rCDQZldCJogsJHojuRdGQBJd50Yaus2R+q0hNpbsDSTjiBTU7rF11hX0tgc40bAbnfW3alZcgByFg+jm2AdXFSz8gjGjrEhhEJD3jlhvBxuABCMdnvPr8UHq0UkuG89rhgS4OnIhVdc3mGJA3yC0culTb84Z2FdKuLDWlSM3qTfu8JHbTRZjCjvJ1S65iDcWEMOS6MxyrSeTOQvtEppoObn32XKLFqy+3RmBieNpcbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1001MB2358.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(136003)(366004)(346002)(376002)(66556008)(66476007)(66946007)(33716001)(44832011)(52116002)(9686003)(33656002)(2906002)(55016002)(316002)(38100700002)(38350700002)(6496006)(26005)(186003)(4326008)(478600001)(5660300002)(86362001)(83380400001)(9576002)(6666004)(6916009)(1076003)(956004)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QUGQGek/vd/IvU1N5OmJdAqDhMhJE5iuEGbktlt60mJ8/uXIrCZtRvMER2S6?=
 =?us-ascii?Q?EGv/V+GHX/LRy0IPhEPh4C3jL6jamlRqgbRlKprt2XYpF/7Fw1ZrFeAQ7Fnq?=
 =?us-ascii?Q?+U42qCrBqmGTLx5cnsrSwZBIkveb9hAbPWW4HlnvGhauVqvBKW+CU0x1mS/+?=
 =?us-ascii?Q?zMNEhhtcDczJFVIpaLsCmpfKoY14dusLkSads/PXpk7CaC+5t2CF+8qIVItv?=
 =?us-ascii?Q?RRCUl2QN7cYZlXtWRHm+4WtlfLEi3qfZti11PzPPMfTJf6RDuGmu7z/UBMdF?=
 =?us-ascii?Q?t1VSRxAWzAKHsRBwbHRc00crH1XyTM1qzD8/SvYXFwPBMAiw9guARxFYgbD6?=
 =?us-ascii?Q?3AJmSosgcPz6B+aS2H982OFLJS1rPczfC/wpc+T3riIMbnTu79/XaxdeLqjP?=
 =?us-ascii?Q?r/QiRVGDha2PW3yHFnwrZUgbpr2p215VKlXF9sjVVIAxm6qskjRycfLxM7nc?=
 =?us-ascii?Q?d7Ir0LYP3Owt2fIStmVi/uKUUSsiPjeTuSF/sbLyuxoQ1WAwYX5OM+8lHVu5?=
 =?us-ascii?Q?PZHJ7EHYBLiJQbi/lPhfA8hhjq016FXrl/WEpSGpbPDdpLYz9cj2IolXM3nd?=
 =?us-ascii?Q?boZPKk4aGOcXIOyP7bwELhhTeINZaaZD0H9FIEK894FfqS2XtfW3f8zEfllb?=
 =?us-ascii?Q?OhEL8SdcpKqBAoQtuAzH/QANeWX5oq1k8CgQ0YZ8+9VBI3uVS5qLVBX2/aBP?=
 =?us-ascii?Q?ENsVe4rfwJqQIAJe24D5MIdGcjujApVpsPvl0PxxuaxhK894hiizsp/PB9ob?=
 =?us-ascii?Q?cY9Ir3/0IwZGCrVDP7AK+7QvF/LsIcjJ0n04L6XVnIo6Dwemhk1RUlXpwCen?=
 =?us-ascii?Q?XhKoE4BmskJJmUbqd9nx9agZgZRFQo3/kUWq7BLJ4QcqAh7E3o/uZPnsNP++?=
 =?us-ascii?Q?ApDBjBePn4GW8KHVW4rHUyyy1OoMh5hVYlGpVP/KngZq0dvo+bAPfCNJaQ3n?=
 =?us-ascii?Q?62JIoYQB/u7rucD5fxL2DQMQJD+FAiQ+evrSvyYVU02ImV1ztk7m89suWws/?=
 =?us-ascii?Q?744Vx9bmn9hzpCLGZHuFAnn85UFgkVywNJRky9i5P3scFQYCsE2j3mx7sWsf?=
 =?us-ascii?Q?20dZXg9nD5P3s9INQyF/q6/OFgV5CvrbmVIrObnanAspKCYnykVMIwmaKbOn?=
 =?us-ascii?Q?Tn9xlilumr50jfW2KNayorECSH+fj4VtgR96Sg34ClWuPI9TCVOBWoJFooZR?=
 =?us-ascii?Q?0ZheXNTcdA6mjQiE611KWFHAo09bk3Dsy9bCnyboou0mL5FFACrGGlgyclXl?=
 =?us-ascii?Q?5qbevvlmAdbXtP6nz+ADheS1QOmvWbmwr2ycRnqbWeBKFYmM02CeIZIhiWvt?=
 =?us-ascii?Q?6UVhVnbxt3UavsALDzx4hwGR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cd77ec-3fb2-4330-6b3a-08d95cc17dca
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 12:13:56.1535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLZu/wEj8Lf158v113LfyKvKFwRQqlEhOpjmXXkXN8hoosvApujBRpyHSId4ylUUsmlOTxLvquaM0CzwluUxlKvRyKWlg+JeNAALThUJBY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1784
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110081
X-Proofpoint-ORIG-GUID: vx9lisZxKwkmQlgo6hQMypMTEDyn63iw
X-Proofpoint-GUID: vx9lisZxKwkmQlgo6hQMypMTEDyn63iw
Cc: virtualization@lists.linux-foundation.org
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

Hello Jason Wang,

The patch 030881372460: "vhost_net: basic polling support" from Mar
4, 2016, leads to the following
Smatch static checker warning:

	drivers/vhost/vhost.c:2565 vhost_new_msg()
	warn: sleeping in atomic context

vers/vhost/net.c
   509  static void vhost_net_busy_poll(struct vhost_net *net,
   510                                  struct vhost_virtqueue *rvq,
   511                                  struct vhost_virtqueue *tvq,
   512                                  bool *busyloop_intr,
   513                                  bool poll_rx)
   514  {
   515          unsigned long busyloop_timeout;
   516          unsigned long endtime;
   517          struct socket *sock;
   518          struct vhost_virtqueue *vq = poll_rx ? tvq : rvq;
   519  
   520          /* Try to hold the vq mutex of the paired virtqueue. We can't
   521           * use mutex_lock() here since we could not guarantee a
   522           * consistenet lock ordering.
   523           */
   524          if (!mutex_trylock(&vq->mutex))
   525                  return;
   526  
   527          vhost_disable_notify(&net->dev, vq);
   528          sock = vhost_vq_get_backend(rvq);
   529  
   530          busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
   531                                       tvq->busyloop_timeout;
   532  
   533          preempt_disable();
                ^^^^^^^^^^^^^^^^^
This bumps the preemp_count.

I guess this is to disable page faults?

   534          endtime = busy_clock() + busyloop_timeout;
   535  
   536          while (vhost_can_busy_poll(endtime)) {
   537                  if (vhost_has_work(&net->dev)) {
   538                          *busyloop_intr = true;
   539                          break;
   540                  }
   541  
   542                  if ((sock_has_rx_data(sock) &&
   543                       !vhost_vq_avail_empty(&net->dev, rvq)) ||

The call tree from here to the GFP_KERNEL is very long...

vhost_vq_avail_empty()
-> vhost_get_avail_idx()
   -> __vhost_get_user()
      -> __vhost_get_user_slow()
         -> translate_desc()
            -> vhost_iotlb_miss vhost_new_msg()  <-- GFP_KERNEL

   544                      !vhost_vq_avail_empty(&net->dev, tvq))
   545                          break;
   546  
   547                  cpu_relax();
   548          }
   549  
   550          preempt_enable();
   551  
   552          if (poll_rx || sock_has_rx_data(sock))
   553                  vhost_net_busy_poll_try_queue(net, vq);

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
