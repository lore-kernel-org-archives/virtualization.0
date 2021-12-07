Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69A3C433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 02:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 69C1440153;
	Tue,  7 Dec 2021 02:45:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOc4Mm22KCzJ; Tue,  7 Dec 2021 02:45:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E759C4039D;
	Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C48CC0078;
	Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09730C0071
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC33641C72
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="DppiRJG0";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="fDhuJbe2"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ejjtn4d0QArd
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3570541C6C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5Hlb012536; 
 Tue, 7 Dec 2021 02:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=NB9XJbLpKqnG7w7C+qCRfmBlaYxb97HbXc6k9N8T6JM=;
 b=DppiRJG0pAthO66IdyPkelL9+pwtBBc3upd67uRcVfCQHpYHksqCYa2pmf3PC1qb6wdi
 AmRTn+wfExx66UY6PqJFM2H6GtV6d2oGaDHmsjs7vRkEtpdSu3vwqbISYJgm58cmV03x
 n6BE14n65ml6QSyH1G05HSl4eUPe6MjojXEmNxxRjG+t6KKRREv67kyW7IkX8M0zklns
 sfk6LLKuG6NM4H0JhQZpw36YuTGllz5eDgG9pYZmHMm5PAfWbo/zdOOGl4OkgNAY3sD3
 5Sgtr4N9w7oG205l01kIAuvydL3Umepx2wCDBEZBPXNqKnCs/Bb4w2KozYQHwMLx0oCI pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csc72c2x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B72bJep124653;
 Tue, 7 Dec 2021 02:45:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by aserp3030.oracle.com with ESMTP id 3csc4snh1a-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao8DPVP2Dymjd95t+3LF/gkOJkfRxW50Nc/bpzGa7C4IqZmxexed9wJ6gYGPbih1lUnXq0t9fj3IXMONqYwZx15BQqWopTip88H0R0eN4id5PozzaHvJHEEO0rh8PERJL+wF7lhryGMk9DyPf6gQGJUT1EjOORX3+VoWR/FlpImR+xtIBWa8KzHCFMQXuUCj6SgtOJ9UPWOotvk/aCBKsQ4HV6UupiR/6K2VPaDcXN4s3bi3ztfBx+WCzpla3N0dGY5kvaJFPV4XPjnV+4K+d4BFV6fnc7zOEEwmrkSwg8POaXaz5tfGXkQopZQ61Jj1eB8MgNUHhO3Gkew9u5jdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB9XJbLpKqnG7w7C+qCRfmBlaYxb97HbXc6k9N8T6JM=;
 b=bgboNIYv7DoUAR6PKtKlSXiKeFzZCjBodFV/lnmti54tOcpyVwZLGeJk7MyrcTMs0pYl9seq5n5QVv/+PRije1EvjiwCNLC5Oot4XhKrud3iKhh3U/ByEGeYbPsdul7f9rZYdnLfn/oMSlwtiSJ4sUQo72xHgx3pZk3Qs2rRapWtJV3tnkU5d/pcHFciodzkuxZBbfZcfmcxOG23ZIoDF6ygwgWDI7ukqeIGcbRIVe76mbwKdW5jy4nL7MPe9ZHnBQwCIHMSFMAeFpyYJ48ahwQbxw4AhyNjsUx/vzEx6eBp7A1GlT2SiTG7dGqJz771nphAZSjJ7FHQnVWYEjjIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB9XJbLpKqnG7w7C+qCRfmBlaYxb97HbXc6k9N8T6JM=;
 b=fDhuJbe2/LSdQzLSqOfAPdFnaL+t6BtWmjQcDLVlr1vwc/YWMC651yOLOR2uQH0+9ZbHQ0mkNd9CLaSlXIdXs31/YQrkV7BlMMZ6MkkeLPf5qNS1Op46vbtV2UDq4cXWxhdbbcaiudWAnT0uCK4rHOKJSjhhtVxriFir6Uyworo=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 02:45:21 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:45:21 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH 5/7] vhost_vsock: simplify vhost_vsock_flush()
Date: Mon,  6 Dec 2021 20:45:08 -0600
Message-Id: <20211207024510.23292-6-michael.christie@oracle.com>
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
 15.20.4755.11 via Frontend Transport; Tue, 7 Dec 2021 02:45:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd49044-bdd5-4578-05b6-08d9b92b9c57
X-MS-TrafficTypeDiagnostic: DM6PR10MB4347:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB43479BCDAEBAA5447F4122B7F16E9@DM6PR10MB4347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7hE9TuI3ZaE2JnhHnk6XLzuUir788jrbcEx1k2RZqGIoxfx9sonbJ7lg5wY26j+afeg288vuCq5mN1Sr3rfypuiZTIEB0MMiPFtnRXmSWX1FU9hYWh3lSGw9MvSaj39+vqH+3dNYeWbkBA4tCw1H/BfmXvSFge5jiUUZ38gYCmnggpDXNlxtSIHHYVydIQwUtEQqZpTeMDKhR5VOw6LXaA+QnyGOI8v3VC3KXYkVX/UNfgSWV2E9ml9MoU8+4ltOTE/NsFXM4lYkt1E/gZWgHHrUkf4DSoDMKGNukyXyz+weE3JxcxZMhTHeQYz7I+hfg8NI+U/1KenGQRADTG5+sSYERO8DtAGHBDxg+IS/61LrRLKIhwSMpNV2Cyss1YKZWNf7qYPhl4SoiR8HVNZPcGVWzGCsuZa+1pKcNkZzdNbPZgG1wZVTYdAPeWLuHqrqCK/MeincZ0kn1g5Vfo0eal11wgfbgxmPmNjfKoFxiQ5d/KbkuFuvzSNF+ceSwmMOLN0QYu9Vrtdk2d8u1BURitDeuJ9EphFrOP0RoRywXPyWQtCJBQnJVF9Lw+/deIv/PadI6CqJ+gd6Zw+PPyD8Cf8/Z/Lm88ePRTWg6G5EShD/tT6P1aiipI0Ti/T+gVRfAVKpOkJQ0LGwG0fjkpu8aey1KbFzbGbDT5rloXmKkEAQMK0nkAtCPRl0fv/44Gvj3UdSh/ig56ItYGOxSf+rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(316002)(36756003)(8936002)(38350700002)(38100700002)(26005)(8676002)(186003)(6666004)(66476007)(66556008)(66946007)(83380400001)(4326008)(1076003)(2616005)(6486002)(956004)(52116002)(107886003)(5660300002)(6512007)(86362001)(508600001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QMT+GMfSfHf79TEtvuD7KaYbHHXLiuN3pEn1XnlOovS0riUBEAdTPtGcre+2?=
 =?us-ascii?Q?+bUvRsQ0xdZwwFP07MHKH4YcMXstewQ8uPX4FlSskdjVOWqH5Pj0nbZhtyMZ?=
 =?us-ascii?Q?jONAQIaUYVxnr0wxmWaUjMQ5F0w5WrXUibhNKQPkFjcMo8H+z/jn7XuJFNIh?=
 =?us-ascii?Q?AasqQcpKHed8yP2aBvv/vVOXSCVMV4kdaLP619fdr/AneHI7+5jQri/P6DBx?=
 =?us-ascii?Q?hhhcJgh33ICEoGCHmnmVMWlnKJ/cMZqI08W1KPA863eJv1qoOAM+78uZMG+7?=
 =?us-ascii?Q?2c0WeKyJhRJdkwmr+VxCs5c1WY9O7/A8Jz9+dm5MsKhgW0hkSz4trPblYfvn?=
 =?us-ascii?Q?Dqm4TIPrG8Vz9HK4x0kTBDasabZIDVDbiqJgwRHAmcXgpi642JhoGdbjiruW?=
 =?us-ascii?Q?8WbKFarUdazzAwvklx/4BztXe627UNVTzEP/rv9uLDORN8BjB8K4jNy/fjg0?=
 =?us-ascii?Q?XBoTw/Uzk3DkdFYgS5wa4tFTdCDzXP1Dff6tmmuVlDSnocbdhkaSTjhad1oJ?=
 =?us-ascii?Q?hHVxLl7KBVVKmM8Cpwg3oE57ReCADe9fIZmfIVVtSLS0Q9RbaSkdWW/dKgc+?=
 =?us-ascii?Q?NTewV9EGBcodIx1llt3bifTWi8EMdviiC/wThQXPkxCyo0MOWnEgjDSoYXUS?=
 =?us-ascii?Q?KndVWPriG4yg1ELv7w258S5Sxj7mvKxIioy6apd4Po3sZkk9iCSmx41vdCOJ?=
 =?us-ascii?Q?mvmj6QTZ5aOcO72epo/wiD+uA7R93u1EZS4QMVGqwIsWnyWl8jAEZEdccDs9?=
 =?us-ascii?Q?uJCmCB6S0S4b6NYMsOT0Bc6WufV8/UnZgs/849IxIBgX/aif6w0xU9IGBQd1?=
 =?us-ascii?Q?WFh8ZapMtzHVp+kCRKe2wrj4K1SKd6awOeKjishPYWZY6bi4oly8JRFvStRJ?=
 =?us-ascii?Q?3p/rWtskdZbgywydQhfPzF68hdyL6V8DBG+IuupBT6v8Byl90AArjdcs0PoH?=
 =?us-ascii?Q?LBRDqhOokZ/770Krrqn5Fa1WpvppevU7ffz4GeDJW6ilOCuX25QrhpxpAymW?=
 =?us-ascii?Q?/uvBwNb1BuBK0MXhAjfjRvXFpQngYY0PGjdMYm1/6YuI9o+4nCKFxj5gLKUG?=
 =?us-ascii?Q?hpPxDtau9odZTSf35TF3Rxv32tDC4e9ScAeY8L5iF3pAxc5n+14Sx7Jg+5ar?=
 =?us-ascii?Q?379JajaNdOtxPMojL55yxAzw37h40MqPsHm/L2SkjkQBciilI4D0e1teqxNz?=
 =?us-ascii?Q?D9M/ZQx14EEU23deybDfT6n/VoCzHXpIfZggpRrKB+v9Msha9bCw5q3U0p4W?=
 =?us-ascii?Q?jWcMYp0tXkAEFlQX5OXh58NLintteoL1PePYuM+A+ujbK76k9Fh76Jiif/Rs?=
 =?us-ascii?Q?aVkel6LxWBcCBKRNFUJ+K0wyi5OSFFAZNid4kPu0i2jxPi5SEMOdg/ZY2l1k?=
 =?us-ascii?Q?e/3mj1jK70V4IZJ5dqBB95mS+DnT/yMG4QSh2+venuyM9XOizotJ3NgDCVCc?=
 =?us-ascii?Q?U68DsGUQvf2uarZDKcXqoCzosYM7KOqVbfYWbrdWPN99xe49KQ+WI3ZPeinv?=
 =?us-ascii?Q?niC+NxCiLBPFPTEL3tP9GdTwz+DK3ULwo15SOXavfc9DNH0G0De3m7OvHndO?=
 =?us-ascii?Q?UijXOtxKJp+MD0c8KA5y5ndPm1fHuF0xV0J6T0T+dTeJta0Z1OtnMuwRHhez?=
 =?us-ascii?Q?5c7tPLofbNwDBLh8m/brcOVU0FTJidGhcjfKGrOwydeZtdwWTpWYottEjpln?=
 =?us-ascii?Q?0vyuXA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd49044-bdd5-4578-05b6-08d9b92b9c57
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:45:20.9266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Or1kiCh+7nFkKBGU9Yz2wQVGheWtNwjTXp/nZjWOAYvf/aNKv2eM4nbBoiIrs0CAS6CfFdu0xMkJG3ypBWlCbtUY7dj/m9/x1j58oNg7aTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070015
X-Proofpoint-ORIG-GUID: bYOR7Z_m3hPwyLyXF0E9t4Mca7p3Q1X5
X-Proofpoint-GUID: bYOR7Z_m3hPwyLyXF0E9t4Mca7p3Q1X5
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

vhost_vsock_flush() calls vhost_work_dev_flush(vsock->vqs[i].poll.dev)
before vhost_work_dev_flush(&vsock->dev). This seems pointless
as vsock->vqs[i].poll.dev is the same as &vsock->dev and several flushes
in a row doesn't do anything useful, one is just enough.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vsock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 2339587bcd31..1f38160b249d 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -703,11 +703,6 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 static void vhost_vsock_flush(struct vhost_vsock *vsock)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
-		if (vsock->vqs[i].handle_kick)
-			vhost_work_dev_flush(vsock->vqs[i].poll.dev);
 	vhost_work_dev_flush(&vsock->dev);
 }
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
