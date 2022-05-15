Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F61C433EF
	for <virtualization@archiver.kernel.org>; Sun, 15 May 2022 20:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFF6060F9F;
	Sun, 15 May 2022 20:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ET4wKDt3HDy; Sun, 15 May 2022 20:29:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 603D060B4E;
	Sun, 15 May 2022 20:29:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F914C007A;
	Sun, 15 May 2022 20:29:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 162B3C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F06B1401D8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="H8FzRyh8";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="a9l6iinA"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pSKZR-Ld-c-6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32350400A4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:35 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FEadqp020757;
 Sun, 15 May 2022 20:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ypIyVYafciBhNoyWd8PpMyelaLBopZerVU7IdPpZpFU=;
 b=H8FzRyh8dS2JakI0OAseeVMsF2YhZX0xh94/P5Zi4RY6r+Zv+7f04O6HweWdgwTRt7bm
 MGPAigKrJt/M8irgKD9J/SUb/hAA6blUbTipBYD5MTCv+NwkVdMQQKKmaY07ESPH/VEU
 ep9d8FOgH65ckPRLPebyxGt9KkXcDBasFT+Sf+3OFNIDRw+yEfCR95a2IaOqEKnaXAw/
 2UdKple2kv/bhH4kAO7QB7jMQb9ipAzlMUUMu0QrhieMNaqZHF6tgJnP1Ayn+69SLvt1
 bbtgrwpz7Z/f9LN131fthOmwja55SND7rspt+35/hnmSizVwMB8G/9CrUffgBkJ7Tuc5 qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310hv2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:34 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24FKOthE000789; Sun, 15 May 2022 20:29:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v17vqs-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz9d88feIqTAbbIyljoPkMbQTwvP7FWjSFGklqEjoSf5moUcMadxmm+byRroIMggVAw1wzBTAV7+9rMrmvgFn4vRmAkdPpQuF4HVT76xUIRstPzh3/qKTUagS/qayXgeMlz6WeLA18HQ9fjh2CUdBWvrMCRXVd28rSL/EPEnS1owZt0o0mDMAOS4cdNiijDoCbJapDTzM8XzyYTiG2PJU8thNYGB2G7yMh4n31XnIWwMTHCtPv6Hvee0aGWy0TIq8IcQWqNdDNBuI3WdCCdExjp1l5T7zufrBEfLFfdWRhD715xdrPAQvR7B2x5yzc02nE1Z7TpSJbe/42wycbG/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypIyVYafciBhNoyWd8PpMyelaLBopZerVU7IdPpZpFU=;
 b=RlR1QJp05C+K0sPq+LWVmmS9O6NnfFe7NzeZ/cD2kPV0OTvIShwAgXwMIOGfMa1JE4z/ovr3RsH51AZznwyzHZMT7GgOY8UBF8gOo5AljRCAVYwfYcWaNo+DiZWTwu1Wvmyd6chWZPf7/t2tpzkj4oGI98GYAoZk9/Ccn4BaJTCStAUAEIkqO1NdmGu2No2VLpfluMK8Xfedhccy5LYl3sgWk/gBjTpp4qMB6RGgefR+O2Jjk5qtM1FXuQk5q9PNMpW3xA2C5sDYlnA23q/bulgGQCk6oVlqRXyfxXgMg+rIvDkzUkkUUfp8F+UoDZ7f20h62WPR0OYNm2FP0TsJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypIyVYafciBhNoyWd8PpMyelaLBopZerVU7IdPpZpFU=;
 b=a9l6iinADBZfLEQhTEAw96NYfsLTkblTwZDYasZy+Xy2nCGm8TPN6qH5fLr88kdJQuI8e5ZN8RWUWTyOYd7yPVRqFikBbiFj8LZb41enkH2a2l66a8aZcaKN6t7zqIOFuSDE7xJeqpmNKlC+ZwGTjx4f1CjLCmm4VAIKub5Ed+E=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN7PR10MB2707.namprd10.prod.outlook.com (2603:10b6:406:c9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Sun, 15 May 2022 20:29:32 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 20:29:32 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V2 4/8] vhost_test: remove vhost_test_flush_vq()
Date: Sun, 15 May 2022 15:29:18 -0500
Message-Id: <20220515202922.174066-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515202922.174066-1-michael.christie@oracle.com>
References: <20220515202922.174066-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:8:57::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5794fe20-3efa-4c1c-80b2-08da36b19e20
X-MS-TrafficTypeDiagnostic: BN7PR10MB2707:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2707CD022195EB9FBB3BC8B7F1CC9@BN7PR10MB2707.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uUD/7Gw29QTjiapx5b5oBPhmEPaIf3tre6nJQpK2QvfRaZ3UNCBaHtWiOrbZl8/BuWhgO2RbEXf9t1aH5BEndl9697x7BfcvlMH6MtcXjE7ShkrKk6tv4SubB27dCMVBTCtfg337bHj/ZWyC94OL7qWVvnnvI85sGf00lveA9JwtRrzre001KcOxmsYVHAJgi6STPn8+27GszyDpQdC96WSJtJCoSthyfKS8FDcVOqJHznoNWCC9mWM3E0G1pD4IZEhjrj6LCaxnrRNhwjgelqf5j9WDBVTCYUVgpPxjQ5f1RdINWIRwEPxCuG1THYpFUmeQOnYYsT0yzX22oJWA9BOoDTP8+uQxrqtPsRrIYux5LD/z9RGVJXa/wuxRCgOEszjGbaGlJnysVXQZaDMfWtdH7V6eZwiOeCCdMiNU24FhKAweoRgkyRayZwxF2LLFUGsAC2U1vYR/fTbkRpye1DBR93p0XSFuxnIBc04KnPo3J/s81sYXIUlgx5Cxg0CpkeF9OGh30DYR72Z/SP60Tiv4bkJCfXPvSludiExek7ZQRwm2lGhDnPGh/FJME66ARI3PUYK3eVwmeSQw2ZLQ3va5lLFFJ37m1uey8L6Lfw1UYWSClMP3fA48T+3qUWqbtE0UfVQI7MlF3Yiqt07T0Cx50eOHGY+4/QrzqckDyjm4f4Qve2qCMQIuKncBcKiCtaz6EGOm9+lODT7qLkRqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(8676002)(107886003)(38350700002)(8936002)(36756003)(316002)(26005)(6512007)(2616005)(186003)(5660300002)(6506007)(6486002)(2906002)(38100700002)(86362001)(4326008)(6666004)(66946007)(66476007)(52116002)(83380400001)(66556008)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s+6kH++6fXWpFpftRD+sylc2D5uSWRRowRj6X/F8FMJibH9H9RGSg25M87IB?=
 =?us-ascii?Q?eC3XkW2jWK7LmxY9PvKtgUr6awMz6Mr4mioq41GZdcQXFPjuoZ7j9jqYIrO2?=
 =?us-ascii?Q?qDORW1t+RHMSxHzyRPuTjo82UDT3BSD1WxytE8QTYTFMAobSc0Vhd19pVwPA?=
 =?us-ascii?Q?brg4s7LJiGkgdIRjYEVnyku+7XdzC13FMwZadmqyFmbBzc8jT5O3fDKNkvA+?=
 =?us-ascii?Q?73j3FTqZHikxysFt0qc5t1z02PqyR1KdQEBRJVBet7Wdw7VApUDmQMBhQpk3?=
 =?us-ascii?Q?272hEvkkTzM1qd1uckHGWEY0XQ5x+HReGOxJvOD8yIVVL3xyUq3TPxJJ4s3a?=
 =?us-ascii?Q?gM9gluk7tTC2Xhmso9SOnscZq3iBcyF8R3QuzJrSTi8AlFZSxWRX8E372ATo?=
 =?us-ascii?Q?tf5NjRzdMn3u5Wmw8dGnblu826URcTjH1AyHVaLvRJX5smOcITCU79qVoJxK?=
 =?us-ascii?Q?6qU/l2Rd7Jlb6gS3F5xQYYhXfknLFt+Hm40JY7ljvL43ketlxgYCJvHDzV/z?=
 =?us-ascii?Q?DoLk0MVrGLkZcDp5Z21lK7MmE2EU0G526+uSrdJxwFTesLxJz535y5GAcY7X?=
 =?us-ascii?Q?BE7Sb5bc0R3p7NaPatfJe26wJ/H60PeWdsOfJwcI8E8CAMp5+Yp2Sf1MZXoH?=
 =?us-ascii?Q?sqsWcRZ80aKt3VY+hXPcviwvIbR4T7wKjBd5OeqKwV8BDAhch3A2mt7hkziF?=
 =?us-ascii?Q?ej10eFogvtcGlLx86dwJfoORG7hXFg/wp2fF7C/RQtOevXWUPUc618byrdZW?=
 =?us-ascii?Q?CeGuAaZcHvjr+HFO8a+YCfQUaYQDK5J3oNJGaf12PO9JIyQmrVjxfzFsXg6F?=
 =?us-ascii?Q?tPsnNi0sRDdC2Oq6Jm566dvAjVEQTMSMopbTd5EQi5jrejAOlsO8luX1ANyI?=
 =?us-ascii?Q?5mJQAJBxLmRTEWBed6e+gtrDNOrnXcYvGq4xeyNZV2wp51ds47exzhxaLX3B?=
 =?us-ascii?Q?wqnOdRGo6XxQCjA1xeDa5S8dRiavNnZGjK8+7F+FxiaDfC9pn4iM8GFBlbqY?=
 =?us-ascii?Q?xMFxIW/TWlnICfgSMBkRIOQ01c1LDtwNM4ygEhZCbc1N7RWYQAGjA9Ds3wPX?=
 =?us-ascii?Q?g+mvhk8I+ws/7037Ywc6CIzWMV0sswBcz8uj2pNKyXK2EWWRLAkP9Gb6kGfZ?=
 =?us-ascii?Q?qc++8rUMBV13VJ3hd18OLAKT0x3URbrhO9eO3HWIqcSl8+KrclWW/KDrXvXX?=
 =?us-ascii?Q?cD80RLq7FrCENn61EOYHW0JLkH7CD4QrKe2ocd4ZnpVAMRbJ0FwZOJFlFMwM?=
 =?us-ascii?Q?PfEwALqo3GpQtXH+AVe3aRtvcnvj71WW9R2FniCEiDzGTIkKaMPA8dw9ht95?=
 =?us-ascii?Q?7kJ/fj7qqf4e9+BRCCw86/wVPklwJbrtZUa979gDD9DmkceyN44Onm3TQ9eI?=
 =?us-ascii?Q?mCsP7FkiybPzNVgCL8+0YWcKsdAj/k2b/1rvtEJKvQqn8wJZ8o71qNeCkqHc?=
 =?us-ascii?Q?l7910wcbuLT1sYVgRTG3l+rJK6Fp0vMXvWpbJkM6eid2Knjx6lt0LF4G+GQk?=
 =?us-ascii?Q?Wvu0IfPKYWStGGUPTqVu2NzpOTOmPUEgn9F4qTKhjqNeL5E2MmRQSqLcJ1Ru?=
 =?us-ascii?Q?C+gE1MUS4XTfMLeDB1/7ZVtTopon8xTRv1UImgFIdjzXrRAVpCrpH1tJsU5E?=
 =?us-ascii?Q?0e2/uWeIaoMdQ6UM/sNUgMeR6VNtF498/MI1sL1gfx8WQf333Ljt8hvTg7Ph?=
 =?us-ascii?Q?xknIIZu1zY3nmP+SvqSUdvsu4EUqr0Eq/VErENkMqGk7KSpFPZnekik0Jfzv?=
 =?us-ascii?Q?uPOGhVoI9ffnEbyRFibWXFs/Mo7Agsg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5794fe20-3efa-4c1c-80b2-08da36b19e20
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 20:29:31.7794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZfuakT5jffVEGNYQJb3cnNOmhZImZWPvf5pzi4pdVtuV2D0ErtC0cDI8v99kJCaGNHn5J2ThTZUZ1sMG0YsE7Ca5BnXvl14nTQWe4aR/qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-15_11:2022-05-13,
 2022-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205150120
X-Proofpoint-ORIG-GUID: 5sWlxqAoUfsctYKDIX3y7iCWT2jnfnpp
X-Proofpoint-GUID: 5sWlxqAoUfsctYKDIX3y7iCWT2jnfnpp
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

From: Andrey Ryabinin <arbn@yandex-team.com>

vhost_test_flush_vq() just a simple wrapper around vhost_work_dev_flush()
which seems have no value. It's just easier to call vhost_work_dev_flush()
directly. Besides there is no point in obtaining vhost_dev pointer
via 'n->vqs[index].poll.dev' while we can just use &n->dev.
It's the same pointers, see vhost_test_open()/vhost_dev_init().

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/test.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index f0ac9e35f5d6..837148d0a6a8 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -144,14 +144,9 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
 	*privatep = vhost_test_stop_vq(n, n->vqs + VHOST_TEST_VQ);
 }
 
-static void vhost_test_flush_vq(struct vhost_test *n, int index)
-{
-	vhost_work_dev_flush(n->vqs[index].poll.dev);
-}
-
 static void vhost_test_flush(struct vhost_test *n)
 {
-	vhost_test_flush_vq(n, VHOST_TEST_VQ);
+	vhost_work_dev_flush(&n->dev);
 }
 
 static int vhost_test_release(struct inode *inode, struct file *f)
@@ -210,7 +205,7 @@ static long vhost_test_run(struct vhost_test *n, int test)
 			goto err;
 
 		if (oldpriv) {
-			vhost_test_flush_vq(n, index);
+			vhost_test_flush(n, index);
 		}
 	}
 
@@ -303,7 +298,7 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
 	mutex_unlock(&vq->mutex);
 
 	if (enable) {
-		vhost_test_flush_vq(n, index);
+		vhost_test_flush(n);
 	}
 
 	mutex_unlock(&n->dev.mutex);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
