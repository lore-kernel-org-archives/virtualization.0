Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A28CDB482
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 257314218F;
	Wed, 18 Oct 2023 17:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 257314218F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ACLcwwiY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6yFMB43PAlqx; Wed, 18 Oct 2023 17:15:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A0B3A42189;
	Wed, 18 Oct 2023 17:15:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0B3A42189
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 707E4C0039;
	Wed, 18 Oct 2023 17:15:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5086DC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C2F642189
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C2F642189
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yfQ2wQe6-LmW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AAA5E42144
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AAA5E42144
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIW9R9BBl18osvuFk+n1VHj2eljqG0k7GLTWfGTNtmM14TIs6iS430Z4pDLYp4Iry8vgKIuiFi0XBrHAv0wuaRGxtiotbtBO51aG87FA9JioVbLOCT+/VnccQu//LgLfNkn/IdNKTxuN9gAdB0pY4hSc1mKLKPoTNkqhbnzoINotFjFCkoAwyLM+e0RG+3EVGjqXoxu3oZBKLCfQZC/Lw24L+wJFbjUQYjwqwpGN3q2RUlSKYx3Y5l2w1LmA6CgtnJpynzyqw8l1/b/fIR60UCS53HxXkWLJLSxBOoAmKBlLIfU/m9JCf1oPx2dhAZh0Q0QMnNeGUvYaadjZ15JGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3STa7lEVTN260CF+7a2Ikvh2pPY1BfsD0f/6MUcbh0M=;
 b=MqDDn+gFn3vK8G4/dHRvfpHK+IkNEgpES3r12ERHaG8B0sulcrkmr0mQEp6qnCGokchKf0PhVcVuQhjNDUsCSDIH+NXp7qGQ6kEv9QrEolewowSyWMVU/6Uf/IMzVEFVlEz6fLfLdaT9FxkkeD4lL/84EuYFKW1xg1igv6y4PA2wv1a8Ry4zMVlqk76sz2f73624LNcdBKT9T69aYGAzsYgY+PEL2k033SmLAUoGHFfNlIjdroAEbCMamfwBuFpwOLq7s6V+bKiOndrLmbjKNnvrFuTL9yk9+wrLPt3hMw+rOsco/oHx/BRkZgKo3ktcYUbYXE/l9cNuT9Dxn5niyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3STa7lEVTN260CF+7a2Ikvh2pPY1BfsD0f/6MUcbh0M=;
 b=ACLcwwiYLdR228ZCNNxR+3D1vsKViBIq9Zeak19PEkO6dAeWZBseBXX27S/CjKKU2klwYVYhzkgK2UJHcHXF3ZCL2PF3r6/WDQxnc0C8OXspikeYgKz61RIzOPBrVWj73IhoW7eifKnEsbpUYgz8S232E3OM7gpOSQ9tDUXHLrSuqJ9AKfprkHWW8YMdVah3gRxp5egvxgkRqfJ86DkGEky2JhSrDoo37iXt/WJREgK1O9GgBr34wydTyqBxLgmeD+QO9PX7NaBTs+xQkfX5gUqARiffbNp0O70uuNYRad7bvbszmIXT+EWOlYvVyTfFm8rAUmJ2dZe2egJ0Kxzigg==
Received: from CY5P221CA0158.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::11)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:15:48 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::d4) by CY5P221CA0158.outlook.office365.com
 (2603:10b6:930:6a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Wed, 18 Oct 2023 17:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:15:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:30 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:15:27 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 01/16] vdpa/mlx5: Expose descriptor group mkey hw
 capability
Date: Wed, 18 Oct 2023 20:14:40 +0300
Message-ID: <20231018171456.1624030-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: ac40035a-faac-4543-270b-08dbcffddf5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOeiaaqTThJ/Q7gIK6eUCE2G7m9uBODGxXLOJPtQn+SIL9lG/SBhEtpSFpSPZazyteqFavMlte/7Ft4l7kAbppt2ic5Y10s2bw7EcMHyyyo20YaRBU49noeRQySYMHRBPEGQ42tbYzi6oWdOH0DFXUSzwerUL/yOrr7h0tf4er5SNND3+CgwWgmeyqu1u+QUa+W16wmmkADoCCwzWFHaRKXQCtMvNFRIaxIQx8bKohigeMHgqv5F5BHyfnqK1PV7bkwZsXCLIpl+8lNOJGs8JQHKx/hK/1pGTGMYl4VxBPeV7pM/I+Vb7IyP1/wLtuwy6V6Fsf3/BCa/ICk01VJ0xScfXTO5YixOCg95Xv6sJDv4qiDrV+na8ARmN6JxwqlervqnYy+jWlG/4iDB/2ZIg/EbL8CvFhfeqTL7On+kJTYPG2usIObW4FbVZk5XA9XFsYb5BF9Ykt8fzOH1Er2zgOf0siuafIbOSZvRrre6X4jXD7d4oWuahApwCO72/AWaaip6Itc+PAAfUkYnIJuMSntWbXGd6zfuupr97MwPU7Oh6FagBKR3iUs4Jc/kCt7T25wRN8kMEeCKt9/KSEQ1dhqQiMiBUWJDTO9y5q0uGqEHwt6meRULX9X+0k48I0EnxiAldpSWqmljMhMiq/Y86qjh38Ga+kBg78cWxKH9BjxvlbTmi/Saq5nb0qNrCt5gtNiOZJ71AmVA9RpexEMukzCYAgIgyDL5eJymNI7wn2Qf7ezW/RviBKKVESy+kKJ7
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(1076003)(478600001)(107886003)(2616005)(7636003)(83380400001)(36860700001)(26005)(82740400003)(356005)(47076005)(6666004)(336012)(426003)(41300700001)(8676002)(40460700003)(5660300002)(4326008)(8936002)(40480700001)(316002)(54906003)(4744005)(70206006)(70586007)(110136005)(86362001)(2906002)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:15:48.2881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac40035a-faac-4543-270b-08dbcffddf5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, linux-kernel@vger.kernel.org
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Necessary for improved live migration flow. Actual support will be added
in a downstream patch.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index b23d8ff286a1..6b6be1a0d575 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1231,7 +1231,13 @@ struct mlx5_ifc_virtio_emulation_cap_bits {
 	u8         max_emulated_devices[0x8];
 	u8         max_num_virtio_queues[0x18];
 
-	u8         reserved_at_a0[0x60];
+	u8         reserved_at_a0[0x20];
+
+	u8	   reserved_at_c0[0x13];
+	u8         desc_group_mkey_supported[0x1];
+	u8         reserved_at_d4[0xc];
+
+	u8         reserved_at_e0[0x20];
 
 	u8         umem_1_buffer_param_a[0x20];
 
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
