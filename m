Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCAB1C0DEA
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583491; cv=fail; b=Qr+2mepgdX8lSBu8PW3BpBptrJECrS0fzJktTf9E7rWm1R6i3A28YnGIt11FrP/xdfWqov75o2e+OAh95eiQZQ84TPQYJvCAnzKNTA7nlLmKREPp7ONOX1VLBDATo7k7AaA1OxdNkIdUhe31BPRaafZDOlUzjk1vRvaEcQ58Z3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583491; c=relaxed/simple;
	bh=wKSqH8znK4M4oTd9KiEjOJvpDzQoYGFesAbMWqEeCk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELHYTmZ79J7jTAmoEhD6n/rDcOoI5j1WN83os/FNeb+XzMzKai0WATZkbWRwq/DTJp+C++VvqYT2zRdPFRCHvqAh1GFknu0P1/uQvSTLRhE8m3AayrWAHktVW4Y99p4LES26UaCpdK9AvpXOLeyVRr5P2Y84eGAh39Cpwwhp6/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m6Ny+BqH; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m6Ny+BqH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U47xHfO6qZVIi/xRreMxoSVbWL1J85snQEhLADb+kNyful2UD72SIpQZlScRXLdV3J+Os6NbhglKrK0eFXOPyhYc9ZbJsyPkw6LsItZDXX5XJhVHkQWFiQUNFuy6n7bMVDBE/7oMj5V2H6SOTqYn1JeTcvlDdNMlGObSQ8aZzafQ9CVsYRR7BRBvSwdZ+/6PaPeAcObjBEhwC1VZEYneOxrVD9wZ3XSG44H9IRoLzp0XoyDY13xAeroL/aKZkqFkN6GU2OdF0NTUdo12R5zC0Hs1jskwWxNZk18L27WdAGUmN3KsEJC+1nezQVqsM6Xl61yauGsiawqiNYXlMwMYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7TDu4w+AWZFYWCpX79TnGAvuCvTI8JjqdZiFtdNwFo=;
 b=rGDcjNH7zwq3euE5nHsyX1q75nccT700Ah4YRHydAyitDctPhgvahNHWf5WnKeDE4sJkpJT3GDjWEO7IJmUAARlyNyX6eEjuJrCGAqbXco5SfKS2jJXKg5uAyDxwewsgQ5WmecSdVmRgwpub3oiCbQB+Oufoi9KKAI/rd08IuFkwwHnIbNj7yyQFzt90x6ow17gi88nMbyAbm9CBDNGO+5SS6jHsZQ6G4IcmbZorY6cPEqwYrxyJVn3FLavEix7YA9XgRdEBxHx2UyqEM0QLvhqb5sHZQ4MUTVA/sEQPYEtazj0tLUBkupZjvzDOG2rS82oaSqDdiNczKotqSfsw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7TDu4w+AWZFYWCpX79TnGAvuCvTI8JjqdZiFtdNwFo=;
 b=m6Ny+BqHAXcXVmBfrzgZFS5EkOk2a3h83QBV/zfXyAAKPNeAYOSWzYCMsSn1TXUtqkHDLqW7kPX1h74+y5UD9Dh3c/F5rxLf+8mtGOMq5QS4t1Mb1O6G1niMt1HSZlv7f/iSCs5E+jUolj3YcifUpJ08ItLd5y3hc9pNwOhyvtzBabPCm0YiRgQLSStG/XdTUByMqUaXsn9eoFSFy34I55BQ8HaVySwA5fjyFOn7kBW8lqbHlVcz11tAAnANAn97DoC/BxVRmEKTX4HS7xV6rVfgQqWqiugTtDb1Y0yUtRKU0wjmdeLV2Eqqv+nP90oxucvYjfueVXYxBjGg7gR+dw==
Received: from BL1PR13CA0129.namprd13.prod.outlook.com (2603:10b6:208:2bb::14)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Fri, 2 Aug
 2024 07:24:46 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::f1) by BL1PR13CA0129.outlook.office365.com
 (2603:10b6:208:2bb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Fri, 2 Aug 2024 07:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 07:24:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:32 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 00:24:29 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>
CC: Si-Wei Liu <si-wei.liu@oracle.com>, Tariq Toukan <tariqt@nvidia.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 3/7] vdpa/mlx5: Use async API for vq query command
Date: Fri, 2 Aug 2024 10:20:20 +0300
Message-ID: <20240802072039.267446-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802072039.267446-1-dtatulea@nvidia.com>
References: <20240802072039.267446-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c293d2-4184-4ec2-e1b6-08dcb2c42f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RQJp61l7tuHXuNkgbfeJ+qHOyL0UJ6nKkMoPcRik/tyb7M0k1WVuIEVceTQa?=
 =?us-ascii?Q?Dboo6jsYsW0mroXhiul2no1faBXjojGuG92PrLe7LzZX3KEK4hWsotz8mSii?=
 =?us-ascii?Q?9SRhy/Wa/56V09gAoYlSWBARrJFcmPkJt29Nn7SQ0rUfcD9R8wwWQoeHbxsX?=
 =?us-ascii?Q?cFKiH1yaG0JZTUSU0he94vN9I0qMlLKTglUILIB4yjOb/buzk1EE/5GY2UkD?=
 =?us-ascii?Q?FlywN0wd035PRFr7tRKohsXskJfm8gg2Bd/xoOIWvGD5urlEZ+mG175Yg4D1?=
 =?us-ascii?Q?YCgGfCQag6hWlykH2inyQyJKmk6UUSWg1deiC3JYO6O6fV7fy27FJunkPPW0?=
 =?us-ascii?Q?8ZUMgXwuhlR8Aehh2cMjjzC44Jpix/ckwLKrizrNL2QVdxZdzderw6qzvsc7?=
 =?us-ascii?Q?FJzZMkLm8e8BSLX6lW027a62JHCIdbHRphQQPoVzcrk0DRv/KBF52VPodshM?=
 =?us-ascii?Q?j8eDHWd+ENrcWFX1ywA/4+sQvts6pCkcHdJqoUpWh3i9u8gLS/RqvEG7Tr9o?=
 =?us-ascii?Q?FT8RIAJOC5/Sg/+2m3vukjwrzbJPG6WzcxdEmUQo+DwsKYA5KBvLNV0KZeFX?=
 =?us-ascii?Q?NEcSI2d3lUEuQGZ2df2sUKSibNcM8qRXTDjz11uiCPl/TAcTNZda8obChHZX?=
 =?us-ascii?Q?b8ZvDaF+m6xOVHDtPDA5rWwh4Ac8pqqoZ/IZzCiffKUnqJmt6H3jdKxaVwnJ?=
 =?us-ascii?Q?rkuur82um8FkS24ZhqvYeif/MEw7w8MJ8+JV1cGkjhKK82zX+SkiI69p44y8?=
 =?us-ascii?Q?ZG+M+mGBpIh6PcNY3SgbC5G906vIT2GxyemEtDJFIwWeEf3MD8fhvA0uz8Fs?=
 =?us-ascii?Q?SM3Y4ulNuTqs93ovW5BBCtZ7YlYebMtFsb/+1hSMVgE/KCU9EKDZ2CKeRYUc?=
 =?us-ascii?Q?1PO6QVX7Q+UaJNyz1S+3G9xr1mcwvL0RUxhNfLYsOEpEmzrkKBEwHbUwdZNv?=
 =?us-ascii?Q?a/NKgNfix35M340h/I2w2xSWBnBSMQd+rbCybgTJZgUEmiwZAeMpD1etcbDY?=
 =?us-ascii?Q?ceeT5wvYoM5nmaK9niGZuRKMhQn2GT4eQ/I6LXk5bXiHd+/CtL6naqUEwUl9?=
 =?us-ascii?Q?A9c6K8wbl2aNGj/Wb4MIWGIlEJxjLoy4P+rFYl4pNgFZdO8c8EHLcI/45X3N?=
 =?us-ascii?Q?rWW5xUMrqFkb4tHZxpzGnvUCEZBwxX7RAs1X+ZpKqWkX6dlZ6iryz5ym+QlX?=
 =?us-ascii?Q?1xe8JvZKe9qEwn2cxcUM12/AdK8pH20/zIGBRW/jGfpWdh3i9wWmbNDJhHHP?=
 =?us-ascii?Q?pxwzWx6gZCT3FgnabtAXZmHIxWmj5M2gCbNGMGD8VJxqIPUFExwuqXpVeF3j?=
 =?us-ascii?Q?TCq1o9/KkwC/hy+7CBzyZQ9bzrPNsih7AH50ODN84zqOGoJSEkKsilAcvlJ8?=
 =?us-ascii?Q?4eJvqGHqwHzj8gIJzIP4k4RtlMy08S6PqJOnogFMtLzZgJ1vIvsfjAlwXmV8?=
 =?us-ascii?Q?TvsRtHdKddMAjBk/qGPvB4FTkIMV37yd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 07:24:45.6317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c293d2-4184-4ec2-e1b6-08dcb2c42f68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113

Switch firmware vq query command to be issued via the async API to
allow future parallelization.

exec_virtqueue_async_cmds() is a generic execution function that will be
used to issue other async operations as well. Handling of throttled
commands is built in.

For now the command is still serial but the infrastructure is there
to issue commands in parallel, including ratelimiting the number
of issued async commands to firmware.

A later patch will switch to issuing more commands at a time.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 181 +++++++++++++++++++++++++----
 2 files changed, 161 insertions(+), 22 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 424d445ebee4..12136163d8ad 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -103,6 +103,8 @@ struct mlx5_vdpa_dev {
 	struct workqueue_struct *wq;
 	unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
 	bool suspended;
+
+	struct mlx5_async_ctx async_ctx;
 };
 
 int mlx5_vdpa_create_tis(struct mlx5_vdpa_dev *mvdev, void *in, u32 *tisn);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 12133e5d1285..be8df9d9f4df 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1184,40 +1184,173 @@ struct mlx5_virtq_attr {
 	u16 used_index;
 };
 
-static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq,
-			   struct mlx5_virtq_attr *attr)
-{
-	int outlen = MLX5_ST_SZ_BYTES(query_virtio_net_q_out);
-	u32 in[MLX5_ST_SZ_DW(query_virtio_net_q_in)] = {};
+struct mlx5_virtqueue_query_mem {
+	u8 in[MLX5_ST_SZ_BYTES(query_virtio_net_q_in)];
+	u8 out[MLX5_ST_SZ_BYTES(query_virtio_net_q_out)];
+};
+
+struct mlx5_vdpa_async_virtqueue_cmd {
+	int err;
+	struct mlx5_async_work cb_work;
+	struct completion cmd_done;
+
+	void *in;
+	size_t inlen;
+
 	void *out;
-	void *obj_context;
-	void *cmd_hdr;
+	size_t outlen;
+
+	union {
+		struct mlx5_virtqueue_query_mem query;
+	};
+};
+
+static void virtqueue_cmd_callback(int status, struct mlx5_async_work *context)
+{
+	struct mlx5_vdpa_async_virtqueue_cmd *cmd =
+		container_of(context, struct mlx5_vdpa_async_virtqueue_cmd, cb_work);
+
+	cmd->err = mlx5_cmd_check(context->ctx->dev, status, cmd->in, cmd->out);
+	complete(&cmd->cmd_done);
+}
+
+static int issue_async_cmd(struct mlx5_vdpa_net *ndev,
+			   struct mlx5_vdpa_async_virtqueue_cmd *cmds,
+			   int issued,
+			   int *completed)
+
+{
+	struct mlx5_vdpa_async_virtqueue_cmd *cmd = &cmds[issued];
 	int err;
 
-	out = kzalloc(outlen, GFP_KERNEL);
-	if (!out)
-		return -ENOMEM;
+retry:
+	err = mlx5_cmd_exec_cb(&ndev->mvdev.async_ctx,
+			       cmd->in, cmd->inlen,
+			       cmd->out, cmd->outlen,
+			       virtqueue_cmd_callback,
+			       &cmd->cb_work);
+	if (err == -EBUSY) {
+		if (*completed < issued) {
+			/* Throttled by own commands: wait for oldest completion. */
+			wait_for_completion(&cmds[*completed].cmd_done);
+			(*completed)++;
+
+			goto retry;
+		} else {
+			/* Throttled by external commands: switch to sync api. */
+			err = mlx5_cmd_exec(ndev->mvdev.mdev,
+					    cmd->in, cmd->inlen,
+					    cmd->out, cmd->outlen);
+			if (!err)
+				(*completed)++;
+		}
+	}
+
+	return err;
+}
+
+static int exec_virtqueue_async_cmds(struct mlx5_vdpa_net *ndev,
+				     struct mlx5_vdpa_async_virtqueue_cmd *cmds,
+				     int num_cmds)
+{
+	int completed = 0;
+	int issued = 0;
+	int err = 0;
+
+	for (int i = 0; i < num_cmds; i++)
+		init_completion(&cmds[i].cmd_done);
+
+	while (issued < num_cmds) {
+
+		err = issue_async_cmd(ndev, cmds, issued, &completed);
+		if (err) {
+			mlx5_vdpa_err(&ndev->mvdev, "error issuing command %d of %d: %d\n",
+				      issued, num_cmds, err);
+			break;
+		}
+
+		issued++;
+	}
+
+	while (completed < issued)
+		wait_for_completion(&cmds[completed++].cmd_done);
 
-	cmd_hdr = MLX5_ADDR_OF(query_virtio_net_q_in, in, general_obj_in_cmd_hdr);
+	return err;
+}
+
+static void fill_query_virtqueue_cmd(struct mlx5_vdpa_net *ndev,
+				     struct mlx5_vdpa_virtqueue *mvq,
+				     struct mlx5_vdpa_async_virtqueue_cmd *cmd)
+{
+	void *cmd_hdr;
+
+	cmd->in = &cmd->query.in;
+	cmd->inlen = sizeof(cmd->query.in);
+	cmd->out = &cmd->query.out;
+	cmd->outlen = sizeof(cmd->query.out);
+
+	cmd_hdr = MLX5_ADDR_OF(query_virtio_net_q_in, cmd->query.in, general_obj_in_cmd_hdr);
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_QUERY_GENERAL_OBJECT);
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_NET_Q);
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_id, mvq->virtq_id);
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
-	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, outlen);
-	if (err)
-		goto err_cmd;
+}
+
+static void query_virtqueue_end(struct mlx5_vdpa_net *ndev,
+				struct mlx5_vdpa_async_virtqueue_cmd *cmd,
+				struct mlx5_virtq_attr *attr)
+{
+	void *obj_context = MLX5_ADDR_OF(query_virtio_net_q_out, cmd->query.out, obj_context);
 
-	obj_context = MLX5_ADDR_OF(query_virtio_net_q_out, out, obj_context);
 	memset(attr, 0, sizeof(*attr));
 	attr->state = MLX5_GET(virtio_net_q_object, obj_context, state);
 	attr->available_index = MLX5_GET(virtio_net_q_object, obj_context, hw_available_index);
 	attr->used_index = MLX5_GET(virtio_net_q_object, obj_context, hw_used_index);
-	kfree(out);
-	return 0;
+}
 
-err_cmd:
-	kfree(out);
+static int query_virtqueues(struct mlx5_vdpa_net *ndev,
+			    int start_vq,
+			    int num_vqs,
+			    struct mlx5_virtq_attr *attrs)
+{
+	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
+	struct mlx5_vdpa_async_virtqueue_cmd *cmds;
+	int err = 0;
+
+	WARN(start_vq + num_vqs > mvdev->max_vqs, "query vq range invalid [%d, %d), max_vqs: %u\n",
+	     start_vq, start_vq + num_vqs, mvdev->max_vqs);
+
+	cmds = kvcalloc(num_vqs, sizeof(*cmds), GFP_KERNEL);
+	if (!cmds)
+		return -ENOMEM;
+
+	for (int i = 0; i < num_vqs; i++)
+		fill_query_virtqueue_cmd(ndev, &ndev->vqs[start_vq + i], &cmds[i]);
+
+	err = exec_virtqueue_async_cmds(ndev, cmds, num_vqs);
+	if (err) {
+		mlx5_vdpa_err(mvdev, "error issuing query cmd for vq range [%d, %d): %d\n",
+			      start_vq, start_vq + num_vqs, err);
+		goto done;
+	}
+
+	for (int i = 0; i < num_vqs; i++) {
+		struct mlx5_vdpa_async_virtqueue_cmd *cmd = &cmds[i];
+		int vq_idx = start_vq + i;
+
+		if (cmd->err) {
+			mlx5_vdpa_err(mvdev, "query vq %d failed, err: %d\n", vq_idx, err);
+			if (!err)
+				err = cmd->err;
+			continue;
+		}
+
+		query_virtqueue_end(ndev, cmd, &attrs[i]);
+	}
+
+done:
+	kfree(cmds);
 	return err;
 }
 
@@ -1542,7 +1675,7 @@ static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mv
 		return err;
 	}
 
-	err = query_virtqueue(ndev, mvq, &attr);
+	err = query_virtqueues(ndev, mvq->index, 1, &attr);
 	if (err) {
 		mlx5_vdpa_err(&ndev->mvdev, "failed to query virtqueue, err: %d\n", err);
 		return err;
@@ -2528,7 +2661,7 @@ static int mlx5_vdpa_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa
 		return 0;
 	}
 
-	err = query_virtqueue(ndev, mvq, &attr);
+	err = query_virtqueues(ndev, mvq->index, 1, &attr);
 	if (err) {
 		mlx5_vdpa_err(mvdev, "failed to query virtqueue\n");
 		return err;
@@ -2879,7 +3012,7 @@ static int save_channel_info(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqu
 	int err;
 
 	if (mvq->initialized) {
-		err = query_virtqueue(ndev, mvq, &attr);
+		err = query_virtqueues(ndev, mvq->index, 1, &attr);
 		if (err)
 			return err;
 	}
@@ -3854,6 +3987,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		ndev->rqt_size = 1;
 	}
 
+	mlx5_cmd_init_async_ctx(mdev, &mvdev->async_ctx);
+
 	ndev->mvdev.mlx_features = device_features;
 	mvdev->vdev.dma_dev = &mdev->pdev->dev;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
@@ -3935,6 +4070,8 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	mvdev->wq = NULL;
 	destroy_workqueue(wq);
 	mgtdev->ndev = NULL;
+
+	mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
 }
 
 static const struct vdpa_mgmtdev_ops mdev_ops = {
-- 
2.45.2

