Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562E3C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270C860FA0
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 270C860FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05A25613A2;
	Tue, 21 Sep 2021 21:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gWWNE95BbAvT; Tue, 21 Sep 2021 21:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79BBE61397;
	Tue, 21 Sep 2021 21:53:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56975C0011;
	Tue, 21 Sep 2021 21:53:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF7D1C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD93740709
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="qYA5YpbP";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="QVgINivo"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RnO4Cf0a6wx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 911CD406D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:08 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLEBVf028873; 
 Tue, 21 Sep 2021 21:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dAFjJt45cdle1zKW1o1CFz/axLMlzlEmwdOQIbEBsgI=;
 b=qYA5YpbPuD2bCP5qIktgDYQuGDpB16o13UlxYl8MBuJ0JZnS/O5hVVB/c9OqNbM/4npA
 SZe3Ua/GvuRhTlasOzdtPWUCwNdOKshLlMnD/YwOdpQg1pmasIb40PaTxG04S8OBtdLx
 oXatZaRgbNdimroDfLGD4MS3N7PO5O0iRvpT5DJg1K/v8QDuro1d+aJ8OL6BZLVIPXBS
 O6sjOJ7fJ0nhbjqTMm2unb1QYAJrwLGjTkOo0lxzbPUfxrsdYiOAMzitQxcXbaSvROJn
 kSS1V9i4IGlUy+t5B1gNiwLOCNnKvanmywKdekhvl52RDwNgCsheAbVrxjvvIqwS5v5g +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4r85gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LLolIB153863;
 Tue, 21 Sep 2021 21:52:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by aserp3020.oracle.com with ESMTP id 3b7q59s7sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5JW2HSOwX/0jWypkg13DJQQzkjvczfPHaephEd2h56LvDdFlnI4nbgCn5bZ4/nix+aZANMFCA7SiENVGaU1nw5DbGLsBveJ4g4Q78fRQGGji1nl5uvOmnzZ+Y8dh3i3/H4wUT3gzXf0Ajz4MF3kj7KF8//azXUmPWKR2+/XNZNI5UfL8i2w14NeMnW/14v9EpU64yP5Dyql4+Xl0uO34hS/Aokuicp+VrXqQ9qjWY/AStZr8DJWQTVfkFKlg/TvTkIjYfQJ+AyjRv0TuBU/8QBdyxv61b5Ge0MfvH3aBK0yLTI7Y0N06eNVBkHewGc2HVf7Fv+kQMK//LwGTR/2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dAFjJt45cdle1zKW1o1CFz/axLMlzlEmwdOQIbEBsgI=;
 b=Snk7I7Rr5z1UDOiyvZ3Xkb5AppE2suRwPKmPcsubLgEHQ5cvr8NLFiwMutVIQzC7IT3lHbCSwQEf5Nc+e07IRRvKUZHcpM+zTVdcMYkrJi7RxsHoppjohY/krRrdMVpbFT5cCvY5oT71LXCXgBOs3a/u9ky5m8lqe3yXLiwhy8H/lRFuq5roqAc/sD0YpNv8mZscMPSYLlfal3AvEqBhmBcb19iDe4R/XKN+ZrABnP7CKb/HB9NcWSHY0kbGNWknpa3iN2TzJZZni4Tn+X5STKOpiFUAHXPLYTEMorZqJ0Dv6zrYKI7wdM1tnHU0/oK2kfeP/+R7ZYiFDHXnGi6mIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAFjJt45cdle1zKW1o1CFz/axLMlzlEmwdOQIbEBsgI=;
 b=QVgINivoCngBiyxO0rPAM1/yukcFmWNSdWXTMF1KAeNRctRn2wzs+KCXdySsbwJE8Lc0vMQ2Or8DUwIywB96SWPsHOxq46kBOrCGtvE+9aOoti3QOeIvljy1PX8Z7PaepiMUYQgo8AMi2DXGaCm6Wfu9szhjExBlPXWONmzJ4rE=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB3239.namprd10.prod.outlook.com (2603:10b6:a03:156::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 21:52:39 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 21:52:39 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V2 9/9] vhost: use kernel_worker to check RLIMITs and inherit
 v2 cgroups
Date: Tue, 21 Sep 2021 16:52:18 -0500
Message-Id: <20210921215218.89844-10-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210921215218.89844-1-michael.christie@oracle.com>
References: <20210921215218.89844-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR1101CA0021.namprd11.prod.outlook.com
 (2603:10b6:4:4c::31) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR1101CA0021.namprd11.prod.outlook.com (2603:10b6:4:4c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 21:52:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 345eda58-720c-45fe-77fc-08d97d4a2178
X-MS-TrafficTypeDiagnostic: BYAPR10MB3239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3239C21102A2F788C62503E7F1A19@BYAPR10MB3239.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HO1v8KeHDja8xm53/Y3egSv8p13Cpy7Q1b8A6jpRgwqhOXVqWTEzq0VM0no92Ga69KBFmV5sna9S4t5jaRCUnmrPnJRxIpqWz2kFw6pZ3sKlFn/hpYF5WGzFpCUoWmu2S38Tz8bh3/ycqQelty715oixEYunQy4jJRMak6UHb6sHME7nDcQs3QJjeNydp2STvbVjKauKiX3VG8NwUFuQpjJIoPEFmPmxQKXsYSU0XfISjOQ09bDBVVLTP7+eU+o+0zwJObiI/ERpfiwOvYlHc9NCq7/P2F2qoI5ep/wjgQ7N+DGENDV2+kWENz7Myqe6fQ05bjiGnlpagq0pQ9xlCReSsN9WI+6mUnK6hJlU+OG6+dRSr/oi57xCvob+8kj13H9uJvS6gBm6hkrULaDc8WoEkZQpiIxUpu2A67JjOLNHnqv7VmZsAKzNOc9PijtG/CumCr/gSF5pLuCshj6hhPfus88ACd77t9jw4s7QiSrDf8wz8dj2EWS0+m6FV/UhhZPupSJobNYGkOIE+CJ2bRTdDkwZJRGZNWK7VZtNESIKJx0qpjcxaM+j/ewou+dAOGihv1Fj8On5r0sOwDoUAVSISYOhPzc3TwXi4u3FYVi9A8BXaGN0tvSmzvgt6zGq/OA/BswZZB37Yr9sHuU1ndmAUPwAInGQ+o05AXq5T7vbBizXxUa9C7UFu6w/+4LhFxbXA1FXSkUf4/AI18C/ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6512007)(921005)(26005)(316002)(956004)(2616005)(107886003)(83380400001)(6666004)(1076003)(186003)(86362001)(508600001)(6486002)(66946007)(2906002)(7416002)(36756003)(5660300002)(52116002)(6506007)(66476007)(66556008)(4326008)(8676002)(38100700002)(38350700002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KSCsoZHYEAMNjx/paEFaKbfntVFUfGpilULetn+3kOTxmTqxjV+pI+7TceEU?=
 =?us-ascii?Q?nT8KQgCTtaoIO8sI0D2FIRY7xa3wlVcrJeuTUHnRvrr4iNHROtZ+OOUHqTA6?=
 =?us-ascii?Q?9OlNEtBD+d/frNXFQ1aQPzOq/cM+aJnBedeWROvRhZHazHS9IQbfWmxWq8ps?=
 =?us-ascii?Q?xhNF7sbycQTN8k9byEaQHwWCjNdcQEp7ktOS81JnnavXSk3CRez6aDihxqRm?=
 =?us-ascii?Q?wQ6hiMYPMCkcj0D92cfmXI774dQl20JruoqBfpLuCmyygVoCmY/DD/UykMC+?=
 =?us-ascii?Q?rG88B7hOFcd+HIYoGdfeVEjwS+221Af9ymN6cNojODsFkX6mwR1Fg/erJGfX?=
 =?us-ascii?Q?mwAArs45L1YdQVVZqYK4/q0yf135+NqhT0ouD1IsEoAUH6C5pzu2YNtahmmY?=
 =?us-ascii?Q?oUEK/EKGLAzbAL4s6bBZnlHMNWDTLMTnJpk7CfCeb98FMAF6LWvds7Z9Ht9x?=
 =?us-ascii?Q?MJDxCL8sFBaDEjWpZE6oxTNd2/z5L7SrLQX4Gi1zFIWYti8mO0Nl2IJzkgVd?=
 =?us-ascii?Q?/6mU+D/ByBsSuqFJJJY7M1rkuTOjNu9KSkzv9jgwUEagC05/Z0AB1DJuKGvK?=
 =?us-ascii?Q?Rj4PIBnO9Y9ndWq1nUN+FHLnLgo+8yuV1FoTpIjaEZB47Dm/ZtYvIFZCTuZu?=
 =?us-ascii?Q?rJJFsd6VEyXEaJ6cMM8JxArq9hnj8G/oRsHzegs5IMp+c2RQfT0KYpdN9Rms?=
 =?us-ascii?Q?5sE0/tubV4YCFe1vONWyQkjbI8PrhCwUHVDPI0jDeH6fwdGQJytsg/FFZ3pJ?=
 =?us-ascii?Q?jnI3rkNhfzxsFLA3+/f5A2C3qsGewtFVEuassXL2uajJh8uQhtAoeszIJBz8?=
 =?us-ascii?Q?yy748qvgvdof9sl8DNtztSdNL+6nUe5BNlQyqzZdpnWKyZ29KjgfKPR5U4+Q?=
 =?us-ascii?Q?aJMpFmr6seepPMEJghryofQ8tYxYGW4YLJzTX/Wi5sFOIMiS65GqZvW5BLuw?=
 =?us-ascii?Q?CstxxOlDY4z/1yiZHihHEvAMRMoRgoQucKfNIDpE/4NQCzqf+owPBI/Dq/c7?=
 =?us-ascii?Q?pfYF+esE4pqTIDVcoi2LqSTT7FHGtXi/+8uQhKTmZ0beQzLHCFiY22zCkkQq?=
 =?us-ascii?Q?ufkoQyFrQvqyyP1KjwXGYVz8P+jbsOVwN8u6q/CWNcaAM7kw1hnhT0uoMfTh?=
 =?us-ascii?Q?K5Rg56LDC9Yfy5OaYdFSEP83WIgJZbkRH9xciALZkLLR+vEEuZlA90skVO5k?=
 =?us-ascii?Q?hY6OXA8Ny2FoGXUEbzwz76rIZMNdL45TGSFRlR8HrUuFWBGy2ijk+mNw1gs0?=
 =?us-ascii?Q?ylMWZ1vfa/V5u+2h6en1yXBl/9s8MeA/897Ni/kCM1lZRKeRvZl1BaZB14pl?=
 =?us-ascii?Q?7IyfolJYZZ/a6Tf73qy3lby8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345eda58-720c-45fe-77fc-08d97d4a2178
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:52:39.4079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vj4K+6sGN20/MMiVz58OtNVtGL9lIQkqSctqKotg6v90KSTCACwhAgNGEnLp1eQmUHnSQHishl0M9zU4bc3Fg1jr7yMJJooS1homCPARVRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3239
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109210130
X-Proofpoint-GUID: cwr38CGoqD9qZKoEnLwsSIP3SvO080b3
X-Proofpoint-ORIG-GUID: cwr38CGoqD9qZKoEnLwsSIP3SvO080b3
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
and checks against the kthreadd thread. This results in cgroups v2 not
working and the wrong RLIMITs being checked. This patch has us use the
kernel_copy_process function which will inherit its values/checks from the
thread that owns the device.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 68 ++++++++++++++++---------------------------
 drivers/vhost/vhost.h |  7 ++++-
 2 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c9a1f706989c..7a5142dcde1b 100644
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
 
@@ -603,27 +585,27 @@ static int vhost_worker_create(struct vhost_dev *dev)
 		return -ENOMEM;
 
 	dev->worker = worker;
-	worker->dev = dev;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
 
-	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	/*
+	 * vhost used to use the kthread API which ignores all signals by
+	 * default and the drivers expect this behavior. So we do not want to
+	 * ineherit the parent's signal handlers and set our worker to ignore
+	 * everything below.
+	 */
+	task = kernel_worker(vhost_worker, worker, NUMA_NO_NODE,
+			     CLONE_FS | CLONE_CLEAR_SIGHAND,
+			     KERN_WORKER_NO_FILES | KERN_WORKER_NO_SIGS);
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
