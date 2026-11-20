Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795189674;
	b=p3G4ES77tAm5ZRX5ynlsgJgSsqMMIFNjD1zIc3dateosf9zxFVzdFDfJEaxP/g1JSrKd
	 lUInQxkWvwE6aa5GJqnCR72cxNlKVeIDOOQXQT6/Ulghn1Gm62DcSQTiud6O804Dc6H0Y
	 HTiaB57qh21y9tCtuJUakseyD0pVY42Zr4Bb6c5oqpNcNoTDooc0yYj4vOtlTONEbmFPe
	 KB5E+NEVk64jYYnF2oG+CuXy6O3PWucvHd+4LUaI1fgqkzRqLetYGvG2waYQ+82O7u+Av
	 CyIlu63VuOPe4AReYdtial/WRbvqU5Oj4BxouYXZWIMNF7eOaCpP2QgTKcVqAvy+oKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189674;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YmJwzq43uqoFOjexF6KB8sDbF90AMwtvIlFceM0vGSI=;
	b=xl6SnfOOtwYfQcsZJ0MP70mPwlBkvtDMnWv70tLKX4qtYba+rrnAMheL5YghBYlNEgsR
	 gzNRvAlRVKQAIv2blHBiW5KZrW+0wnm6dZuKXyDf/XBmMx0v+6gyNrJpwffqo4bFCh7Ze
	 xlqmxn593UWuEyCeOPSNsiNt0fVtVaTtAwP7RJ6ytapqh1pXh9oYMC4YPs0HmXlipf9Qh
	 ZoQvRlWu00rhx3/EpAIMo0fhPYJA7W8HnzewX5RAmaUrQ3Yv7ZxBfxmRnEDjBvDbz2yBI
	 WYtE2l3mC2fY+qs7XTobk+PXRBV2uOYAUn9pR15MF5R0akr/XauWAhj6k73zQBOmTHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=BuGoiBlR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.112
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023112.outbound.protection.outlook.com [40.107.159.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837AF606A33F
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 15:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 837AF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=BuGoiBlR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTiv8dINPnD7y3/1vKYFqg1J9fQJ0XGmyUxJlrBzqUb8Lxwn532r9wQogsKQeX6ApyCSCePPXOTPzTnhmBhtzPRk4+RIBe6y1XOmFgaUyoOS2wCLRxCrbry2pIRSXgMRumwRFdYToHZ7il0ar5/5uXPUtq3ZCE6h9xqUQZYM+XwVlee7eAr+ffUFUh5N4F5UWqbqNC5H2p7xlqNYXAkP10c+evJJBvKU8X95cPyQeEu+OTl8IMtdQ4c4zyVMxdaDFlyWyphln5Ve4cy2JDRG3jkdm4tdwh5/lFuboUoqVclBPW7uYTAWOSGLBDkjUwV5EqRz11NfIX/xSpYBS0cMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmJwzq43uqoFOjexF6KB8sDbF90AMwtvIlFceM0vGSI=;
 b=ZXNGT0RbR4t56xgCZH0hl1E+iZ1eF1GTY8x4SqCK/86hQTNx0E+r9sDxt0N9j+GWD2w7pd3L+/xJ4m42BhomQzigSGlc5WYR0vpWKh4m4Q+liIADlPQctAlZsIbjd1Kg4wo6i64BxYtsWZC+ljAzxwVw9DgBzmrOa4TEXVBIOaWo4dTeSOubVlZJKYACUspTe/vFAwVkndgZYE6iU7uE811JS/LF++4my/XO+wUGMB53qIXxWkhH4ZZ/+gNRn25k/RyAtbAS/IbyfQipr6dOA2/NRubYBxjGACfOQFrFAOtd2juAZWoGSRE5Oo6qe3kHkuTq+wk1cAb3AfxfBxfQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmJwzq43uqoFOjexF6KB8sDbF90AMwtvIlFceM0vGSI=;
 b=BuGoiBlRZjIFICim8wB9sF5+mZHvQVGnH5NKvfIrWHwnI580Z8HMsLf3932A19rPk/Vy14GwnG0PJIRbAO8cRYl8YutHeIe1o6i8u530Ktig0iqZJ8U1IBtGjSLXpb4P7k6RHEiUYy57YO/xdQ/JQ+KmFtH19jM02D3YLELMyWnNovJBJfQnAnvrXYoFGqMDBcwKfp3ws09X2FabN1yZEfGB2GmCohCvGsSiOG/t2/qbepbcVGrYiLuiFpenOjNY778Xw5BYgBLDJlvfez3Zx02KZDKHjCFB8cV33iOMVZVNY7XIIO6Qz1fHI71SbRHeRJ1PaFLA93xV18XSVWMF2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8137.eurprd08.prod.outlook.com
 (2603:10a6:10:3ec::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 15:47:47 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 15:47:47 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	alex@shazbot.org,
	den@openvz.org,
	khorenko@virtuozzo.com,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH 1/1] vfio: Take the KVM reference only for drivers that read device->kvm
Date: Fri, 20 Nov 2026 17:47:30 +0200
Message-ID: <20261120154730.882393-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261120154730.882393-1-andrey.drobyshev@virtuozzo.com>
References: <20261120154730.882393-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0116.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::45) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdb5673-f74f-4042-d619-08df471d9fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|52116014|376014|18002099003|22082099003|261009223027099003|56012099006|261022105027099003|261026140227099003|10067099003|261021123027099003|38350700014|261026121527099003|261028144727099003|261022075727099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	5IRvHqQ4t1PiQPca4aNsB/uJKVRVOeezJmf66XLR/b70ygYLPAbND1PZnKqVA8IWboWYCU7l95u03uKmUmohcivTOV804T+eYBBQI3v4dfddDUFl/EkZ0A1oDL8Xrv9jE+Sm+vNlw+6kxpJOR8zh3qbjCXfqc7WyKNOii/tGsx6gHzOGufXkRmXYHaazRDkl6kiCmrCa7q4BVwuHzBbGtWttNpDUE8juiMV9G2a1zBOsgRYih85pdsvETXtju9LQQ89gOevYETfsUSvz4Oxr8a3vHzv7cUJmJ8Vpw5vT5lJut/8cgT3HK5haLXfaBCyadp06+XnXY+bp04nLdqPsIDIDMXH5ypSzQ0+zNMUp9/c4r6LR1a7+N014P1YGTiHM6PjXP2GVvsVi22IoDlWyr23tCah2sdDxQoZJPmPpBfRDHW9jImGnAM3RCvkmUs/1T7JCOdX6pSKPFAMdUlq5MHXndD4cdd88aXyTefjGns+PVRBk8AJrhKXc7fPJJYcd8JyfurznMDzPL00YC43qgfl81HkxGw750Xfc1CgvMelcdDxnNExgphsxbAohrRE9kHroYSWxxfk1qP3fLBJHAflmQHEabWK1w8sbUDZRKxu4/Nb4YXiix/+JIe9WctlVI6xExvuASQXCwbeW/WKop7fAPrPdhrL5behEIl2U5oRwd8zzChs+U3XVcVfPedd+Lx6vznnfoEKGpmoJIBHRv3hJx44kE2LW5XQL+y4yYIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(52116014)(376014)(18002099003)(22082099003)(261009223027099003)(56012099006)(261022105027099003)(261026140227099003)(10067099003)(261021123027099003)(38350700014)(261026121527099003)(261028144727099003)(261022075727099003)(261102123227099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VLjhQbFdcxREXT5aMeDkKCtZJzJ2vMUgUaZ7hYx2XzfudhpnuN6N1VIhU5fm?=
 =?us-ascii?Q?GB8jjpmQutGjYcyGntPg1xlZ6bDHv+n1gLoeYWGV4I+PJV592gZNIvNxQZ1B?=
 =?us-ascii?Q?7ZbVAEv3WA662ColPeojn9RLfombM5I1cVB5NeDpznbx7cRp0kHRjEJhCRpz?=
 =?us-ascii?Q?SAVSUrmkmcxeoCkfeq0ftNNaL2HV+a7ne7rJ/hB7AXkHu7RTaYMUMmDAoyZQ?=
 =?us-ascii?Q?51hmmVtjQZnomM3R6ZrZ10Jf3DTRv3vWcWx07s95EnWgA3NP3VreTpZUyU3s?=
 =?us-ascii?Q?iMk7aarYysZD1zyNO9IDwNFIUu37ZceFEu6SEeCaNgi9y4+82AXII9wEr7oC?=
 =?us-ascii?Q?bXqSug1eLWBys7yZ8FjAwOPq94Jo7EHnDA7vQIYUAEmH6mzsAArsyuSy82fZ?=
 =?us-ascii?Q?HbCsorYw09C+knpn83AGVwr0FjpU4t4RloIvx39BO41xkSTBeVmN7LKv8g/+?=
 =?us-ascii?Q?eWt6yYWP5t1nnxHihPel7K2lt3tG4SSEtPHjXYb+cktedpKN4yAfq4i4jfnl?=
 =?us-ascii?Q?HoX66Rfvv5JU8DBoTg+ywDb+LPf2p2lnp5MHZGoGD/CTW5wQFj8vCrICUhEm?=
 =?us-ascii?Q?6wJh+DULASZrH4dDN/y7K8AiAd3QUg7D1fn/ZCzmil7msowxzLRrwjckyMkb?=
 =?us-ascii?Q?kYVGk0rZ5+abEJmNd2TzdA7wwvaIRjA2EpYiATmgAwMk3PIUrfKVAztmjr0D?=
 =?us-ascii?Q?pRzJ1/BZZ5DK2VU7RUvZYMe1xpTs3IkNPjmOMXNVVB5yKXUe3nIbydxZ6jYs?=
 =?us-ascii?Q?Nte2g8voXcEnrRwf53curBo4ABGTm/mQLBbx9ZDLAhJTwycKOvvBsfg+J6IN?=
 =?us-ascii?Q?WL5++ZRBEKQ6x+DDUP3Ir20WPfz+ZrJnnF+YtSPQjo9n+jKfEXFprwcnD9yt?=
 =?us-ascii?Q?67OiZ8IYlTnS+wZR71cnkpFN8RRVNBSCyzrufXaEle+eLz/yu5zuDIVVqC9r?=
 =?us-ascii?Q?Vf4FZNGUZ8UFbErys+zYFUqiIxbVs9dNvg7bhJG4D75Nbw0cfKZoNQZCcxUw?=
 =?us-ascii?Q?fk7+NTU9y9+psst5QA4p7UYDpTFqJdYH36LrDsPj1X4bogZ5QWpu6BMb7b0t?=
 =?us-ascii?Q?OagREVOzPlu9MA8k6hWDA7wzLiFRLsdDf64XcJaq/xfaglNnpqrrs0sU/26i?=
 =?us-ascii?Q?EYAirjWlpd0GBgXPjLZBMnPeeF/SQ7fbsi0p9JIujXNC8fiPJqSVqA3v+nE+?=
 =?us-ascii?Q?YPdEeigszGlrSzdXc0SA6CQmkHwIPL1hnFZrPCeX+RcDjhrkHaJ5UeVw4l+S?=
 =?us-ascii?Q?W9wfNz0A+UxANKdO9TF8KYZ+rxtM6hkRRAQQixLNkTrR9gVR6LLPAVDDp8nW?=
 =?us-ascii?Q?07G8QukWi/dAZM/Jz6ckWNTntlRJayA8AgAlrg2HOrzN/5YUO7bl2B5AJpYI?=
 =?us-ascii?Q?Xzhx1s9x6sDPZ7OVg6Zf0msstNbA+/nlXYeJ5tJ/DR9F142gHV3NOw15J3nZ?=
 =?us-ascii?Q?9eLzmOXc3DHYP8TL/Oj1hJ1k8C5eAmlr4as5wBvquY/cClbpsQUBYdQG/DPK?=
 =?us-ascii?Q?rI6AS1NtFBP92N4hYfXhU5WRxHzia2PC1qlYCz7SNhpTptSd3RZRQ7JHW6yR?=
 =?us-ascii?Q?l3AFaN5YUXshGczXuz1LpodeMp/RWUb3cYXkGKnFocZfAjC3IvqKiyV4zstl?=
 =?us-ascii?Q?zww698RcFJbk5a+u7zU9fdV3nrVg2qSF1uKgRaCaE7GiVm2ObwO2ExMYAVzj?=
 =?us-ascii?Q?nn50jBnMwPx1w8jbNk1RI/z1vMaG0AVWDGwwvA0LKniofaSg8C8BN1rkPkGh?=
 =?us-ascii?Q?kAaEladEGDPLNRQtjfCo5b21vomZAKc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdb5673-f74f-4042-d619-08df471d9fcb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:47:47.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JfIVZpK7tN+LmaENz2KLB9aJJ9CeUDTuXX1JHIfSqA7ga/mh2JQCcFmbwTDaaFUYw0I/ePNPcRlOTwJ4pmc1eBOjue91xxlr5oXQiNP9Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8137

A device takes a reference to the KVM file of its group or device file
at the first open and drops it at the last close, so that device->kvm
stays valid for the driver in between.

QEMU's cpr-exec and cpr-transfer keep the device open while the VM is
re-created.  The first VM then stays referenced for as long as the
device is open: its file is not released, and its vcpus, mm and
in-kernel PIT thread stay with it.

To see it, start QEMU with a vfio-pci device, run cpr-exec and trace
kvm_create_vm() and kvm_destroy_vm().  The old VM is not destroyed at
the exec, and two VMs stay alive until QEMU exits.  Without the device
the old VM is destroyed at the exec.  The new VM also logs

  kvm: debugfs: duplicate directory <pid>-<fd>

because it gets the pid and fd number of the old one.

Only three drivers read device->kvm: KVMGT, vfio_ap and vfio-pci's
zdev support.  vfio_ap reads it only in open_device(), zdev also at
close, KVMGT also at close and while the guest runs.  Let them say so
with needs_kvm_ref.  Without it device->kvm stays NULL and no reference
is taken, so the device can't keep a VM alive.

Fixes: 2b48f52f2bff ("vfio: fix deadlock between group lock and kvm lock")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c  | 1 +
 drivers/s390/crypto/vfio_ap_ops.c | 1 +
 drivers/vfio/device_cdev.c        | 3 ++-
 drivers/vfio/group.c              | 3 ++-
 drivers/vfio/pci/vfio_pci_core.c  | 1 +
 drivers/vfio/vfio_main.c          | 6 ++++--
 include/linux/vfio.h              | 2 ++
 7 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index ec62db5cc367..3e05ad946c5d 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1420,6 +1420,7 @@ static int intel_vgpu_init_dev(struct vfio_device *vfio_dev)
 	int ret;
 
 	vgpu->gvt = kdev_to_i915(mdev->type->parent->dev)->gvt;
+	vfio_dev->needs_kvm_ref = true;
 	ret = intel_gvt_create_vgpu(vgpu, type->conf);
 	if (ret)
 		return ret;
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 373ce574c431..5ec858389ba3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -786,6 +786,7 @@ static int vfio_ap_mdev_init_dev(struct vfio_device *vdev)
 		container_of(vdev, struct ap_matrix_mdev, vdev);
 
 	matrix_mdev->mdev = to_mdev_device(vdev->dev);
+	vdev->needs_kvm_ref = true;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	matrix_mdev->pqap_hook = handle_pqap;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 92627295182e..d661bdeb1834 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -157,7 +157,8 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 	 * Before the device open, get the KVM pointer currently
 	 * associated with the device file (if there is) and obtain
 	 * a reference.  This reference is held until device closed.
-	 * Save the pointer in the device for use by drivers.
+	 * Save the pointer in the device for use by drivers. Both only
+	 * if the driver set needs_kvm_ref.
 	 */
 	vfio_df_get_kvm_safe(df);
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 185f359f75d3..1b7b4f907895 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -184,7 +184,8 @@ static int vfio_df_group_open(struct vfio_device_file *df)
 	 * Before the first device open, get the KVM pointer currently
 	 * associated with the group (if there is one) and obtain a reference
 	 * now that will be held until the open_count reaches 0 again.  Save
-	 * the pointer in the device for use by drivers.
+	 * the pointer in the device for use by drivers. Both only if the
+	 * driver set needs_kvm_ref.
 	 */
 	if (device->open_count == 0)
 		vfio_device_group_get_kvm_safe(device);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..b1689f9325e4 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2173,6 +2173,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 
 	vdev->pdev = to_pci_dev(core_vdev->dev);
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
+	core_vdev->needs_kvm_ref = IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM);
 	mutex_init(&vdev->igate);
 	spin_lock_init(&vdev->irqlock);
 	mutex_init(&vdev->ioeventfds_lock);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 4e5d738ccf4b..aa26c4e4c6e0 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -476,7 +476,8 @@ void vfio_device_get_kvm(struct vfio_device *device, struct file *kvm)
 {
 	lockdep_assert_held(&device->dev_set->lock);
 
-	if (!kvm)
+	/* Only a driver that reads device->kvm needs the KVM referenced */
+	if (!kvm || !device->needs_kvm_ref)
 		return;
 
 	device->kvm = get_file(kvm);
@@ -1536,7 +1537,8 @@ static void vfio_device_file_set_kvm(struct file *file, struct file *kvm)
  * @kvm: KVM file to link
  *
  * When a VFIO device is first opened the KVM will be available in
- * device->kvm if one was associated with the file.
+ * device->kvm if one was associated with the file and the driver set
+ * needs_kvm_ref.
  */
 void vfio_file_set_kvm(struct file *vfio_file, struct file *kvm)
 {
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 0cc91c6f96d2..debf75e83cae 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -54,6 +54,8 @@ struct vfio_device {
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
 	u8 precopy_info_v2;
+	/* Drivers that use kvm must set this before registering the device */
+	bool needs_kvm_ref;
 	struct file *kvm;
 
 	/* Members below here are private, not for driver use */
-- 
2.47.1

