Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF137159
	for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762344; cv=fail; b=Wtdix60VgussGiWRj5xQYR2RYgcmc6LEKzHQNu236CQZdZLBaZFEF85oIShr2+opLHjUSG2itfCiGWntYj5c834TP4f1/uUfjqtrX9LruY8bT8lVv8uEdHAz8a7LebkHBS4u/ubkgYBgIttsPK89iT6PZKS1UZV0Nh0v0v0CXdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762344; c=relaxed/simple;
	bh=Y+FXHbqD3/bs7vX1gccaYvHO5TeXwaoJ6/mcLb4A5Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DNER0eFpquopP4iJigmZl9M1n+gBGmGb6AnEvDlqUySmHjze+QgYqSyZEtzCivD62Gr2xjPSUP8FttdxqExQTphAhy7CldPUHviLQpprgsUVZ+s/b1Bxe0roCSrHX6YJmNbQs553mHQoMkYIBN3X9lCJKICvQ+o1sQBPji5t9iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=NZ2nQG5Z; arc=fail smtp.client-ip=40.107.255.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="NZ2nQG5Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k44mWOvkeZs4tM44fak1HYdC2Vo3OQeRuXlKs3Uzr623CTcq6WXrxpw3cz+XlB8kjNqG3G+KuUnl/CFpbVqUNV028fzVj/f9SNbIHqTvYWsVsP1RbVsnU1O+4aRMTl9XIUf402gMPgGReygWjrv9aQvYnxeEytD2ZUmPK09i0AM7toZoZxG/coeZiUAUbamBI9p2WlNrWXUZZAuk1t1W/l2zNCyOS4trYbsgll/UvhMNQUa/XAsg2utk25p315XPXXUQI0i8RM1criNN+D7of3YVQqYx1yKHtL0rLvcDcC92YnK+/REWcKauMy//zri9Rvd6wPZ5QT2uXZj/ehWmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx4Q7BTEoP0SAUFe3GGwMo4nSjk5y5NBb6r8OZvB+Dw=;
 b=NuM6e7PylUgAjvMxJkogFzPrg5bGMbsLwyniUwkbMTh3DsAhiFWvJ5PVCeYPlyk6kWjHGgjpORp/7rqQiymrTLxU7BnCAj19JTfms46PujkOEGweACvvl48ytiNhncRJF0ZQENpxlDKALTUXKMGfjWIJVGcph+lgDCGa5i+srCwR6tqI92ubZr59R5Fp79n8GSr5LL4WZsumitQAnf6B+QYev2Vp96pPZiEyZnvVdoBtkIESigJS2piwy2gQ5NlBhY3WCfcUg+67KOW3sJMd3C/yJD+M3Tiqmryi8GM79AsUn1I1hVKQalasaeXEMkWsW9gqZxkwMjMeQe2t1SBysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx4Q7BTEoP0SAUFe3GGwMo4nSjk5y5NBb6r8OZvB+Dw=;
 b=NZ2nQG5ZnKT2YZCT8dvdnCvsSYOD4eHUX78H0nNfASEsS2ljiGWq1ICEaiZQZnRxL8TIU1Mu62kuRQDMc22qj56Dsvsjrdd5zSa2sFWs+PniDq2V3tcGx6u6sbWQdILDKue68Bzghg5lACuGv/LAyQcf/eJQ0mswN19vY1SBrki2u/N7ujRFIc0Nhb1S4wYFt+UA7GeWv+10HkExB8Di3W3PkPBmsj95n3pmV4mYMlkeeG8kjoC5Ic1bv/pE0FmbaAScZD98ffza/WFnq/Gsqx9xh/mvQ1cCnbGsKX/Q4Q9k2sh8hPLYtpaC3PFM2XGf9kcLhHKjVTZqiqx7p8xHXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by KL1PR06MB6161.apcprd06.prod.outlook.com (2603:1096:820:d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 11:45:35 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8%6]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 11:45:35 +0000
From: "gavin.liu" <gavin.liu@jaguarmicro.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	angus.chen@jaguarmicro.com,
	yuxue.liu@jaguarmicro.com
Subject: [PATCH v2] vp_vdpa:  Fix return value check vp_vdpa_request_irq
Date: Mon, 18 Mar 2024 19:45:07 +0800
Message-Id: <20240318114507.1899-1-gavin.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:4:90::22) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|KL1PR06MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d203919-a79d-42df-85bc-08dc4740ec3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rbMNT+potxDW+aJXVIciIL3b73mGWGTzfuUt7g30OaAnXGKr+rXZVcQEcEz2mjxhscW3Eio/IAT0P0pVQddWYP9N9PzlA+A5As0W7Qvv2OSXl65Uu4UUj+U9fgLpV4ocbB/W4f9WRnn3TuhsQ+rMc/s+jZgUhoJiYRv2pR1Is7OOgcAaCMJqiwHTSa+vOXu5mqcx2iue15Q6o/rVt41rPjmDkxveg06sX7CU+X+jo+NNdIqoDDS67uSacEF4MQQ10Ly9sGXm3eZWCmsNjQfD19xLELV6H6cIFvAVJilzMSbgssYPLMcGzBMqNo9FOuJccSn0HlnX1Xts22qZLf5Ui5qW5D1HOZr+sWZAWWdkq49zncX4kEpPbRSU1p/GXlGp9S7EyN118fdXsHcnf+paYwgni/TS5bHzHcMtZmqTPWWby+T6VW9ZEYFmdQ3ld+RVqWT9DB2sIaX1Jqsbw+Rggb92Yd9469LWh8v+iGtVT2KWgYb+zSv3++4cqkDPUYa1MY8cg2NfCNVnplOCbElIa9eH6JNOYwXE0cVx8IfDUfMxej8rRzFqd5+4/LWoO/wbPGYFDV42mqMr2YFcDpRCYCB4A1ZVYyBvE3ocohQnabr2hBloJAae0TsjzhnSjzB/e1ow18Mg1ZteUAlU5PTd4dQIjwltbZozgjOOCGMzUK4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OcaLCESWlac6GFexIrXKeWC0ThHC1y6odKS/4vhWQ0Y7uLivrX+da8BJl5C4?=
 =?us-ascii?Q?IAFbpcEcHR/M/DFZ4ZB49JhyHO83VHsUyrwFbo7lMGrWFw56qTUGHHb97bqK?=
 =?us-ascii?Q?yCSingaZhmd4RvfWmFvTjJU7Eu9SbjHtWrApi0TK0KbPhlwihQH2Z1n049VC?=
 =?us-ascii?Q?3c/A0KfjneR+Sq/RgTpS0fgW2t1uryfX8MuBlqPVtTDqNfT1NhTmvimPlVgT?=
 =?us-ascii?Q?sybinaJ4NE+rnkqgiNgcFxbkVuEzj9+VHNctJ6s7rp2hDkTQxCl5261HyeSG?=
 =?us-ascii?Q?Xpw4vXzwBMmwN1/DE5Gms5WyI6Ld0QFj4QGySg2Cn9PTmehkGJn4CpMfpvft?=
 =?us-ascii?Q?lqwhaakeo9O6u4npzU2fiYTg/YkwfBEHtcmxhGIE14mpGsTr+kUkJ0Bnm7o9?=
 =?us-ascii?Q?jypgOvPniMf3RqME8WHRQHIZk2IMIzRAD4uimtWfNfc/RaaBXIVZ3UXZKuom?=
 =?us-ascii?Q?41iGAJEC8tYRvNbzIsE8SfpzvqSyUo/J/QXFqDsPzXuHT5maizk8NyJiWa9e?=
 =?us-ascii?Q?IGE6Ie8WxsTZ1N+lUSl6lqSEQ+4bKnyQvbJuwAcMOhktnettR8t1bMNggp9n?=
 =?us-ascii?Q?FgLQOSaBD1rsRSM1miumpWxt3Y3NnGMx3QlCmI+oOdCwE2jALTiFE8LiTPrq?=
 =?us-ascii?Q?VYhVC3IyborxeVfKK+jpHO7rHSjDu0gapHkSpxc98DDHZ5AynAT1ZWXMMGrO?=
 =?us-ascii?Q?gIi96kHnR3kHcaovqhuFQi8ffLqyrC9cSbtyIN8Ol/ldUgMviMTNJvWeXX9Z?=
 =?us-ascii?Q?lbJ3kLB76gnrC6u04Hew310xOlopB4YR5TEQLXYl0tGR2ahfgTmvM5eabMas?=
 =?us-ascii?Q?WCJCAvK31E2sE6P1w3IqTfuUEpj4AGIwMK1U4uFVWCcu5qTQ8LNtX4N578DZ?=
 =?us-ascii?Q?cmBISmJbhq4hZ0jfl6MHEFBKk6+iwx6ot0DcyhFxrIbXgCRj/dXB+IwZaaPe?=
 =?us-ascii?Q?lUAmzFvbGR9Ps7OYGvm7U9sAl4bra8n+u9ax/W0UX9pXMpdJrrEPiVCtpsOt?=
 =?us-ascii?Q?qCrM6BUwEbSqN1PZpj9bTPHaJY4FxbqJjIvn92dw5ofNLbfd0+H5liLaDTlN?=
 =?us-ascii?Q?mtGiDn09MuVgq3yTr6fcbBRIfg3a80l6p0mu2yk1k9rqFi+Fmo2ubffOCBfV?=
 =?us-ascii?Q?MpwP1+2vxJcTh5sLe/4xe6wLEDyBCQrEZ0n6iihyJetye9VRyNi5U/ykPiaT?=
 =?us-ascii?Q?1a/PjeeNfi4ybLNagDlfjYkjCElj+WgWz3VbiUGH1n8ZLmBBTry08449AnDx?=
 =?us-ascii?Q?goiEKmz4w6fpfgV45xfUWifMfxcQ3Ak5MMWlt88gfKPwglDzZZEse6xdYz6g?=
 =?us-ascii?Q?qk3c5j+H5imLbaPE48MvEoVCA1rDvUMFk1dJK+NnzkSjmDt7W5polK6UxE2K?=
 =?us-ascii?Q?ixa07h2E/3PA1cyiDY0B0Zftm1RdE5TzbkBFtvBW5dvXl5eIhlztB3Nas4Ao?=
 =?us-ascii?Q?vJ3fd6PN35FwlGgdRV+V4WtfROb887oZgnVb74fQgQ9YdxPTK91pKs/coRK9?=
 =?us-ascii?Q?Rjlnp140WvdyEZlhPyHxrW3sb0Z0x4njxaxpOdcIBwh08cciy52wHpOBD/cI?=
 =?us-ascii?Q?0y1qP1EN+MhRpCTLyTjF0luonL8KhJXlSPcSHKnnsvfyv1sFmpHfulLmsnVf?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d203919-a79d-42df-85bc-08dc4740ec3f
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 11:45:35.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZStGIuuc68X9nNgdsJzGXx/XVz6/nTROEG3ztjLeH8H/2mMO3d48kQ9vhNkMocLvQhMMhqwKca5SbZUKQYaavC4jdAyQc/VTzD7PCgb62g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6161

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

In the vp_vdpa_set_status function, when setting the device status to
VIRTIO_CONFIG_S_DRIVER_OK, the vp_vdpa_request_irq function may fail.
In such cases, the device status should not be set to DRIVER_OK. Add
exception printing to remind the user.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---

V1 -> V2: Remove redundant printouts
V1: https://lore.kernel.org/all/20240315102857.1803-1-gavin.liu@jaguarmicro.com/
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..58dad96326f3 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -213,10 +213,14 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
 	u8 s = vp_vdpa_get_status(vdpa);
+	struct pci_dev *pdev = mdev->pci_dev;
 
 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
-		vp_vdpa_request_irq(vp_vdpa);
+		if (vp_vdpa_request_irq(vp_vdpa)) {
+			WARN_ON(1);
+			return;
+		}
 	}
 
 	vp_modern_set_status(mdev, status);
-- 
2.43.0

