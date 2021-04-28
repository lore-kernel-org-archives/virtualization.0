Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3128C433ED
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7536143D
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7536143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34FCC4188C;
	Wed, 28 Apr 2021 22:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id svjRSxXa0MJE; Wed, 28 Apr 2021 22:37:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8661F41880;
	Wed, 28 Apr 2021 22:37:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AAB3C001C;
	Wed, 28 Apr 2021 22:37:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94270C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F2714187A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sOQyHdeb6NLw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FCDA41896
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:45 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTu5o177193;
 Wed, 28 Apr 2021 22:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=6RdXZzDfI51aViQHX4RFciXcJ5Dm2AppSkV7djmQESU=;
 b=gXzDgP/UWV7Rh0SFIohas3Q8lAtePvE7WxbWouwFNXa50+imLJqKfBiF9BAWfNWJ9HLq
 DDNWmqUvJepWzdbKpoQWFaYLKsk2wvGHFN9uG4bRtSvJLoc9BBI+EVlwqM7nTDjVMHRx
 CBagpsxEgzmEaOTTmG7MfUBFx7bvjx4XgwSWsi9yHQYDRcQwSLL+463r/t0p1EPFE9Qi
 Xn4dQG4jhm7jxOjdQVdGOdpnmmTp0sb9yUJaWIxOUl0vSNC8ySYVBNQASWLG526qpuMq
 muOghZCEIt/Q8lniuNYY0R5Znd5+p5q8nvKBFiXbHKvHuq3SwQdd/OWISmjr5inoNwY/ sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 385aeq2j3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTqGB184211;
 Wed, 28 Apr 2021 22:37:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
 by aserp3020.oracle.com with ESMTP id 384b59a4td-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbWBhd3CNnzS8hvIEhnH578oSprVrwfz18NV7TF0AYrVgfxBxYqhha5cqhEztVKLsjntwtVrLY4IfJG1hdAmCLqc2XUQhAQi5wY9aD24LMtd3nu5rhahcWK9bbs6E8eaJvZmFr9aN2MupcAszUmQiKp6L/F8AOl0SBPJ3WQGv+DZHDvZn5ZLzm4l1597WhmFqR6SRuvs5CXSaSOnPDVX6DdpxAZD2Hv097Z91EuIvL7GbrOVex7sNuBIJxy9kUUHJOxMcija2rZh5ow/IdL0mu5pdl17eJu+t8/yztzs44PqHdXMm21oX4ph9ridw3ctJ7cZgDCO0xhEis9ke7behA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RdXZzDfI51aViQHX4RFciXcJ5Dm2AppSkV7djmQESU=;
 b=aj+WP2SRiQlLA2ba6Q99fpXxkdEhksMLDImUG0uaKKeZ2yLrXuR95V78I8g4efWKMgxXRTxvr1Gig5WQTee4XvUF8XRzY9FyFpZZ1z2ZS2hK3RVN8L90WGzc4bTPPUeokBg/p9HXspInLh85zDLlpX/4q0snlbB22O4PiHNsTd4h10XI7eqq16Qt0aqT/qLSM/C4XPCN9K7eUcbWn2873RQ2dZ3k5GGprA19Qn7W3Uwo0v4ps+LkZaioO8B6aivYJMYWUTx2a+EobLO3sVAg7qVveP3g/L9IYvTyMw+Ij1AytqO/rrX4wlKzbxf/fGcoKkuAY+NX+gaZXsRLmJseTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RdXZzDfI51aViQHX4RFciXcJ5Dm2AppSkV7djmQESU=;
 b=wBjOD/IwmXnJK9eX/HbA480ZmdAAbU5PEpT9vNwCbk0k1yqRH2GG5zZj/G3FCRSNTZxnyljpYU9w6Bi5EEZjstRtlQg5XtOL9GTMv2NIj+9HRn+7wkQbcWbspp17IxFF5BptXNCeB97P/fEje0YOAjtnqFhg7goeXoO5/QnFCe8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB3701.namprd10.prod.outlook.com (2603:10b6:a03:125::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 22:37:41 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:41 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 14/14] vhost: allow userspace to query vq worker mappings
Date: Wed, 28 Apr 2021 17:37:14 -0500
Message-Id: <20210428223714.110486-16-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 724e56e7-e2c9-417e-ac0a-08d90a963bb0
X-MS-TrafficTypeDiagnostic: BYAPR10MB3701:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3701E87C17683171204F22E2F1409@BYAPR10MB3701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+msYZN9MThAnExC2AWb5La0XpkxQ405S7/oUED4+Nx+/FPW2qgWEyTPI3CQn6adqeC74vc3RIBOg11vWWWzNVNFmyds22W3CIgbajBcVtgm533I51rpGosGDFmJEVXD+DRKsZ/2mD8gw+HpuCZMTTr5L9pevCIR7mdjPmtqSH9wnh5fMIvHIsVuyJL4rzOOpQISI37EWXnyYsB/KXI+SKyI1nXzbl6CRIQMfIoVEJdJGUZSbpRZhD3dSpDrXwuhEJi++i0pK7vr7XkOCpr18R8mA6HbtzIPEnY9iyfPDBLYoHlkn1jB47HuArglOji2GGQtk6fTQ4wsPJH4I3GSyMkUUBsgZGaJJWLncBWnmQ9rAQsgYM2m+StbbdiOwJDUIjPy2q2DYf6OYAle6XwDVzpyfxRWlGkX8iJRW+5aXIaG2zIafr4Y8lkkqHExOgMVMc1pxe9pidOmWXL7Y2zWNzrxfMlPlaFrwol5A52KuiggoY8jIiRsjyCzZmw3wvcX+jyMnnz0zJfMfD92Hx2GGpgIrulj/K2zaKivCUbQc5ZCL6gZ17I/Elffoc4RX6cNOxprhPQzBgkRNVBAFb5nq9ok21imctfkOam8sqgNXJ2U0BNF4/poVroNZUiGezwgOroI+AFP+KFZq0aBBl8JfWTCDUcPKo22xNmkyZIT5HBbp6scGYp9pYyQqJQA4OW0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(366004)(39860400002)(396003)(346002)(2616005)(956004)(8936002)(1076003)(36756003)(6506007)(107886003)(4326008)(2906002)(38100700002)(6512007)(6486002)(86362001)(38350700002)(6666004)(5660300002)(8676002)(478600001)(186003)(66946007)(52116002)(66476007)(26005)(83380400001)(66556008)(16526019)(316002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?csV7BwZeVVl66jceyICG8IsXEPidRv1KUabloGQvSMEg8sfZFeWcs8YvQ/QU?=
 =?us-ascii?Q?oeYpmRAxNkY2EvcyS8lSFGfa+mI6NwjyjofDGOdIXO2BVd95hgP9FvOtYFOo?=
 =?us-ascii?Q?EluX1W/6VkhLZFO4YtNT4G/T1Jy7hNktceOXWkXMdWxT2UiAw8xyy/Z6L/DK?=
 =?us-ascii?Q?B9S2GiKZyM7Z5nSKruK+d7EEh0hp6Ss4uQQ1Eejsfe4BDAWb6IYWuDwFDdrD?=
 =?us-ascii?Q?d4u/zBQVzJ5aUpQIevsjFPUcbnTeQqHCDlIK5qQy2Zr2IJdO6Br/es3IL6Dc?=
 =?us-ascii?Q?wvpz/2IN3RpdvKa4qJukwpWD0AmiaRbMhBRBvVhGpUr1ljQ1bfLdBEv9R8Nc?=
 =?us-ascii?Q?8AogHPw7IA5Gj6nM2b0B8zTT70dejwCg7wuAATO1XP3dwqB1x3K71SDFAJMf?=
 =?us-ascii?Q?pxdLJnv1Zb4wQ9Vk51cu3dCCNoHu/Qq4s2vpdGRkXfSIDwY8hmx8w56UcNB4?=
 =?us-ascii?Q?aZ9CyED2TAnSobg0NdWcVOJzW5v1Fw/fJ9x0m/12jVoe/hpyyKz8BXoNS0eb?=
 =?us-ascii?Q?kI0U0HYJLz4DTaFbropAJ/b9tR5cf50v1H0twkUS867p20Y1dDKE/AqgQ9di?=
 =?us-ascii?Q?rBsgCk13i33hfy2SuGNJSDHnpY5QzZyRlUWPOfGb4sXMJ0V84zBDUoruCDjf?=
 =?us-ascii?Q?XmTWur/lmll1HHZZzmgqj3BWtFQ8MfIX4MfQVQHHt88EVVglHLq55mBD8rUq?=
 =?us-ascii?Q?ZpkAsHmgW3N/qe0xAuGwRaMtygrmPoqYIVBAcxO6/mSjuwq7FzK9OTlY9f6G?=
 =?us-ascii?Q?OdE/n8AdyKmbf2vAQz+LQPZtXyNptQ/rQ1bLF4wo4Q2Lwl3Th50QIltOhSDI?=
 =?us-ascii?Q?YdFWSw1Zx/zj7zKWQWgOThRsob66J6KtKpxK9LynX5yTvE5QxS+uoykYRdd9?=
 =?us-ascii?Q?iMzW58KgVZVmLcHoTLBnLobFQVRVuG1omLd0p7bRWNOonKfYBgeIt/yM8Fp/?=
 =?us-ascii?Q?IxZmAx90lTCIYDbUsjsr1IRxqllZRmiuJCb85UtkBzsIy8kMbC85JDoM0dGp?=
 =?us-ascii?Q?WxQHQPLrnZ3wveA4Y/J/6tKqGLXgUmyKB41EBr707tPZSwkVprjotOKE9sT1?=
 =?us-ascii?Q?IbNXobE5KyfrVKR9FenjGM2iK+DxVWjUC9fejmIKfrIVDeVBNYC/VqavjQhp?=
 =?us-ascii?Q?dgJ1ydZu0WtAZOPgixxRoeNErqkgWUl4/ra59LlQLHAVBWPNq9zhAJE3IBCn?=
 =?us-ascii?Q?h/R9k9SDoJQW5dqQUGzyhl3QXGdsEjD3lbO9pv3CxCzD4M9bXbmwQJphkLSq?=
 =?us-ascii?Q?/qnQQLZQRxjl3unmlFKdxHr9es8LZi7eVqt6R4Y0abHE6HIhCEN+i5qAiahu?=
 =?us-ascii?Q?N7e9AvAR+KZZRQz8j9ud94Sy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724e56e7-e2c9-417e-ac0a-08d90a963bb0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:41.5990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoZCUSLil/Uu9Rp2WI97+UP9vYNIvhufwvBuMRgtL2JEl5bsH2BQHrY1pU7kuZxB3DYTCx++NbdP9Z/6zCwZ1WcUK8g0YLMtB+j9bzX6ukU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3701
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-ORIG-GUID: YW6P75nx3MGoReomm4XCxN0pZ7CoXOhC
X-Proofpoint-GUID: YW6P75nx3MGoReomm4XCxN0pZ7CoXOhC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280144
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

Add an ioctl cmd to allow userspace to figure out the vq's worker.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c      | 10 ++++++++++
 include/uapi/linux/vhost.h |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b2d567a4cd53..e6148acbe928 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1885,6 +1885,16 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 		if (!r && copy_to_user(argp, &w, sizeof(w)))
 			r = -EFAULT;
 		break;
+	case VHOST_GET_VRING_WORKER:
+		w.index = idx;
+		w.pid = -1;
+
+		if (vq->worker)
+			w.pid = vq->worker->task->pid;
+
+		if (copy_to_user(argp, &w, sizeof(w)))
+			r = -EFAULT;
+		break;
 	default:
 		r = -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 61a57f5366ee..24569f89611b 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -75,7 +75,8 @@
  * worker will be created and bound to the vq.
  */
 #define VHOST_SET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x15, struct vhost_vring_worker)
-
+/* Return the vqs worker's pid. If no worker is set pid is -1 */
+#define VHOST_GET_VRING_WORKER _IOR(VHOST_VIRTIO, 0x16, struct vhost_vring_worker)
 
 /* The following ioctls use eventfd file descriptors to signal and poll
  * for events. */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
