Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F44C433F5
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032996113A
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 032996113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C540761529;
	Thu, 16 Sep 2021 21:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q_0qEgzWDtvm; Thu, 16 Sep 2021 21:21:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 34BBB614EF;
	Thu, 16 Sep 2021 21:21:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 084BAC0011;
	Thu, 16 Sep 2021 21:21:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF78CC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D3F183F23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="HzP/zdU2";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="N2dSJVMi";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="U8gQDJJP"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mmQMJ8QBff3D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF81F83F1E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GK4Omo009148; 
 Thu, 16 Sep 2021 21:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=UDzD+wE69P1GE2KI5B6hgMfAV25h205Jca/VihiNBXM=;
 b=HzP/zdU27tmp7SZ6NjjQLuRzbX5FKHAaYAx0gFsLTAPOjJHuoysWwsCqabjn8Gr0xFqT
 34prpeh9kwiT4++C11efZnJaEOxipgD5RNOt8sexbpqYsCbqXWNN9aw4aJhfM3q11PzW
 zvZkGqQjlqdxJcHnp3BX7b6fOUh6dWCIy9zHE76XlVXADsZp5m+oq8BI2UB69pxTSQVE
 A7Ht+MUb1PiTi0rqULTwy8Uw0EgK5g4udEamLEilO5H7q2cMUqfNXPBU1/W5xymx6Xg6
 Cv/rH/6cRWxKOrqu1ONbwDQXvs4lF0KE98vOCF5mVVJEsKgx26HH2UxVSwMtJA/CcLiW 8A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=UDzD+wE69P1GE2KI5B6hgMfAV25h205Jca/VihiNBXM=;
 b=N2dSJVMi5+RoxRQ0q9+korg1SZw2njD2ioE+d1sJLjgvZOoHic5nBAiOtAbw96PRzZs7
 XLy19JsQz8fZ7fbOIJHTWdMTfdYxw8u3QSGySA1QwsSj1ySpUTJBUCYpHeR3T58600w5
 LoN1kGybMPxT9Tm2kprNPi+sF4sHQJlB25y9CSXd8qQu7wtSPy1mgM4BFgHBLlkKZReE
 tcYCOa+k3qPYcZ2X2O3Ze1UqAWPv+1HfXSao1SkPhLXubAs+5IvqZGw7ed0lTuwZwe5y
 PLIfV/GLYMc7YHDtV6Vai92BHFVKsX1QioNj9FNBAHI4FnLq56N4Rm6Y8oVFT5P8SGSg nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b3s74m7x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GL5XNu011268;
 Thu, 16 Sep 2021 21:21:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
 by userp3030.oracle.com with ESMTP id 3b0hjyuvpe-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBL0IrQI60iUHRWKtti5JdjHulNmIh2gdL7V94wUVubwCsfYhEAzpzeY7n3fb9gn/0tBsSTL8qQsnbd8kahGvW1IAdW3MqqBCCGKOSp0dajWB5zhtdu+PKk9ikGO1c60sGNi0yMVj+R1ps9W1H7oq0YmYmKRp9E7QlrtkGPVblrwZnJh0Hc+JoZ6UYXc8XFZgpLsxTvjXuab/AiMGCDy9R86tVvLyJsBu3YNUI/R3gzW5kbDk4eBeBQC6QL9fG+OT+dJs8yiZ0j4GU+NKvO+9CMfkbWhod5T59rqafL8ZU3Rb9mCuo2r/8sAxqratKWfeDJjkxOy07snJ0zDxaQWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=UDzD+wE69P1GE2KI5B6hgMfAV25h205Jca/VihiNBXM=;
 b=JnwlWZ5Mr3P2ekHGWkTaxgdGYKUDfPqQc6ZR8aOkiGOB/VBjNTzyajW87xan+l7mSrcG5gIaODjZkB/fehboNyzArXopVIQQRrhmVLtXdCpsDgf+cMVCktuM3Y+J9TeoESl0d//ZJV+/Sp8TbUx47MQLB+ziOJ5tBEiPekBKmXwol8Lz5pP08X5kr58nM4fTkQgri0H3g8NKSAqXPls+x8UT9keK9Ypv9y3ShBLKst8sQPcEoh4Jnvovg1zj/3NyXdCq/W9zIocRR30h4Hhs1fskBT+IssC7pssByzY2StI8zs5eWQgbKGStvYeYUyXbiZBKE3wCIi8WG17CX6mimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDzD+wE69P1GE2KI5B6hgMfAV25h205Jca/VihiNBXM=;
 b=U8gQDJJPs2ukPmgpmqAnZExNlEEqY4z2ONTsbnZsqS9ytobm8q2E70ji1Q4aKmMkbQ3cJ4nwvsIaPAL6FsOl6Y6rO7+CBLG7GwrgE0XC6Y8aVKtTmRHg7m0jB4IOgcBR5OPbzTmZwV13NJ1Ncsnq4eJk+nmLOmwDamELmM6TBdo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 21:21:08 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 21:21:08 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] vhost: move worker thread fields to new struct
Date: Thu, 16 Sep 2021 16:20:49 -0500
Message-Id: <20210916212051.6918-7-michael.christie@oracle.com>
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
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:21:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3adf4d83-a51f-484c-6cdf-08d97957e653
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB293594438DC81D48228A2595F1DC9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ghKc23uIkYIifGCCXHaCWcVD1Ro74r/RQ/zLY1HE46P3QFTcrbm/GcW8GEpHhY3+akB+7eKaRmJoZKoZBNk1W3qJ95cHAeXA2kk/9qyVgNT3rrYmPHgv2Gg+G7Q/U3cg3/d1CFyVdSGoe4lsroUMEgjnJqefGa5FAKYE+08e9MRkcFOvdg3Qj0NNGLdZYtbXfwCwbo2/RGk5Nw+koeYu4Xk1GwOMe30c0BSQgW6tzmgu4LzHt3u9dL6sR5r5CIWf/RmUfdHKAGYwVhCSZg61a+t/7ytDnWnZ5UijSyJyzmZbNcbcG+1O7DGuUUMnpKDIHtlK1zUxTTrYoVZFqzxMeF7X/eFCfzETvAHNV+SU0b8ayz/BBOFFu3u5QJ+PsFUvHZqlfO+IGPvxT/4iFgYRSSDq3HlCDJL6bpkhhsJPUo3vU68UTKrNPW6qjgBC2KwhmOn+PJDnDx3/0g3jVF9WDQeDITgNraV5Kc6ljU9KPftPBL5vub0pMzxiUdE7chmGcLouOsK+zGh3jlGso4R5HMY5RmqBTfZb0LGlSMjoGmu+7ValPnMzDPZHT7bH+CRaLJuN7292Qh0s3I8xX3lzafjEmAE5lnAb7R9nZHfCDYFNG3yHm1kXg7wPLGMJik28Qi+q6UrPaXGRfHGKyHyYo/9sZaa6wAXRlFvXFoPPjyOu6HmfwyigtGNwtdyD6vIr6Eta7T+J3xfjrVTFpwDrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(86362001)(36756003)(26005)(107886003)(508600001)(8676002)(8936002)(66556008)(83380400001)(66946007)(5660300002)(6506007)(66476007)(4326008)(6486002)(2906002)(38100700002)(38350700002)(1076003)(52116002)(2616005)(6512007)(956004)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQ+nSu1w7+Kcxvbc+UHb/03d2FXaAuAUkI5ZPgNV5iWFTNZP3h7Hz8e8l1Uj?=
 =?us-ascii?Q?q9TflANiNkwDoYpfKCGg5TArjV5NlqRIJFYE8Kdvnsv1RVcz4geDgH7Xmu7a?=
 =?us-ascii?Q?f+H1ZcAUaZluj8uJWIKdYOf5Z4c8hBNel+K8gzM6HPwOjWk3GGSx36jqKVaJ?=
 =?us-ascii?Q?xzLE7v9m1ZkID3SIR0Kd9vb7BJ8EgNCz2iTgIz5YIcZXv9iqdyVCk6z/joR6?=
 =?us-ascii?Q?TbKeWrNYV+L/8GuAAo6vjgqb5cEMEp+RS3Qw5vo3twdLBYMihNy7DpCJavjF?=
 =?us-ascii?Q?pQgLZUs/f+NVGcvxSX1NKv6cA6hw9yFCU9k6cIFKVeYdrQRJQ1aW2xPWPCnX?=
 =?us-ascii?Q?msJAkXemSUNsJj5tFgVL8l0/cGu0TiGR9aJ+s7O7j/dTyo+z8GnOsfFmzUUv?=
 =?us-ascii?Q?5yz5KgVQIZ0rjq7sYen2Xs6mms0CSG5CbBvjIyhQ42cp2bKQun3POW7F0x1k?=
 =?us-ascii?Q?HC1rnzz1H7vDJEnd9jQFypyzf++vucEVF6FL+Y9tklk8kDd8GS98fSZPjiYn?=
 =?us-ascii?Q?dix1X9N2llvcliPSVSEc6/z1JS4b4PNHxMwMBjga4HO/jaOBP8ZKkcnT8I7k?=
 =?us-ascii?Q?o6oCo60XRHnKbjAQE8Kkq0G5ywWKPoDBhG/YAYb76BJA5zWXR9f0Osx7XnPR?=
 =?us-ascii?Q?7RRDkpu4y4rk655qZhb6hdU2oQT4Vkjl9Ap+r2EBVU0Vufi/REDmHPLEJKN9?=
 =?us-ascii?Q?BkIqBG5n3jAlxQnw+tUVsoV44NJXDHKCEWC3tyrdUY+FEaIoyB+pUvbeXNW6?=
 =?us-ascii?Q?RibX781IWZ/tu859xgWuoqchUnCBbcUK9kzNpk4WkFIytd3YhI6Q7sUMWcvP?=
 =?us-ascii?Q?2P5X8BTnXpw9LfFHNRRsVVGP2TxVokJoharvxFhIk9JkAyTh3hniiIvcv4/g?=
 =?us-ascii?Q?1LvstMqz3KFld3f4nBNeCXY7YQWMKeKCbz2KS3e5Sb83VY2ZoObzrbpsZbJe?=
 =?us-ascii?Q?REeAVEeGWOidE9SvlyY/ogDmukDyMMjneCGLkaJmzLdD9oZB04ZOgpQ+d6qh?=
 =?us-ascii?Q?crBwKcP4Mxh3ZdCsbXTwdHFkIFjjo360/GcWPi+RB3H7/NvmqsoLcGd4LHtC?=
 =?us-ascii?Q?KDwZ3LivkMOlZlzkHWWUoYynDSJcuUlgDp3eH4nBNSYMCYviOqvdrVXHTwD/?=
 =?us-ascii?Q?FcrL4xB9n0Sv6GSk7uyjTpV/P6S8PJ2Y7kiX2rk1zZi0NFTEOMA81P/OEz3I?=
 =?us-ascii?Q?onBMN1331m7PAShxFosg6inwUe9U9YqN7yHHQ4F9KCAWrv+5Qu8X9WXv07i8?=
 =?us-ascii?Q?9R75TMOiOWUM11dbEWKeH6y+hkXRPuvrr+NcECXF/kaMd3xIjbXYdJxC6cG2?=
 =?us-ascii?Q?9pb+sf9X2YuoZGZbTqOM35ho?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adf4d83-a51f-484c-6cdf-08d97957e653
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:21:08.4927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZBSme9KJR2rX7Kc/g1cYT67yH0HvfMWzu8eMmiLZvcaVgXza4jOlPkwUF7PMcAT+JNb1IJ70JAFSMMrWvy7l6xbNc2iOzAS4k9cfSOZl9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160122
X-Proofpoint-ORIG-GUID: siqmMiFipgl_PwuDveg69vSG6Gc8wCS2
X-Proofpoint-GUID: siqmMiFipgl_PwuDveg69vSG6Gc8wCS2
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

This is just a prep patch. It moves the worker related fields to a new
vhost_worker struct and moves the code around to create some helpers that
will be used in the next patches.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/vhost.c | 98 ++++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h | 11 +++--
 2 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..c9a1f706989c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -263,8 +263,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->work_list);
-		wake_up_process(dev->worker);
+		llist_add(&work->node, &dev->worker->work_list);
+		wake_up_process(dev->worker->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -272,7 +272,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->work_list);
+	return dev->worker && !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -343,7 +343,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 
 static int vhost_worker(void *data)
 {
-	struct vhost_dev *dev = data;
+	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
@@ -358,7 +359,7 @@ static int vhost_worker(void *data)
 			break;
 		}
 
-		node = llist_del_all(&dev->work_list);
+		node = llist_del_all(&worker->work_list);
 		if (!node)
 			schedule();
 
@@ -368,7 +369,7 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
-			kcov_remote_start_common(dev->kcov_handle);
+			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			if (need_resched())
@@ -487,7 +488,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
-	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -579,10 +579,60 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker = dev->worker;
+
+	if (!worker)
+		return;
+
+	dev->worker = NULL;
+	WARN_ON(!llist_empty(&worker->work_list));
+	kthread_stop(worker->task);
+	kfree(worker);
+}
+
+static int vhost_worker_create(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	struct task_struct *task;
+	int ret;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return -ENOMEM;
+
+	dev->worker = worker;
+	worker->dev = dev;
+	worker->kcov_handle = kcov_common_handle();
+	init_llist_head(&worker->work_list);
+
+	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_worker;
+	}
+
+	worker->task = task;
+	wake_up_process(task); /* avoid contributing to loadavg */
+
+	ret = vhost_attach_cgroups(dev);
+	if (ret)
+		goto stop_worker;
+
+	return 0;
+
+stop_worker:
+	kthread_stop(worker->task);
+free_worker:
+	kfree(worker);
+	dev->worker = NULL;
+	return ret;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	struct task_struct *worker;
 	int err;
 
 	/* Is there an owner already? */
@@ -593,36 +643,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	vhost_attach_mm(dev);
 
-	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
-		worker = kthread_create(vhost_worker, dev,
-					"vhost-%d", current->pid);
-		if (IS_ERR(worker)) {
-			err = PTR_ERR(worker);
-			goto err_worker;
-		}
-
-		dev->worker = worker;
-		wake_up_process(worker); /* avoid contributing to loadavg */
-
-		err = vhost_attach_cgroups(dev);
+		err = vhost_worker_create(dev);
 		if (err)
-			goto err_cgroup;
+			goto err_worker;
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
 	if (err)
-		goto err_cgroup;
+		goto err_iovecs;
 
 	return 0;
-err_cgroup:
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-	}
+err_iovecs:
+	vhost_worker_free(dev);
 err_worker:
 	vhost_detach_mm(dev);
-	dev->kcov_handle = 0;
 err_mm:
 	return err;
 }
@@ -712,12 +747,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	WARN_ON(!llist_empty(&dev->work_list));
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-		dev->kcov_handle = 0;
-	}
+	vhost_worker_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 638bb640d6b4..102ce25e4e13 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,6 +25,13 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker {
+	struct task_struct	*task;
+	struct llist_head	work_list;
+	struct vhost_dev	*dev;
+	u64			kcov_handle;
+};
+
 /* Poll a file (eventfd or socket) */
 /* Note: there's nothing vhost specific about this structure. */
 struct vhost_poll {
@@ -148,8 +155,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -159,7 +165,6 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
-	u64 kcov_handle;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
