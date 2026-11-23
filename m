Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442374;
	b=4SwYc6wuxE7DEexVqiBSrieM8XyK+4Vb6URPzn8AbyjyeLxtX3BNz0e+U4uDzzDApsfG
	 D776DL3MfrYYz+W9q3WaZapBh2IqDPlo+7psP3JiAm1bJ85GFhSBDdeVJE5gEi9syJ9fH
	 YYkj7GCQ1ts8d3LDbZVYWk0ZP6BxabbMN7TkbqpyjEx8i83NKARDvUK74bSlZIhcKvs6Q
	 ynHkoxohQw8hqjeFVkmyzhkGACcMevGeKl+ZfkbCjPISLlhN3DxIJVk7VxYRY0be5OT/p
	 SfPRYVpvK0dk9LSfmZwkVsIh1Z5YcJ7Kyi/bm6wB808GBfk0ItdzfP5ISbjH6IdebmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442374;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=frTHv8QvYSvGJVgZvgfZoTUzKOX0EfxbPZY31OxkMa0=;
	b=MrwYOQdAxpeSCiQh8OcKJAVOVOQAz2lLBa2v8LY1vhW94p05nt06J6uvie3Qisch21Wk
	 c5PCe2dvlLlVOBSbv5FqyL+n/PUYnVaIASqtaotDhmIq8HtFGCHng5de1AS1E1gRoPyeo
	 yDW4mUBxodA0O7lHhb/HBhJ0CTYuAEgiJd4Q3K6HoP5oRMvD9PLdwIfG6b+C2Eo0ImEi6
	 7nz4HJ4eCqsIWGM6UHVz1nC8jpVm3L3lq4C0h6o1FKRj+5YQOPrxBTlB4NS3OvMDBukNv
	 nAYwpP1X/yDhobuw69uPCT4ZglMtonB+MrwUXMkFW8TtF4t0PkFdvusRhTxhdyAdIXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CTCpp1DM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.41
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F1606A32A
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 13:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A34F1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CTCpp1DM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wocW47H8dVO9mnBIVkz2hvjscvxgi/1ThyHb+GTqkUKxus+tNIafMlA4U0Qj0oTBMBTxMHgVWL5advufSzijGurkHO6FMPSmaXB2+B/eHOOk0O13cUQTGrzIdYx0TR9TxdIU2nX/j0gIjMWtG1xj/At0K+MLIbBVctKRnoR27Vk+JuyJ16u3sTjj/OMZGa/JiwEelhOGv8l4iWSCqlZGWf8L4mPxXGVc4zDNPQc0Nz1tCyemfE5E4dyoQzvpblRb1y06ZEaZk1z09Qfc/52Ga2M3h2WHSu1WX9LYNeZsPt3Dt3Lqfy6II5Ti4Mzno9tGpknSgxm4hodg9M45FMZ4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frTHv8QvYSvGJVgZvgfZoTUzKOX0EfxbPZY31OxkMa0=;
 b=P0yLJTLqLw4GZ0YGaMTQfkSUTfx+w2X0g/PYEVlZI9Z9Sbt7C8adaOjWBfDhnG8TNSMORERKkIi9A0t+SJDTrse2FaSjUGuV+uD8qP7URxpYFvCP2l0VQ70iXTxBQckyfUkV01GsAy2e08tzCvSUsaR/Q6tEAj25MshiD0VvCPia8W1fS+wx31zgGPMiSsHqbRHpL3Tja+VTPYQ0Q14yJVet7W7rv83czREAVMbR/gR9qGK2iLTWNW83HWQiYz0o11ZIQUNunI8528Z5rSVe29P4Nw6FayvzIi188m94hmVcinSe3KWhGPPUiYNx0T69eESAscSTuk7bvSytN4uNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frTHv8QvYSvGJVgZvgfZoTUzKOX0EfxbPZY31OxkMa0=;
 b=CTCpp1DMlRj8eW6svMv+h/FhlCIKFOhpcT9sBGpMi4fEp/9tjMh8uCc8sKieVKhGSNrp9GU1ucfaPhNi1RC3nScp+j6M0yhPRjCWxLGtLAb97YFuQS9dbfH7sRIZMcIWAZpVtPLUnZXUhUfq4YTE7Xp50WI8+fmgLX8j9ss0Y+NLEY8hJVw5bFkDHS+rlybx9oVktqY7yhxsubv4vgP85QpH8ltzVklUrzGwqCFnsZy602QcRz7DtFrJ4jZhYRfBxnov1fRyd4KRcC338HuoNadxP9yuJ5CIzC0oTsyWAn4mmY7TqYm/rnMJUEUQrmcqnqze3On3gs781VBZgcpDFA==
Received: from BY5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:1d0::28)
 by IA4PR12MB340717.namprd12.prod.outlook.com (2603:10b6:207:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:59:28 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::43) by BY5PR04CA0018.outlook.office365.com
 (2603:10b6:a03:1d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 13:59:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 13:59:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 05:59:14 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 05:59:13 -0800
Received: from f43.com (10.127.8.9) by mail.nvidia.com (10.126.190.180) with
 Microsoft SMTP Server id 15.2.2562.57 via Frontend Transport; Mon, 23 Nov
 2026 05:59:12 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Eugenio Perez Martin
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH 0/3] vdpa/mlx5: Misc fixes
Date: Mon, 23 Nov 2026 15:56:43 +0200
Message-ID: <20261123135646.3962652-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|IA4PR12MB340717:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a944369-b0d2-4c2e-842c-08df4969fd4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|11063799006|56012099006|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QsBZW8ImuCZuHzYQevhid8k1rm7f+1fsW8TBVGIx1JwtqJonulxqeSSK+8ZtNscyfKtruzexZokxpGv9pvo3GDaUMuJ8yQ6Ne+aqydscZMnCIa9Lw9D06Y8qv8PNmYjagTrAkqfcEb+3WBEj6rutXSWAE1vyhPLFXMzwiqyPOnJAUK5s97gNtmuUBoFPEDVqRUnaJpQpSr2a2vLba3sCL34MJ9+q69m8gwuRK2be1fv49FDsPGzIXhwXfNlJR1eO687pTWOvh+TpFh3LBYRblVigyrAXyvjY3NgnGT7J0FBE9XWQPuEtXGqip8PoHxKkw/WEQs9s9VXpSt3PHhWd4nBdqX1UAIwgrJP4ZWiUPvnH+tyVLNhYSnhf18ijog41/ytpYLQlT0QRoXCatu1+efhM7ho6twvlEutj7W8tB7W4QBJF3O7X2hjsoz6waYFh8p32x1slBfYcSUJIgMQBOdQ6h0OrdyjEAvjvofrMMF7zGqhgrPfYJ9YnJfa4bK4KX/yaSpLdsFSUarTzIw+6/1N7xl55AC+zruXwNjtNwEIB8U7uB6kjtd1ZTIXD+zKbh/cAyKi0t/sGPtveIdEjcDkttPQlIS5Ju5ByT25cFJ5M80lCDt1kNvca1VnKYmjiAJUgKcFyJQhBUBa9y0l9XnjAiDb0W3D8I3lrlTuXmFQPHLpERYTHS4BO1pDHKTmHHYnoORBzkMX0qSnM9PfNvw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EDcJGikpElwZ9QPBpoLpywRH4cwUCk8J+WJ+7cfgyocb9/w8x0zM5bjP9bYKNx5JpfqKNJbKHCdo9smteOr0IP3HJ2FSzJr6BBF9kV5QzQzzTbKmW8iiiT09FYiFUZN6pAdxv+xxzN7iE75mHDNEx6EfunZTb642npS2uYLWVOSosJn/ntARVNXvI7YUOSAAAAWGrv78Gj1t54J2kWEBZ74VEbJ7IpbF/lnaZQHkEaRwXQc05grb1ee9v7DZ8eWAUNYe3osYN4I2eWsVW8Q3kSFT39sgx0vj43Qcy8/eaWcg9FQ5wkOi7de0ElTwRoW7UZDrHLxhVmPrTTf60jj2nZzFYOdVek+lDFmh1MFpiSCqaxwZjIlegbo12CXsToRoEiBDdrVtcAbyZJFxz0jmy9i1hC+1DhleidePzjVcZ+cCF+jlTXuJXwN+xa+VVLpN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:59:27.9541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a944369-b0d2-4c2e-842c-08df4969fd4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB340717

Here are 3 fixes that I've had queued for a few weeks but didn't get to
send.

Dragos Tatulea (3):
  vdpa/mlx5: Fix error cleanup when VQ setup fails in .dev_add
  vdpa/mlx5: Increase the maximum virtqueue size
  vdpa/mlx5: Don't flush the workqueue under reslock

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.54.0

