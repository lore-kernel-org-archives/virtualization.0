Return-Path: <SRS0=fvq/=N5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4956FC433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 07:33:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29ED6109D
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 07:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F29ED6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBBD060BBD;
	Tue,  7 Sep 2021 07:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nNt0W1WzXfR6; Tue,  7 Sep 2021 07:33:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 642716084A;
	Tue,  7 Sep 2021 07:33:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24E47C000F;
	Tue,  7 Sep 2021 07:33:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AC68C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0789382A29
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:33:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="RR4xCv8g";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="HZH/bHTJ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="VlrJpTt1"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nEODh0esMopy
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:33:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24C8C829F2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:33:05 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1876HKtB017560; 
 Tue, 7 Sep 2021 07:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=lSavTCLUWaOupvNkPmm7Ii8bukNJhmdOPvHW3/VsBr4=;
 b=RR4xCv8gLKJM5St53szOzyS5flFet9Q0TJPfk9Et6/K779IFhhH+uIK403XGVFBOe9RX
 GrDJcEwKiQZt0+2/ulrdgpyLam4M2zAqnUNGLDCf8x/lzFGH1uUX7zKQCB99RraG7XOJ
 Sg77htE2f5zgvarhxp+i2yRmGx2QL6++vtWZHBIqGFxf79MTiAkpFzYZSl+8ND97o4te
 W9uv0ncDEwsvGBb8Zz8+iLDCZkpLia0vcHN4T5E/NxQBx4lYQgUS3L8nGYqgrUGesU50
 dgW4cN9JnkJOrG+djMXN6voWVgdNyWCk+9SGBmB/RCtatCoWRTmE84a6RZPXNj32ao/e wQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=lSavTCLUWaOupvNkPmm7Ii8bukNJhmdOPvHW3/VsBr4=;
 b=HZH/bHTJyTlTJr7W99ZReHmKCzJ+2odtlRsO2yiAlIXjSc2zwXQENgAaVfYAuORCKcok
 emZtHYahfZxoqHSPTG+vzHmd72caVBpoKT5xgV9yScSSc1CfXH1+0K0c7YE6NhKzhHkx
 Y0YW4SYAx18xglpR0kT5BvNTJ4vXR87BzjsEHntsbCn7kuw7Wy8SfuH5SuGjwfcZivS/
 XSzJ2Kx8uGYemucwYHxYEbQW5jGTNfFDw2XZoXvhNIpDXGPFV/CYXyTLHkIqHCGkpg/z
 70cWQ7JHilp6u6fGhIbTH23hmig62HHOQbbJ0ngcCBzxc501egfMyC3LwT8+L3loQRAu zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3awq29gxj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Sep 2021 07:33:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1877U0R4125810;
 Tue, 7 Sep 2021 07:33:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
 by aserp3020.oracle.com with ESMTP id 3av0m44shq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Sep 2021 07:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHOJkilqXFEnPdJgwIeFjTX4kLqUhmMyQDkubWAIjdQxI9a7R8ynkaw5Gb3goaKWbXcyprrJ3FKpuHQM3D9tiMr05SCajxs/4hS1+cj8q+VMVIJMF+aDn1SNla6Rt6skQ0VSQIdHGpXmqCnBweuV7KQkhdebAJ/J4Gr5sAuBz4kPuTFwiJPgnkH/1wWvEmrs4ShneMcWSOPfnM+e0iFvmA/kjm2sOVFWJ4SjXuniPEXl+EpDA18LJnGoknePK9B1F1ZiZBvyA2tBDQKy0q3vugw4gjqZhYNhGTeEqh7w0Ww6i50x6S5dyJHHiVWtffgMoXri/vWCFjJ1Xp0wvUwKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=lSavTCLUWaOupvNkPmm7Ii8bukNJhmdOPvHW3/VsBr4=;
 b=kOTEmgvP9haV2wumIwhBUZviLweFtNICanLWx4zSDRe6q9jxeUnqk4yfHz8rXZm/U+r3krb7rtXrUjC149AjR3Up2KcALdcF4tO0I2FNH4NXtaYxJ6j44BfpWcHhmu24DX8GDKKDR8Jmb72AUT52Ru8hiwQad9Y6e93CTRKu3DmbQVpSDqjSdAovI6KdvMMctGFDenIM9hxCjcpn4+F00es4xfl6Ran5R9jiAQlVk3HC6PMM07GTwrO71eYS2L//3EJtZuA6O4mcdLrc0aIkVcEpB674uG1+njwnQJ3fii777Pk2CEGLFB1JdXsRHn+R4y3KbMwgj5Nah87FM/FRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSavTCLUWaOupvNkPmm7Ii8bukNJhmdOPvHW3/VsBr4=;
 b=VlrJpTt1Kyp3xAgTmbsmHojdTuFMlX4Xe0fhbC8prAtzbtiPAnqANYHYDHxixEMOvYM+BndW5E4YFd3uECqvP/fVHmwUtCqa1Tyvm9v3hAfVwfsOODHc0fn4JttFn0+aH6teA4NHB2NZQtFZnHpayInrotr6Ec4rfygMdO6/ULg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1775.namprd10.prod.outlook.com
 (2603:10b6:301:a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 07:33:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 07:33:01 +0000
Date: Tue, 7 Sep 2021 10:32:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH] vdpa: potential uninitialized return in vhost_vdpa_va_map()
Message-ID: <20210907073253.GB18254@kili>
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0093.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0093.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Tue, 7 Sep 2021 07:32:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0379b50d-8469-4880-f8f5-08d971d1b90f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1775CD66A648F7ECBF7375888ED39@MWHPR10MB1775.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oiv/6MDm4D7MweoRgbVlmAawh5iw1ppAQgzZrKQQ1iWoODNvDMbNp2JL1bxgXHdP9okAUPZf384KW/lyG2hGGmEH7gw1vciTK5A2aFirpDPkE9JLbKH6cUyM7sG7CWPeJ8C15se00KBCcPX7DASUxjc5qpZ+G7O7hw/iEVszL8K/kf2EpXw+koXj4+vzYqY02sLc8xk8c+bStfO/LCrvbWS0mJfHCBq/FY3bEWbnD/NOP+fNEfa159wRI03r5qAzZg9ZdcHpQn1J+IvGc4abK2LGdKSMC8p5rw99k8Lf79Ar4c0URCpkPCVHdwkPjCRfmGyCMlHs5VFg1NS4SW4x6QvFw23aPXa64JFiS6lEey3C9rj4zbh9n1HC0tRLlAG19EuRnJzKfAkHV5gJpQUhxzo6oqaQHFkMQ0J4ejNzisa50KQl2ZkNvds2w56nR7hlSm0IrQ49q0I7+mCRVh+0e3Cce0UgDFPiS3lnK5Sv50NRAcLTqStACioAqNetU/lWkNnRsupgbHYT99BlboxbKrZ+fdIUEQ7OTiPO7s//+2UEL46Koe8ldOuj1fN3cgKOeZs33X9xjE1a5gpZ16wv70kTe2I911VYaLl8gVhsi6RGNFrurH5XpCSt9HTMQzLmLxAMqsFZocI28Uw3+OIqRmuP6MjLEC9m/ZrCqE6rG0ttsV/su3PCpUvyJPu5mUORT4xXWNqpI9fBYAKPT1legQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(86362001)(38350700002)(38100700002)(4744005)(66556008)(66476007)(66946007)(5660300002)(508600001)(55016002)(9686003)(6666004)(4326008)(52116002)(110136005)(2906002)(6496006)(33656002)(44832011)(9576002)(186003)(8936002)(8676002)(26005)(83380400001)(33716001)(956004)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8HPasX6cGIpRXc/iamLO77Db25L3nnfWGO4JDaXX2eI0v5ajSIUdGhoIDf55?=
 =?us-ascii?Q?764muD7cAFfWT14WWh974fognwqkcDrzqupBHPtStBVtrf+63YCXJs+zjEZy?=
 =?us-ascii?Q?ZAEl5fP6JSfLbLMcPdcn9iLh6iVWJIlh8Fy414llMQ1SPXCP2BmJf4kPNsWT?=
 =?us-ascii?Q?+Ytt9BQxXfPZNZZrcDsG578xsP0KXlU6MR6SViSI1Y8j8GxRwnLdpyDm7oYW?=
 =?us-ascii?Q?5WOciqI0inui2tZ3tB82u+fSvYO7Zgwe1UyDW6zR2p1OdhpNgUewllr26uRi?=
 =?us-ascii?Q?dqp+eM3xT9TQhZBG5MySbsBJ24UOtIlmfKGuuqH8WCujuDGv7dwTCh5qPPLo?=
 =?us-ascii?Q?sEe2H/wPMGdNWi/uJdxWEAB+BdVC3qD42KIHtkD0CYpyEtivaLuFpWTF+NGC?=
 =?us-ascii?Q?YohDfQAIM1qgYF654WrOgkSigrK6es3sirXBrorNtoZA2duMXDtA8rI1BuK4?=
 =?us-ascii?Q?qDgzvpz7fn83rOMviQ4ts2JpN064JfIWNWRS10gEeJXebJkepVL1HdC8P8i+?=
 =?us-ascii?Q?lmh49u2OCoL5dSfXX9IDy3P0gBngXsTQU8FG9tYnPywCpw4F/pJIMSVJbItG?=
 =?us-ascii?Q?cceLKs6t4oe0gpbcmMxHa7PSg+od6DetDWWZaHrr/cWser66hSsOGZ2WGkfj?=
 =?us-ascii?Q?QSKwrnSWzgPpJps44yoZJrxtZsrd5a2VjHF0a0JX5Th4YjYVmD1WotKZ5owO?=
 =?us-ascii?Q?qTBu0y7eE43eAo2+O/7EEZ31duYrRQI+Al1loTOBaGSZKYNpHSjzxUIWCOeR?=
 =?us-ascii?Q?GTcTHSE1q30B0BGRLl8IPeIDkM7ml9w2a02JE39xd7BRqZ+zHQkwY4bV/5dt?=
 =?us-ascii?Q?So7jAOC6IjmohdObaJQFjpH+GM5v1qfvY3wzBm/gkyylo7/6q8dgeyrLn9Hn?=
 =?us-ascii?Q?IZgD6L9YfvGleT39T6znJ7drPMotpwsEJyLxtbRRhbkywbuDFsZ+zfBbDH35?=
 =?us-ascii?Q?WQvauRKLI/GXYcRzBSqrfC2PJuirxRZEGtUF3aAIbtlBc62Hd9Mdwi1hew6y?=
 =?us-ascii?Q?VZs+pxqYRPdJWwWvk+K+dSKnK98N1lpaItSvEjl8BuiNkGlbNAkzORxSFOe9?=
 =?us-ascii?Q?3hse8oE5jgGayEchUUTGBX28aR6GlrorQprGXFvx1JZNcsmORsBZRnfgS/3+?=
 =?us-ascii?Q?Z8V9UqIv7AxNT4sVFGBOoTMXrnYqEKNl8mYom9rHZieAWgrAPbcM79Glggn7?=
 =?us-ascii?Q?p8f+kqWmHSGHxyWC8snl+8VinQ1crXX1pqMvHwEVLnp2oP8zUruzyf11QdMI?=
 =?us-ascii?Q?YqfMniX3NDN2YgocnNXiI0VDDoEtubQDAxBBWj1V/q9KFdCQimdgd4KphOT+?=
 =?us-ascii?Q?mVAdDLrA5giGOY9zkdnTEevb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0379b50d-8469-4880-f8f5-08d971d1b90f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 07:33:01.8140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceBfj7notL5QueZFoRO96TiRff8y2bIctL3WqRpliEc8wpgyPP9juWICXxRXEN/32jevSsSAAep7e5p7FKksBB3HTR+ZhUfoiSN+ZDMBURc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1775
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070049
X-Proofpoint-ORIG-GUID: ngz9adtwM65VO_73GiInT8faTqZl6Tv9
X-Proofpoint-GUID: ngz9adtwM65VO_73GiInT8faTqZl6Tv9
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The concern here is that "ret" can be uninitialized if we hit the
"goto next" condition on every iteration through the loop.

Fixes: 41ba1b5f9d4b ("vdpa: Support transferring virtual addressing during DMA mapping")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index d0c0fedf2c09..170166806714 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -640,7 +640,7 @@ static int vhost_vdpa_va_map(struct vhost_vdpa *v,
 	u64 offset, map_size, map_iova = iova;
 	struct vdpa_map_file *map_file;
 	struct vm_area_struct *vma;
-	int ret;
+	int ret = 0;
 
 	mmap_read_lock(dev->mm);
 
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
