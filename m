Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905CBC433FE
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 02:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 375CA41C77;
	Tue,  7 Dec 2021 02:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xtpKjjw-yKIK; Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DFF7E41C75;
	Tue,  7 Dec 2021 02:45:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD07DC001E;
	Tue,  7 Dec 2021 02:45:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2FA8C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF76981A6F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="WbRcUs6n";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="S0NNikni"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tYWoZ43eYUF3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18F3E819FC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:23 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5C2W004493; 
 Tue, 7 Dec 2021 02:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=yIGpd2HJcR8lmukvwpRXs6N2Xk6Fq4lieOo8XiU+jJ0=;
 b=WbRcUs6n9qxjyU0KpL20uXPe/fiL3XQIM2RB9xToIf4kbEED9xEO85rMQm6Sv/8455Jl
 stI+PCBJRfdKZc+X+omqBbOjPUNCs48Hjow29B83s+U+N8yKYCp3ZrIrxn21Dl3yJjGt
 AypXwnwihVnu0106l5X2RN+O1GebD9ysoqxOWjz9Yc4cFRcg8sMdZSaeq8nOgq0P0XS+
 aYQJ43H9MSkDHQONbF4lmrZ89edfUYudzjJUJFwP4BVDIWlfaTm78uN2UNVxrstdUAED
 euNgNBxdyHDyfWRETaNrHvGgRQWXO3FQcXHkPtJCawQU9MDVqIhx2FUMgrEn6vFK2OT2 Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csdfjbwre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B72bJen124653;
 Tue, 7 Dec 2021 02:45:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by aserp3030.oracle.com with ESMTP id 3csc4snh1a-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW/bskBNcXuEsDm6SeyqNQmOoNCxRg0h7s7EgOHJzMNsA5/bBZiEROmF7PfG6eVr5DetFpCPWeVZfSdIuEAmMYJ0yQHGvh/Pv13s+TMjEEDma0qY/9o6d7pDF21J8KToc4B0aM70NCrMZnkc83j453mbZpXesu71w/pFKRb6bGtf5bvZvXMQLfkw8xTHULEQKQgtjCmdftrqJFhbIwgU8RpkBtXvTthrZxUMsToRub6VkboUuvgjF2HhVcx9Ur9olU3iMKWAdx+eNYpBc8o2+8dsVlvur1gsNiDU2KnJpAs4IJ/MfhcUeMV4FQpLY0IO8OmHsAAe2UjXJrgVulPaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIGpd2HJcR8lmukvwpRXs6N2Xk6Fq4lieOo8XiU+jJ0=;
 b=EvKzcZZ2bCm/U93RKi6hMUTCkymJDpLsygEbvDGxW8U9Cm9bEo4w/x5LJ96l5Ehg8picdD1ZOgCAND39tAcvinLsrX+cy07j9eh4QaZmUhV/ueihubZ1X/bN/jTEDWxNvYTDW8imY0e9rk+4QHuLUbGCKdtoxPu6U830k9wYBYDs2w+1FdQxeLOps/BtESedSrQ4U3eyIu2xXe6zIA51DaLpTpJPjqxw5S+RAwY8WFxIFO5t+izRxbeyUtKEoshWkkUMdHI3mztYqgaOSdeDeGmFn/9NMPOVsrOG+iraKP3Ck8Hb4qL5BOiR9AYqt5wJoc6BqQPnd9x2Aet5BZF0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIGpd2HJcR8lmukvwpRXs6N2Xk6Fq4lieOo8XiU+jJ0=;
 b=S0NNikni+n6wvSlizGNxSXN0xVjVafNvG2So3uSy2xBJ61BK7F2JMvcQ6UtWRozdz7MdWSxr24PqPZoquxe5J3mos71zLS/vwaKQagVbSEdd80ogRN8u1llzxRpbLPirgMBzK1cT4CHR9NM9wIA/nYrPAsRntLFO+c+D3VQxXbs=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 02:45:20 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:45:20 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH 3/7] vhost_net: get rid of vhost_net_flush_vq() and extra
 flush calls
Date: Mon,  6 Dec 2021 20:45:06 -0600
Message-Id: <20211207024510.23292-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207024510.23292-1-michael.christie@oracle.com>
References: <20211207024510.23292-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::39) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Tue, 7 Dec 2021 02:45:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83d69b7d-4742-4c34-29f2-08d9b92b9bc2
X-MS-TrafficTypeDiagnostic: DM6PR10MB4347:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4347C59D146372F8E8F81A83F16E9@DM6PR10MB4347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxXTOLbOf9r07daueukfGdAIUNPzSutlHnhX6yjfRYcvwURLAEnLlOrT1oe0TjCtu06ddQDv2L3gyPb4d6fiNwycgGbPDE+IyY+gIQwWSuqpt+87zdUxUHLvmlQLN1/i6TTzcx0GAanJeGfZU++lJiMndMaezgjSFJlZXV8kqgkEXXeGOcKIbZqgHGIbc85fyVzfNCoMvlh1Y74tqntaWIzQwMwuUS1HsgVCjf/YA6+2h0kiyR4X/fwG6kQlfbUnAYEXbrE6cMF50DNK1wEAEF3K5MODzXor0DcYkqiCms8swLMGeEicPtUSLr9YqcSdn7qHC9ub8i4penuMdOkBiZ1Q3h2nrg27SmrZR7VOcASSIp4wPqSIEQBxCiiI1gkUZQ30KPpCGB6O7EtHxTRQLGSvVjOm43x1puidfm9hgJIg6UbxmUXDAJkbU69oXALPixCTVttznpLig7IMlokOKoqXOGwynyv+lukM0t7VX/vnk42V3boE0FqYyK4oglWzkhLP0YUdGAuY4aNsdtoXtGI0savfiqg3Zn+P8ph9Y9z7lof6UUdI8JBOEdV2bC+jhmTOnT0pQEWClY5d6FymVJaOAcl9tWsKK1M4XG9wV8kqMJscmMUNbho+tDZdDkqisBjlmlVaLTzpSQJe7VADivGSo4JPhAmN8qjWxSJs5U7CFnZrpD5hWqabN4iy7pX7p8TeSEBpU5Y3JOad2YVWLugXGPgTFNCSoGIj3EAJKAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(316002)(36756003)(8936002)(38350700002)(38100700002)(26005)(8676002)(186003)(6666004)(66476007)(66556008)(66946007)(83380400001)(4326008)(1076003)(2616005)(6486002)(956004)(52116002)(107886003)(5660300002)(6512007)(86362001)(508600001)(2906002)(26583001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vEJkq1qciz9z4GctjIoFxiSRKWak/9gwKPUDL5ZWGoWhYuL1OVfE99ZK449w?=
 =?us-ascii?Q?ha4dd2PqAISvqD9gomgeKLjR/5QFjbN5Z/Z63yVuVzsKH976YIetC2Nh/IDE?=
 =?us-ascii?Q?TxGW5y91Yo1LzDcSptUtaiAQZWlCe391aO1OWkuxiVSgumf6nPUvV7aeOe13?=
 =?us-ascii?Q?G5M4VYUJp6iFnr/OC0KbdbsBGrDVssD+5Dz/uLQWHqfu4+7sX+lmLXIf4snC?=
 =?us-ascii?Q?/N9HRljeureVm1DX5NGod4G5BqrjLb1YQWdCqpHW/vqJ1BJaazMM8G4IixzJ?=
 =?us-ascii?Q?o5t+PNoP1h52DVUVKUbRBPLk8GBIY2DngrYgTWoj9iCYaADU+1rDbJa/Jook?=
 =?us-ascii?Q?2MVMDV2ctV4f26N492zwZvHOHy2bGB5DH2Oqd9qrDfPevDfK91Y9CanXb/kW?=
 =?us-ascii?Q?VirWUeSkY4xvfR32XEoxoeSJCpEYk55UzdTbWjHZSw27B209ZooNOV3km2V+?=
 =?us-ascii?Q?hbf467oMCHavNTmeWB8PN/eie1eM4JmOI9/Wg8//E5uUwsHPA+LX2LNHu/Bf?=
 =?us-ascii?Q?T1WgRqOhkLdcvKJeFrhlyjjBhJEC8PlfbQG2FcLCS0XX25d1T4sM1ttmiwQO?=
 =?us-ascii?Q?TvWB2tVpvcEJTahjRHCVBD5asobLD65obpEZhblWvbeRsW0bbS9yzqNhXlut?=
 =?us-ascii?Q?f+8oYRHpYaqKNiTYfodI28UtG+v4oZwVkSaBiUV68Bi06B9SApubjAIsch13?=
 =?us-ascii?Q?TmP+H0rXHfgrQVQW0qcH/Ol9I6EcqMWxJiHtMDt3o4cwKITCHAN7U9GJJUtO?=
 =?us-ascii?Q?lnQpXpCMP57T+jHK4pLs/5KGRbsyf/EmOJ7n/cXXzsODHadnGD8PNN8HdlbH?=
 =?us-ascii?Q?t4XbMoQfQHvaL4KJrQuvMrZxHmrHpdpr88ABOK5+O0bz1kiXk92PaS88G7wN?=
 =?us-ascii?Q?jKqjHj4yCvAbDdXENBI08R7HFjBmCS9aoAMztwCwaET/SEFKX1CaJ/JA/+WV?=
 =?us-ascii?Q?SHmcD+MD+OysmvYDTGFIz1eEl6CYrcLKRNunAfium34oIn6YP4J4zPWsYdgy?=
 =?us-ascii?Q?OKhKaxM8wQcdP26XYO1xjxotG1rnKTfwXFOuZQpf9qHiIMknBFCYb8L/0JqI?=
 =?us-ascii?Q?wo417b002U0YmIozFsZUn4v4D9tFw1B2D+3txgCSaJi5rkaLg5uQzNDvUV/g?=
 =?us-ascii?Q?1c1gonhpyCNr37bw+rx8FnEi184JkAsvAU2wiWGshTc7ZqEV/whwpicSHTw7?=
 =?us-ascii?Q?UexBXP1kCpgP1e7UMI5zTy5nDE6oulXxDfb1Y2V+UPYcPwvO2YK2seCg6W0h?=
 =?us-ascii?Q?MnEyX9iONOR3Fua4EOwGJ8NBFj8XiWDoO2G+km/WRkq2HalKK2VyqsMJPPN+?=
 =?us-ascii?Q?ZMRGJAmWUCw68gkHYMaPv2TFKkCv9btziI0DM/XYW3ivAYZ2rsFth9iNoQ7t?=
 =?us-ascii?Q?raVFho30h5vpme4FOMFvoUZw1dE8Fac1DuPsqYSjX7/R4zfS7DzlKxczzAfN?=
 =?us-ascii?Q?sn9UvSUaq3ZzydFmfhoTgS+ZMwG0sqA9F25PrSAnsHXPDUxGr2BxLadNXFQI?=
 =?us-ascii?Q?pRRN/OUryCVrf17U9O9lAxM2B1B96Vj68SjAwGLKyJnnQbqecnTslNqE8w9Q?=
 =?us-ascii?Q?2eu/3hz0hL6aVKfWxNUhxLl6BiAH/al/XMowW41wQoa4mGC2WVuk5X3cTTBC?=
 =?us-ascii?Q?UQsPdDMeYlpUtrq6Fft+wfYCvRLTBaS4EbGiUy8bfGOllG4dNG9WH/8ZMeVG?=
 =?us-ascii?Q?/S4g3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d69b7d-4742-4c34-29f2-08d9b92b9bc2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:45:19.8950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYmdxqAUAi3odop1pNb6SzuXzLxzx7O075YB+YKGFI/xuP/dChVK1CyA6i/lVh03Wf3fM9B8PMRakhU4uYPfOhuy6dfSMjjjzRZjgJd7tlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070015
X-Proofpoint-GUID: 63PqBauCScmXAXfETpL3aoeyUwkiajgZ
X-Proofpoint-ORIG-GUID: 63PqBauCScmXAXfETpL3aoeyUwkiajgZ
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
---
 drivers/vhost/net.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 11221f6d11b8..b1feb5e0571e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1373,16 +1373,9 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
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
@@ -1572,7 +1565,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
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
