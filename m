Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A46C43461
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C078E6143A
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C078E6143A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C001406BC;
	Wed, 28 Apr 2021 22:37:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DEomwrRmZvYo; Wed, 28 Apr 2021 22:37:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 636A1406AD;
	Wed, 28 Apr 2021 22:37:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7892CC0029;
	Wed, 28 Apr 2021 22:37:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E6B2C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64D294188F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ENb7uaLb";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="n6uU+3wU"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ifexiUnwRYze
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 298404187D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMUvFW127251;
 Wed, 28 Apr 2021 22:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=K/SonrcY6Jrs80X/MtGS0T97carR/dhc5QzdfWgBC4Y=;
 b=ENb7uaLb3wJ0jTecc29nfet+7WkTq5Js8PUQ0is1XhEmX1HDjFbs44FDCLS+bThh2Qp9
 lI3TyRDTmD75JJFVvHgKkkZM2CUZNz+yZtnphJeJFZy9xM6ImTHIU5eeQgl4LI6JGCd8
 gt+HToFUUNb0A1LZaloQllofYRqPwoQVimPk5LVJvwXT9m0xZbgeEwJ3iMvDurjZDuOH
 ex0eiOqkVdxfBwEFqYdB+vmh/ye2B2m/jIYOol+SwRmAw8p+eOloJECgHwpwmDfgWDzn
 zKE75N09wQmgBXx2t2t4nq7BXVLGLLS9zZ8hyncYvi8yQ6CUUXd0t7TzpuEuis99pSLP fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 385afq2k4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMUmEB043084;
 Wed, 28 Apr 2021 22:37:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by aserp3030.oracle.com with ESMTP id 3874d2pbek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/SqpTrrliCMS8hQOuDBXdfqATNTQvDpD3uz0hc3wRWUSUCiwVCB2qB/nNGXRSk2dlXixiuENrBfTUGwmXSxQwxqRSUYJAVOmYlv2OpQY6RixXXNg8eb26z+b6Y7N6U33g/0cpmCVkRXk3AgMIqOFuOMNlcFrQ9PQR7ff8sR9KQvCp8Al/FyyfaCilNlopwL7h0XwuHEPWbIl1QcDIs9et3KmyfQajji6JquOVIQTYUFNhOynaQs/ks5V52f77VhYNxJIDHERW1Hyu+7bRaLzp01tw2fwvTnUgP6Swl5PIrMvl9d6X3JjC2EniDzDiKk197Z+4kymlY3ayUWgfjgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/SonrcY6Jrs80X/MtGS0T97carR/dhc5QzdfWgBC4Y=;
 b=mJU1NljLefG3cGLJK01tsbpQEs5ylVveUcffHPp5m3kCq59Bblh9clHYPoSxJeeclfY9F3aCu73aNvfOlR1OmPjHTODp61m4s/QMYR6XrO7wTxH0siDP0KlK8FCckEDK+NdacTgoUrimqQrKR4/ku5E/BRLvOCUjYm/2BwKWHw3L/f0813pImzdfeRx2A9b7UEJOq8Z//X4r7Wo7Hdrr7F+8JaqO+KKoHX3tOHIJeZDL5MERs0B8b6HFBd9bztEa8BzFEwAdXhJMOAa861GinyUl/JMjiiT65mOUp+padRKkaLdrRLIWCeTL7o7rlU6SRmx859jqDgSErgpV0dvD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/SonrcY6Jrs80X/MtGS0T97carR/dhc5QzdfWgBC4Y=;
 b=n6uU+3wUlGEErMmZQH27cMpijyPjD2RGGpa3c9X/Cwt7W3nb1IwuGNrGIviOM8dlGKpHNJQyTj2n+WRmejx8pwtrJ0rguw5i0f79C5cCJn0K0NbDVq8BF+j7cVl665rs5q/MC8KyI00VGvaqpbkN2Zz6D/wOQOb34F/k5Nnhp7k=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 22:37:37 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:37 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 10/14] vhost-scsi: make SCSI cmd completion per vq
Date: Wed, 28 Apr 2021 17:37:10 -0500
Message-Id: <20210428223714.110486-12-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428223714.110486-1-michael.christie@oracle.com>
References: <20210428223714.110486-1-michael.christie@oracle.com>
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR1101CA0019.namprd11.prod.outlook.com
 (2603:10b6:4:4c::29) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR1101CA0019.namprd11.prod.outlook.com (2603:10b6:4:4c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fd21527-b16c-4890-bd09-08d90a963934
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3794FB16C08E155F32BF5409F1409@BY5PR10MB3794.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErKRPnA1t3iv7CmqNM5hMWyWDVptBzLSbBZbcb+4i4W3qL9rU40Y5wt+S4f8oq1skqeKY6lUZVHMZHwo8Z4YyQFOPj6IDtKdeqN26sSQGIe9t6fFlxIr++nJ8IPXimunnGnSnK41ewLi7ki2LuIN9XRtYYFJuSC7m1s2um3q5D3VbMUaz76NFr5lNMU/X3WYPIJPuEgC7DtJbAXWNVsatcE2yEcr9X3IFj6CcX04HWMS/qp9toxKzUbLi519uMsh/oEed1ff5r5HSqhcCEWLqsuufomvdW/wOrcpghdmuCQDRZil0Q160336XuheHZkFgeHXWtqTnyuRAk3A6Gfc1PveN3B8xyDwJcP9619+Vap6NUAKyMh3NGtRrfssJzPhNbHi0gYdSjIwsqpe+1R5ZYIyZFwEvIe6tFAsqJ0g0E1UB9PeNIrPoaPKbl7ussHu+bgZLhRS/U9ObeRsvj0XCRH8jcXhIJhn1GzNjKQ2wtPIbvDE4wGogV4RYiuUXdt47uZ31zugHWqn9F2VHuwyLk5EIwafYj2puUXnLA65siLkcpz/U12sdw5BtYXf53drQkMkWjDkKtLf8+jGm+iU3Ze9djvem0RiUoYrHYCmQlO3wlPDelv6yJmWeeqQ+0RjOqOgt9XxTDIEt2/OH/OI06Tkr/vdnDnCr3mVlPr7MSaiih95bsffGyadaES9LwZe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(26005)(1076003)(186003)(16526019)(6666004)(107886003)(83380400001)(86362001)(6512007)(8936002)(316002)(36756003)(52116002)(6506007)(2906002)(6486002)(956004)(38100700002)(478600001)(66476007)(4326008)(2616005)(5660300002)(66946007)(38350700002)(8676002)(66556008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JN6xbDsdcJLYeMEjL8Xese7oov/C0ZWnIkPaYpYPe7YVOK0/QAfRlUgLdmX9?=
 =?us-ascii?Q?S2M2NhzOG+zwb62FbAQP9CubnEQ++7ZaBhV/FHBNSRQaTjg+WnqGOCZtdDbk?=
 =?us-ascii?Q?1fDsI2KMcDInp/8UKvl+D7JTfWCo3w740kSDnR/KO8vP/H0+VexbrDYt9nxb?=
 =?us-ascii?Q?WoyBzJptcBw47s7UaHl6os59c2vEmJ0sIDcV8ApiRDcHmxqe4VMG/XEdbFER?=
 =?us-ascii?Q?WjYFnBMj7LwYY8/a3W+DBtz3Wn/7A+TUbP4sQgjcDXvStEsog8GjcEe8fo8l?=
 =?us-ascii?Q?TCrwjh4vNwBDP3NN17IQKoihpV8yELBbMi/EJgLhpDVHPIVEBxVRRmlk7W96?=
 =?us-ascii?Q?0BHLjNhq6ZwOCRc3mDmJJlg4xvC7rTaA7DnmXGWIVVH7IG3wX9REZ9YMsD35?=
 =?us-ascii?Q?uRnnrM1n9nZN9SvMiGcKQIebqhB8eGA/S8S6YtFhKsKrljh8HLfMSsjuAgZZ?=
 =?us-ascii?Q?1vXWvrmXIwOy+J6DsvzBCmnctz9GruU4VjqbvphUd9lchR7+ZprYUb0rZNiy?=
 =?us-ascii?Q?yf/IUzXnxhTyUWBU2mcJmQHnvvWWRSCTS7nC6NohrH+Wxd947KPP7ALwIU6W?=
 =?us-ascii?Q?uCtqG/fAjxLECio44VlxFkkBmHlswPW2SuXkT60yPPt4pU2JVZ/tvkAigJIs?=
 =?us-ascii?Q?F2oReUlubJzoIPu84BBIRBL3gQpid3l+IS/PbzgQ/Uy5I3OXcgXI2gwJ1EPK?=
 =?us-ascii?Q?gGPmqSzq2CHaiBbDQdPAjbV/cp0T+ambahgxmzrolYBP1TD6uMRTqBYAbCrg?=
 =?us-ascii?Q?FJzLjMacLO0bsacdvV6Ow6p7y7kLKNGUstnjwsEAymtY1xwjVxLG3EJLRdY8?=
 =?us-ascii?Q?Aa41iC2De/WO9RIRiY/8flq2Pdk6w1crf7JWROre15fj5X/0wWMkdjaa/lgH?=
 =?us-ascii?Q?Ch+/HUkpjv0HAGMToxt+zeSnipVzaL4Y62fwLNhNk9DkzsitqVdzumWyGokc?=
 =?us-ascii?Q?KAmVJRDKd9cJBMstfM0O7QAAoCFsvD8N42FaAlYXiZHNeq58lz+avAU3b5uN?=
 =?us-ascii?Q?AN8s7GNfgpym2+EjE5sgkvFOm+ovTnUQgFYhKaya4y9o6BHjQ/qEDEnfmzEe?=
 =?us-ascii?Q?zyvkwkAXDDQoW0hrisqSz7nfBPqykV/mwIrAz+rAl4jqAO/4XDLtwADdZQpl?=
 =?us-ascii?Q?99mZ/CqDlM45Iq82/VCq1PFDQ5dtGZ+E13ItUeLHaEdqUvNBFYzdjgEPHKyp?=
 =?us-ascii?Q?vgYImuGXfvdSovwdF3VedsAR29GR8bt46XRyGnoKQMVADLEyfwpIHur+luF6?=
 =?us-ascii?Q?T1Kl8zSlC1liBdmDYwEL30sLugaybbc52AwmFrN8O++hBvw4xmwtveHgYYbL?=
 =?us-ascii?Q?NMppZCGYrlT8CrfJrHzNRd48?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd21527-b16c-4890-bd09-08d90a963934
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:37.2614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vc4aDV40oot9047getMO/yeUuUaqCzYzqfvX0ecvrvxDzK5Lax46EqmkMbVRcYqZ1VtI8Pat2u2N4yhNqRqIFVlgsYh+Vqt723a2FQ/vyf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3794
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-ORIG-GUID: Ev9J3FKm2aGuVT6ej3hu3Wua9jF8IKiE
X-Proofpoint-GUID: Ev9J3FKm2aGuVT6ej3hu3Wua9jF8IKiE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
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

This patch separates the scsi cmd completion code paths so we can complete
cmds based on their vq instead of having all cmds complete on the same
worker/CPU. This will be useful with the next patch that allows us to
create mulitple worker threads and bind them to different vqs, so we can
have completions running on different threads/CPUs.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 48 +++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 96462032a972..2f84cf602ab3 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -176,6 +176,7 @@ enum {
 
 struct vhost_scsi_virtqueue {
 	struct vhost_virtqueue vq;
+	struct vhost_scsi *vs;
 	/*
 	 * Reference counting for inflight reqs, used for flush operation. At
 	 * each time, one reference tracks new commands submitted, while we
@@ -190,6 +191,9 @@ struct vhost_scsi_virtqueue {
 	struct vhost_scsi_cmd *scsi_cmds;
 	struct sbitmap scsi_tags;
 	int max_cmds;
+
+	struct vhost_work completion_work;
+	struct llist_head completion_list;
 };
 
 struct vhost_scsi {
@@ -200,9 +204,6 @@ struct vhost_scsi {
 	struct vhost_dev dev;
 	struct vhost_scsi_virtqueue vqs[VHOST_SCSI_MAX_VQ];
 
-	struct vhost_work vs_completion_work; /* cmd completion work item */
-	struct llist_head vs_completion_list; /* cmd completion queue */
-
 	struct vhost_work vs_event_work; /* evt injection work item */
 	struct llist_head vs_event_list; /* evt injection queue */
 
@@ -377,10 +378,11 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 	} else {
 		struct vhost_scsi_cmd *cmd = container_of(se_cmd,
 					struct vhost_scsi_cmd, tvc_se_cmd);
-		struct vhost_scsi *vs = cmd->tvc_vhost;
+		struct vhost_scsi_virtqueue *svq =  container_of(cmd->tvc_vq,
+					struct vhost_scsi_virtqueue, vq);
 
-		llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
-		vhost_work_queue(&vs->dev, &vs->vs_completion_work);
+		llist_add(&cmd->tvc_completion_list, &svq->completion_list);
+		vhost_vq_work_queue(&svq->vq, &svq->completion_work);
 	}
 }
 
@@ -543,18 +545,17 @@ static void vhost_scsi_evt_work(struct vhost_work *work)
  */
 static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 {
-	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
-					vs_completion_work);
-	DECLARE_BITMAP(signal, VHOST_SCSI_MAX_VQ);
+	struct vhost_scsi_virtqueue *svq = container_of(work,
+				struct vhost_scsi_virtqueue, completion_work);
 	struct virtio_scsi_cmd_resp v_rsp;
 	struct vhost_scsi_cmd *cmd, *t;
 	struct llist_node *llnode;
 	struct se_cmd *se_cmd;
 	struct iov_iter iov_iter;
-	int ret, vq;
+	bool signal = false;
+	int ret;
 
-	bitmap_zero(signal, VHOST_SCSI_MAX_VQ);
-	llnode = llist_del_all(&vs->vs_completion_list);
+	llnode = llist_del_all(&svq->completion_list);
 	llist_for_each_entry_safe(cmd, t, llnode, tvc_completion_list) {
 		se_cmd = &cmd->tvc_se_cmd;
 
@@ -574,21 +575,16 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 			      cmd->tvc_in_iovs, sizeof(v_rsp));
 		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
 		if (likely(ret == sizeof(v_rsp))) {
-			struct vhost_scsi_virtqueue *q;
+			signal = true;
 			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
-			q = container_of(cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
-			vq = q - vs->vqs;
-			__set_bit(vq, signal);
 		} else
 			pr_err("Faulted on virtio_scsi_cmd_resp\n");
 
 		vhost_scsi_release_cmd_res(se_cmd);
 	}
 
-	vq = -1;
-	while ((vq = find_next_bit(signal, VHOST_SCSI_MAX_VQ, vq + 1))
-		< VHOST_SCSI_MAX_VQ)
-		vhost_signal(&vs->dev, &vs->vqs[vq].vq);
+	if (signal)
+		vhost_signal(&svq->vs->dev, &svq->vq);
 }
 
 static struct vhost_scsi_cmd *
@@ -1799,6 +1795,7 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 
 static int vhost_scsi_open(struct inode *inode, struct file *f)
 {
+	struct vhost_scsi_virtqueue *svq;
 	struct vhost_scsi *vs;
 	struct vhost_virtqueue **vqs;
 	int r = -ENOMEM, i;
@@ -1811,7 +1808,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	if (!vqs)
 		goto err_vqs;
 
-	vhost_work_init(&vs->vs_completion_work, vhost_scsi_complete_cmd_work);
 	vhost_work_init(&vs->vs_event_work, vhost_scsi_evt_work);
 
 	vs->vs_events_nr = 0;
@@ -1822,8 +1818,14 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	vs->vqs[VHOST_SCSI_VQ_CTL].vq.handle_kick = vhost_scsi_ctl_handle_kick;
 	vs->vqs[VHOST_SCSI_VQ_EVT].vq.handle_kick = vhost_scsi_evt_handle_kick;
 	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++) {
-		vqs[i] = &vs->vqs[i].vq;
-		vs->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
+		svq = &vs->vqs[i];
+
+		vqs[i] = &svq->vq;
+		svq->vs = vs;
+		init_llist_head(&svq->completion_list);
+		vhost_work_init(&svq->completion_work,
+				vhost_scsi_complete_cmd_work);
+		svq->vq.handle_kick = vhost_scsi_handle_kick;
 	}
 	vhost_dev_init(&vs->dev, vqs, VHOST_SCSI_MAX_VQ, UIO_MAXIOV,
 		       VHOST_SCSI_WEIGHT, 0, true, NULL);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
