Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FF9C433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 15:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0AD841D50;
	Wed,  8 Dec 2021 15:10:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W_oGXmR2iCLt; Wed,  8 Dec 2021 15:10:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 633B6409E7;
	Wed,  8 Dec 2021 15:10:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39700C002F;
	Wed,  8 Dec 2021 15:10:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48EEAC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 15:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3556F41CC3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 15:10:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TgV0tTeXG7XK
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 15:10:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C818409E7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 15:10:15 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8F9WMl026570; 
 Wed, 8 Dec 2021 15:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=s+Qj1sEMfqvI8o440fdiMKmoKBxW/u62b4V90gwpGPo=;
 b=eWRbCEcoOX8zSnz12xcKgFBknwyW1oNf3qbKaAaVsDIuY+uMqyOto3ifjwbce1HCCtmL
 NG+DYmc8mCYWo0EaYg8B2xJS/KL8Qw3XWAmagceQtsr5eEYZy9EXtnsRdoV2D/jprgNV
 rXH1do3AWGpqwtKBW+2fME8Rp28VdPtqFfRA0ka06STlI6qDeVAPOsRCK0V3Lp2KNNYV
 ltCsImwTijbkzDqvJN1hdNUcsCbnUvevYn1rfuDGaNQaBYiEkoLcmaay+oQLtwqSXULL
 bQV9m615FXBzoIuCLH7pHwxah1R41FoUdscZbIbq2XKhM8O/vb3hEzo7ZihEkbqA4FjP ZA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctup50grp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Dec 2021 15:10:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8EpRVj157727;
 Wed, 8 Dec 2021 15:10:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
 by aserp3030.oracle.com with ESMTP id 3csc4uud9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Dec 2021 15:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaKQwT0GtJhUlM8dcPOqthPDRmoFdFWybZS9omMiEIdsBq32U88rAhpfcDlU6TJ3gHahzfhqhwwZjc0HLvcoXs0BbG4VyAjSzXkMMH1xLY5vxX7DcB7virFSA2XPI7pExxWJPx4t5QpvwobpxS/WyM6RRAwzns0eO6ruThVmYAqTmJIGmj5QXqFSjtj76EisaU5xn3scvct8JK0ksicT+Guy3/mrvejh6C4tOauvf9tJ0qoePxtrsRywy2rcq+wkrXzuqRWMVOyXMCS5eLt9FjL0EgfU/jCfbISDrbQbZ7rkwuKwF6gASDs2JzOQuHtO/fdJF0VQLNcBOSVFyQWoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+Qj1sEMfqvI8o440fdiMKmoKBxW/u62b4V90gwpGPo=;
 b=UHSkmNrj9WotDApJl8z3rS/ifqlPeXZZpJDXPaYTikJeFcOnmxpreh3oqjFH4CenzfppV0671SN4goLudyN394/F0c0uARHpQ6Frl2c4Fd11rpPbUS79x1QvD3jgQ4onswFt+jCqaQEy8ibxDA8OsIGWL7PQMVtdgau6GU42FZlhcSt/Pn3PMIv5MgEzra/WUHKio7MJ0DRPshEDaeqxheEU5LfmyWiOJBbhU1VL6Ru0TdHbx4y2kgCwLhw+LQgsC5kCiqrxkyogkwoIFvtFF/QV5R9cL4r/H1iuNt8lAfp6qf88uuUW13xNlm2Y6tKKAgz94hj08MBKmAbwjS1EQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+Qj1sEMfqvI8o440fdiMKmoKBxW/u62b4V90gwpGPo=;
 b=ZAIGiLnolm00m6EF59h36kcKk/Aaw+SHs/i7A/54PJSFh1RxJlu9FC7aFZC8WiQuBTMRNoJ7ctssEUH0BrELdzNHZ1ZG8q4c/0Z9oS8kW/HKBqYudIVq3ZkuQm7gj7vzXJzHrmA1+695RdcLJw+NmnA/kIOLLjrtqXh+hjQdVGU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1358.namprd10.prod.outlook.com
 (2603:10b6:300:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Wed, 8 Dec
 2021 15:10:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.024; Wed, 8 Dec 2021
 15:10:09 +0000
Date: Wed, 8 Dec 2021 18:09:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH] vduse: check that offset is within bounds in get_config()
Message-ID: <20211208150956.GA29160@kili>
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) with Microsoft SMTP Server (version=TLS1_2, cipher=)
 via Frontend Transport; Wed, 8 Dec 2021 15:10:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cacdace3-7a7f-43f6-fd18-08d9ba5cd2f7
X-MS-TrafficTypeDiagnostic: MWHPR10MB1358:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB13584182FDF78545CA6340218E6F9@MWHPR10MB1358.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhq84ODE4NFKJZqa/fQOlGDIdTQXisGF5S7zKD8ToHwSbcYi2CVcx66EU6ORuz5ofXLRYgvNe1Lyr2TwzAs3/tUcdh7rxq77uaxG/zehVAaqt30qhmMxQhsjjg5Ij0aQpQaBk+45vN76aafMkbmXkHW9b6tzlYyrN6S/SOWi5QgoKhFjc+ahXzprcKjk6jZwqmgUmLX/dd5CVinOCEEo6Ebp2RZgXeMzpGlSUA3wrTBriR6/y4EQRLgb16aM8fb9/mpt5Iwv2Y+OIpeg6PsTjowIUDpgO8R9dIY+kyQNDMM33mGwVrkilVLQmL/U75+BgHZdBjMGoDGVrNEHRNCwuOoD/8dbbUJ29rRJludBjw3I/pPyTtYb5XtUE7rnCP3RGDDJnhCKSzzWCVVMxqKoDR+dMEzHjYutfyAngJuMjxJlCmYUmbNWCkhk76atLc0Qy30qGifD5tFtvb9ouaa28KCDLzUqM6wqU8oVdWKxWHa8T9EoA2LwtT1pbX0Wex9/KO0xReowyOKgx2S46beus5YNVGCdO13W612vGmKuGPcXaZS7aSAq1HW1UugTXrJl+sdwJL9T9Y5bPnvOuPpmjxtspd6AanDuuvyrkU09GhRAFBpb/Blu3hqzTYU+lvHWDNVZ4/7K889aPirTBymvikndajjbl/V5xT2jRPJWbMuQZAmk0oTQHsCz9WG/jsy7EGLPXa1cCCRv9A1lwVrRZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(55016003)(83380400001)(186003)(1076003)(33716001)(26005)(44832011)(4326008)(5660300002)(956004)(6496006)(66946007)(9686003)(66476007)(66556008)(508600001)(6666004)(52116002)(8676002)(316002)(38100700002)(38350700002)(2906002)(86362001)(33656002)(54906003)(8936002)(9576002)(110136005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c6u57mgRj4DbLFEp1aHhPgCyYpoacHruFOnXU1+KDae8yssByxweG+0JWL0E?=
 =?us-ascii?Q?wBFdGozFVolhknBbFkPotvi5bhmvMc+8+0mvKnbsPmMXhD7uWback/zAIHmm?=
 =?us-ascii?Q?ktwwb2GMBw3O01ax+Vk5Wvkwr5bJfNUhqIW6jTKTeeTpndA5gIaMMOhnq4KF?=
 =?us-ascii?Q?tg7VSPeqMw+7PjpcPuZDmbaG/nMjz63vFTCKoDL8HWvV7i2cpR4V1VgcSuQQ?=
 =?us-ascii?Q?8K39EKXH2ubaDEdD88bjfACIuwW9gJd1ipVg8YsWdVxtZbqBTTEYbuJOtj2+?=
 =?us-ascii?Q?avC3r5ujaN0ak+z5EyYcJBnuxsz194WizeWp8FI6Vx7eLVJmIyoXdqb3gZMe?=
 =?us-ascii?Q?h9JVqyoeURedJu4f2+r9Ob+9oHgammtqwy4WT3uZlKvVsIv6yhBklR0VKMMw?=
 =?us-ascii?Q?mV+Jb4PukpNxN5LCQGa+SGp1Pquay+WIF7Y8aaDGkIGqczODjKJPwRVHqE6Y?=
 =?us-ascii?Q?xa8Rd1P+19W16XTI1y3CeUEbRCssa0/jrTokiLlfS7svDsQsZmdhzkNPeSVA?=
 =?us-ascii?Q?M3UMTE6Y1MUcPLcKPkYyiQJqG+h804ZYpgHiJpYmoUExwboOd7w8XbxerMda?=
 =?us-ascii?Q?LjUUI1tvaxUmeLqSIMBvr4lmt0dnRW/6d4oSdEHJf7H3t/htqKLbMDebJTFs?=
 =?us-ascii?Q?pdUNc7AWlHkudJfX3uzyWQ3cplS3yQNLIVBe/wi2SnVvWGtRZPyDMHQfEzup?=
 =?us-ascii?Q?TzAOjjI8Pa8DKE+4w0d17j8wRKe6Doq62ULKGPWY6LxRzSi8B/Zw7TO9QPGh?=
 =?us-ascii?Q?rDl1LPZfHmfMeKNDb+jZZpyTKAqmp8tlFr0lN7r4uIZCzBOwAKFBrL8BT5wr?=
 =?us-ascii?Q?iuc+IZtSM83QCflsUPhm9JZUiYGMOpQrs6GWrjKi/nRuohaZnVd1bd7GA15A?=
 =?us-ascii?Q?s/vziAoBuApwj1qElDgQrSgUm9q43Hoxuds1uaoq3DezvMwF/S4+hPGeLQEe?=
 =?us-ascii?Q?yT6Uz+HJL+96zXDiD9/5srTBd/5vXpLR29kmqcE69N1hwLA4W1FMlPogFWZm?=
 =?us-ascii?Q?6neYwGNv56obUOF9VvYwqP6b3Dvi4sAwx53aDQKMWJoa0CTnJJ3GBwWHMVHH?=
 =?us-ascii?Q?iL0lBMotMQR+WHZH3QFyb+0IiGQVfkR2pfsSgdnp1L9JWFf822SG3yfO5qQp?=
 =?us-ascii?Q?nus3OxZTbE3R1NwhHch2EVi3ngdPt9ftF5y7eYdrPEyrZEwyEVLoNIEpGA4b?=
 =?us-ascii?Q?KMNB50gbFqpbOuXj40YwHF9B5qrJ3NqEYra1qwm4MLOYGoOyGTZrfgx02sJf?=
 =?us-ascii?Q?dzZcPpzZdoPD4OQxSaLLlNgzRFotQ0sb4rfEH1F2WxrelopLLMb3GmoREeDD?=
 =?us-ascii?Q?wosny0j6HfqGXDBQKK/HWaTDlJ57TDnT+StS5lFHNBCXmGRc9sVuBYdcfwEC?=
 =?us-ascii?Q?435FceYFLVRE6qXeyEJyQv+4SHJ7njqKxjqAOMW3RqrMRXyjhlO+xveOuYHf?=
 =?us-ascii?Q?6KRs35V8nDgzm+tOTGh2j3dvedG4v0zZ/MmbGT9eunU0mMmjoSVfT4X40G2a?=
 =?us-ascii?Q?XtpB/tX4jZJmvn/zTAqydtpXNwnYadxmcSCoJSZTUy6GNI6/q6rE8R6qufpa?=
 =?us-ascii?Q?h3yV1qn11/1jVJkXQ3Qw2Gz4NgS0v5QshZFEGE31UgBOYnmRMiuoOPcAzloj?=
 =?us-ascii?Q?/lCLS2/rB+qO8OVlR0tp1i4jOUmTemFMBHumU2rCptVa4bovEt93mlCTWdyI?=
 =?us-ascii?Q?d7BIYcWXEusK6R7z4MKYZPdgz58=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacdace3-7a7f-43f6-fd18-08d9ba5cd2f7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:10:09.0699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaeR0WfeRG6EHtP8fZAjP1xRlDNLAW8sMXkY3iMrC1d2qaDMKFr137xNg2MhhziKO9zaNHtv3ZV6BnQcpZOJUNYVel5c7xSab/VEqpUkPcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080093
X-Proofpoint-GUID: IwNHOFm3I6MrFzdWK1C2QmhUyvxvPMqG
X-Proofpoint-ORIG-GUID: IwNHOFm3I6MrFzdWK1C2QmhUyvxvPMqG
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

This condition checks "len" but it does not check "offset" and that
could result in an out of bounds read if "offset > dev->config_size".
The problem is that since both variables are unsigned the
"dev->config_size - offset" subtraction would result in a very high
unsigned value.

I think these checks might not be necessary because "len" and "offset"
are supposed to already have been validated using the
vhost_vdpa_config_validate() function.  But I do not know the code
perfectly, and I like to be safe.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index c9204c62f339..6693a2c9e4a6 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -655,7 +655,8 @@ static void vduse_vdpa_get_config(struct vdpa_device *vdpa, unsigned int offset,
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 
-	if (len > dev->config_size - offset)
+	if (offset > dev->config_size ||
+	    len > dev->config_size - offset)
 		return;
 
 	memcpy(buf, dev->config + offset, len);
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
