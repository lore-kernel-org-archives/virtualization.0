Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C99C433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A80461166
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A80461166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 486B083C0B;
	Mon,  4 Oct 2021 19:22:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 54HfndQatWcA; Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3B46383C1B;
	Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1206CC0028;
	Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29B68C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08A4740263
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="U08RErgf";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="phXhhvcl"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mRTQD5QVRpFW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8FF3D40169
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194JH7Mf024351; 
 Mon, 4 Oct 2021 19:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=SMrEWBdJH6U0LswhijxTTMCWpCGKqrwWsxt+EhVz3yc=;
 b=U08RErgfiwQ9O+CVIg13OBcHoCCsS2b6U6qnumFCFkLzK+x6HqggAZgspdbNRpkk/tcd
 JdeaJx063gRHNi6oUvE1c3NrWCiy4TUQ6gTlCbuqv6RnKs3wveI7o9+vhpBPR//GHO3h
 0SoewnaMiVKrKkeWsvLe9Ywiwik2fT3wLSElfzaKj81daODZLEGQ6+oeNb03P95JD44I
 MsrBSoJoizDD+gHPU0rErANwQ4aq0QX3kWwctV7SrXbZawCvw5hfmpptYu/ySKvKanPh
 TMXM8cEPYyRCRRkWBtuGrw2oco7U/OAtRxwSUQoOrI6X0SFqQ4ivP/DMqCStLMlqVjzn pA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg4549y60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194JAbks095280;
 Mon, 4 Oct 2021 19:21:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by userp3030.oracle.com with ESMTP id 3bf0s5c7jr-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG+M0yC4hJa1QB3JyNifX8UcY6q24j6QkIQiAhowMh6/AlrykjOhZ2glEycWRH3cE8eddKGiWVw7yAkmxtFlCjN3Rh0aUK6Qdu50coBA3Gm+GGYArdroGfbKuZd/QkZ7X8rYJ4RgOgr0fS68cCP1CPbFQCoiWvm7/bpTool8Ukq6SfoHUNe6uF8R0AOGX5QktXgbk8TRGFb+mg2tcYM+tik2C0VktwvP65RsdX2gfhuCIXgWaJuC7ZJVGwa3GleC9LVdpqOfrBVHJYqIEzMMdO4XPIScsa0Omh8LajOM/JYxWmc5r7PhWZvMwkAdzHNy8YBqIY0yXuBwAczaqCMnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMrEWBdJH6U0LswhijxTTMCWpCGKqrwWsxt+EhVz3yc=;
 b=LoeyDfkVhUVK8hcwwK9wrS/H1xJoYAehT2pEHgDC0HLIg6B7po+b1ac33ANP5AsXCrZOjQciGX4ReaqGdcoNV1ff+qsuLt4dWoBitabl4e6ew7x9pgPoLNc/GlTIgTH7v+zir01L3KgxN+lmobo3b48cBG+MXR/ubasJ/9n419ptzoCwvU5rALOwdnceySpqW1JQThUXwnQB/WZKK8OfpoL1O7fmWWb6WhORmFE5ceq8xJzJjexrm06zi79MfWv/kV/XUJnFTWpeL/mp5PPdNbgAeB+aD8IIMU9tDNz8Y4CIV/eVny9XTEETSIOFeaB4OvV6CLdGZE7v+Qq+esDMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMrEWBdJH6U0LswhijxTTMCWpCGKqrwWsxt+EhVz3yc=;
 b=phXhhvclbOUTrizpe3LpEJrnH6fXuvMpEyMFaeQkUk6OMbkIho7N93EEc01+rRnYqoswgiyTiL6BbZqEsrz2l3+r4v9NmTD1B3VEmsb3J24TmJobsongTugipLkavfD+vcWyTcFwNyAAJNLWUN1otBX3gOvPNr+0lZw4S/F5CvM=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1548.namprd10.prod.outlook.com (2603:10b6:3:13::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Mon, 4 Oct 2021 19:21:43 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:21:43 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V3 8/9] vhost: move worker thread fields to new struct
Date: Mon,  4 Oct 2021 14:21:27 -0500
Message-Id: <20211004192128.381453-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004192128.381453-1-michael.christie@oracle.com>
References: <20211004192128.381453-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR15CA0034.namprd15.prod.outlook.com
 (2603:10b6:4:4b::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:4:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 19:21:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 828f0d96-784c-4e72-67ce-08d9876c32d5
X-MS-TrafficTypeDiagnostic: DM5PR10MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB1548A77E9FAA956A6BC27962F1AE9@DM5PR10MB1548.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7PV5+pM6Zly5NYs27i7OjT0kD4yNa0xqC2rTQi/sA7GENpGu3zDbnyb6Ib3m2dLhzUWZIX9JJxEWMl6QSJqHCx4jNG1i4I2NRFA/3rS5ngBMN2G8KH26rET8NT6mvjWIBDmBq5zAiErB5KX2O7JmDYj5BkT9pZ4E8cH5WlTNDsez+Z6x5ClRnENrH7c6WfVyTUK7ovGB5EnT9JiXma5nbsejAWf6lfIE/4Q68bX6LUq2Adkd6I31lQs5XE0Y30y2/6cG1Swy6mYq45+5hFx6ixmd7XmKqURELKn0eLzSRmKoG4QaFogK3wSt1BO9bN1zpmLU+uzSDxIYK0L5yPUk47rCvpwyTEu/j/1NZ4jxIYzmD37YxHDm49DRL8B6pnL12r95Gfs7fmdEogEh2ABSTO8YbYltpq9Ocbl+Pa4bk2FlgHpKNFUvBUXlwn5ZlSDIADTzj0PBq5R9AdRc3zFtLglfFLaGA7x9Mki1DMXydLFZJA/sNNzUgJRIIftEwRR8Jd+BBJbwNollpcMuHGws5Cgb/WXrC6XqKLoF0AH03MRhjFPpcKkKQnyVHMjntPe9Fow5ZzhGl4JLY+Tv5nEf0ZcOkC3aX7dct+rxeL0YJvVJFpUIYWg54JZQ2tB45iP1jHUFvnTx2cQwZqXbAxY03N0u59ybp2XlNppK5ivOIcdXakxdVPWGvm9w+xIY+//YhtVj00UGlqBHuKeRltgj0G6zjkcE2o9xJxM2sox56Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(8676002)(921005)(7416002)(186003)(38100700002)(38350700002)(6506007)(8936002)(4326008)(26005)(508600001)(2906002)(6512007)(6666004)(86362001)(316002)(52116002)(1076003)(36756003)(66476007)(66556008)(66946007)(107886003)(2616005)(956004)(6486002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aH4sCqaYYVlFWB2r3skpHclTLJmcjxy0Ne4QdkqZJCFg1x8VZuHI47x0IkbI?=
 =?us-ascii?Q?fRaXd9z+NScxh4xnocEpUh/dQPblOpuOhK402lp6ixn3l5G7tqfdBAt76Tn3?=
 =?us-ascii?Q?970oNZv4r0b8l9UBmHEKnIEZFX+11WakGtLc9Ke1ZWgkyteVEdzkFTmb55yC?=
 =?us-ascii?Q?h20Ncef6nwFc/mctcZvAY9BCg+6rTBN0LfjdV6lHOHa5z0aheNgy377VHMRJ?=
 =?us-ascii?Q?jB6Yjc1cLeON698xdlWy7vWQPZdFt7AaaHSrcdt/PztG+9iHvG6YwdOe5Gcb?=
 =?us-ascii?Q?l9HG0GKqc1qZzoeQKX5kXBJ7rEuBLyDYXqOEJhYfeESByXF0bd0myMICxXNW?=
 =?us-ascii?Q?+xDCpdTTEAFzE3zIEHyfAhbgR6H6KFqUFJol2TfnSAdP4AVloTC0OUALTnOE?=
 =?us-ascii?Q?oZYtwaryvOZrWYhNnU4nk0ugkaHaFLsrNbvFXNd2qL9bRsiLrn5mGzISDftq?=
 =?us-ascii?Q?WN51UPsSia/JzopHguyLVoHsye8qlBDfaFewOnv3dtV1Jow32lUewSqxodS1?=
 =?us-ascii?Q?dFSsZ36so7N7hzyru9hjNjLsvBeOVuioh6dm7s9WvnOEESaZcfp7/0U9M0Cm?=
 =?us-ascii?Q?SWuVcukKCGD4lgtdi6HjiljrgbOHR+TtC8YzHweVOZGO90JWjhEwnhYG9QiF?=
 =?us-ascii?Q?YBF0krD0fWV6Tpa69CcC9INzPSwbH7GXAkL645PpMU25gIYn7nk/71v6ladp?=
 =?us-ascii?Q?xDVd5+iffpwn2nSkwNFqj/VRFGUOTatNCVUm6K8gjYYxMzLc8J/9fTt47PhZ?=
 =?us-ascii?Q?TjzCQXJRW7Y4XXLrZdN8Pt7JA6SkWOPUp4JoWEQZs6Tbv9Pdnp7maicGWvYE?=
 =?us-ascii?Q?2XxM7ySGVhZ5l3V07iK7FfF26qEO2RCcYFE/Ox6BLE/7Q8ZigY8UOSuEUfkj?=
 =?us-ascii?Q?taQPHguk1xPvR+L2xODJ5idO4CJUMeJEMqg/klr86ZUjMX+0O9JV6hKPvZPa?=
 =?us-ascii?Q?BDfLal7XbkrHQeDpswuDbwu+194uc86l5nlfGPzNY/dAgV0lzEmpxlEtoa89?=
 =?us-ascii?Q?f70TD8wx8D2KbTG/d0DeTU1JG04o7w6LZKc8A+VIrQKeW6JcInzUrIClmMb+?=
 =?us-ascii?Q?02SRHhJSgeUtfOQRI1Ndgj+JEG1UFCBM1h53ID53LLs4DlK9bp9P39MgcRF1?=
 =?us-ascii?Q?KjKH12OygPxpCOqbPM1p9goIEgMZ8FDRJTsM8elJVC3bI6j5pOVjSRxpopaB?=
 =?us-ascii?Q?2AsL0GlVR20ml82CvRv9mxesuf4gHBkAxSlu9fVL/BO3XcKNH41CeXm52M5V?=
 =?us-ascii?Q?EaW2dPNfUTV5i+Hf8gylsbKIoney5pJc3hky3YDXdpYSk+lCU/PcmAfUfWIs?=
 =?us-ascii?Q?/7Ejjr99TFP23xw+z1rpdRrQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828f0d96-784c-4e72-67ce-08d9876c32d5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:21:43.1069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1D1+di7ufmjMtWhx5TLHCwxs4EInJ4hrOVvF3jrlgkvXOtWNNveLqqmFP+X07qw+jLA4CdHeuypqjJ9wnBd6H+UFFlasJHLYrN7K3APRHIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1548
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040131
X-Proofpoint-GUID: 3fodW5qdVi2O5DsxIhfIUvcZaJSkciZC
X-Proofpoint-ORIG-GUID: 3fodW5qdVi2O5DsxIhfIUvcZaJSkciZC
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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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
