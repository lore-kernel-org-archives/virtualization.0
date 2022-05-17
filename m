Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AFFC43219
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 18:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77196408B0;
	Tue, 17 May 2022 18:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y4F-lnffSjKh; Tue, 17 May 2022 18:09:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A3AC419D2;
	Tue, 17 May 2022 18:09:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B7FEC0087;
	Tue, 17 May 2022 18:09:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A953C0085
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBF6260A84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="HeW4jEkR";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="rzuUpMhj"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UjuQxm_4_l4N
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00C2E60A9C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:06 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHSqvG019293;
 Tue, 17 May 2022 18:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=PUeOLkzjZkWsb0fxzVTKpoCF3JN9nNGYa5sNeZq7WkE=;
 b=HeW4jEkRmINbEAe5vtnNLnI0yHfUXWhZSyq08qunpJSxprEmHY5r4/KKm3jReztetvR1
 EZRLOqg18bo+5q+HNfdgXJ41++vkEpbza0xVDf9yWNFnxe9xJs51N45n2R3VVtL+MiMP
 Ghwh05qfqICRhaKxOvJSGPYxIwsHI5PdgckRp98ea8gTCmuWrQ2JVlEXwr5BfDlKa12t
 YW/uTn+Vn8O4soCPysjMU4RaadnSTLt5ZEL7yEHExNAV78hFAfGC9Rfpvfr5/YK62n9L
 ocSeIH8IpA6qWHJSfrf6XVQxw2jAJ5iWm37KN4O+LVIhrR/r9nSU3UMXI3huzYUkdiDD gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371y730-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:04 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24HI693J023985; Tue, 17 May 2022 18:09:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v8xk2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOnt5Sbd8Ub5C35mjfyBdvUMk02EcjcldTvDN87EhY0i+LFkiuP3R2vbtzjVNzXOzJaqzK3z/dXctzGlfT9jWzz+2lyd5sr/TntzS3mB2aiiMg7TL2wvHZ3Ikv3rJ1nfFJ8qxMSytSwkPgjjhGk5y9FP4jwI6MsL/O2yiJYDnGNe9LRL0MI9n12Ql6XLu2ERPC32p+csbF6Ekg9Cn+LlQO3C9IVC6g9e9gTOMmQkSeqcHPcCOPIVnqSAL1CAXqyLdVGB7/lxYgunwNQM0PumUJP7nTPWBLgJbsHcANh4enZuUi2qYSr9aJJ3xipX/kzvn89MfpqR1fJAitVmj/vkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUeOLkzjZkWsb0fxzVTKpoCF3JN9nNGYa5sNeZq7WkE=;
 b=YJof/IgozXOad/Eu9aLCdilXjTM3K9bfIqOS/bz3tQxsLQOWGsBAIax8pTdM393dhE8Te3kcL6eolSQXwW+xgCqCkXWKwseEi8STTyXy/GiD7bOGSq6kUrnB/xFG9pf5goMSNfwlby4MWoSg1zrR7mpBXDMOcXox6G1Bj2dPGr5litOq53JkguXel0tI4uzJrdkk7wTALlUWDbHEZwkSIEgbZme2UgNFFljuNU6O9dCzvxRb+QHW2BU6XM4lCLTu0RmWikdFTMJGfvKa1XhQ91oW7UrEiocDLTfwjmXKf5XwQ8kl0RCuwxhwEDqyw/RGrpqJUsg22HcNlaKI2D7c8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUeOLkzjZkWsb0fxzVTKpoCF3JN9nNGYa5sNeZq7WkE=;
 b=rzuUpMhjoC8emW+wqDDMGFTL0aksoV4oFjIDFU+QXBB1zTcilx5hSdZv97cPCHKCfIh1fB9FFNhCzIZSamd92F6D8EUsvuCNDi0JInH5Fdgl23b4e0zoNjhj5yp14Ql06322QA2+IbuDCsfoSo7DVdhEMAdt+Co/lOAw2q634vQ=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB2873.namprd10.prod.outlook.com (2603:10b6:5:63::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 18:09:00 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 18:09:00 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V3 3/8] vhost_net: get rid of vhost_net_flush_vq() and extra
 flush calls
Date: Tue, 17 May 2022 13:08:45 -0500
Message-Id: <20220517180850.198915-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517180850.198915-1-michael.christie@oracle.com>
References: <20220517180850.198915-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:5:60::36) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eda83cd3-fa7c-477c-2c3e-08da38305131
X-MS-TrafficTypeDiagnostic: DM6PR10MB2873:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2873D9F0419A9E14F1E76A6CF1CE9@DM6PR10MB2873.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FykiZMuzvvY9I+SauiWbyYWcxK9EgazVVZyZYR0B5pKgFofIihKwkjoB5CTfesUiVN2uZK6Ad2ThPSdEi44uzJk1AyD4eYxMmWDmofQMeEKC4wMjyOuSzOwHtItx9lcIbpKcppG3ctmYd9T78TYsl+ZRxkCv/YkwG6lLloAK6T3KRGJeHBURHS5DPCLrkbGyGySJkLKaTxfYdb2qvxZXtA88b+P4cPv8lWFa4/KXG0XA7LOXM19ZxNwXPGubqBdDpsU5w4bTHKmVo77Sh1KICE+QfxPVs1HHR/WNWC8S3N1tv0kPi9JPMnbCWM6o0KQcbNtUs/sg+tSMvQ/hLYVgpUcYyL/N53SOB8yAHW8wufzaLNPZfNPhJ9hZOTjm4heA6+54xrRQUrQ+C4JIQmRLNiWag6phRYL12ED//ye0cwwia/Svo7YN8MNtqaHHK9uqTf4xjMOTCferjuw2/VN6tJ5lbW2F+TaHn4a7G9a8QIlrqNIF1U1ByADUHvyevfw/5U9gd59+2+j/N1Rcnp8NkuXKl0FmpDGemn7siDO1/nOWwMHfhoER39O1w1rLh9oMWMDqTkyo6dLPeujXLg55y/VBPs4y4rWbMTwfuiVt+dcCxl4L5HhImOXhS59ckPpWAi+7zXn6KAIe2TMmwb7Lf5bWBNGul+T2HZIJ8SXB1V4X3fKUuVXU7vJVZYecLvRV8NHgoh+X7mrnBfuRzeSTrc27V2WLnz0DIDZK073P2nA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(36756003)(5660300002)(83380400001)(6486002)(316002)(1076003)(107886003)(38100700002)(6512007)(6666004)(2906002)(6506007)(26005)(86362001)(2616005)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(508600001)(38350700002)(52116002)(26583001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7I6BwN1//mFOvqbmm1hnrkoCEZ3VbBstMK3IgMwEa7LKi29WfmZYNqYNkqwH?=
 =?us-ascii?Q?63kIdaxYYADDkMYzvo7LtBOuYov4OkX+vS7ASiAjzxXpqHYTy7XlYshdTuSF?=
 =?us-ascii?Q?mK89RD7E3iCVa+pIkCSiRo0gxKSOFovzrxQObyh2p3e9Qx0ozWmsyznJvYaD?=
 =?us-ascii?Q?JudtBwk5U3VIYHmH6TTL8+cclWMxQtAB49YhVyC8uU//ynytqeB/PgG97U6g?=
 =?us-ascii?Q?+9bFG9bIPGBXQgx8OxfMbToDwWHn4F3y2HaEUxAQcb6aE3JEXcAjiilsbF0M?=
 =?us-ascii?Q?f9e4Re+svtOBjqNTUFGdyxFILqDzLRlDRsPsjxzSgUwxE+7EKDKBVnicCUop?=
 =?us-ascii?Q?quxasWLR5sc2tLvY1eMpvJcAyW/WrOE2dZ1qEJ5RbTiCBxi6CAtOAJbvXCqC?=
 =?us-ascii?Q?nf0pPjJklFhsVUUfLUZDdvbcD7Eybl766+xsNBP+mOdnvJExgdSUQkxgJszb?=
 =?us-ascii?Q?N0/TNLZRafgpVGn2IWTjKh6RxvxUGfRMMb63yI79hnhnEUw91S1focAAvcBL?=
 =?us-ascii?Q?MrG6egX4uqjZ9Q/8LetKQ2GW13zfugSL0WJIf/Qzu65ZSznjzCobkc7zmz9l?=
 =?us-ascii?Q?s7LbnJ5obA2nzjcBVULm9d/b9xYxUtNi2eyNeBjRSX81QpDAyckiN/Mf/JoY?=
 =?us-ascii?Q?4mxuwaN9WHcG9v9bi5fJyAvrkFaXOLXBlFpJqfN61bdP/xxO3BlMLcDSB9Hz?=
 =?us-ascii?Q?fDZD71M2trT002NPDYJpTLmuscOmtN9B8vhRuoAblcdPuMjdfhDKlehsf8TE?=
 =?us-ascii?Q?3eltXWxR4RifWo0i7tWZGTLQOMpZ2H7syh/iHde3llZqYJEj+Kkwn0DN7zuH?=
 =?us-ascii?Q?ogUUbY6gtMwLr+lxqPinvwOlEqXOylJbJyi0Eyr0CKZwPxRqQI/50dmllIsQ?=
 =?us-ascii?Q?KNTksabFuZUq5IikpmCNLFRWd/ngUzf8RrxUmqncDCpEEylCQCsYLuplfrc0?=
 =?us-ascii?Q?4quv3IDMI/eTI1WYQIll4BrjJhOu09uE81Px60sMevs9yNsTmps2xLSw/OG5?=
 =?us-ascii?Q?PBcseUwbreuMo/ZjHQ2O3SDmocOU/lgchYbsu0hd0M7iljnGOkNFLDT+7oT3?=
 =?us-ascii?Q?PpXlh0cpaJm94/yevg2JtJozmFFsUxtCmjKE1oymOD2ktzrecZi2jN2KsM0k?=
 =?us-ascii?Q?R+fgsNjntR0k29u1+IEvRE5qq3y5A8oh8jdiagrzCsXXgyg9Klrtd0+ufhMp?=
 =?us-ascii?Q?FQb4cc51JE/EML7t8yT/7AByUWSUwxj+cV3G3H2U8FWjLl/4i7lRjJKS5zRy?=
 =?us-ascii?Q?X6vulW17YzGiRyiwORs/H+k/cD0tWk5mSdwuD7gcQn+AYLYxAsR0THYh2+uV?=
 =?us-ascii?Q?UTJmMvkvFDA5OkVZ7s9/BzwEzaHLecDmHGYSxSWgk3CCT6F0ZKg7D/ys4At0?=
 =?us-ascii?Q?piu2Q6Nwff5ErgpDGijaFCHvVCFgw1O80oPqwn7yJhJLYa5OzTgFSRSmJK7S?=
 =?us-ascii?Q?9YkoxFxOHSDHGlyZ25dlt9YQcpkZ4BWLqyn/CPxf3vMTVF0xBhQsveBR8tSA?=
 =?us-ascii?Q?FaG81ZzY9/gPQ7Nqsea8CoxH9HlUn1E0GdAz33eRd7rVoUftID8WkMiMuzbM?=
 =?us-ascii?Q?DpMfI62FlnmFnP5jISZ2VPqSZ79jdaQR0jHkz29SsbmeP3uIUnDfIH9mhChC?=
 =?us-ascii?Q?tSlew7oLQznRyVlHCEYgzqCBZ6vEsqOBytPzBJM6TSHhANzBdU3Jy3jDfY39?=
 =?us-ascii?Q?ZyAoztb9NTl07X3H6GpgQNQgjPqNEd3dlOOq0kb/9U8PdAkhLFjet1EDe/My?=
 =?us-ascii?Q?3m2uwkQawnIZKhv7XJEqqnHE+bv94Wc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda83cd3-fa7c-477c-2c3e-08da38305131
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:08:59.9046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNrlIPjLl9JbOI7KajD+97lY+aBHKr1PX5UIugnTBIKEi3nmANViMINR0w+yMFibTwF+r0ALKIK867wq/AySBUBp/PTBFtC+Yi7m1/gwve8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2873
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170107
X-Proofpoint-GUID: 3dMfcgQVD_OQiy_g5Pq_5u2sSueME_Sr
X-Proofpoint-ORIG-GUID: 3dMfcgQVD_OQiy_g5Pq_5u2sSueME_Sr
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

vhost_net_flush_vq() calls vhost_work_dev_flush() twice passing
vhost_dev pointer obtained via 'n->poll[index].dev' and
'n->vqs[index].vq.poll.dev'. This is actually the same pointer,
initialized in vhost_net_open()/vhost_dev_init()/vhost_poll_init()

Remove vhost_net_flush_vq() and call vhost_work_dev_flush() directly.
Do the flushes only once instead of several flush calls in a row
which seems rather useless.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
[drop vhost_dev forward declaration in vhost.h]
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/net.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4e55ad8c942a..047b7b05109a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1374,16 +1374,9 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
 	*rx_sock = vhost_net_stop_vq(n, &n->vqs[VHOST_NET_VQ_RX].vq);
 }
 
-static void vhost_net_flush_vq(struct vhost_net *n, int index)
-{
-	vhost_work_dev_flush(n->poll[index].dev);
-	vhost_work_dev_flush(n->vqs[index].vq.poll.dev);
-}
-
 static void vhost_net_flush(struct vhost_net *n)
 {
-	vhost_net_flush_vq(n, VHOST_NET_VQ_TX);
-	vhost_net_flush_vq(n, VHOST_NET_VQ_RX);
+	vhost_work_dev_flush(&n->dev);
 	if (n->vqs[VHOST_NET_VQ_TX].ubufs) {
 		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		n->tx_flush = true;
@@ -1573,7 +1566,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	}
 
 	if (oldsock) {
-		vhost_net_flush_vq(n, index);
+		vhost_work_dev_flush(&n->dev);
 		sockfd_put(oldsock);
 	}
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
