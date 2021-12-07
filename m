Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22557C4332F
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 02:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A374C40541;
	Tue,  7 Dec 2021 02:51:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XtZlA4GHB8gE; Tue,  7 Dec 2021 02:51:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2BF7C4018A;
	Tue,  7 Dec 2021 02:51:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5403AC0077;
	Tue,  7 Dec 2021 02:51:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CB2CC0072
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 022AE81751
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="VEX943fT";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="kaZGlAEV"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rs3Q6u7CPJcr
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:51:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3448880EF9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:51:32 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M56v4019273; 
 Tue, 7 Dec 2021 02:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=TvoMJoiphXhAX84Y0IH80GMqhjqUhR7mOvEu4dNx8K0=;
 b=VEX943fT/ZBaFSKA/hJ449awj4z9ftmIUh4MSQxJ03F0eALoj/cIcb7yrI727pybXP9q
 OUng/F3m57TbYzWS6A85OUluHLWxYg/+Muh775s7jsvVBrs7KBfyE6/swOqRiHQCkFE+
 2BlLMPStpBRbdc9Neo9SJrAygJH1WDLdubGweyBv8+nyvpG7tYyF3DUZnNZ2TgwuKw9s
 4y0FH779oLdtnhmCd8PSE5xyZ+/5PCNARGppElqy0jVWQRBxi/dN1LwHh8y4jwb0OA0e
 3GV4D++ZEvxusnUeG4SW7gqOEYnXYcpyf9zX8NwNd3fTVM8Bj+92wPdHwux9oT1uC8tc kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqmefa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:51:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B72kgla153019;
 Tue, 7 Dec 2021 02:51:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by userp3020.oracle.com with ESMTP id 3cr1sn5w2j-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVZnUvUfe9na/hfr6nOxO96vR60Nh9iWkD8tJaqbJA5XmBgg0z04o1XMX48RaFCCbnCYrh66+eBNpqbXHur32737RvdxtDPEhGybF5f4kyTTLuslRj4u4b5C3HLZIeYXZy8YUfEkxvqOdxK3W7DqZyALAX1zB9zcYUlTSt4ok/en5rKdkiiLY/93r5amUHnJnzsAQ7DFwznzpfdRowvL9EluSxcBmJlpc8FETNkhmKBsQN4DiSKPWi02YeihClIfUaXDw9HD4ZyjzemP9UEVQSM9xUm4Pld1BEXG4eQt1N5jcUUvM+jjec545cWxifdVt3GzUc21MycZt9IOnVEw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvoMJoiphXhAX84Y0IH80GMqhjqUhR7mOvEu4dNx8K0=;
 b=nCK3rUkllVIoc4V7xu0NiczLDENEiOV+e78QpfLkjerq3lq/Q10axU4bADvGsTmb0b/PmYUxAMb/rk5T/8nXP7PLRH2DaOIBtC7DDkrKOmGsVpX7N626vUijXT6wFycsPlJsR3iY+To7njNokcWpDLlVp+W1Fl4SVsnB/mmQQxgSkdeMD0oQ413SuFeiWQ3Bm8JUYchI1PYxY3Yi0hZIqay/Zj/zzVR859xFFojwkBDf82BMADgF8Bh0QR8Twb64CwyB8LKRCAfjBiOSgJlwjck34WsH9+YDiZ1A8Bg8lnnTACuEdqzg3k7k6mBMygEEB5a5XAOPTgZvifLdbEwQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvoMJoiphXhAX84Y0IH80GMqhjqUhR7mOvEu4dNx8K0=;
 b=kaZGlAEV5iAl/JLp8PFI0jrlMCKi98D94sdRaSkT4cHAD0EsLNdlwlxKc06Q0gu+480fPV0C4J0Hdp3dcrX0Qj+ZDmbzY6BU16EG/GAKgmzb1qIqQqGUKhgxKlqFJx1rpifs9e3U4x9jJvQkxoBa3qdhP6E0CHHQLO3zS5jicCw=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 02:51:28 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:51:27 +0000
From: Mike Christie <michael.christie@oracle.com>
To: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH V5 05/12] vhost: convert poll work to be vq based
Date: Mon,  6 Dec 2021 20:51:10 -0600
Message-Id: <20211207025117.23551-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207025117.23551-1-michael.christie@oracle.com>
References: <20211207025117.23551-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::20)
 To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DS7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14 via Frontend Transport; Tue, 7 Dec 2021 02:51:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f241fe70-d75e-4f15-3e7a-08d9b92c76fe
X-MS-TrafficTypeDiagnostic: DM6PR10MB4347:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4347C7F92278122D7A776107F16E9@DM6PR10MB4347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDRyKnV4+cSBlCB5h4no5Zqy4n0TVZeooGOriiiLXCL0zkVv49Lr1DFMfKa1ZEwMSyEq+RKyY4bGMbvHjDxO4qQ5am9zqd/m0NXqnEUjgoYYoYPGQsp1RkhjvfozuHE1UJ7YD2Wemwspaua/ppYVipQE69CuLpRC9mBZGv4WWc33h58uNjnlkYljv2rxJlmw+V2xEWhg/tZhWZGmWv2t1SFE4aP/NpPx0VADSbKDTwUo4tUiGGbOLTkk3CvvlORGL7OdC4aWdJXUiVg7zMXqDQ5K0wpMSH9WBXaMlw3/zPyo9Pu5d5Pt8stqiia0Mrylh3id3eZ6X+e68Ssed09g9srPC/WHEdwYL0xEZQT6w5U1OUgr/ugX/NHZsJIaqN2PAuwrCi3isnqWIBEr4O7qbfJucfbRpjWZ7+q5ErU1LpMuFwRSa7mfk/ASRjjDTlj8WrR7O6rrO+ZApZhRrDJIjixk67t7IxUsnyIqteijJZmBvdNpwlT3veE0524TBE5s4HP8I1TuEQrRf8j0qy13DhQDMKhEmDJfTaNEUmsukTz5IhBkGQTsahg08pE4ilygTWQonLwoJPTnjmsUiIJU6LUL03D3YX75/7TgntEB2mMxPs8GS3hUEixqfiKIhDoT1OTmEBsbeOVAGSWvphW+AJ+PsvAUcwxtQwtBpC0xav2nSxbW3CN/4dnce0/E+ElZRuO78moLQrS1+SNp6Z7vsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(52116002)(6486002)(956004)(107886003)(83380400001)(4326008)(5660300002)(1076003)(2616005)(508600001)(2906002)(6512007)(86362001)(66946007)(8936002)(6506007)(316002)(36756003)(8676002)(26005)(186003)(66476007)(66556008)(6666004)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FA0QWYRZNT2+kowBHx/PuCwrnAidII7dGMpmUOCL8qMFB07jsPwL77RCoGyb?=
 =?us-ascii?Q?OMBAV2yM2bBnRzXSPV+mtSYDm2zjzqitQ6B2ryh9bLDOK16FS/58LDmsLzF4?=
 =?us-ascii?Q?UDI2LW0KvQN5SGdWnJVCEylDcmn/bRQ3mVATRyJ4ltanegBABkBCrRi/NWt7?=
 =?us-ascii?Q?zcRraS6mC4FF6zmHtfoJBQSTKMN4SOH42w4COgELnspb9fOqRSgbHFQMVhZ9?=
 =?us-ascii?Q?4QS0DYQiPKHCoaQP8jfItfHO70nIZJsl72ZXpP21ykItSiihSmAfYCjVYKtm?=
 =?us-ascii?Q?y5iFeLVaQDi75Q1vhTyeDvxhcwU6Y45gUQ66ItZ6xiGNqcE3vloPgh4ht98+?=
 =?us-ascii?Q?CfjqrF2YHnvhJFHAWIaJLlEh5pTkQMIJICWEhIwTFCMaFVyFiey70X9m11Tx?=
 =?us-ascii?Q?0PXYYgwBQmRgRnTOEx6t2jkxk2Bm3+V72IK0SHgoZHwukMsxzDlf2hg1AEPk?=
 =?us-ascii?Q?KBIKm55hN4qGLPnf5QVeATOYaHI4psGdiRuyxupdOFguXnxbpPQf3x00kowf?=
 =?us-ascii?Q?UGE2uv89XF7G36+yDDJ0KmCaJBxAiyRSkYcjYaTmAM1sFMpQhZSgiANJHc79?=
 =?us-ascii?Q?0e6CKJOWa060nZpJFF4WxGWG0RheFoNADeRB/wMDzgcSZjoGQvrbYkDADCs7?=
 =?us-ascii?Q?9lXTRYAqXx66Z9TZ/0DdEuPpL6MABadR/jGJwOlMFkVDKN6nGIL2VawMNTDD?=
 =?us-ascii?Q?7nfoW4W5h1+DI3q1cr5JY0RRJ35pQn02my2v5V+X5n61ZHMy2V3NjYoK673c?=
 =?us-ascii?Q?SSNV8S9qFtKBYgXQ+cW9CudSuBk5Zr78nwJLzENM8jDzbYLDZYDkxOXmzGFH?=
 =?us-ascii?Q?AIAC1N7y/WMoLhPN+hMkrrfSzsqDZbsgmD1zjLeiqNiJ9kdmr2Cep6dGUd7C?=
 =?us-ascii?Q?IdHQ1Z3ytdZdh/2+VWXrNnu8eYLnG+9L+k9B8sLo6RAgmOPTzCl6I4sYVTou?=
 =?us-ascii?Q?0kg95OjZ+KFcIrC66P8U114nWA3MOuc2s6OZdaGW8X/H0PL3Xw6B19Kw4/Pd?=
 =?us-ascii?Q?ZiIInwtcu3JqU69uijRmNIJ3k3XRBzp4yH+Yeqq2MkFYpPpK3zpS+/53ECPT?=
 =?us-ascii?Q?AJTX4u5WTBao8oC5WBmmd75AL59ZVMgXxsMLeWGHxP47JzztlSrwR841NBWc?=
 =?us-ascii?Q?aJKMk4zpR3e1wZSRQ5B7oP9zS5cJYI88I4PFrgtdMQFU6VmhBnqYET1pDOY4?=
 =?us-ascii?Q?6yXHHxe7yz5elMjY2M3ZgGlOuXZ9CW98e6sEGkT5eCNkcfHqZ1VLJ8jxkEgE?=
 =?us-ascii?Q?QZDnJaFAfiRI17O7zjPgMi9e3xA+ehYjdRtrYPEp6lREuicLU62FgFpx2HVD?=
 =?us-ascii?Q?ifDarpcWmTC5kHgbEG1DdjPn33Mhhud5kE5MmDSls/wZAhTc0ZK8LexssHqs?=
 =?us-ascii?Q?yXQMytS+sp5U/5aXWbwcMrK/5qFk2E1VY/7KAUivkqoRLe6FOoNFlFhyok5h?=
 =?us-ascii?Q?IBzCFZGG8aJG0YJOpMJK8tRwBJBTsiSXLnd5zXph9oKKHjTqCmPYB7g8qMQ2?=
 =?us-ascii?Q?MImxWFOZzizXtTq9WkbCt8zbDc8x1W5SIOmDR0vUEif2HsZ4cWmBbdhP71wp?=
 =?us-ascii?Q?FSVVWNQT6iMj5tYAL7MLIb4BUu2QhAJxjsZCOIo3Cl+MIIopU+AUJh0u64l5?=
 =?us-ascii?Q?HIY6tRAkfViQ43DzLbnmx6QnmKSFzxkoA9UITfdkSFBnpxP8+GDAtr8KL2cF?=
 =?us-ascii?Q?HDAaOQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f241fe70-d75e-4f15-3e7a-08d9b92c76fe
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:51:27.7938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+iaXx/BHCxJyjAVcMPyjjLoNVqer88mdsoE4EIdmIshA+u/pT7XF5Fw2a4SePJng1kHJ7tEWxicUHj1AuQ3ZcYoPjnSExJ1iXChxeqCWLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070016
X-Proofpoint-GUID: MFfM8a35uiWFJpnPmCoYPR7KTUQjrDbk
X-Proofpoint-ORIG-GUID: MFfM8a35uiWFJpnPmCoYPR7KTUQjrDbk
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

This has the drivers pass in their poll to vq mapping and then converts
the core poll code to use the vq based helpers.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c   | 6 ++++--
 drivers/vhost/vhost.c | 8 +++++---
 drivers/vhost/vhost.h | 4 +++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f225cb9dcb10..6e2b1670ae51 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1339,8 +1339,10 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 		       VHOST_NET_PKT_WEIGHT, VHOST_NET_WEIGHT, true,
 		       NULL);
 
-	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
-	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
+	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev,
+			vqs[VHOST_NET_VQ_TX]);
+	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev,
+			vqs[VHOST_NET_VQ_RX]);
 
 	f->private_data = n;
 	n->page_frag.page = NULL;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e5f5acc7e648..e9f78f0d72cb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -186,13 +186,15 @@ EXPORT_SYMBOL_GPL(vhost_work_init);
 
 /* Init poll structure */
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     __poll_t mask, struct vhost_dev *dev)
+		     __poll_t mask, struct vhost_dev *dev,
+		     struct vhost_virtqueue *vq)
 {
 	init_waitqueue_func_entry(&poll->wait, vhost_poll_wakeup);
 	init_poll_funcptr(&poll->table, vhost_poll_func);
 	poll->mask = mask;
 	poll->dev = dev;
 	poll->wqh = NULL;
+	poll->vq = vq;
 
 	vhost_work_init(&poll->work, fn);
 }
@@ -287,7 +289,7 @@ EXPORT_SYMBOL_GPL(vhost_vq_has_work);
 
 void vhost_poll_queue(struct vhost_poll *poll)
 {
-	vhost_work_queue(poll->dev, &poll->work);
+	vhost_vq_work_queue(poll->vq, &poll->work);
 }
 EXPORT_SYMBOL_GPL(vhost_poll_queue);
 
@@ -512,7 +514,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vhost_vq_reset(dev, vq);
 		if (vq->handle_kick)
 			vhost_poll_init(&vq->poll, vq->handle_kick,
-					EPOLLIN, dev);
+					EPOLLIN, dev, vq);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_dev_init);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f5251cf902ce..58032429bd05 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -46,13 +46,15 @@ struct vhost_poll {
 	struct vhost_work	work;
 	__poll_t		mask;
 	struct vhost_dev	*dev;
+	struct vhost_virtqueue	*vq;
 };
 
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
 
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     __poll_t mask, struct vhost_dev *dev);
+		     __poll_t mask, struct vhost_dev *dev,
+		     struct vhost_virtqueue *vq);
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
