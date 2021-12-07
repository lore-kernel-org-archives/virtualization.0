Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDFDC433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 02:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A781560E61;
	Tue,  7 Dec 2021 02:45:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UhnT3toW89bL; Tue,  7 Dec 2021 02:45:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2907960E30;
	Tue,  7 Dec 2021 02:45:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FE72C001E;
	Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18A82C0072
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED33940153
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="gBrZVwlM";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="F5618Rjx"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ifpjw7i6H2pJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06ED3400BA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:24 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5TKx004022; 
 Tue, 7 Dec 2021 02:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZJXzKhwiyZNUOcykfe9cNtl7Tg1eLR2r0khIgDFRjaI=;
 b=gBrZVwlMS7ITRcp4Dx7PcJa9Tk9rOyHqeGOgEypZ4OA2YF3dJPs2WNDLAR1L9S+xuma8
 lf99pplsiUHzL2Ibyih4atP+G8bqgQljqzQuVqIEQFLEGeopEzKgUuc41tU15HdY5Xrj
 fc++JEZQx6mgjBSVYH2U022wIWN7b3dU2JiNqPq/LRC9dTjahmlcUfUrhP8pOvhXqcPK
 SmtT6PNhaI0lPSOQ9tkH5PoHC+bXGq6k4eqJASchWF9y5jQKqoxCbJwbTbpRqngkfFI8
 oe7Rncu8+VcpB+brtHAUGmZjClbXcxs86TAW5uI8jUCUUS2VSdi+edr4CgKVn8UlZU9k GA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcc7px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B72bJem124653;
 Tue, 7 Dec 2021 02:45:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by aserp3030.oracle.com with ESMTP id 3csc4snh1a-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViZgFI0KH/we+MNFLCg+JRr4SRceuH3O2LPKrrYt3lbdIv1K7s4jkzWNClDLt0cpNb3DTvrEJREA2czgwKn9XrGjQGFk+g/xp/UYVQdXP3ca66Wn27zhyTxzXDiGtUfAkGOGlY5ZSf5iJ1azMtuj/hIUB58MtQHpDsRd6G1apvcJ5qsNxhpnFxSnRjw7GnR4uubUxAhT2anFtcsVtuMqXeI86YjGp3KQce5IAQM66gOaqt9CIzBkC9IfPJrNdC9Ij0N3hsly0VdESre8v7+7i7O0SqKI1j+ihRXeoE6GmTI3ibIJXZ9R+CbWCqb9SZjxspkkmauWAsU3XWzAqrS+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJXzKhwiyZNUOcykfe9cNtl7Tg1eLR2r0khIgDFRjaI=;
 b=eAjdltiYxm7Ezo2RP7B1A4met9323FTlkqjoG1uFuhrOd345XYkKuZ5k8W89pxHMr+YQeuLJBBux/ksqRNdz3cli+ckHqd9eZb+kTUf8qh3z59EFGKe+mbSP4tvpzjOxJ8Wd3WJVi0hzgJVrupl5OXk76PxdS+YeuIDn/1mFa1WLg9tv4ASCPFcWGfwmzFB8Uk9iwb8qjbgZyvlDblCyagSkBDr0HfIXEj2QH1KYX6ioS4PAmfM/3kvw4/sWx36QbAOPCcPMXTgIgEaWfJTWk+OaSYjb9xcx17gw8rTrZg5XeOqh8Cq9SydbziF6fskdyNJc5/NIE+WwAAV/r6pbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJXzKhwiyZNUOcykfe9cNtl7Tg1eLR2r0khIgDFRjaI=;
 b=F5618RjxRfzafjedVJFVwDRovstlKgfvFJFYKVeXqdhxPHw8hKlrQT67sIXCBckvrrLKhykWob2ve4XxoGbFexzOn4phzrOWfaFWe6wKOaTLnY4G3bWJGSC/irbOlFwu34KVumx+81uadLpwAoMb7rnl1vGCozTCMWfjKdTxamU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 02:45:19 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:45:19 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH 2/7] vhost: flush dev once during vhost_dev_stop
Date: Mon,  6 Dec 2021 20:45:05 -0600
Message-Id: <20211207024510.23292-3-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: ecd1d3f6-2830-49f1-aa60-08d9b92b9b7f
X-MS-TrafficTypeDiagnostic: DM6PR10MB4347:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4347A153EAFF8533798C2F47F16E9@DM6PR10MB4347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bGe+CFUom3GYoCfPxwP+/Pfw03yahO0HYV88XG2HK+QeATYf7V0kJZvmwfgmK5EcZPbe5/Etz1trQTPhAaRyZys1Bshygh86Bqa4O5sbylvQf9TlPfokJfv4f93CG5DxnT8J+9x8ER+r1W5vwTj/DtiBvQlEbsffJM3eAAxDJLQUqz2cOX3mqc38H8tsi5RGpWqlq8r98rM/5rZPN1TjUXfw6aeXT/nZ7MRbpjDibPPgUDQSc16D3RKOIF/K1gRflGs4G7ul6SK8SS3EgZ7H+OhGB0Ul4Af3vvPQ7proQUnb1uaes+rYbyDZnpvcqQXgdNpiEQGD4Zz+k67FESFUNw/FvV97n+qH4Ws70KUwecAK5YpAWlj7vlH/y5rDpiDRFmXSceNhmNlvUPlOVEAd7LzA2Yec7Ih7qb8GHLUtt6LNEeFo9xiAn3FXIj72er/IectIxpnLNbOiQ0SyaBMGccuKdw9ULh9Eru68opS+tl27/fJlXjweSkGVowD+MA/XEGnv5+u9c6P1rUd8XC6SZ0PyxQjMcTSF69icuZqVs7ujFa3CxBajmnN3wHH0I26YXMboTbd7Hnj9mal2sQf4XnXlg8O5o3bnaWSbmUw1Hy7e31z05JDWkU9mhbgmVYHHaftBsUlxLikMzE3QjKlq4vn/IxTd9vluLCSrQq254m9+MPTz7ionXlHaDY1AbcJHJAMAk4ozomzLURKYsT80w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(316002)(36756003)(8936002)(38350700002)(38100700002)(26005)(8676002)(186003)(6666004)(66476007)(66556008)(66946007)(83380400001)(4326008)(1076003)(2616005)(6486002)(956004)(4744005)(52116002)(107886003)(5660300002)(6512007)(86362001)(508600001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NUKWglkX+YWtAazyzx8FrJrEm3s9wvwxe3uUdtGB+IX+taG54V7JcR0YD4yK?=
 =?us-ascii?Q?Rfp1mdwVLuu2Blka2dJqNSkpISfDZkPSwPwuqTAj+4hpiYpLEIS2TZdZ3zBc?=
 =?us-ascii?Q?fEV2FABbN547eu0e2WxCElsRtiakdmp2J5v6wcDQlGwK7N8iMVeEiIyB+Gmx?=
 =?us-ascii?Q?mf+Rjzm0Xr9sFMh8xbUYY26K4wHFUynS4/0xoabbiRCrwK523S3kRKzQOC3S?=
 =?us-ascii?Q?veKUJcb8FzjjVl3fq4CHP4sYpHtI9FdIhJliEcXcg7tpsAs4Ubuz9n0TDySO?=
 =?us-ascii?Q?teCoeCmdJtGVKYfFQiXtAwRrwuXetcARISBQKfXF6o5TxplmQlvs8nfEE9w6?=
 =?us-ascii?Q?1UUNbYW4JV6v2uyUv5NYhAwcEVBvEZu0pGeYiUX3oL/etDblaOT97pCK3OWm?=
 =?us-ascii?Q?MRSieJVLCmUe0Z2h15yv9140A0Tw0P+e3wILATQ1MBKuNsGNchEIxxa7yKW6?=
 =?us-ascii?Q?RIW24+B76oq12iDp3cqHQmap2vPZz820V3UC3aHoc6AswqwUzibrRPrb8Ep2?=
 =?us-ascii?Q?EBST8zxj7zddMHL+/jxUR3Bbm5d3aVtRQDBULX6BwMcyxm5fsTRkK7jUWWOG?=
 =?us-ascii?Q?NYcQYxSWGhmQbvClnvJ6XfgfKbozHgBI58zPhDapZ5i64fZeEUp39RAaJSDN?=
 =?us-ascii?Q?dUl9WFiK3xmOEhtWnhoKs/4BNclbLkjCB6PFH7JitH338FbMsWLIleFKT6O0?=
 =?us-ascii?Q?NY7nxK58jeUotJil8DGksgZ0TEsZOYR9El+/eK3yFRPoxzDJbOCdukuyHkJW?=
 =?us-ascii?Q?yK0s7dgSDwuJN0YyhiovcWcqBvrUtdpCFs0S09maLtNTf4Vf7w8BMgJQBW/q?=
 =?us-ascii?Q?4vYb/lxfaMxyn9smOu1+Uka/V1b5rYDDcSQ6fWrHHF48Msfiyyrf/vjZjfHi?=
 =?us-ascii?Q?yVhqfC+kQ7nURZwX2D5C3pzwW8FlonuQrLPijCgYP7Z8oqPJyXbygb7zPdR8?=
 =?us-ascii?Q?Oh1zSFDWYdTzy1pw3vtvy2mz8vcvrQULwN3MXDUrV3Ihu0H5Uc/ofXMZdjGz?=
 =?us-ascii?Q?tPHkb4uAMmuDUyLe43K/2sg38pGn5+/QYQXMIYiuR3qf/VLBmN/G1lJkFYW1?=
 =?us-ascii?Q?EOWfRf0fl9grISeirUCYIeqA8iTh+wzfuhsD/RIvvcdTTexWGx++Q+Y4sFE5?=
 =?us-ascii?Q?k6FkEvwxiH7RxecFNLiJ1lW8S3wE8VqV7uGq00nAN/BTz2HLwBSsnCNnTszZ?=
 =?us-ascii?Q?7S55P4y9yMGNSZxPJ+RWAHZ+nUb0QjDxrBrM8Yb/eQXJWGnSbYc6vPwho2EO?=
 =?us-ascii?Q?aeQuikzSVvVsh5tNtsrx3J7iVDfybnl1aVg6quVTs3pedfXGgNLE9O2v9lpS?=
 =?us-ascii?Q?ZZalSCqNIvP3nOf+31cFxmwW9LxrlWtKwvJNEa4Yb04gr1nvIDqdy4Mcrl5Y?=
 =?us-ascii?Q?uZw8IiTshrlfLUPpDccYtncoxQwcVtJFEBna+20LsKVuKOlhXej9bl9BfqSx?=
 =?us-ascii?Q?c9j7KTEAxTJLomsUuowtzMe7a2IUhulom/GBNLnAEmlzZb4rYzfKLoz6YnPk?=
 =?us-ascii?Q?90Lc/lxRiYEw0wHPxhzTuyMvVt/1CtGcP4txhl1ZDOkuGPK1fkD0NmrjIMGU?=
 =?us-ascii?Q?P1I34uVCL4MAicSgH6BvEM32ZLpo7FPJUWpUtmkD9VrisIsc5wivKcfKYzWV?=
 =?us-ascii?Q?KKzjPBMKd8i94yF9RCWVfzearoOYvmwR5JzogmJoCjL9p6jgYb7fYWeANI3Z?=
 =?us-ascii?Q?kkULkg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd1d3f6-2830-49f1-aa60-08d9b92b9b7f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:45:19.5012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXyvcFSrCuTGXBN+Uf3VaTz+E0y6vGFVlDL7t9INJ45jwtkmoKkDhOIwNyVuCB7KeUj39qNiorjiYd4BZ0/rgxDDmeDyvKZB6zqtknwZlN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070015
X-Proofpoint-ORIG-GUID: UHuJ6P7ceaYCKDCBre74bZj9tMQzPW_o
X-Proofpoint-GUID: UHuJ6P7ceaYCKDCBre74bZj9tMQzPW_o
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
---
 drivers/vhost/vhost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 7346fa519eb6..17e5956e7424 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -667,11 +667,11 @@ void vhost_dev_stop(struct vhost_dev *dev)
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
