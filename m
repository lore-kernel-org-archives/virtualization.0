Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B813E02B
	for <virtualization@lists.linux.dev>; Fri, 17 May 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972712; cv=fail; b=S+IdcmSc7mQ2LxnVRuz6enJa6pDgi9QDkw22yyTEnqm+/EEnXfC652kaxhRzSaYmrYwJXPJC+98OM34m95ZsB+xz0Y8TpKWBuMLBY0oe5s9es5kJLsCr+9mt6XhPwkTDUCRdziNnxuJ/U1pNphJuSUHfNEgS1OkBS8q06NDOl80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972712; c=relaxed/simple;
	bh=F4kY6fYYW4374FyoI/AwYtE3CwND98HlrJeK9ZiZF3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mrqFYzlno0ZwfmWB5svG1cySc4sfOUWhpiZ3RY1o84rCIES/PuAwxa4Ge29NX0isskxyfG78b9m6HDCOclfFEd7TvwEMSjiAgLbKYiIb67BpJGG2dyOO64mfCwDwFhwUGljX5SZCzha3T0zwH3JJHcFE1yAOsdUjgY8ac1xvXBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZCsI3Vi/; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZCsI3Vi/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbowbDGTbhPBhT7ISWAfWxsy9rjOUxlIv53/cCX5TUfJsK55ei2vRS4IG5SAv8RJutM7/g76dk/hmSvAO/Uuz5nFv6M+s6wE+SMGyMNkuzcIEzSf8vrlzGry1NT56Zo3LH8Izh9i3Aw7T5uPVsX95Knt3MW0UVYOko088fZ0DKzTn3I009v/Is5LqheCy/TtjkJD8cHTWW/sxNcPvpVVV5GhKnZM5YHdHSuAwAt1lNf8teOgYeK/aSriSfKkXS3XfNiDh5kNU3gE7Igtp2dewINyZjjbU/nUM5/ks0r5upnRcjTHbiyN6/v+xe6WMWy4La93ezJFILaYmmhNg8pBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWVY3Q045RDb0qkQpZYR/IsdLj5MPZ/irM3tLtWBnC4=;
 b=X1FOkbYxGI3W7NWLcAmgg9RpjmuucxqXdxZZDx7LpQzn0g39Aon52GuXgR+7Dz/x/s9t1pa6YJCaM7EiAOkrgy1h7tDNqzjuNyeEkFonGiOWfRnbW83wwrU6KceoN++zEmCPV+shE2LTJ95sW98fWiJ6Qsz3qCtx/PT+0dpdR1j0gw2Bs5XkaCWZ8k5Kcp6repZ26gRBK52xaIe9t1eeRPtWof3C1jyQfwdNnHrieOdkdbFLUk/7AJ6rHLgbzm5MvRz2B29HnNmmouTEmXqquFXlxFw8thYwjRsqYo6SeQMAjkm03WtH3Be+1MjLkFrs4I+XI762L2aNlGcZF/o9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWVY3Q045RDb0qkQpZYR/IsdLj5MPZ/irM3tLtWBnC4=;
 b=ZCsI3Vi/L4Z97OS0MVCd3Z0toA3PvLZttUfjNeY4w4n0GhmF+FvyCmRZ41N/31inXWshpMJ60dXhg39M2RR/EhCLFMIGjbiofmmXVzhAY5bsxg701fK8ApIhJfNGr8pffST4rrYS+xYseZTtzoht/uDQqRdm8pYzIqMVMfalq9n2YIlRBzvk9keGMjjwcwCGJ8kefTlJ2JadLaABHjOHOZ/QWOWItoCsZ/iu6UqpEyycKX6IwIYnFMqM10JeSMo6AsNacmYOH6GpHsMyIBMxSuAV49G/Z2MBzxApd+gI03Oos7jrMNr0OrHDf0vYZthvMscJa9IYnDBJOd/NhWbO7Q==
Received: from MN2PR15CA0039.namprd15.prod.outlook.com (2603:10b6:208:237::8)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 19:05:06 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::b1) by MN2PR15CA0039.outlook.office365.com
 (2603:10b6:208:237::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30 via Frontend
 Transport; Fri, 17 May 2024 19:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 19:05:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 May
 2024 12:04:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 May 2024 12:04:58 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 17 May 2024 12:04:55 -0700
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: <virtualization@lists.linux.dev>, <vgoyal@redhat.com>,
	<stefanha@redhat.com>, <miklos@szeredi.hu>
CC: <mst@redhat.com>, <dgilbert@redhat.com>, <yorayz@nvidia.com>,
	<mgurtovoy@nvidia.com>, Peter-Jan Gootzen <pgootzen@nvidia.com>
Subject: [PATCH 0/2] virtio-fs: change handling of failure at request enqueue
Date: Fri, 17 May 2024 21:04:33 +0200
Message-ID: <20240517190435.152096-1-pgootzen@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 39190057-5d9d-4a79-21de-08dc76a443d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JwH9HLr/eI332bW0XbV8slmdSh0b4DGJ/NbDXv+X9vhviAnsTBYM3YkJWlUJ?=
 =?us-ascii?Q?OyyIHMio73sAcuGFx38/m0seaOa/CT2ecqkJZeDvDLiVhIGvnK52v5vXhd4Y?=
 =?us-ascii?Q?8XJxQquODWSPAkdZi5J+AIpO+WxRskKzc8JpPfvAK+Rf2F04iIAIRlwvfxwS?=
 =?us-ascii?Q?JYWLXmTeIZ7WtZ/wS/5d6VTubvnF9xgP+n/88WOI52PhtBixrI/gNHYJvtfu?=
 =?us-ascii?Q?jum+00ne3NJO5vVJiAgXzcUiUwM4jyfazw3eob/YrQ4Z6BgPHfn73GRoh/iY?=
 =?us-ascii?Q?KozyXn6edgheln75DM3jHa/dPxBxXy8fJv9qqxRkg8nd3yw9l5EoLti+Fb9J?=
 =?us-ascii?Q?KLTDsrMVPPO5JRwc2hE/kRl59whRVnhxgztKAvl20AwH/6J6RmTL+kn3+wsX?=
 =?us-ascii?Q?4raiskAkZutWfKlQENRG7bEhUVOQouSwPl4KS5UBtwVQfqSXjIzve8WFpxIO?=
 =?us-ascii?Q?61wUVuGmAfDBjKQD4V4afvGkCXJZPDEgHW4yEJbFEoCgzs/i4n5BhaZacAr8?=
 =?us-ascii?Q?ZjhpLNrzCBFCwtVRLCyLBfJUdeuKZWa6KFURHHB+RcD9ceQUDLQwbm7mIBFN?=
 =?us-ascii?Q?u89zez5Q5wkWGKMOj+MjTxAlYarqB7PwYCTsi7UHrt/0Nm+5+X99CQnRw/Q5?=
 =?us-ascii?Q?1Va63efre3iA42NJbDi4k2m7QgUNMIL2nkY3f/98b03mVJiVA2prrUE5dDFi?=
 =?us-ascii?Q?CP8Ir/TIa9JYE4zyThY3msHGRJWwL+nVQc3P4qyLTmzy9NifdoDAA1G7aMq1?=
 =?us-ascii?Q?sqMUjV1fJWU2e0Bezc2M4bkZPAcyYGUXeWVz/pXve2oHFj+kA1/EB2adYFw+?=
 =?us-ascii?Q?8IKrVFqCcEEfBOXzgNuC07gh6JaaTMXkTPLjoFRPQ3H8of8Xmk3xqTx1iWw5?=
 =?us-ascii?Q?0f1v/nvkg5o9XPpD+PsSscSy11AL7FQs+a5PmqDhvxeo5uFjZyTTM7N3R9w6?=
 =?us-ascii?Q?NfI0OU/gAzs7JI5tIm1oGZdUd/GXpXjMfbPI79GbCcKN/yzQyc+nMg5rtaYw?=
 =?us-ascii?Q?7tTjX6KWhhy5iUe8LvvmUTuZbvb9BtSQVSAXItJylBS0cKTpCW8DQmEiSEa1?=
 =?us-ascii?Q?0ol8LpIornR4lHr6odtTM4N+y39sUjyLeMcACIMzkXjkFavZs7BXMvdWcNbG?=
 =?us-ascii?Q?mozHuZVE30i/ZlZxmCbSl8xjWkaDlaSNzcfLX9dcFwgmCGPsaaByWNj5mkDL?=
 =?us-ascii?Q?dvXmu3JaAY7ApmPi/qIzV6TLPWCrcaYVa6e5ZLQ2J4spzZvT+vLLS+8CmzHr?=
 =?us-ascii?Q?T9G9tsh9l2GwawCSSUozDP6YcNSNVj3Uow3u59ceYjokNzfiitIFVaES08NR?=
 =?us-ascii?Q?SdfKbs2a3hiuDWQeDGX0j5ij8DSLFUhMoTRVLtEUCPqj0yuHTi4WC2ivS5ni?=
 =?us-ascii?Q?NeIw4Pg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 19:05:06.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39190057-5d9d-4a79-21de-08dc76a443d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

This patch set aims to improve the latencies of virtio-fs requests when
the system is under high load, namely when the application's IO depth
is greater than the size of the Virtio queue.

We found that the handling of -ENOMEM when enqueueing requests is
inconsistent with other parts of the kernel (e.g. FUSE) and also
obstructs optimizing the enqueueing behavior.

It is important to first remove the -ENOMEM behavior as the new style of
retrying virtio-fs requests in patch 2/2 is only correct in case of
-ENOSPC. With -ENOMEM the failed enqueue might never be retried as there
might not be another completion to trigger retrying the enqueue.

Note that this patch series is a revival of my patch that was last
discussed in the mailing list on 2023-08-16.

Peter-Jan Gootzen (2):
  virtio-fs: let -ENOMEM bubble up or burst gently
  virtio-fs: improved request latencies when Virtio queue is full

 fs/fuse/virtio_fs.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

-- 
2.34.1

