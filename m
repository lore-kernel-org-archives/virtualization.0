Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407E18AEA
	for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498565; cv=fail; b=kGM2qOIpB0drAXk0HJjddSvNe5NtoDs2LW/MOeS1/o949sqfok0PsISNy63auT+s+u5nB89qj07zh0jntVhyvEsdZ2mMPg2poHEFT1HHhkOJ4xgnaQn4hkICintMM9wTUBglrZOxZaH3oAETmO9WMD2/JRNJK8MB0XlcsGFSN3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498565; c=relaxed/simple;
	bh=TkzBR8hNjF7P+O7xaBRs7zZwAxcVujIk2K7QcrY0ut4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D4j4yedDEvhABMWzCYZeup883AjtmJk2h7cOTYEa3ClihAfENCBPQ9kiBY4NMBKtr+bjtJWUbeWzmAtOOzIpOI7j8hm4LdiM02l3wmnCJhPK8bj1vKjyqktR9y9EzY/Tj4cFCI6fhlDmOcaTguAi0KRuZEhqGLL7tWkNt1N8puY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=cVYgBB1T; arc=fail smtp.client-ip=40.107.255.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="cVYgBB1T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da3lCk/M6EfndCnov++4xSx98VUE0d0fsj+SppaoQqtQdlx8HpiWJLMyVmhRdwcLyJQpFSooVC7yo97k6LLXI9ctwkumb8PQVPr2Ke81ngttUxhPuiw/q0HZA9qJqKQjeBBVg41YNpW4RWGm1EwpeFBH6MSZ8yE3+iR1af+cEsLrMl5s2p4MjpbDtSVpoxS762QWlptIon0RRaTlp9KdfJjpTJFtRpRaYhCWc/b5aqS1jR+beEflUSTJNcP7L334tCM/V2+CPQg9TgG0T1s1Gz3EDyDuUGHDcCRVGStTXgO/57gKGgGFcPkqxD+IQAxejoVaVELjLuBes3+U5SHukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAmGjMfSqeBezXp5xR5rZmLeIU5AJBLvKZNYg+rVdFY=;
 b=D2SQ9bFEQUEQlh/DM9SV2ACKHuoajFMLaF5socFZym2eaJXyWLgbIqlreFgakpoZ+RJ9TH4j45EOfIOSl4zU/d0nQwYFUGcLHuUgqxjsVFZHZVInWb0VEnRN58j6bstW8wmkAg5buMcE5NO1XNHu/ftzGH+gBoyq29lZ1/KlCYK9WT05wsMSJbKE7ew8HYE6URUFbORuPJlIx/v4wNf9MiDY+Y44ABdrOz1pfYT9oqtfOiZN5OTa2O02oPg2eYF/za7/owi2v8x6C8NsPizqs6ZHrNLTp+dpJehj9kVehTDGEB14OaOYZVzyAe934pjICzvQOSuhsXFeBC2GudeKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAmGjMfSqeBezXp5xR5rZmLeIU5AJBLvKZNYg+rVdFY=;
 b=cVYgBB1TfbBMB/7wgxRPVrN0NVc3vXSr0FwstXZ5HQxM21s338/ld4KfVtijj0hAQV+IzRht05YGtrFeFb+Z9jnZMHdMSCw690vnf7OTuMctlziSg41a98WIaALqsCvmyNhafEu5E5u53/xLt+fLw5rSROV5eBGjc622FL3rZppmdB+fdHBRt6w1fQW41XuKb5UVHcNu3VRr0GC394q2WB2zCjt1OaASaffpGHvd1iaV/fhXQbHd/xm3o08zbssUDPgKWU6P9GqiZVBytiuazjPbFW3tK1CQDdoRNlaRWKPq1ffEwvu8KHpcpaGqhJcrKy//SekaohPQou5/GtNjxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 10:29:18 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 10:29:18 +0000
From: "gavin.liu" <gavin.liu@jaguarmicro.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	angus.chen@jaguarmicro.com,
	yuxue.liu@jaguarmicro.com
Subject: [PATCH] vp_vdpa:  Fix return value check vp_vdpa_request_irq
Date: Fri, 15 Mar 2024 18:28:57 +0800
Message-Id: <20240315102857.1803-1-gavin.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::11) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|SEYPR06MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: c33f6f63-7841-4140-0df9-08dc44dac521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dzITi43RmlDL+WfWsLn7m79xgMxaoKrY/8ue1F5rii9V+TUQ23jJiQvC2qLhRSnvKRaVR2SFdoQDVGFwqPAYbS8GcSsb0ChrK260z0b5rnsH++vylJk564GG2j9su18WmbD1hb7Koqumte3v3MMw0eYW8JcOhqBXTUApq2VZmSt3vIebOXKQnS99YqI+r3j0uxxMeM9v0m8zsyIu+dgRdg/z90dQ1Wf2OgrNJfEcCBsHKAD9KxCWqhY7KS5PFELPCbdAGbI8638W5E3OK/sMnohW12/q0V3QNuEg7/vj/ufdszVWY2At7F7qHOiPj4UusYED4rX9uGeD0re4HskSStaJL3gbL3V/q4eczcslVpgXJySdRXaaJrfdC1VzSzNAmU7i/yPDvpJ0WhenviyOkYD6pczHY8JF7Lvzp0Oy6pj/8CyK5Dw0HI4U0JIJM2WA/4YYSOxQCxY+bQjhk4cZnjKuAxEnVi6VFbxc0wJTpDnRCvMPm8/xs+16rZO0mWcZb9VIXQP1DF2Y74YqjgxkwKIzL4sC/EJMo96lbmd/cRfD4K5U8ya9Ur/aMZvZzYeLql6XtDa07h9D0ySx0wPjGmGHUhUWjRnbLrllHKdYCTIb0T/X/ZKmeprT4vi2l8WTF4Aso79WBHOtrYyhTuVE5hZqOCGjr+eBhmLhp6MQlQfBZrI/r2UslMxmo0DktZ3sOx9J75zxn/meAuNi27z0mw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6mC6miA5J4LYsdmsB38htOC9snDrPBjxYh4Mn5gcdI1rBOOaZZe3mF1+Z/Rq?=
 =?us-ascii?Q?hE6OGneQ82dCwB3NOKY5ugNs6BMncFkHgxf4Bd9ZNsgs/8ZcV1JBe3vCTspn?=
 =?us-ascii?Q?qU1qMkfkN6QYan0BBRKAUnK7aJujFj4oukahJGTQqVqj6iXPoLfKYNaliFWy?=
 =?us-ascii?Q?6lzmnrJ8JkUtT6qEsuvT1WjDqed2Dmw3spTXz05nFTfr06twVLphMkVRYxGx?=
 =?us-ascii?Q?W8YBfbQP03R0mqmqnCJ1ywIhS4qmGLdPm8wqlZOVvhDNmxHw+qNYhCV/Rxlw?=
 =?us-ascii?Q?qeIvAQQ5vUUA5Z+Qd2GByJd/M4vHSi5XHCnZap+AqygIl7bJs6LiuQP3NFw4?=
 =?us-ascii?Q?MdpvQ6mZQmKKxjRSE/4W3HgoCxK9j217/+ltGfx62YaqRpiAlG288N6ivpfe?=
 =?us-ascii?Q?P8khnCsN3AiSe6OyZYn2JtEnXhmyTRbhQCG5FRfH/cVKbdo8QPxEH7xVEmvq?=
 =?us-ascii?Q?ytxlwZWM5DmGTlTTjk70o+IMsWn4c3xNmX6tOlqj85Kf1rtOBfNv+0rHaKI/?=
 =?us-ascii?Q?xVJ5vA7LD1c1oIl6rAUMyw+8gxmiPEC+s5Zhjue2AFEOXa37p/S1OXoD2+RF?=
 =?us-ascii?Q?bTVW7VYYBTOqSsD1kAcQLXcUEy8rxyQT3guyET4AGL/O4EFn2pFInuQI2j5E?=
 =?us-ascii?Q?+oOpY4tb0Qs8Yd+w26KfGPmAPAQ5nBCFUZEDWpaqb4qlEd3BZCH4CvPwmcHF?=
 =?us-ascii?Q?x9A/7ajnMwL5xyVbnV0XnlYPIrEwxKehPFSKd0fVH2pxyud7SlUIurH6wsOT?=
 =?us-ascii?Q?r320A/j2KuRbnwnoI4tqaTdGGfdBVsh2xu0bvD8PZ4mh3lfqaKQYfacLn4B+?=
 =?us-ascii?Q?X+Z1s1iSMrDR0KTuVgxI7/3/ZNxHUG13N6mDS+jgR+8HwrcQTG6+BUs8Nhh3?=
 =?us-ascii?Q?I77SvFbx+fLe6THr+LTFhAp0WBaZTlWDV2JybVHwVpt10bnx2qfuae1WWGj2?=
 =?us-ascii?Q?N8t5p/Xm6iMOFq1ArA36Un8eej6DSj4ioUFcDr8Y9bt2bc2j8mkRAa5In2WE?=
 =?us-ascii?Q?AxjBZo/0W2L0RsmdlmTPweXYzk2/rhLr6/53c37sPuGCOzjNUO2if6SCY9MX?=
 =?us-ascii?Q?56kLH4mgZPtxzi4iAUUHWLQh5Rlh3T7CslpuRvowHC/ZEClN9aoipbKUQ5K8?=
 =?us-ascii?Q?qXP3Rt0UOMzy/JBgXA7P79MbIMzNGwKNqg9QWwqDzyZJwjsCHyAPtQ2MlC9D?=
 =?us-ascii?Q?xm+TSQs3YEzxH+8TYmgWusVL8AESJh17VdihfWbfYiBukzttef1XI3fFCfiH?=
 =?us-ascii?Q?pmhTw0ZDXNL5NQQAkbguS71wgkhbzx+k6tADv5NNmMTjjIwfVA6XkmtOETay?=
 =?us-ascii?Q?9RbEUve6mKHKNKjci5f3moUwxRFFt6eGhg7YV4rle8y7qFFa+hUpvKJj2nDx?=
 =?us-ascii?Q?JWeroLoWmAyHf81Q4qLs5A7+2Fra4sg1+F+kpcLv3ghDRlLKC87cXxNvFnLl?=
 =?us-ascii?Q?pEKPYBIrc84mDve48fpSfFN10Wgz2r0CrXRX7YhAvmW2mnt60t+OZxdIW7UB?=
 =?us-ascii?Q?wXNf453eqfkCyNQS1Bv2ZSZZTavkBc3i+dmC/VFvXpYOcwtyND9imS2Lok6h?=
 =?us-ascii?Q?NAvKfdZnfFjhGXqLjjdpijsGrJEA0m7YqLGBudHJyQ7umXx9qVVrtIVhK/Ju?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33f6f63-7841-4140-0df9-08dc44dac521
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 10:29:18.3320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3wjcPywshxSWIJ46+kJnXFIXCTpXlUU4Xf+5ECYnZrf4s6Fiyt5J/yWwi562CXn7ZwFV5sdX2hDkB5QY01b+UoSduUSn9LfN5XiwTH+Zuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB4989

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

In the vp_vdpa_set_status function, when setting the device status to
VIRTIO_CONFIG_S_DRIVER_OK, the vp_vdpa_request_irq function may fail.
In such cases, the device status should not be set to DRIVER_OK. Add
exception printing to remind the user.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..c1270b263867 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -213,10 +213,16 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
 	u8 s = vp_vdpa_get_status(vdpa);
+	struct pci_dev *pdev = mdev->pci_dev;
 
 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
-		vp_vdpa_request_irq(vp_vdpa);
+		if (vp_vdpa_request_irq(vp_vdpa)) {
+			WARN_ON(1);
+			dev_err(&pdev->dev,
+				"vp_vdpa : fail set status is DRIVER_OK\n");
+			return;
+		}
 	}
 
 	vp_modern_set_status(mdev, status);
-- 
2.43.0

