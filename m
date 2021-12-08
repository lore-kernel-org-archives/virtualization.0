Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E1CC433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 10:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5027360613;
	Wed,  8 Dec 2021 10:33:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vD5_imeu5ahN; Wed,  8 Dec 2021 10:33:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F584605EF;
	Wed,  8 Dec 2021 10:33:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CFE8C001E;
	Wed,  8 Dec 2021 10:33:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71284C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 10:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C8E640207
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 10:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="bkhHOniX";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="NeFv8pe4"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HieHOav053tg
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 10:33:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E217540202
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 10:33:25 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B88wwjT018339; 
 Wed, 8 Dec 2021 10:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=3U9GAYigU/8PQWYa/5Vjlx7M9ruZmvnldw72yBfQNQ0=;
 b=bkhHOniX+zUoiQYI/VRlz3AyvM7U4QpG4pqGKzfZw3J+36rDE7dwswMmnjv0zWqCKqrs
 mbk6RUJEmnpHrlNUtfRl+K5NF098yPsRrKz+45IvR9b4KsQp+ygnawMK07kUMSlgfNN7
 8TqDQCxzOVKXFahO433OTSmMAL8bOORVuZmt2rw7HiF9yRLx2dFSXXmGqWwAx0ticyHk
 esVo9CiZcJoKkWBSeCEnM9KsGNe7VeW7bPCV9Vpge5DlpagMQo/5CCsIHV+zEgxIImNC
 5lwmfypRJG2BFP60E4uTkIMTMsN0tqIlYGBw3lkRR28A7h5ada6A7CwqaQ9OUWBQugiF lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csdfjfsy3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Dec 2021 10:33:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8AFCEv069322;
 Wed, 8 Dec 2021 10:33:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
 by userp3030.oracle.com with ESMTP id 3cqwf06pxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Dec 2021 10:33:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k50DNNw9YROMZVsmFTblcGYoVZI6rl7Rne67wyESn5fDp5VcOQZ6UaVEA0VsicmA2qABy8o6dDYx1ReTsVEZPZ97sa3Uhyk16wwHwRxmTY7X96LgsjpABIwpY0MokkGxXZEJB+h9zYQ+JY3TSkcoh0Mbn9YhZdwRskW4u4O2Z0IIMQ88/X2PNITXyhK/mei5F5G+oO6uFS5QK/kWij/AyXp+cpExCvp4IA5RfzBu+uWqjk83U6j6L37RXHqU9gCqxsXdqwi72qBSY6RGsaWP5ZgXF2DuN8C1Pv4z/A6phjiuoKyFobbQuopJbSCMS/NDN2ddFApGXvLT0pE8r85tsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U9GAYigU/8PQWYa/5Vjlx7M9ruZmvnldw72yBfQNQ0=;
 b=UMKEUE2x25ESrJoNdYgNgIaRnyU/KS53U2vgT5ZixEpb008h9bUJ7td4Otd7lqPB2+rgO0BIWpSBUwBNVPBH5zxB7lVkk9tj6yY0Isg82NyP/YfjsX4eQKux9nekKF2OQ4SBL7WhuXQYOHPZa8pzj18d/AamBDEjg+d0R6Sfdz0tnm9LqkeMcSmvgen7zkOCIYxrPJrFfejarZXA1MtXtoBmUdhPatgL0KBphRPwLmVma5SPpwYqXw5l0nbePqVuojACRbVZ+VibRFIyI/D0fTtRpVbxq5EDYZhd035CWphXnSrtL+YmJKINrgnJjHcW+EPrgs0pFHQ1GwKWgSTLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U9GAYigU/8PQWYa/5Vjlx7M9ruZmvnldw72yBfQNQ0=;
 b=NeFv8pe4v1Gy4Pn4/EKjAiFV7ytm70lxSnognzixKi+76PgONPazTY6zgMbhaANgsymk2PTEj44RdRUsUite9YmYKbWmTJ+5t4XU/Op+EDjWvu0Robde6UGXJ3ZcmuibZO/yrOa7GhN9srvpMItpc6OewXpyxUQjr8uCwbOQ090=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1616.namprd10.prod.outlook.com
 (2603:10b6:301:9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 10:33:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.024; Wed, 8 Dec 2021
 10:33:19 +0000
Date: Wed, 8 Dec 2021 13:33:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH 1/2 v4] vduse: fix memory corruption in vduse_dev_ioctl()
Message-ID: <20211208103307.GA3778@kili>
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0100.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0100.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Wed, 8 Dec 2021 10:33:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a61f1f6-7bf6-41d9-4e65-08d9ba36270b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1616:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1616A30181233C86CE0776588E6F9@MWHPR10MB1616.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJi39AkPtgVv2qZ5adrKbVvlYulIOE5tCC1u5Qv1YfgdWxnCk09J46o+qwwxMQzzRQNRRvz6/BX751pMHg0HGCu0dLPrE+NEBL35tUgmwongXA+cvSIP/4R2nLkAnRgaj8u8kwf1XKZNpvOO7JHdyT9bKG0nXc1uZ9AJkS2+8N2ahCG6p0RPKwfRrO5lK5JHhYIoOE8xgyXGHWbFae0vSTk3L0nUw3weFmodaRmARUEvqrxXsI3rXQl0a0N9Mu5oq4ZW1kLnwUNEoovnbV2qet+WWD3rpWjkZtETRDS08MIvcz4peVFLlaS9CR5MWa1v1wi+wUH8Bvno5AITOfMqpdwvt1sU5gyN59MckPmPewPboy/Oy+f10v60IIBkI6tsEi2GwjdoKqfaIaSprOVJkJucYAs9kE/dakSotcAIiVhzY9+4gooJ7SrzRWleUbWzsxIYV8FdwBwjc/c8mbZF5XGHMbNzg0LNlFRZAwNTfgXjMk2gt4pihvRoGD4LD+8RVmDxE80axfeoY5heeml6tCAIEINbi68SHpm8Gbm11d+I9IFdEH+GTtrJ+Yp33bMPTAjQdR08a370ySyIv/ngApgkgEbwqmMaCiMtMo1o5TSGHnr0+O+ZPA3YJYmMt3X8MEOnZUgE39FJ2tiRAbmylwsNe9EWPcff7AVKZMxbsH2OV+REiJKntbm0/UPmdYjUzGozqXkC6N67qTunPdq0RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(52116002)(33716001)(83380400001)(66476007)(316002)(5660300002)(6496006)(55016003)(508600001)(66946007)(66556008)(9686003)(44832011)(86362001)(956004)(1076003)(186003)(9576002)(26005)(6666004)(54906003)(33656002)(2906002)(110136005)(8936002)(4326008)(8676002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9kXPBx4NQ9/Mpha0gB68N8TZR71uclisf8hX5cWVGs0xwMZ+y/4auY3OJT9G?=
 =?us-ascii?Q?F65ylY2BRFIAm/YpZ+rFajyh+qSale7j0OkkVrC57+SNx3TUis6IXIeFjeAw?=
 =?us-ascii?Q?GkQImtA0uiicfCbpbUmR/+XTxXfOtTFaQUSvDX8rcuIEr5L0GghsRk5QG94e?=
 =?us-ascii?Q?DBAWhOpz92+kvjcu7ujCiCcPnHMdxRFtZSGGmJ8xu1DozFXA04rd9nGjg56O?=
 =?us-ascii?Q?eZ1M9jj56n30G1WWvWcikRhUavKfNV5SF1aezB+YFgmSUZgamD1BeAUWmpnU?=
 =?us-ascii?Q?OZvX3XuO7nS8/Sa2rQQpqC75ZvrwcyR0Vme6g0/VECOe1wd/GOT5ktB9O3kN?=
 =?us-ascii?Q?g1UInsHzVPnIfqOfE4fIBGFuw8yrq0yaH5qWCPeKdo6V7jchiWWWaqBhcN2a?=
 =?us-ascii?Q?/PXkMCCI8OzLCiRZqqTIW7ewQTLbZVVQX7oGGEPBgQMs4Z4pm2bEFBwhbVSt?=
 =?us-ascii?Q?VZgrsyhDaJeXl6bCMIVM8/sDcGE1iwAuwdv+44/fLhm+yMM/PMaatMHHo1xp?=
 =?us-ascii?Q?s+w7f7nVfECOxnkyfObHcGd19ri/iw1eCO7kuUuOqWOt57xYobhv3Ztknpt6?=
 =?us-ascii?Q?3/03gAdZ9dEvdF3EQkzXF9lGax4f0TB4u+0V5VpoGLcf1iiunqi3X22E1Qnl?=
 =?us-ascii?Q?Tk+LTwDeP5i0z/dweG9dlRg29oNo2AUqZeVWi5/oVtnSXAGoscr3UegD9HuR?=
 =?us-ascii?Q?+YM3fgE7mvFadbw0UkoXZxDjeFSwXawCHWGW3xccDuFP+/pwesdBjep2bZnu?=
 =?us-ascii?Q?BS+XwkFCZqpZ7jwKEXkYs1JrSVNEJf68BFXbhwJkf5OiWfPYdlAWTHS/2jSo?=
 =?us-ascii?Q?/s9WeDyPKY60l2D+8fkpbuKT2srknWJrp4ODuKXjUfgjaTvbVZCChyNTXh+L?=
 =?us-ascii?Q?JxtDPpt4f/ZcGu1N5SyKzpZPIemystMA7oeod5GaQwCMCyPZjQKlxgoEZt/x?=
 =?us-ascii?Q?Km+smLqdfMurD0Zd4vfyIp/p1UBBYg5QSQ6j63YiIAEVXijrwpmpeByGc5iS?=
 =?us-ascii?Q?vEFg8hZ1L47QmVhlF71reelyMspHjLOOpaFKV61h0pUfRhpsSoB5s51vW2d3?=
 =?us-ascii?Q?93H1CK6ird62cbHzdf6oY9jjBrx3wHXo0ByS7E+jJq5Xfgkc9OMLCidwt3Y2?=
 =?us-ascii?Q?7qYRKHBwST0/RLw6rxjwvveDbpV/tmn+zSDQfhzNAHyHssaZo6NK5zErDSfQ?=
 =?us-ascii?Q?TDg2I9osAruuOhdxWYy5VhG3MS261ZOK292VjfzRbqu2c3VeIZQKTKuaL1gV?=
 =?us-ascii?Q?oWzxLAeUbXsqaVobmheL7R+0sVXlXJO7rVYuY7HvTAPIl/142sY3fcZRykF2?=
 =?us-ascii?Q?0DWHvdOaAmg/3ilcw1Qx4xiepvF0kBIvzjf9E3UJ5WCsMk5XwE8oaunh/aru?=
 =?us-ascii?Q?yE9Rkc7JJjokYZ//0qichwwEe7X22/MVpqwlSCRp30tXh9h4T7HqckigKRk3?=
 =?us-ascii?Q?zTUcoMXwYyAn/zTaybF/P9f/vptEGOud8r7KDvbAX4Zpf940QtZ1qCaSDvDs?=
 =?us-ascii?Q?81/S5an3M6b4h4PXVr6EVyzERtrpFxiI9zui4HlSS5Ibi45sBbKduQ7ujHfc?=
 =?us-ascii?Q?uMC9LDLspGHPtyVbu63u3KlXNXVXgCGgrkWxTX/vGdk9KIw159/iA2WqEcwu?=
 =?us-ascii?Q?fsfZZy+nPyA0ED1blIDs23ptxisesnyyuP1ESO1+QdV73BXXNHACnSsKZrlB?=
 =?us-ascii?Q?XE+tTl2Eif3hghyC72ec3k5KTMM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a61f1f6-7bf6-41d9-4e65-08d9ba36270b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 10:33:19.8666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXT7LP/BTGBr+OYz7ttb2JDMOfjhviJAcuC2bMzzzlVv12zRhW4PfKJDbIAdP+RxSIvsChQUVQcW/lCmAx7u9/LUfV2l8j6kxRA+y1liAfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1616
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080067
X-Proofpoint-GUID: IH1boHbKGtEMQE4inMN5kcQJTRrKYF1w
X-Proofpoint-ORIG-GUID: IH1boHbKGtEMQE4inMN5kcQJTRrKYF1w
Cc: kernel-janitors@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
 virtualization@lists.linux-foundation.org
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

The "config.offset" comes from the user.  There needs to a check to
prevent it being out of bounds.  The "config.offset" and
"dev->config_size" variables are both type u32.  So if the offset if
out of bounds then the "dev->config_size - config.offset" subtraction
results in a very high u32 value.  The out of bounds offset can result
in memory corruption.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: fix reversed if statement
v3: fix vhost_vdpa_config_validate() as pointed out by Yongji Xie.
v4: split the vhost_vdpa_config_validate() change into a separate path

 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index c9204c62f339..1a206f95d73a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -975,7 +975,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (config.length == 0 ||
+		if (config.offset > dev->config_size ||
+		    config.length == 0 ||
 		    config.length > dev->config_size - config.offset)
 			break;
 
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
