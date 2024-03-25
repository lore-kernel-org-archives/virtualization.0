Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE76F08A
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403378; cv=fail; b=upu1fNFkhYtkE/ZmyUVRVNWoEkRS+mxqe6AnZWKVR6/OcTJ3gDvftplC08XfiofI6Ad/ld8gkd6YAel+grdPkqrwpsTR8s1+H0o5d/lmA88NaoWfLxGvKC2WrebHAsps5Ck1XFn5GldaAigrsy3tYvreJZ75NVZ+MI4boGom0Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403378; c=relaxed/simple;
	bh=TWJ8uh3xOLiXDx7AUYsyUPhthUetEUWdzBrBZDcxGtI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A3opYyeJGf6N9VD1AAEcVW/VRAbx5K5vTCWLi+CTok1qpkxl2bIyLi+3gI16FyyWbWYokPtaRGMINL0feFVu2X50KqKS1ub/JZxCUcpPnZNkLi7J57hJhZArVu6HDVRkmCUehhm1+D3FzW3vv6g2XL13R0d6H5KOu2KP+B9IwVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hJXNvTo7; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hJXNvTo7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGELtw0nv3xCABu5nAW0pHa2YQMOAkXQpCRW1q2xY9VJI7wwSE9WTdifHER4UrQY5xbkQfhDRQnfGGfzkTc4ngTIHvpfSEtrroyRGVmA1mL7Gp8wl04r7QZB2LPvBEY+/zMJuZ6+PT88NKRuwJPqYopWXBpG7x1HVDYFJq2RnkRmQjhfRkoE+FDJpMdmShRMxVXKl3OCJ93nk/4O+hgmuFdEOqrWUrKjil62N5HpTvkZLwMtV2DBgz5INRqyYTCv4AN12qEeVafrpp6VPJlnVOltHXfA0EgO0gLd662ShcZU6LgVExDdDKESQsstXu8iyHn0G2p5io/I0QFgTtxBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeOK1Oz15oYu5hljzWKzJcObVkwTdZjPDmfheXOWGy4=;
 b=Rmoi/nNqr6OAGuAXBlpanYMknaLLdq0t4btePx969nIOIdVZka+ojXIQwVdux0cmyjYxCcnJyj607IkwqkUq/ziymTtZ0UU5us935VeGmsl1ok6pHHlPFTM7h0XelFsHcPBmHkiemoirHKVuwjZh+z38KZc4GpaidTkBWsnI7dGxTlT7sLIf3/coiKtcHZGVrsv8Ax5ItxpKICUKy65lnQf2GTBefpungM79TDxWVFEaspjEllfIhIci8SabgckpozjHj8cXK2bJ+8/FmF7slBLbV0QifP3JXr3UTKHa9IOiBCSLv4RPFHxy/iJL8KOnj3fshFcaLh+dSw6Sv60D3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeOK1Oz15oYu5hljzWKzJcObVkwTdZjPDmfheXOWGy4=;
 b=hJXNvTo7pS/K3GhjKaN/HeQi6TI9VcmWT6HkdMvVkQz10ISM6nFZ7HLg42MCLf/U5LS+HrJve+10YPDNLIyezg3+ed38CO2ZkbX7kRUZtILIqwAu+eFQPub6IEGukj14Gpxx6Cw3DUgGxlboN/9o2rG8VFFwth3GE49ldVev/rCR4363Z1XcbZ9G/E6/ccsLlpBOnFZM2mioaw7x2nKdKNg5ikPfDAy73tHT1f4QRgp5DNuwuUpKAf+mGGK4wI/KpKn5paRsj7h6M5pugpPsb2Dwb/hLn3wA6n0loyZj/CAjF0J/9EiQbfit1DBn/mZmjhdrimm8Y3Q5sJBtg8Z9fg==
Received: from BYAPR02CA0034.namprd02.prod.outlook.com (2603:10b6:a02:ee::47)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 21:49:33 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::5e) by BYAPR02CA0034.outlook.office365.com
 (2603:10b6:a02:ee::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 21:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 21:49:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 14:49:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 25 Mar 2024 14:49:22 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 25 Mar 2024 14:49:21 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next 0/4] Remove RTNL lock protection of CVQ
Date: Mon, 25 Mar 2024 16:49:07 -0500
Message-ID: <20240325214912.323749-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.42.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: db681a1c-7f29-4faf-c6a3-08dc4d1574f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ZmaalUQGCp9sBqIel83j0Dirm7Ft0rIcBhnqKGpVDV19uhk+yXs99x+0VM9mlRZfCt63LosR3+0iMAonkUKvFNVVA+UnAtvYBA6JZBSgiJduDm0xF7IBFeG3n5ojoC424UN975WVRNzMK3TohpOiiqcICn2WRheY0fcdU/SK3lnm1QWTXww68z5udn4TWO08xyMCoGXq7YouUrBdP17xJunGiYtAZJ1jx9I1Fj8HOYeOwExbKx3wIUH4nkUuqEhVWOjAKXr5781vTDyXAJ3luAjn/mKaQZrDsZkUOkUKW55F5txnFcPgZz8EWi5s5vyM4dvYTuG0nyw2nJOLDClyJXvjzodiFuyM/s/D88Yy9XkmUGhkmm3ETO5JsseBfTX5qsdg0GfGeVnzbzYJrw/37ZhvDhcogS0AqUyLpXvssqmTdxizjruh4No1ZCEuNLGBrmOyHT/b1iCHqANV4C8v3TOWsiDVvImkjzqaZvKgAIh49ATYI66q5gsu2zusYySNY4h3YdHMz2d5VcQJ/d+vMAraIjkH6r6Rj+1fQAiP6kxue5uOQTSgYwR1jXrA0oYaL7eOA3ZfHXCMxR7NRMPJetdd5eCflrbzwRrCnadjHU3H3fxffjfwjUTP7FiJtLiEcNtykTjcAAQqaDJn8AVxM9QQn3m8u4yDJQh1Z3f9TkII4Q69bqxZjd5GCAioY4NL7rvYZ6FwNN5QR8JC8oICBxkJcK4IdEltlk8REao81rYUpKoVS67oXsZVpm1eM2U
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 21:49:33.1396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db681a1c-7f29-4faf-c6a3-08dc4d1574f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

Currently the buffer used for control VQ commands is protected by the
RTNL lock. Previously this wasn't a major concern because the control
VQ was only used during device setup and user interaction. With the
recent addition of dynamic interrupt moderation the control VQ may be
used frequently during normal operation.

This series removes the RNTL lock dependancy by introducing a spin lock
to protect the control buffer and writing SGs to the control VQ.

Daniel Jurgens (4):
  virtio_net: Store RSS setting in virtnet_info
  virtio_net: Remove command data from control_buf
  virtio_net: Add a lock for the command VQ.
  virtio_net: Remove rtnl lock protection of command buffers

 drivers/net/virtio_net.c | 185 ++++++++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 81 deletions(-)

-- 
2.42.0

