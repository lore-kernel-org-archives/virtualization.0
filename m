Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F548C433FE
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 06:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1ACA415FE;
	Thu, 13 Jan 2022 06:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vdV5EpRA8DAh; Thu, 13 Jan 2022 06:05:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4EBE04162A;
	Thu, 13 Jan 2022 06:05:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0DA1C006F;
	Thu, 13 Jan 2022 06:05:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B182C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3635140924
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="luBmSkKZ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="eHuH7sN0"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dIn_XQHED4PM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 130794090C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:57 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D14j5l009474; 
 Thu, 13 Jan 2022 06:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=c34wryxxUc69Hboj74OKY/JPaKw92EpIpNGE/dS/MTY=;
 b=luBmSkKZ25CZPo0uM87xld8PofxfOJnKQNZ/QK+erfIIIsoKK/LmJFqHZvgexRsGUpqb
 ynq9vMB0m9f++lrXtZVJYwXJ7WTUXe1DHjYLe1JWila8HRYKECFeMe6zQd4wEF/7Mo2f
 z9hjpHob+jGJ/RZk15+5+cPAeo8pHWa5jZk0O0a2qBt4GSirsjybpVMKw8PbjU4u3EWg
 BgBokEAGEvuUUeEypDcLPhhpaCivETFsOxW/IRBZJQORcaBm4SsbgA2OC6WF3vEmYRUv
 ZN3XCd8apfh81eOLZUZZzjh/K6utGrT0JV7cUVCP/rX1oqKCLJTyQ/FLFDFelbxJAAHm eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx86q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:04:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D5tiXm168433;
 Thu, 13 Jan 2022 06:04:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3020.oracle.com with ESMTP id 3df42qxdw7-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmQiGXBibAcjejx7fev4HFNg4Y9SneDQRace78E70DghTYchYQe3tze9vpI+hkrIU4ehTrjSMRELTIIPp/+bEF96aMjHgyp4ancmJDJjMWES+STL0hOvr22E9RhU8M4yPmIDNrxCo4WmBJoQEdS1QkNbP0+Ysh0NLzB72oq2BsD3CT26zq9VHO2TP/UsE/1g9IsVyADuJ9lNfGOFshlCYVvw52rW2IXpZJHUI73mf86tqzsTn/z3k+kOpblGMr50dEzMABcKtZImLZAzQbsRH5j50Ri/qYt7ieGGaDBAEbdcX4TjPeLnyp5H69t4848ruCkrcDw271qCqMpviKYfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c34wryxxUc69Hboj74OKY/JPaKw92EpIpNGE/dS/MTY=;
 b=PDqbBL+lSHlDRV9F34trC85O0JZ22CakNSt88RU7dsMSr31f6WbZjY+u2dPDR/Ty0o0S8j8gWPYyWqb47PBw5juQgja9Y+zjOo2MfHmd0OQSmmMeqLs9RsZBLBYZjRHwD5duqR0+hYBx9CAwQcVqTRbgx0kFG4xg9Xf3IirE/ayqrt17h9q9CNsCfRAZJwSpVZO1utHIBt0EAMt/OkJLVySXkwkd3vS5tecxE3++YbsVNkxnElJkqPtjKThEdrwDrtdz1hmJA+picaP8R8YTrhlvOTDJNMa6G7h4d1+bcRAFu1+psk/cD/6PzWjnzh41dP3xR3QvDNtBvW0EGNV27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c34wryxxUc69Hboj74OKY/JPaKw92EpIpNGE/dS/MTY=;
 b=eHuH7sN0BT3aIPHj79i4yzp0NckeJQCVPktVsRr3xmGqpjjNkeHWgJCrB+SWqUS5YzCCHzfvv4GXRGfcj+GTsSqXUmgjVmZ+CeqlVASDfPePi32ba+N9Fkw9XNpX5VzaQW5RkKpp/LPaL/sR3Rf2xOGfBbUOXW5/K3TrihqqfZQ=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5599.namprd10.prod.outlook.com (2603:10b6:a03:3dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 06:04:52 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 06:04:52 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: elic@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 1/3] vdpa: factor out vdpa_set_features_unlocked for vdpa
 internal use
Date: Thu, 13 Jan 2022 00:10:49 -0500
Message-Id: <1642050651-16197-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
X-ClientProxiedBy: SA0PR11CA0188.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bcb4356-5aa1-427e-733c-08d9d65a9d36
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5599:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB559909C31890E248FDBFF451B1539@SJ0PR10MB5599.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFNi+Du8S5tO87qDYvqosuX+E/dMWxuwUc51HbT7+t9nI285N8+AY5/+sIWOKv6g1ILwLoID5Z1Md+jd03yNDVKzcqgeFE9+jbXU4RUIP7BkazjQi037D3boEF4l3P4MZH1AdbfaM90/P4ylKMrreOYoWu4VXTycB3nNIrZdK2oPBcwKHicHjPiJdE43O5O+65AU2lbntpNQmZM2R2l3iOKEa9+/DiJNlgsbmEQvGqjfP/WvJum89jyglDjMnoBfrtp7JQVzlzd4stYYyp3qeJHJo8NnAbKYca888eQoQWy/wvyQRe1xnFx1dWpakha75rvQArILQLG+fa0MRoEkH5h3xkEmNZogmK0jABCjy9YTUi8V4cmOBcHuwHInk2HQvX3Sxh7yFn5Kr8U2+ngsrS+ct7MUkp4P+s/SkFzoD22f/xduBejHau+AaEPthBa18UADzHwb/CxDjJ1h5QKNGCFtg/P7Iu6T1nsPuMO2nxFiiz4PWBIoeDTO7hazXRpko1Ke5dYyH3sI4sgqgN5ZsHlMh8VEbL0cluXhW8hw2OXL2aYWeym3MIdqvoj2JAUXt9Of3coNd1XcdpoYnIBLaMW9ZYNEraKe99mwdU1eGGOi3wwPW+CXDGL3unJqGdRobpAiZ2Jsc4bjRlG2CESy19oUX+CrX+9/AyPrB6ujz1ZE9ziVXRIpeaANTEDPNwCrdrK/rWgo18XL8ZxZzjPPcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(83380400001)(36756003)(52116002)(26005)(6506007)(38100700002)(8936002)(8676002)(6486002)(2616005)(107886003)(38350700002)(66946007)(508600001)(6666004)(66556008)(2906002)(66476007)(6512007)(4326008)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+RSU7T1+E3so8MJxd1zJQ9AJ05znmyra7hKTqFQnXzq6tpzTUcQremkv97jl?=
 =?us-ascii?Q?m6vFHPEb5ZrbQZnvC0nGc0KQYfayKbDHp+94YRttdKoDzdJ3JygkErLxIyvk?=
 =?us-ascii?Q?hDSbn/VcykMnbEO16YIK1d0t2t20gMItOLNZyW9aoYHaYBmw04swdvnmMe//?=
 =?us-ascii?Q?uR8YdwAQgUJPE/BiDnpN5PnrIJEZdr3N07xFOJYtJP+xpOJ7SAd+sOSVsf1t?=
 =?us-ascii?Q?bznxgMYoDUTAgadJ2w0KaFhtSh1G8mM9lbsPrRzAggNBZUgsXSr6ZVRyz/+v?=
 =?us-ascii?Q?dGT8dEeYG4jbE+PhNR4GpMVsVMiQMSuCmolJVFtHmnsvYyCrdhPc2c+wjwXM?=
 =?us-ascii?Q?rSTxEJcEwxCGVnhoAWS5jYC5JezxHvqaEnniDnv4UbgSTq9HnhbdjLNAk0d/?=
 =?us-ascii?Q?x5g0UmoRc2BkuZ3iDvw0EHI2vy4m624XUqKk2V7dEPfEX9ZRdH7082ZJqxDq?=
 =?us-ascii?Q?jIhGRuzY8OZXUacb1iv1pLIJOucV9cIjVUyt6Oq8v/6V4vejLkcC7e76omAS?=
 =?us-ascii?Q?ueLslTxpNgvW7/7scRHH79hwVxBwLPQ5DVsg1AzdDZiNAflrkkrVPOWFaJW0?=
 =?us-ascii?Q?oKMuipwN2CPZdDnQJVKBp2zsJJ/hfsw1oB10M7xJaCrHtPcE61gkGatKaw7t?=
 =?us-ascii?Q?etVlOwDnFEQOQTHd4MyKuUeXUdAfAjOcYorbhXllIXJiiAGZN4VRdWEcIe1S?=
 =?us-ascii?Q?kFuJAExuGe+2quDxNniK7oQasnGyQtu5vBiDjbih+a+idyTtvrVD942DNo+g?=
 =?us-ascii?Q?zlVGPNyOwygtMjixrIAt7FN5rifxz/e3KmcmflmYIgWAUfovYsAdk90q0rmi?=
 =?us-ascii?Q?pxyVWmxRSRgeYCUI26OEEUhegtNaJyufpqmO/wExnGngHJJsWragTxlfNIqe?=
 =?us-ascii?Q?WwWuVmhH5sZ1iLtnfua1OEJDMs/b4Tl+x2Yw1tLZl1A9DX/qA6QbOZhfUwao?=
 =?us-ascii?Q?p3KofW58sAgt/8m0bPOWsLObNFfvZdtWWbqd83hEfDD1k54IWd6WW0achGhW?=
 =?us-ascii?Q?7Yq1qjFuhYLTh+APhK0HA5TLTMHh09PTACyj4QI6+9XniKMdH97iffgEHmnl?=
 =?us-ascii?Q?rr8/Dvsp7aoUUhS+V5dPfbJo8MmtQQuLya74kVczdnSUexwyegG5yN+eznNZ?=
 =?us-ascii?Q?yFGDjfjUbRuinJIWLNjBbAF+9YkIe9hnRm8ik7iOBNc3Zj1Qa3n4+Z6aaLXa?=
 =?us-ascii?Q?9DQ0FZXnjN7DPg0g8b6hPvgEpy51lRcSu/4u3TYttrLud65n8SDdNasJrUvr?=
 =?us-ascii?Q?FrIYwf+p5BCNvwiLQ7jcif0Gc42zdSyUdanHbnS2qpU714IO7Iqj1yyeLwsf?=
 =?us-ascii?Q?Xudh4NAZND83qv3+r+SaQeaEY0YiK/xPglTeYzA9nKIm2lTl7A1Qe0koAi6k?=
 =?us-ascii?Q?dvdKxlL3nOrVseE9m94IoCbwJwKucYHxFfvevvw9iowr6Dv6xNGps2GOFaqv?=
 =?us-ascii?Q?JUwcSz5ixvGbLyPwiuW6RFHW/m97uIozvtcKvk9sb4OSwL+hznePPjxpnKaF?=
 =?us-ascii?Q?qOkoEftv6f1ZNHhMJGZ9cy+9XUD46HhAgyMEro0GVYsOfLcanKNMcD51X9Ql?=
 =?us-ascii?Q?PKomZSFwqJBgoKR3Zc9mvgwpHEPKGLnzsn5kNliQPZcg5NEThdNkAp6qkQn/?=
 =?us-ascii?Q?yj0uoXNs6N95lGsm9qpuXxc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcb4356-5aa1-427e-733c-08d9d65a9d36
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 06:04:52.4346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rhI79Li14ZDBKMZopMhSjQOdo4FDRWXi8hXvV/tyKu2Zmt5OvRdS0lVBskMUX7yTSgJ12wvfmGUJXzfEwfSeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5599
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130031
X-Proofpoint-GUID: -8keciQcj71QPD7Wyp6_bqH9uY_cAofN
X-Proofpoint-ORIG-GUID: -8keciQcj71QPD7Wyp6_bqH9uY_cAofN
Cc: lvivier@redhat.com, eperezma@redhat.com, si-wei.liu@oracle.com
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

No functional change introduced. vdpa bus driver such as virtio_vdpa
or vhost_vdpa is not supposed to take care of the locking for core
by its own. The locked API vdpa_set_features should suffice the
bus driver's need.

Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
---
 drivers/vdpa/vdpa.c          |  2 +-
 drivers/vhost/vdpa.c         |  2 +-
 drivers/virtio/virtio_vdpa.c |  2 +-
 include/linux/vdpa.h         | 18 ++++++++++++------
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9846c9d..1ea5254 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -393,7 +393,7 @@ static void vdpa_get_config_unlocked(struct vdpa_device *vdev,
 	 * If it does happen we assume a legacy guest.
 	 */
 	if (!vdev->features_valid)
-		vdpa_set_features(vdev, 0, true);
+		vdpa_set_features_unlocked(vdev, 0);
 	ops->get_config(vdev, offset, buf, len);
 }
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 8515398..ec5249e 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -286,7 +286,7 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
 	if (copy_from_user(&features, featurep, sizeof(features)))
 		return -EFAULT;
 
-	if (vdpa_set_features(vdpa, features, false))
+	if (vdpa_set_features(vdpa, features))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 7767a7f..7650455 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -317,7 +317,7 @@ static int virtio_vdpa_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
-	return vdpa_set_features(vdpa, vdev->features, false);
+	return vdpa_set_features(vdpa, vdev->features);
 }
 
 static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 2de442e..721089b 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -401,18 +401,24 @@ static inline int vdpa_reset(struct vdpa_device *vdev)
 	return ret;
 }
 
-static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features, bool locked)
+static inline int vdpa_set_features_unlocked(struct vdpa_device *vdev, u64 features)
 {
 	const struct vdpa_config_ops *ops = vdev->config;
 	int ret;
 
-	if (!locked)
-		mutex_lock(&vdev->cf_mutex);
-
 	vdev->features_valid = true;
 	ret = ops->set_driver_features(vdev, features);
-	if (!locked)
-		mutex_unlock(&vdev->cf_mutex);
+
+	return ret;
+}
+
+static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
+{
+	int ret;
+
+	mutex_lock(&vdev->cf_mutex);
+	ret = vdpa_set_features_unlocked(vdev, features);
+	mutex_unlock(&vdev->cf_mutex);
 
 	return ret;
 }
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
