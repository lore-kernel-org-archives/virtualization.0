Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46475C4332F
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0251160F8F
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0251160F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0E6383F23;
	Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rzZdl2hEt4a6; Thu, 16 Sep 2021 21:21:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 36D6E83F26;
	Thu, 16 Sep 2021 21:21:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 511D9C002A;
	Thu, 16 Sep 2021 21:21:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B8DAC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D6F080AFD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QMKfWDa9OEGr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB00B80D7E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:11 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GK6jfg002295; 
 Thu, 16 Sep 2021 21:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=LzXfXSm4I9C4H6ewwo6e1pCPR2Qvt8gU0uGQla880sg=;
 b=hjIUnOIElViYyh9kBptXpi5IQH3imkCM0gxYpFj8OlSvLjbjO7TuiSpk/Q3gRLQ6WWdH
 ETwgpYrWlFijYIjwtD5EikVZgRt/IJ4Bk6Li1KWTrsuY7cEf7IhsdX/vAZcVSno8ZpHh
 vgW51mstkknoiHwbMQHwEeD8PdS2fltQQ7f7FEqjw6xqEgphVyxQEyryGAhwnVO4YvMt
 9yzcTMRIw8AcBicBnO4EbJsNZiJAMEp87vr8JDXfMbzNLdytzoKo1sjm6nGGb0HH4zDj
 D1P3tN4YPd0NnAqz39ZZPK2fcVsOxpDUB+Gsolw3aexNQrFhmbyQoVUZIYn7Jw2MohPY Nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=LzXfXSm4I9C4H6ewwo6e1pCPR2Qvt8gU0uGQla880sg=;
 b=yQ0kiAJar11KnlCm1UxD4+dv5u+xJx5hwLSHEhE6PC3unAaOfgkPIhwueLC7BMygetH6
 7+rFPiOnT3jLjPZzLtqnWhQNzZkxMgFQFCNkdwXeR8EkngGvVfYmdXzTpBgjksZGnfeB
 LCx2u9ti9SBfJ0bR4RjKGEbzvdS/cMiE/rlQUQxtWALFfe+cqQL5EbKtyrw2d891EVTn
 lD70cnqf48Slh3bXKvd72gHKyG9p6q9/w2yFY9ANtc2TR577fEqAH8sTd88R2O2Ls54U
 KkAuG3vqloHdzCxoX2AGqK2LJq7L+OYK9wL6k2dSDcHIt5pmZmjhqp2FxJaX0ouhxsgU fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b3jysnkcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GL5XNs011268;
 Thu, 16 Sep 2021 21:21:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
 by userp3030.oracle.com with ESMTP id 3b0hjyuvpe-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYSqRy+kXlJJazUillQdEO189QJ31GnTSTL6/Mt/lIH9j4dXdA+vd6fAgHs7Bl7LYHf2Mqro6yjLrZQ16vp5NfWDtUn56HqZVLpeoRlDZT/+r1K8S86MgrNswGzkQU3Ei59T13Uxtc66OryIlom3nhdyxJb+AA/26U5k/s5pE9kXeQISFVmW4D38CXAA2R8dJrGLiT9fF6h18tLqfFESXz8l1cZGkcoOkFC1WYwdapIifPbXapTFDV4oFI7IrchsgEo8r/o7Ag3yQ0BgRXZzFRAjOyVTJ8J7neCX0U2ZVJwqmhZ/4ozb/h6X+xJd16j6+Lt3lKoWtKuID0hUspGXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=LzXfXSm4I9C4H6ewwo6e1pCPR2Qvt8gU0uGQla880sg=;
 b=nLBgSc9m8o4Ya3DSu3pxkpI0X8n2snxzKefQ+F/pZk2pm6fGGZ75MUDXlD3/UC0ZAiKplE5FkKbtmWjPf2NRTtwBGwdA1LHKD0Z50aXP8/KMax7INAo0H6yqDXV+FQ8Go/D3RB0edAc8MYm7iRQcPg02auvAUzJbj8VLouYcSt9JSZiki0gJrx6aan7r32xxR+T83Z9kN8EG0gfc9DR3ihU54+8UWuLDWYsgqcQ7I5isHQ+3YcObxYppPwNuHw42FIBMOuJY9UIi7YbUT0yAhydx/d5WY15WOOpqpq6LPxYYWsA29etzJX3lYDhv2BFTDBFLrtLnKX0xWm/NzVzV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzXfXSm4I9C4H6ewwo6e1pCPR2Qvt8gU0uGQla880sg=;
 b=BIGJJT/2u5I3i9+M5gEXZgEHml78CIpr+tKDJdgO/UYka7kvviijtEteZ7Uc8b4TSUTbevLpkt6rdOc7dDA+4r90H3Sby0MnWfuS+1MFaQUvKZc8jCC6w3ISCk0TtzsKRsx7OrR/e4OkYHXyeapDOfoPlyINiENNvr/myPomsJU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 21:21:06 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 21:21:06 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] fork: move PF_IO_WORKER's kernel frame setup to new flag
Date: Thu, 16 Sep 2021 16:20:47 -0500
Message-Id: <20210916212051.6918-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916212051.6918-1-michael.christie@oracle.com>
References: <20210916212051.6918-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:3:12b::13) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:21:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47a084f8-e98a-45df-22e2-08d97957e517
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2935A06B6778AE3F639B7EC9F1DC9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baPzwU8WpkVZGb3yHjMgi0jlgV6zR16g80YqD8HaND9MZyJsEWssCu92BrCc8FdOGlVYg+NQ/0F8cuvwHoM94GfifTy1HzNn4tQN8zWDlMNpzNSwqU7HBM0DhOG0KMrh8M5hFEXSnY/g+kT/cICzJgdJKwkhKsdsYsNYaX9oNEQ+lhNORHCxLkc/uTlQJiIlBdzWDNl4PaOHPGMDs1QN29MO1+buJEZ8tq680rqetaPne4DID1UxTQqOvmk5Brtm/wmfBAcb051k5NCBH4mLi3rM4s4SoBzoj6gE5tI3rIdOLC7to1KhyUAI/lmbZ//XgaViG4WpiuML/mfZsMoO1GuJpPnCkjL7gjdlW0PB9eZKkE+SQb1HL4MCF1kjvoboX1TgxgiBVDH1ThCC1N07T9Cfk5vJ3f7ZYH6EMCDTkOxRw3pV+LuA4c2MDVt/fCY3edcsObsgO7HcRWy4gBaOEKIpFtiySJosHylh++FSUX+4jNyW8SqtdG/qEn2SbJIdMCKfwJytjuQB9sT7nCzwECmaHdkSsy3TFCeioa0Ss5Kr+Bz1XtG6+GvqWR65F6QZtZlUs8p6QlZtpWcyHPXlObNLkvTG69modaGm/XbClhhLHkQCwWvlMqiRXgXEwNYu6C105u5YSGjYXZTqIrUq8L8LlHMMbg7vAiVG72W2eyB1NQx5MgrD08WIalA2p1VPjJhDn87ApDaKu83NR0d1WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(86362001)(36756003)(26005)(107886003)(508600001)(8676002)(8936002)(66556008)(83380400001)(66946007)(5660300002)(6506007)(66476007)(4326008)(6486002)(2906002)(38100700002)(38350700002)(1076003)(52116002)(2616005)(6512007)(956004)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hD6Cs6wYiQZCtoPvX5ziMrNPHyjbDJGtTdayA0gDFdInTemgPtaMyxtOgz6B?=
 =?us-ascii?Q?vyPei14zZaZ+AEA9GkvnX7AAOxSPWmKQD5clKyYkkvkcySI3Oih7r+UfQ67g?=
 =?us-ascii?Q?uBasC9LgVkJ8K+a9X6a/AadAIf0qFUksLFM60/Ag5ufPCyxElBUDbCMgxiUa?=
 =?us-ascii?Q?uO4gbVV9YpDb+l8RQ6co4e0aFOqssYTCl8wds3F5naXOlUgVtO9b+zTI0xLQ?=
 =?us-ascii?Q?2OWtmdxnHfKKcHoA+lYCePijV7tLB6jdYepmn3+vEOeQB5DK5F6EGyFHLtKY?=
 =?us-ascii?Q?wswd0yy7Qub7Kpu5dZU0xoovOpCA70+EOdIQ94ujexlh558YTLvV1gcj3NdS?=
 =?us-ascii?Q?UU6bV6izu1UWo6oKc7duzBe1dgFoZxdSwHaxPApqbcf7V1dX45sk7wZBMEuA?=
 =?us-ascii?Q?oXy8Pyk7o/Gl0H3fG4GHGmWblZpTIlFG80EZzmFoATGLBmO5NkzOVBPmioM2?=
 =?us-ascii?Q?3QNob3Fe4E1xv8hD9zcszUQ8m9vUSQu+gW6gc9oHJOnmRB0mMUJLZ1Gphyeu?=
 =?us-ascii?Q?85R9wv1/RWt1iKZJtJPHv5hw8nosi5eC0QnHBYtV5+olADQeRI+uhoCtwBME?=
 =?us-ascii?Q?HN+diRQrvZBD4M9l97bGMB2rvBlWeO0RdSWlH0dIgDOOimPkHsI+UVHr1wRP?=
 =?us-ascii?Q?9elDHcTUJs6OHX1uOQHVVgodBW3KvTjW9OSgeV296ySgM8qyZZTwWNt5QjKq?=
 =?us-ascii?Q?RLzLb564kol/j91l4muzKkmpDjRCdHQ57OMxLC2jfxPl5XyuaI23Wwh5iIfc?=
 =?us-ascii?Q?dkE9WWSQ4dIZ/wTMxKRCll0i1vhdq7AoR0+UPGHd2iQ60ejcxIAJquBEtMe5?=
 =?us-ascii?Q?aGMLK7vj59/uZGfRlnS1L+DejLI1of7wF1jsKU10Kjl5cO+tIRaH1ggh3NS7?=
 =?us-ascii?Q?srj4H9+0Jvjtdk6uk3hQo2iTkueYj0HFOHaAi9GGHqth+PxAbKUe5u1JlSnA?=
 =?us-ascii?Q?khgcpXxtvDt1xQt2/fC9mSvvkmbsm3n6S8tNIL97mzjZcB0vgVSGW4dd2vCv?=
 =?us-ascii?Q?l3QbMzGi+cWk4H42CHwDqaT9tMh67PcwQddA470pgavbdcKtFbQ2GPViJdUt?=
 =?us-ascii?Q?hXxu64+g2Y732fTxeAgteL3Lr2tUj1ms7c6f7WIDdJTDoljI1gKrOxyM4gnX?=
 =?us-ascii?Q?7lHDVmkFvQstNriXAz8zIftojpmNCTUuT5a0dCi+7gVapzgLLH/8JWh6rcMR?=
 =?us-ascii?Q?lIFeF6cF7hyQTRqZtwcR3ofGUlGYcgOyTcd1lfkm1iDO4UB6Wj8Zi+UYmMQw?=
 =?us-ascii?Q?YZz25w8qGDI9SEvlEQ9N8YoQSJdsA8km2rbtpbXCPJ6VjUj5mRJmpUCNYLzr?=
 =?us-ascii?Q?IKWmHyxQJZu2ufS0TsmTk7hv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a084f8-e98a-45df-22e2-08d97957e517
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:21:06.3839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgBdk4Wru0cVmz45BAyteG5NOySMUmKIM2OybbNOYsuGNaPo4zq3fCkJtYvJE9aG6TquvrhDGl+V5YudH5cjDMLNJSGb+I4rE8er4BsDVFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160122
X-Proofpoint-GUID: xe3eTQGHDo0YBAmlrS7i9QmOwSptnW1T
X-Proofpoint-ORIG-GUID: xe3eTQGHDo0YBAmlrS7i9QmOwSptnW1T
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

The vhost worker threads need the same frame setup as io_uring's worker
threads, but do not handle signals and may not even be executing IO. This
moves the setup part to a new flag.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 arch/x86/kernel/process.c  | 4 ++--
 include/linux/sched.h      | 1 +
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..ccdec11cd120 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -178,9 +178,9 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	if (unlikely(p->flags & PF_IO_WORKER)) {
+	if (unlikely(p->flags & PF_USER_WORKER)) {
 		/*
-		 * An IO thread is a user space thread, but it doesn't
+		 * An user worker thread is a user space thread, but it doesn't
 		 * return to ret_after_fork().
 		 *
 		 * In order to indicate that to tools like gdb,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e12b524426b0..817d3a7bec77 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1664,6 +1664,7 @@ extern struct pid *cad_pid;
 #define PF_VCPU			0x00000001	/* I'm a virtual CPU */
 #define PF_IDLE			0x00000002	/* I am an IDLE thread */
 #define PF_EXITING		0x00000004	/* Getting shut down */
+#define PF_USER_WORKER		0x00000008	/* Userspace kernel worker */
 #define PF_IO_WORKER		0x00000010	/* Task is an IO worker */
 #define PF_WQ_WORKER		0x00000020	/* I'm a workqueue worker */
 #define PF_FORKNOEXEC		0x00000040	/* Forked but didn't exec */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index d0b0872f56cc..4a6100a24894 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -33,6 +33,7 @@ struct kernel_clone_args {
 	int cgroup;
 	int io_thread;
 	int no_files;
+	int user_worker;
 	struct cgroup *cgrp;
 	struct css_set *cset;
 };
diff --git a/kernel/fork.c b/kernel/fork.c
index a0468e30b27e..1dda1d4ea77b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2041,6 +2041,8 @@ static __latent_entropy struct task_struct *copy_process(
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
 	}
 
+	if (args->user_worker)
+		p->flags |= PF_USER_WORKER;
 	/*
 	 * This _must_ happen before we call free_task(), i.e. before we jump
 	 * to any of the bad_fork_* labels. This is to avoid freeing
@@ -2563,6 +2565,7 @@ struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
 		.stack_size	= (unsigned long)arg,
 		.io_thread	= io_thread,
 		.no_files	= no_files,
+		.user_worker	= 1,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
