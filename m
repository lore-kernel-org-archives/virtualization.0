Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451D1C433EF
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FF1A403A8;
	Sun, 21 Nov 2021 17:50:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D5eMfmi51QJD; Sun, 21 Nov 2021 17:50:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 44037403AE;
	Sun, 21 Nov 2021 17:50:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 611A1C0040;
	Sun, 21 Nov 2021 17:50:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1186AC0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCE3A80E54
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="w7KhXVUN";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="I/HNTPQn"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IHuRlmeReOgo
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D89580DB6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:57 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALEAhpp021623; 
 Sun, 21 Nov 2021 17:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=3xxgqK3wtCbWC4KtjmdItgwVtQSY0A1n+I/sVBqIKC4=;
 b=w7KhXVUNgGkTvXgn3GuhPz4cIh26pgcrujQNV4n6xr6jalB5hoqlW5X5s/KwuR3OQ4VD
 6IsW66IYDi4BAQ/57pmzmT8gB5HTM+kNpLsiQ29EbOKaYcQFuBdD+LgYQowaNXr/34RH
 B85ZkZSCX6h7F9InmvMT3hlL1vN6LHxashuNfWi5NJFWYq/pDnU63voeg3p8uUCRUv8z
 emaJjVDDs3bfVe+rQLYyM08l+H0iZ3OdpTjO2mrxnVV1grc6POf0i4ZJz1t6SuarP2F9
 I4DOz5KoMnsF9WMcW5i3iG5JIj2WgEe0KGNhGyDWtVpX6IVM8wAq8Bja1XGHNPAjGUK2 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ceqm1vmwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkUY4015043;
 Sun, 21 Nov 2021 17:49:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3030.oracle.com with ESMTP id 3cep4vp60k-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaXVfi6N4uQ3C7irm0l7UkkdPfaxfgBjbjHhdyRRUoh+Z2VPY9nrL44pHCoCAkFE9Sz6xFoRallpbZT0wgTjmaFfHrCvXOS+IjNheA5n/0GJSt60OUKmqBMjrTPF/7lFNyhQP84h3n57JwEcchScKuqPDWe+fmZAegV+wAocYDdIz30cfa14pyEueWGqcPxl976CPEDH8nEKGLJceSOVR5uS0BjLWZCo4UavgDn+sSpYbhoRbttrmBdw5HHQ3C6aKyNZLvf6PnwWzg/5T268okYWnkVzrhbs36EtTzwwgyCrHWvheGTcHe7brR+zCWReQqQ+Ff4ydMw/JNptgdHMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xxgqK3wtCbWC4KtjmdItgwVtQSY0A1n+I/sVBqIKC4=;
 b=jkNgSK1pkTNIdtRwUzNN+9/ttTkBhLVu94wNUNyOFxDQ12N1myWVtKAgO9z9ZapulYbFoWU29zn6GeqfSDXceHhmMKZ5pzYdbnIFqYDd+okOJSWfdg2ecfZvh1Hnb89PWS9TrZcTKTfRaG+b8t6M6Bc56A4ViuasTDC7615+oEeHK8AZD4Lpndf+uXD+pWAr6kvVMlQ1r0m75aNzXQr37ujHKg/QfKt7CYAq+MgcDIwfcPxDQLHyZ6BwpktxeRDn5Pev0oe4HoScSy+r2oxwMOyNWJmdED5RZwGkSIXae1meefuJu9CQt5ljrURct5l01TuTsfe2qae7Rfvcw18HbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xxgqK3wtCbWC4KtjmdItgwVtQSY0A1n+I/sVBqIKC4=;
 b=I/HNTPQnQ4isn8oUNLb7+JaTkWudVAWhl/5SxCMLuJp/kqMxQ2fGwv0swZiPUw4XkltRheQVq8794wfGtIo+HO381DBbWoLpHlWq6pbIFJHuqxo8+6OCTLJYypY79Ku66juZypJUF+WdJxZ/IxnR6naoJi3dr4fZTjPLmK8Q+LI=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:50 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:50 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 08/10] fork: remove create_io_thread
Date: Sun, 21 Nov 2021 11:49:28 -0600
Message-Id: <20211121174930.6690-9-michael.christie@oracle.com>
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
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84cd9a2d-2cf3-4219-de63-08d9ad1750bb
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5055A5424177E69986646D0BF19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aY89GW4+clYtU/NTF2baUIbvpAB20zxEsz/Omxd+g4+sn41ROCG3WTtqpaCXp1QIQcg9rWPmlXG/PcI8fK77Fay7A6EmCba9oBCPM9HH2P49XqFRV/C4UBdfEF1jkBu9qMF2oBEW/mcT01m+TC83nkyPMy3FNz/hbJJUl7hgNiw3kWwTyDoTpOkCtsYPWCS+UlAa4F+POiyQtVn0EySFf0CpQZJ7ACHW76Sm/Y3oBFnk0QgM1WjDwNb94H5u04LhEUtbs4165rKzhTFzffxpCIJZmnWKQJsPrnTpd6NI2H2CMB3SnnIL6EEckTT4i7zmLEL60oKLxF0ZHmkSjHo07Zf18O8sq6x7hYEyeiYIkN++DltCf9/BWblj4/mRrDw6o3DMtpWY0lBz84U7k/Z0+rbxOBx1F1HOs1Nopks4UCsAitw5MnIylR6mCmeIZ+XdGG6HIO9/bLAF+1aelRYK/0ymX4jLG/bSCiK0cDEJIj4VSxx+7B8L8hkTPmDCZceWmC74fBthvrF/oVDhjp+L7kSGuKwxiOdakqNWzBDlh2Z3QPtZZPx5/XHsyOO04os9UvLvFv65K1JuMvr+umSelhPWpjm73gJDUhkXGE7YhqdaJY7ZkHRUWAlLLHJT4RHA8e7NWHrSjh3/h0VaTLzrh1jvN4xxAycn7lX2plYiNd73FdYM6+Z1DgFVlHbUVzabbIjaHMAb6clrr9H21kAlj8g+68xo7fnvayIPXen+GEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(6666004)(6506007)(7416002)(66556008)(4326008)(2906002)(316002)(86362001)(107886003)(921005)(508600001)(38100700002)(6486002)(83380400001)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/MA8Gde2JRMUOD5z9L3tlwviNGrapEis0HLXse5dvl/nWWvtgutyVTIJew05?=
 =?us-ascii?Q?DWGwWytGocYMYDrvORgCN8vkVuHLp5JwyJDNx5f9M0PFkLx8R+kaaN+NuAVx?=
 =?us-ascii?Q?/X667ownb5L+nifNoXAa1Tl8yQJZxHJCLP3DIf/dF7inOVxRMxVnJLpi0P7Z?=
 =?us-ascii?Q?4xPU9dwV3jA/ak2DHN+X/Uh/vYzUUHyze1RMcCLdewAq9lZlOOF1UwfPgA/f?=
 =?us-ascii?Q?PN/8lERz7fRqVu75PFOqA3sEPRgM3/FchlzEmE9B4OFTBCu5CFJTH2S66xB0?=
 =?us-ascii?Q?tl8OMkH8rsdEZgdRfSlSwJNATkwecO/noPq8mX7pUyMTd6rgf39mGyX13eRv?=
 =?us-ascii?Q?5X6Je/On6UNMq2Fx/dni+qFgJCTWGbwbHG0BlcmUObhQTnEncIus6u8tEy9G?=
 =?us-ascii?Q?MvMvrRFMElG/Egz6JfZzfhwnNHyAKhUzPW/Yz+7fA1Uzbb3il7tO7aRVcTgD?=
 =?us-ascii?Q?jPYaRoSdUc2JuJPSB/YQq/G8S724cDgM6VpBEPND7lcKVZFZkTErQfyVG83f?=
 =?us-ascii?Q?xSeWmu+qT8YknOUYKo07e21XFJaVC0ddiTQXK7WAMYUAf0qsT6acBQk+3wO4?=
 =?us-ascii?Q?jNP4xmS8UV8l4rj+khcoblHkOjODDYP9EF6j+yyZcLM7sVby8jIimzikQjR6?=
 =?us-ascii?Q?2JIYdraC3eamJHLu/WCQpAMssdNPvNs+WQSL/K/gFNVkj9EU9YlvVj0E2t5q?=
 =?us-ascii?Q?BhIS1tssFr/9Llj+0B2x5Mb5erqFvfkciqrVuLQHl3UpZzTn6nblEo82etvs?=
 =?us-ascii?Q?sPTjK6faN4V0mm0+QoO2XBI/tvnZATRB0czvZyReruFk/jsIMFiZ8gj0VLEV?=
 =?us-ascii?Q?scCVdrNLPNcC6KrcnJTC97z+FVmrUJJh5jTy2hkoZpfd5mqo5Oi6g05gfVIz?=
 =?us-ascii?Q?a6jesj0wR4Pmm8bzuI5QzIlRrN94rwEAMdGwm17SeqYotMVJEnR0m3BN7ih0?=
 =?us-ascii?Q?MO++8eAt9avyz0QsybiWL2Jh0eeqqkBDl/KjqeRGS2fayhf3ok4s6bwjW7u6?=
 =?us-ascii?Q?nFiW3s2SR58p78wZBo09purRaUCslkYc/o8aY97uIBeghSIQHmRcf50t1l9f?=
 =?us-ascii?Q?h+rRCZ+26NuyDaHQqQ6ZH1x6Wnxs1bOQkwp2umLc8E2kMJxy7hiCVQlQC/wG?=
 =?us-ascii?Q?ZDGC9oa3nG9+kz/G7wAeDkf0RUHLbBdPtwupZDwBR/OS0HADi1YBoXnIT2zH?=
 =?us-ascii?Q?1M+H8uPerK8owkeiYcdr1NLfmSk3cyCuGkZvGkmlTzjt6rpSefjPS1f76VII?=
 =?us-ascii?Q?Wurwbhlna5Dk18SxbBgsi1JoXhbIF6qhO4wqCc4m4Aqg2cZUbtvfVdiGeYi+?=
 =?us-ascii?Q?aqguuWOvP22VSM4iprHIfoj1a7D5fAViUGh6PmR65AxlwQ+0gDVcYHoZaKCL?=
 =?us-ascii?Q?JK1wR9WPewA93XWttwUR2Vx0UBlzBV91npWKLMDBqFdR+L+xZ8SL9BB2lkfg?=
 =?us-ascii?Q?v+tcwrjct3nJm4l+Tev5jZXtnKO+uAr2wbsPBgilLdnRRJASt5fOUw5sOcR1?=
 =?us-ascii?Q?jqQRO4BNuWwKvB8GrSJ+8slRW2dj9P8fuvVRzU2SyqFrcadUKwY3Gyop2JTW?=
 =?us-ascii?Q?gBwIjTqbG5iZ6zOcX4+yndqzGq6J5BYEoZ6o/TWmdPdLs+LSz1CCuDcRB0Y9?=
 =?us-ascii?Q?NAMa6hX6KKacXXeUoiJVSZY/vuYMXATiLtjW+digg0mlo2tr8SnoXUQRTDOK?=
 =?us-ascii?Q?/34FGw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cd9a2d-2cf3-4219-de63-08d9ad1750bb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:50.1577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM43RKGRM1evKHnpNsDLJOZx/aro9Gvuehyxu6YvijrSI8BQmalHWjLeml1jVZYGONg0smcR8UehaGBX/xLSIHebvtL7gI7yATBsZMonSyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-GUID: UaeVXnWTUdFDCuu0O3amLFb2-6kgwjl9
X-Proofpoint-ORIG-GUID: UaeVXnWTUdFDCuu0O3amLFb2-6kgwjl9
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

create_io_thread is not used anymore so remove it.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h |  1 -
 kernel/fork.c              | 22 ----------------------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 2188be3a3142..313fb8c825ae 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -89,7 +89,6 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
 				  unsigned long clone_flags, u32 worker_flags);
 __printf(2, 3)
diff --git a/kernel/fork.c b/kernel/fork.c
index 3729abafbdf9..1b44d048ec16 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2521,28 +2521,6 @@ struct mm_struct *copy_init_mm(void)
 	return dup_mm(NULL, &init_mm);
 }
 
-/*
- * This is like kernel_clone(), but shaved down and tailored to just
- * creating io_uring workers. It returns a created task, or an error pointer.
- * The returned task is inactive, and the caller must fire it up through
- * wake_up_new_task(p). All signals are blocked in the created task.
- */
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
-{
-	unsigned long flags = CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|
-				CLONE_IO;
-	struct kernel_clone_args args = {
-		.flags		= ((lower_32_bits(flags) | CLONE_VM |
-				    CLONE_UNTRACED) & ~CSIGNAL),
-		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
-		.stack		= (unsigned long)fn,
-		.stack_size	= (unsigned long)arg,
-		.worker_flags	= KERN_WORKER_IO | KERN_WORKER_USER,
-	};
-
-	return copy_process(NULL, 0, node, &args);
-}
-
 static bool kernel_worker_flags_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
