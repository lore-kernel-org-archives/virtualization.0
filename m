Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A41FC43461
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170A76143E
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170A76143E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A006040662;
	Wed, 28 Apr 2021 22:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6rRIWo97xicN; Wed, 28 Apr 2021 22:37:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id E008A4066F;
	Wed, 28 Apr 2021 22:37:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03332C0029;
	Wed, 28 Apr 2021 22:37:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9793C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2CD8844D0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="EdqvIqDe";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Zlya/fAd"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o1I28JPUslg2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5619844CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:31 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTulb170148;
 Wed, 28 Apr 2021 22:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=X3NH2C7eaCTbzyQX+i7UcDUNsOPfClVbVbfb/NKqCgE=;
 b=EdqvIqDeCeK7eXCQP/l77cLyS4MqMGvFi1ndABYOwdwCgRRFXAh5VIB33YhqSocDimcX
 DSeyps1dvv21PC8q5oaOCpbcj/NnGM+FBJjBfM9/Gc1lecLdR+wVOty31Vq7RZL27H1u
 pNgDmoxDOjs2yiLq3TOVDqck1V/O9QHkl3rkoD/VQWpmtYb/2HqaJTAAgpUhca6bRx5H
 p/NS28WU6NRz4wDpa0kpQXguQMehik85+JZAFIlHjBT8b3SNcepUhWB0xE7rtwyVRSg+
 rteRC1NQofdHjGwWQpUeZZywIVb+llurXml1QvD5HKJLxf0gq5TI26REjGf2+q0+5fi4 Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 385aft2gwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTqJu184372;
 Wed, 28 Apr 2021 22:37:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by aserp3020.oracle.com with ESMTP id 384b59a4n8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6h+dxz6iGDHpKjLQWu8Uv+tukqq40NdWOOpp1IDWHbfL2V80oGv8AqYJnKhA2T26NY2f96dS37Xcq7kAEFD1m7zrmBv8ZdELC57kFYQ0M5SlUfDwj+2LSyvGtEmi9yk98TVa7U+U8XqysPEyis6cfBh83ZSStjIIkv8+FLGQlR03l+FzvJog/yYiCY+1Hcc3r8DV1NB1bQrtV0A0/CexMcEZqb7BoDlDPQRgt9hF5txyhEPCBKtu9OgLeaeZqrSQhtcLaWxz1lWbagbRu+1eNRtjOkAW2vaKSz6nug4nE17EDuiKe0R9HBvmvSKhCe18BKLgzPdHo7MnDu2LStWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3NH2C7eaCTbzyQX+i7UcDUNsOPfClVbVbfb/NKqCgE=;
 b=NCSJaw+tjLKwCYob6wwLhC/cBvK3g23UqeJGJBESkdF8aUB29WfGNG5KgHtFoW3pNbktyNAE8Sd5AH1Adm/PF8XrROMWxbnNs8mPYc6R+HgCTF1UuId5zMNxs0BtXztMxYiXy8pBlccaLMpGkaQvKEqUP6EAulS8KY/CNODKGvXWkcUiacBbuZqyV7Uf2FwsL7eSK9QTKdny9+7yrE5HcmOcZAxKk7pPpUyhxdfwh4puVkUntn6dQSasMl6P/LuuHeQD19YVTzXmUk+Qco1hTmqHXkfGo35fxtJPZgykmWf2BV7YYlADNIZjfFhYaui0g8FITXI6xqXQzkRzH4ZbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3NH2C7eaCTbzyQX+i7UcDUNsOPfClVbVbfb/NKqCgE=;
 b=Zlya/fAd9cjrwgrXI/VGppKvbEKluNdkzm4ipR/7kQBt0wF0EUv8GjMq6tizAu9vIaX9zERtDWBDyDNnMo9pd/ePezOwFfDrqnLf9YhM0bSm+CIl428gI2JU3XJLL/gLSgtc3Pw+hZ+Yp+30L3ybwuoO5hqB7gaSWHO9ipaxa2U=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 22:37:27 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:27 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 02/14] vhost-scsi: remove extra flushes
Date: Wed, 28 Apr 2021 17:37:02 -0500
Message-Id: <20210428223714.110486-4-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 025b2278-3925-4cf6-8f0a-08d90a963397
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB379418F2223B31C7BD47C9F8F1409@BY5PR10MB3794.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1k+R8IGW074JFU+9kJqdm49hRSe5SgtGSjRT3/zhjC0fHLoLSMHM4w9ZQLH3AcWNIGjOVb7Rg+4oJ9esjre3y61xRXIoAxx9UmU+E1pNYykyF9yYzt2I2a6h1kWzZ/bLlbmZIxdPnzVvV8SaS+uE0QZzUZH8YCxLg9FuLeEosvLSgL8ygkXet8QnFf9lc0IdBUzmtmSC/LP4yi8zhsWvV0wI2TKwbgPMX+L5iVIF4gYyezAycOcy5IFZKLD7HTIHoEzw92SUy2njjzuA3OZbN8/ygUicMV3HH8OvmeuN8cuF37Q5muf66xrIVciN3+7KA4AjoWfojfuo7XvrFMtBtjusEytavNl/v3ZR9wiNAr+gdlJk8L6POZY3JawAOFHEYtIHsy2QVB0TTsibB1W6h3/SXu1tD35vX161yOQW4qCpB240s5vKjmBTAkyrNCLO5pM8HqjlnD/NTtHU1NxHJARF81mFiJg3zTWss8HfyPph9FdA3t2HR0nmSVLw3OYyk0RE3l0xxErP2JDyIuXW9ngjMcPQ0MYSzlbhs3t+DjFMbb8Rj4Y411NoqciVmkmUzNI7W4wjXquRtTgS2c8XyGSe5UwZpisCHxk2LtFh1aPpUtFiLxgh0U3w87LKLj4Q24/Q/tlvWv4B4Crl7nhLHbaDPBbuxbutPq295aDccgRdt5Q6nEx82+0P6jzW8EY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(26005)(1076003)(186003)(16526019)(6666004)(107886003)(83380400001)(86362001)(6512007)(8936002)(316002)(36756003)(52116002)(6506007)(2906002)(6486002)(956004)(38100700002)(478600001)(66476007)(4326008)(2616005)(5660300002)(66946007)(38350700002)(8676002)(66556008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pxsj3H66DtV0uOPfqooHtbEjXJkcb7pawIdK//ONvNDLIqilYAP3MughPM8J?=
 =?us-ascii?Q?dpNHKBgq7EsuwoCwdqHQL2Bx4mQ7Smzq9BRsNitDrB6/f4TA0hSX9+53rTIT?=
 =?us-ascii?Q?WzYYajckTTWw6+6MsujdV4JrIjQ16wuqfUyte0DRUoYmWQRETJAt5EudBI22?=
 =?us-ascii?Q?mRcDFLy3dRNCr9UwIqJ2/dl4hIF9/kjOi9ksC2C5hyC1Fpdt/A5VmfslE5Su?=
 =?us-ascii?Q?yW6BzOv/XRVHZoWy24WrJmbzH6F4k5vKuYSN6PBxeHqs9HGzeXwIVN9GQs4Q?=
 =?us-ascii?Q?XJPvNplCjGnwvYKcU7XSsXBcQCXhyMFmD6+enakL6Bpc3vmPLS6mek8OTpyx?=
 =?us-ascii?Q?uV+v+aRaOP9FUUWIRLQrgb4oKXZP0wvj01cz8BRv7DNg4E2GkmycAC8NcAoN?=
 =?us-ascii?Q?ASV7K6rsS+cD860cQFbUAysZBofDe8qHzxPf92GyHBYeqoDrrNzgHx6h8uk/?=
 =?us-ascii?Q?kVpqqNcC7fwa8kTnrX7YJQObEBIM3B6CMj7pysP06ubJMuIRMcQTkZrGebM4?=
 =?us-ascii?Q?xhe/yh+3wMjJe1mX3rzjFl+XqHmwO46IGCePDIdkfJEOB3MRRU+KkimRhcg9?=
 =?us-ascii?Q?IJ8AKUTQBwAB64wNjQoRm9/TBULYBjNRHcBnPi7oFTH718Ph3kPbPVqyAiHO?=
 =?us-ascii?Q?sxzrlosGCclPKkMmoDLUPBljXksApM5kOoPPY85JZ3Wmv+hA0NVje1lll6VX?=
 =?us-ascii?Q?S6Y6qyR37gOPDU5VDO5/9Q8w9hNYj4NQ909J+8/adHx5E/lQiiZXnTEmBfTB?=
 =?us-ascii?Q?xJ+/t+z72xRYLkTnRPwSU+YnvSVNI9xc6aEVT4YUuqfbj8xSLUvRHfnyCaMr?=
 =?us-ascii?Q?zhvgxGEbSteBMu+3sK5F8j7zmNmdvgCHUXgjl9ccZAmZtJe/Vw0YaksAZC9w?=
 =?us-ascii?Q?9vFq4mr0JKbHTed1BCoBaFB6hD2USFA+2ExNRJbgUHl8+GneBKWGrvGpXfBz?=
 =?us-ascii?Q?VP8woXNA6Idc7AD0psc/jf1pu0VxuM1Tm/74joZ63LVgBX4m88Sv0ClL/kff?=
 =?us-ascii?Q?wBfq4kbqhtepm5JZph9oJOUvouC9ORlv3t2SVCGqtfb8QSiEgqMfwe3VtTAo?=
 =?us-ascii?Q?z3/6A5EO9CdnqOAuHq6wbJTzCd6FHWq3y2PgiuqJCdKqh91zmcobQDUELqD/?=
 =?us-ascii?Q?9/58Fj8vlgiA+ci+wMuGH763hA4d9GmIN2uV3GkDWWKFHCX+bS3eCh6nifqr?=
 =?us-ascii?Q?vvJUGO/uDBnP25JLsS0Z7xGV6wYe7uhTJBAua9JdL3+9WJtV/12b3tOX9+G9?=
 =?us-ascii?Q?fokJVzuMwWVE9yeSmMXt9Ik2wo2iPTe11YkFsip/ezeSPNbsgzfGaSk10kaE?=
 =?us-ascii?Q?ybs1w6/EUbvbQ8aA6Boc3PL6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025b2278-3925-4cf6-8f0a-08d90a963397
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:27.8017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjoTqvYBU6XaUn9FYYNqVpzv2FUpFMFxR8hRu3ot65EufHtqBHp56EBqpnb1sDINlxdpndrYP4dJ6WqYm3APz+Nybbp7uhO0vARtaUvZrak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3794
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-GUID: uP8aLxjQfCfa0LEunvZ0Bkhjd3advRUI
X-Proofpoint-ORIG-GUID: uP8aLxjQfCfa0LEunvZ0Bkhjd3advRUI
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The vhost work flush function was flushing the entire work queue, so
there is no need for the double vhost_work_dev_flush calls in
vhost_scsi_flush.

And we do not need to call vhost_poll_flush for each poller because
that call also ends up flushing the same work queue thread the
vhost_work_dev_flush call flushed.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/scsi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 0fd596da1834..b3e6fe9b1767 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1430,11 +1430,6 @@ static void vhost_scsi_handle_kick(struct vhost_work *work)
 	vhost_scsi_handle_vq(vs, vq);
 }
 
-static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
-{
-	vhost_poll_flush(&vs->vqs[index].vq.poll);
-}
-
 /* Callers must hold dev mutex */
 static void vhost_scsi_flush(struct vhost_scsi *vs)
 {
@@ -1453,9 +1448,6 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 		kref_put(&old_inflight[i]->kref, vhost_scsi_done_inflight);
 
 	/* Flush both the vhost poll and vhost work */
-	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
-		vhost_scsi_flush_vq(vs, i);
-	vhost_work_dev_flush(&vs->dev);
 	vhost_work_dev_flush(&vs->dev);
 
 	/* Wait for all reqs issued before the flush to be finished */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
