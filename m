Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8746BC4332F
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 18:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F17F83E09;
	Tue, 17 May 2022 18:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WXOQiaoFgtGU; Tue, 17 May 2022 18:09:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BE9A983E0A;
	Tue, 17 May 2022 18:09:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13634C0083;
	Tue, 17 May 2022 18:09:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FE3EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 743EE83E0A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tyUc-hbMWq_P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F203F83E09
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:04 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHSg6m023098;
 Tue, 17 May 2022 18:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=0IUceQ46IdO3HNixKZe/1JwNW5IEvPa+8yN8OuOu2MM=;
 b=LQfd+65RlXCpVoupMY9vuDBLHclYc7rxxKlhqTkbV00SYIl157P2TcLtoQWehPugovVn
 J65ZrLiMgQU6N7TzMxt80Hvdc7Q6BAmSzkfet1/SXBpG6KXm46+yvTfc/8umrvdT/Br5
 75/isnsRsqzT+QNHsG80uZzQn38vs5DwGO6yOy4q38zuwmLnw2M90FOtJ33oKmqhaCh+
 OJ6XGi00G9YPsQ2YYgQsw0ZgZ1fwY4Lt6o/KRCGncAB9PtzKqHvA23kwezHG6CgPQ9hl
 HP6C0CI9vSe9tyP0C+CQFQNBgxm5yG2rW5gXmEMwkTkiuYDH/0QXzlnLVu9gEkAGen8e gA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s73sp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:03 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24HI69lX023951; Tue, 17 May 2022 18:09:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v8xk2b-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1WAX0xDkxbpiRNsCNLCHvkYe2IRvDSHhwqfdbx+bqAiMyjk1gjF8palqrdR1ZMEbnjI9BN5MwD3sQQ5TtncVSaIn8D21HES7Cjo9TZgW0c7Tr2+Xuv97+/Gzc+HLaX87hADJ4Scz2i3u9JS2RCjqngCtOwU8agDx1ePt84HszbCI3EiccpchzOnZNLGRL5XJw3GuO/R/B47JfI5+JiyT2NwS6OFXZRRqL/fvo8fvbDPK/U8u6PP/j3/zU6eDlBIl3108yzGu0qZLvqn45Gof7p9zkDBza/JJHI3u2Z6S74KXbjCxE8fpEHD4Ws3t4jlHLPP6Vb2Bfq/T3mBhx3Afg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IUceQ46IdO3HNixKZe/1JwNW5IEvPa+8yN8OuOu2MM=;
 b=gWOwLAm+8usN8MjfvjI/XJBn6Cygn3HlCVx3Z4nGhpYPPNMMS9IUFYUem75iQEXcSjgBPAeNV+5KyP5d7lqb564dvh7aT9wwCFiFwWIWamDvqlxnl+njiMsFnAy5tzOF4Gczhg3EySJeoc1Hfz9VadscpXF5UZe3jkFC+z5KvYxqa2QsFjo4MKoZ+vudZMXwnaMZjUqmguMbT3ObkQX5mbpExbvnkpRvRiWQ/K0Lf5aa4Y11ChztEqpJ5EI1XGDO8vA5Oy+oNneDnUok/Mp3i4nuEMIUySF4G/c7qebNpkVppfxwLXzLDknzDDXnr804oLB5lNUXwAYiSh903TVZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IUceQ46IdO3HNixKZe/1JwNW5IEvPa+8yN8OuOu2MM=;
 b=Vzcm8xzoU7YuixrFtgPGKAJB/HwFO9I6amcBLtDstlvToCqjwzrZ7uGeFFTiyt6XHvyKudR2ckAi+kUiRtZ0k7xhM6fs11W6SDOChgomBX0fnXk8W2+vhm7aXph7t4fkNWZDOlEMhMbwFFgcpzjdvFmnC7ClXF0HjPV4/R2kHn0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB3993.namprd10.prod.outlook.com (2603:10b6:5:1f6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Tue, 17 May 2022 18:08:59 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 18:08:59 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V3 2/8] vhost: flush dev once during vhost_dev_stop
Date: Tue, 17 May 2022 13:08:44 -0500
Message-Id: <20220517180850.198915-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517180850.198915-1-michael.christie@oracle.com>
References: <20220517180850.198915-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:5:60::36) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0033b4d7-73dc-4e7a-0974-08da383050ec
X-MS-TrafficTypeDiagnostic: DM6PR10MB3993:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB39935AA3AC5851E2EFCA4D98F1CE9@DM6PR10MB3993.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wl+ZDt5bVENUhNCgjnfm37AzyKqeUpR9BD1dcvvirNM3qdoX2rxZfoiynds2t8C58a68E1poqg2jX41RBfLbrk6XM/CeEl2n1gL+iI1aZJWeFXFHawRq1MZJjhkq1D2bpsK01A0PneOBsECK2s6oeaUt7KZ8lYv5r//uIvSc2hE6D56M0Hd/4R+dpaHAR9YILCVloVvHRSkA+kBGPymKZw0cA5LyClbKoPfUgeJmjshPmz839jn75QoPtZOYi6rjWDk8P/0mFzm8LArguDsql2yoirmgZJM5r7ifKo1zAvC5cd98VnI2CdA1oH0TP35i8kFui8G6b637Mds7kauCjgWYH8c/ViV3rGBh7npOKjnemp20TzKEklDLHjQHL5hCA5rheP2sB8wBaUWHVglpxt+FdHidETDwZnXd1YPR7fBHkpnVl8UMzBjuV/GkGyLT4tPC9my8F1RQZT673ihthP2ur/FyQpNVoEIcuANJEp16xvrF0NLXnz4l93ZQ4A7DAU+YwSrLxdtW0Myg7A0CiO13iz5fBg09mlfO2LWJcpXIRDsdLXc3Npm/5OJR/CmTvejxdsyWLfHE4TzDTotX+YxU1PKqn2RJI/n0wynLQWqjLd9adFsrcfVSS/yZydk/1UZDlhq23d8WQLJgLPtjf1+1k+jvNT//1B7dNj9XeV3RLA/7YTGcPA8t0w/94X94Jc8efV1DjdUJWtp/QOx+iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(107886003)(2616005)(83380400001)(6486002)(8936002)(508600001)(36756003)(38350700002)(6512007)(2906002)(8676002)(6506007)(5660300002)(26005)(186003)(66946007)(66556008)(52116002)(316002)(4326008)(66476007)(4744005)(38100700002)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0tP1KiQVPLFHMElX8JA+DWhUtncFNJw/mdzAwm7XFybySMKN0hvXTL+hscET?=
 =?us-ascii?Q?khDuzUrwlP58uNbUwN8WrQaZ5Xrwr6T442D5pDdJFLnDremNug1oyH5rtrUp?=
 =?us-ascii?Q?LUjE/3zxsgBEkQeCD7MOk0O+vgvmcVh99IFuUparF1kz11D/d5ft/6q/hOMp?=
 =?us-ascii?Q?ICWWFEeI6JfXbhgMdPfh6ZNl3jfOszTDDTjRpFisw11g4pacrSvUt6ThXOJq?=
 =?us-ascii?Q?TiakNq3wjaLCLjRa2bFcoV5Bh5PmQ1+eihutOceuLtGNILlUV7Gh09AoaWtn?=
 =?us-ascii?Q?bj4E4+4IZSZGhfISGScy5N8ueH//cn6/YwB+luBASPqjyku8pVReHVV2J3ub?=
 =?us-ascii?Q?M+sOQouCiy6Iuz/zt9SXM20cUI7PDVcgemAGGheXeuk276vg46X5+2JIV/KB?=
 =?us-ascii?Q?6ncX4NPlUX4x0PPniL5yimyMl1aup/T3LkRrRft1yogN38fqPDjjjpgkr9QY?=
 =?us-ascii?Q?KSYEtVGr2kZPa8aN2IzG416aRA7EopwCjSUy/z0/xT6XmaX7w+J5e1h4Urlr?=
 =?us-ascii?Q?NGfLFjuUoKcd8AclIjPl5NFNKTNpVxE8wOjPp9M1SwXz7GiSffWe/INN6AJI?=
 =?us-ascii?Q?9GQ64Azg85nkyiL8gznreAHh+bifreNBiNPSMZvyzeYTHZKFzue4cxBt+/EN?=
 =?us-ascii?Q?dV8xLkeRui31aBoDLdGpKW/2kOq9qSnYbwk2C3vRzcR+nwLjgCoUu47o/bGa?=
 =?us-ascii?Q?aZgxGoFwEXOOC6tKXpRtj6HwXHFugMkNCau9/jbnXceLgAAY61hX28dnFHtu?=
 =?us-ascii?Q?GufL8Ds8xRUYUITdp9MfcCr7XMq30PGwvcBbA5cBFKo2dPpyov3u/SbI7rP1?=
 =?us-ascii?Q?dBpt3qBwRkM4OCVT1Bkfm7sHy6DV26JDCLlBQARLOhwuSJrKuXPsAzMRCq+4?=
 =?us-ascii?Q?ag+Br/FmFooDrmrQSUHxevuunmjlKZt0n96V50XwtdxjTljcph+a8nwwnoT7?=
 =?us-ascii?Q?2XJ8BXfDwhBhlIuSV8I85/jPYU0BJQC8GZcA/h2Mb7WjyWRK+0W1dryubqab?=
 =?us-ascii?Q?K1Yx/iD4FIs6FSehysFtwxT2fHKnMcczaEroJdPDkEqeRpeetBT6KEQzppLx?=
 =?us-ascii?Q?C24BWp/NJ0mb2MCkMXwkVQ2tqud2eYqunc9BHg8zxuKz5rw7gA5gHZq0+xhR?=
 =?us-ascii?Q?Fc7pWIFu4tey/mZqrKtsmjj+3PUHzEu8MPtvSIbzao5yaUfnCjRSiAUjPzsI?=
 =?us-ascii?Q?9Y/VYLpSTmMPPjXtmuNULWCDL3+SB3YGQYJSy2tFYvkmOtJeezotsYLqo5Q8?=
 =?us-ascii?Q?KyifHr1e8pKJuRz6bxx/QXiCOX644y16NquwbaDxfND4fEqmnJN1cXNjpIkY?=
 =?us-ascii?Q?ugWemiKkeAAJ/cCdFSql316GqXFRPoOVErIccuFAQcp04IjfOjgY5RzlI7xZ?=
 =?us-ascii?Q?MkAQnt7MANQnUR35W/Hofy1YbUGeStQCBfu8HWjfMW9q/KdU2tsAGI7YaCTe?=
 =?us-ascii?Q?mTHkYNTaMLDcxocnQgZGGT2TVrGNCcLCHtdoWHECEIoVQMoUm8S7k7raW0yC?=
 =?us-ascii?Q?ORjzXqnqLh3hHEv0QKLoRTJVHB5XQ1mZG8ctbCSn+KsNSHlMYj1pMiY3v6qv?=
 =?us-ascii?Q?CgQIYWq0Su2AI3IA9xCM2tJyu32POkYRAT8/RhAZCfW4HHjIj+U3ZE5RLDob?=
 =?us-ascii?Q?haUckeeW977Ck4rOdOEVqAv96n8EwpcpnKWlH3cx5+R3fgEydyJ81ocxbDU8?=
 =?us-ascii?Q?O0jNB/FZNkcEZCeQ8cOLzcNmNyY/knM/eT5eTCMEtkcc1ArSZrw12PhCW56R?=
 =?us-ascii?Q?wtvwTzEK4JdAHtapasw6m/Sj42dFoD0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0033b4d7-73dc-4e7a-0974-08da383050ec
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:08:59.4828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSyWapL9J/4//Wj5ExS/ziPm42AwyuuJop78KvqEE/Y4oE5mepcbsRTVdx3BZpjG9Ez3BAUZU57s7aQJ/i5E1aPDI3LmPhCi9bfJuH6ocU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3993
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170107
X-Proofpoint-GUID: A4xLnLDOMzN3sCc-5NVq7nQM5yVM9NRS
X-Proofpoint-ORIG-GUID: A4xLnLDOMzN3sCc-5NVq7nQM5yVM9NRS
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

When vhost_work_dev_flush returns all work queued at that time will have
completed. There is then no need to flush after every vhost_poll_stop
call, and we can move the flush call to after the loop that stops the
pollers.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vhost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1d84a2818c6f..9f8de04bb673 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -653,11 +653,11 @@ void vhost_dev_stop(struct vhost_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nvqs; ++i) {
-		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
+		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick)
 			vhost_poll_stop(&dev->vqs[i]->poll);
-			vhost_work_dev_flush(dev->vqs[i]->poll.dev);
-		}
 	}
+
+	vhost_work_dev_flush(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_stop);
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
