Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F661C43217
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27A13607C7;
	Sun, 21 Nov 2021 17:50:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AATDaypk4Vsz; Sun, 21 Nov 2021 17:50:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A89FE6062E;
	Sun, 21 Nov 2021 17:50:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C026C002E;
	Sun, 21 Nov 2021 17:50:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E250BC003E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF61E40448
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="BDO+YIkv";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="rlg6zS1l"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7C4h5UV55Y6S
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69C7B40461
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALFh0tF000588; 
 Sun, 21 Nov 2021 17:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=O7+T50/SVwTeqnOXkN5gn1hvDlMr7K5IpB/+dgeVgkU=;
 b=BDO+YIkvIjzs1g9TOUktixqaalejz6+WgyJTpOvWfanLlvstATocu8r4inSP86apjZT7
 nE0EVIQJpxsWRJJbGO21hEOyLms+aR8lXMiOXSBDWKzbPzbNgcwi9NdMGa6ED9E5lY6a
 oQxGt9oE6EYcMnRcYYKX1EcBYLQMlS6jA+XR/loavC36H2w+QpzTqDD4OckwF+FM1VkH
 gCT9BpfOvWV7AOadWzf5UAGX1QBX3iV6ojV0fM9sZ6YQipfjKK8+4XGaqhcuLR8UjpGW
 6R89kEQrZYWE9U29jfr17s9iR7h9Z5TO/8E2yJFvUPj86PEQE0iH+E3W4dlLh6oKkq7e 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cermsmgg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkuUH173690;
 Sun, 21 Nov 2021 17:49:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by aserp3020.oracle.com with ESMTP id 3ceru2jhv6-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeCituD8ktm8g1kRjNxJWgZWI34V9Tcy5g+Qnqb4N69LOMh8aD9NLT4xmuq+I5bgF/BXSZHyuhaiReLMLMrhXQUGQYp6oFtUK0aogSbZ+QYE5wdUZFWsTlzMsXZ1xSAFRDURKOLdHVWo1wu46yaSpLGbR9moD6z5m5nTMmJkwyFCfbtjjvxLNOJ+ea4o7X6tFECKAeyOuWgh8279cBFAo9wz/hsWEMZqhxCqdQGoI3v2+4tkjVv7QW54+wL5SCz1UgOTKHkpfVGLQod0TN37WwfWv3GyMOBBHQYL8aS5rnwksyjTdpH6xNv/l7gQDc8tQ76TYCXxbGEm8MuPIhBwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7+T50/SVwTeqnOXkN5gn1hvDlMr7K5IpB/+dgeVgkU=;
 b=MDwo+csAsiLZz7i/HQKNk4CZERGc9A3x3DTnkvd1v0e4zoltnO+Xvk4Pr7m9x3/BixWbJXcfXiPWl8Bjplebc79v+p7gh6BIrkqEvfO7ylydJH/WWDC4WZ6XDfbtvJdo3srIqloea4Bb9jJcOmU/7a9CN77BIZ+7Jn6DgTmmuEXWofIydv/oMtdcqSJ7iJDRCH5SH6oSkDWIYdFplksCRusQ7aTINk4U+xb45GahrdIKBeJZm0b1TMT8nHu1qjaufV5s5UHJjNKq24X4fmfFDg+bALkpqVslv+xBDLgEGG6uH7tAh3jSvt+2xyFRicgSFIL3Y0Zpnn20HW72EObtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7+T50/SVwTeqnOXkN5gn1hvDlMr7K5IpB/+dgeVgkU=;
 b=rlg6zS1lYaZoWdnGq4aTxk7j6XysmXfsWc8OBv3YSTYPyen6qJ52z4+iVt4G9zpOKMoZGdMjThpCoI8dAOtsJhkmfutw4Qugsh/np4/WCL0uxQ8NYt+nt/ijjrx3tdJqa25UBCynjx8uAWdkzZFh1XoRk6j5E+4FW1ryQC+fRp8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:52 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:52 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 10/10] vhost: use kernel_worker to check RLIMITs
Date: Sun, 21 Nov 2021 11:49:30 -0600
Message-Id: <20211121174930.6690-11-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211121174930.6690-1-michael.christie@oracle.com>
References: <20211121174930.6690-1-michael.christie@oracle.com>
X-ClientProxiedBy: CH0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:610:e7::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b276576-b108-45a8-a036-08d9ad1751bd
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB50559C2EC25BA909B6609343F19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4jMH9bZdiHn+BgTuZIalPasYjgkPmb5azUj0+GbuIxbLlkcVGz/x665r13ZLBMdrZIVX1uxAlhRsHMCMAiHtcAPqwk8dPWKuQgvko9KhGsnqzxRogNeS+UUKmGdjT2ftLXLgGcqLK+ja8o/hJtVBbiJJtcS5j4Dv3rEvtyZkRISxiU9iy68q5hqReH/quzh3z9xchN6XncvxELbRgJLcOMyO0SDgMSR9iBhgcFXqL65WEfJl4fCDsMbBtsxR+MQRcWMiJ7k6YXx589oQZVrAQWuzn2wYHphnQkPnBsj0ko5K4HisJwoQPF6hTCP/NoU/HJepYonRETjTa1JhsUClMQSBoc8j1ERTmFQdrLrM3ffYGcvdAg7ZRwb40DbzZVsWoni31ZMK/UPQpgmo31LZW/w7KZUGY9l0M3vVaALdZCpHEFNSlsaUbmOfS5Q11ly+BfrlUpQH3b0Cu61YSIoFfkIgX7/PeSr+9w7y8EHgWGZmN3yDeZ8ypEOlH2/eu3lHXLHFgZuqLGWtQ3FSrMEAPbIJLt9BeyFtGV3CQR1gjpwQtaYt6nnstyWtr80QE+aDIu/Uit06l16c8EqgQK6onfZJJ0aim382Fy03UxNqWAMvwmpREhvNANnBzd4kr7pM3dyyaqZ3V6ZWtyfCdFR1u+CPj6Yw6Qbkyj744jzz3gQovpkXUnNk5Q8cGmhq+jsnIzkPu0/T+nuzuk4GAAKYuPsk6QIGxoUh6h0DgoStr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(6666004)(6506007)(7416002)(66556008)(4326008)(2906002)(316002)(86362001)(921005)(54906003)(508600001)(38100700002)(6486002)(83380400001)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qADtCSov4K1tIGyr2/JLggQ1lL0RTUyu/tpLCgqMXakrq/TFkfMQ699982IA?=
 =?us-ascii?Q?1M6wLR58TjBgBBmAw4mPL4AT5byismY4+MZCrVKZwXHeA+V5VyJWo0Fi/MVz?=
 =?us-ascii?Q?OuXEWh30wpYJKtOT0jy4VZHYaistBGFShOpd24K4uqvdWyuowVQh/UdDSjcR?=
 =?us-ascii?Q?uTDpLK8y0N6tOTm+WgMrOsO77LaLrQs9P66ewUnJdUUHk0kQq3byCo5+phXT?=
 =?us-ascii?Q?a4MFwmTx/eplFMxTf5sPIQ7pMbHoZi+r6Bok1pYEeYH1Dzj7CWj7j36rMmag?=
 =?us-ascii?Q?gtwjUv++cTZRnBnqI1rtvZolBZ38EARoQdABzf4+bd63X6lc8H6c7XD4SE9c?=
 =?us-ascii?Q?PJuilmpH0kfxWw57VWBj0SBity3W0E0z3FBKYmrVtkRBVLFI2v57AX3z0Qq9?=
 =?us-ascii?Q?Rk3dpkTjQky+5PS50TgooFIPdhpAnnUXkgJj58l0riqJFab4wgDXVnfHfWf2?=
 =?us-ascii?Q?4FWhnoWu02MzajZzh818TYbhpUiAjqi6xhcWoPXRb6JFjBY7WdayDJkkqvja?=
 =?us-ascii?Q?Swasu5Fo/y1TMaiiRnHV4Vk4AMxwWddBZj2bTP7aI4skbejJ/EdyK+lJPuTF?=
 =?us-ascii?Q?q15Adv3ox42FkLbeuza0wdpt8ZmN9YbcLPkGC7oF4+dLtj8yaC3gj1WErAch?=
 =?us-ascii?Q?lWxrUtcO6+bGWx287SdauhRerlYXPHe4iyo1yZPGIV6Ux4VydLChMrYDkwtE?=
 =?us-ascii?Q?JYo+3aEAniZ21TmCFzN9jzt2mkrz03hKIl9ILoZs3vExBsfcPBkj3+uv6Hth?=
 =?us-ascii?Q?n9WMpdgCdClprI8EbIocNdfCE1XAJriFpl8INtZE/qaJQm2ixEkZDrOL6bFH?=
 =?us-ascii?Q?rOTqPmAACcP1BUGTPe+aE15Yj/px93/16MhnuCWs3XPx4ecgkOCdDN930fhZ?=
 =?us-ascii?Q?fcnVOeZqa8Ndp5FEQtl127faFKZbCSuH93/hOA2fOVpvby/FaEFAWmq+SVZj?=
 =?us-ascii?Q?gt8Yvmz3R/+aDhi7S5zIenHvBrnNOOf0rKv3scSQ5PdaslZZpft2mtEy97BS?=
 =?us-ascii?Q?dMfhiChNva/g+ichIalb2+INTKwh5wAbWT+PtyaOJSDVMqoRt7SeKRpNGqqE?=
 =?us-ascii?Q?iRgX47xB8AXCuVZ5vjA2f2Mc7C39OA+/45+zyHgNE7UXYJeGuly/1teuFcNn?=
 =?us-ascii?Q?9e0wwUS5Fh1RQkTH+nOKbe23NYVsfGCYb5L4MxcHxnQoQxE6fpdDBcqBNQck?=
 =?us-ascii?Q?FqkgTNL4IFOan382+jEr75o4aAmjWqdjmkZivMkKUy8hVlW+7lYFUOhl5Ntu?=
 =?us-ascii?Q?jX0FP+G9ok8XPCqgi5//jqVAaRi7wWjhGIwRPP1P/jtDX8/usEDDN6gFx0YP?=
 =?us-ascii?Q?wRKvHjXnoUWwgInoonez8NPPk0p4AC47k0ntnbLYmOOwnCW+Sg0/KVCzwYIj?=
 =?us-ascii?Q?Vx+JaMvlkJKt01wH3PDM7kMRnI/9I5mmYuOixaZz5P0/5Hj60x2/LtCuiufd?=
 =?us-ascii?Q?9O0n9VrSC6sMpG9FhrR6Ins/z0kPYPboelWRJrgCZFoI37TGKzisCc1sH1V8?=
 =?us-ascii?Q?WjuK38XoPctBANCqGGyigrkEQk1sAatjWxFxRE7UnHpilae8I8EuiDoUQ1r+?=
 =?us-ascii?Q?4e90Vh+dcOtvX/CbXz8hLH2hIN8q10A1gSER2I+9vrST0bPWhj6Oto/z3hxJ?=
 =?us-ascii?Q?tqi4A7FRUNuxUVM4gkRR0J5qaySjtPpQ+Ik7e/zeZ2MP7Ar8bPw6fFKbOLkD?=
 =?us-ascii?Q?2Flzjw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b276576-b108-45a8-a036-08d9ad1751bd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:51.8719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pHsqdj5v4VjY/blO3u8V2/R8Vb5UTHMq1HQeJ9K2Xyjqpbx0ysTEbehYwA2E5ROKidV2qUBGGWJcS6ACfL6Hlnpso3F/yWIRS96Yhipx8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-GUID: Tw-dUKMii5ZMI-xEwld6BWBTXEU-RZug
X-Proofpoint-ORIG-GUID: Tw-dUKMii5ZMI-xEwld6BWBTXEU-RZug
Cc: Christoph Hellwig <hch@lst.de>
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

For vhost workers we use the kthread API which inherit's its values from
and checks against the kthreadd thread. This results in the wrong RLIMITs
being checked. This patch has us use the kernel_copy_process function
which will inherit its values/checks from the thread that owns the device.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
 drivers/vhost/vhost.c | 65 +++++++++++++++----------------------------
 drivers/vhost/vhost.h |  7 ++++-
 2 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c9a1f706989c..9aa04fcdf210 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
-#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
@@ -344,17 +343,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 static int vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
-	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
-	kthread_use_mm(dev->mm);
-
 	for (;;) {
 		/* mb paired w/ kthread_stop */
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (kthread_should_stop()) {
+		if (test_bit(VHOST_WORKER_FLAG_STOP, &worker->flags)) {
 			__set_current_state(TASK_RUNNING);
 			break;
 		}
@@ -376,8 +372,9 @@ static int vhost_worker(void *data)
 				schedule();
 		}
 	}
-	kthread_unuse_mm(dev->mm);
-	return 0;
+
+	complete(worker->exit_done);
+	do_exit(0);
 }
 
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
@@ -517,31 +514,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
 
-struct vhost_attach_cgroups_struct {
-	struct vhost_work work;
-	struct task_struct *owner;
-	int ret;
-};
-
-static void vhost_attach_cgroups_work(struct vhost_work *work)
-{
-	struct vhost_attach_cgroups_struct *s;
-
-	s = container_of(work, struct vhost_attach_cgroups_struct, work);
-	s->ret = cgroup_attach_task_all(s->owner, current);
-}
-
-static int vhost_attach_cgroups(struct vhost_dev *dev)
-{
-	struct vhost_attach_cgroups_struct attach;
-
-	attach.owner = current;
-	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
-	vhost_work_queue(dev, &attach.work);
-	vhost_work_dev_flush(dev);
-	return attach.ret;
-}
-
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
@@ -579,6 +551,16 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_stop(struct vhost_worker *worker)
+{
+	DECLARE_COMPLETION_ONSTACK(exit_done);
+
+	worker->exit_done = &exit_done;
+	set_bit(VHOST_WORKER_FLAG_STOP, &worker->flags);
+	wake_up_process(worker->task);
+	wait_for_completion(worker->exit_done);
+}
+
 static void vhost_worker_free(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker = dev->worker;
@@ -588,7 +570,7 @@ static void vhost_worker_free(struct vhost_dev *dev)
 
 	dev->worker = NULL;
 	WARN_ON(!llist_empty(&worker->work_list));
-	kthread_stop(worker->task);
+	vhost_worker_stop(worker);
 	kfree(worker);
 }
 
@@ -603,27 +585,24 @@ static int vhost_worker_create(struct vhost_dev *dev)
 		return -ENOMEM;
 
 	dev->worker = worker;
-	worker->dev = dev;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
 
-	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	/*
+	 * vhost used to use the kthread API which ignores all signals by
+	 * default and the drivers expect this behavior.
+	 */
+	task = kernel_worker(vhost_worker, worker, NUMA_NO_NODE, CLONE_FS,
+			     KERN_WORKER_NO_FILES | KERN_WORKER_SIG_IGN);
 	if (IS_ERR(task)) {
 		ret = PTR_ERR(task);
 		goto free_worker;
 	}
 
 	worker->task = task;
-	wake_up_process(task); /* avoid contributing to loadavg */
-
-	ret = vhost_attach_cgroups(dev);
-	if (ret)
-		goto stop_worker;
-
+	kernel_worker_start(task, "vhost-%d", current->pid);
 	return 0;
 
-stop_worker:
-	kthread_stop(worker->task);
 free_worker:
 	kfree(worker);
 	dev->worker = NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 102ce25e4e13..09748694cb66 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,11 +25,16 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+enum {
+	VHOST_WORKER_FLAG_STOP,
+};
+
 struct vhost_worker {
 	struct task_struct	*task;
+	struct completion	*exit_done;
 	struct llist_head	work_list;
-	struct vhost_dev	*dev;
 	u64			kcov_handle;
+	unsigned long		flags;
 };
 
 /* Poll a file (eventfd or socket) */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
