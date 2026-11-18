Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046250;
	b=bC2cQ4SNgtPZJ9NjtF6cN9nL0+W72CkP7bWLy+Logv2MGscOKUOxoYm7Tx2Q1vkHmLG9
	 twcQuPqJmA8gJb4gOvjhDf9ZNt4Hw0bwV4sSOHoAPM8SvbeHFQUGtjMpjqYInD3XAevSQ
	 IX/p1ofeMkEgan51EzJeIqYZygpBnP6Y188v7zfAZ+4v9Pryk8STih7RYSScT07lg+04Y
	 Z9jcwtuwPBkzAc8FUD+xNCqR0y4QnKEJukseudL6ceXOQyVqcYxEC5VgrceOJ+Ypl4j2T
	 iI9hxnfHBjxylmEGhyRxFQzmZo78xeDQ4FLw9AVgi+AfDruZKPWCKZk6/NVYUGba1Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046250;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=B4zFjEL5hlhQrSt2smgrlHZVn55qIbn5+9S0rz2RBas=;
	b=xWRHO46L5ILir1z7JBrWPqnm/CBSiZQozVTsPqmAIQQ9lvTAPLZJ+NaQSYvAss9wEOFS
	 SE1J/J2QNn6rhGyQwEAmWIYRUH1zBWP61P11+0ZKIE2Ox7Dt3Q9zmk0oQwENGf/DOVd5j
	 3F+RvaKjQXOdvKimLB3sQ97sZuxTu2+4V5A63Yutm+oy7DI7ZgqVR/G9fVLh9XiMDrUoc
	 Vxijz162lOcY4EeOExeFSUAYmr8bnIgGl2fiQt6UuekZPT/1cTd6C5SzhKsKycWhhwTOE
	 6Lx8wK6EGO0nYezLwBeCDsMbEPJZxhtPz4rlQFDDoXEiEvc6Ul2ROSxap0ldxmYyVEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=jhChCI27;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=oKNtFcR7;
	arc=none smtp.remote-ip=103.168.172.141
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484160A2607
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 23:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5484160A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=jhChCI27;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=oKNtFcR7
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 8E1C813819DA
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 18:57:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 18:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795046248;
	 x=1795053448; bh=B4zFjEL5hlhQrSt2smgrlHZVn55qIbn5+9S0rz2RBas=; b=
	jhChCI27TV0AUe3b/OxSOD4nN2iBvo0mrgoeO6U99iuz/83bXfUyuTNSNKQTRno4
	MU4OLYd12tVJtLPOC4q3YKounCyXILO8+Dce3nwTC277Qq/bX6TwMeCRXf3DC780
	qbxJLTdiiwXghIba0ZyVnIBlsIAUGSvnl/wtHcHHbL9eWeJLo9HTg7AeYm4wu52y
	WW5ksSo4mW7ABZgWHmkHOZn5Z/sOPQ5AWllSji1yfzMGYwuhgBOleoB59ROkK/67
	fnGLXf3DB0KHURCzbwnpM0ebq3nmoPPYWU+M555JuKHRroRUVGyRadl8I0oO9LIj
	5Kx45kJPSRX5aWlL8eHWEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795046248; x=
	1795053448; bh=B4zFjEL5hlhQrSt2smgrlHZVn55qIbn5+9S0rz2RBas=; b=o
	KNtFcR70DVjYBfQi1evQJ2By4kJtIi0MW4f71HgMh9FX69hVTo3SPkTZpPr1eoW2
	fkRlTLtN+Ij+6RuMKKvr/hYrps+MDdwlDnU63FxILssh7XBdzIpKWt4kNs2kkgGF
	zAaP0ONbV1XQhJcW3VdfDZSlPd8mYA6l68hckKA94RF5x323FWK9zdsANjw5Ue91
	gtlOt9aCHV9EvNIFf/1toXez4eZG+zrntjM+FqYQnPacW4vxBAxW87zOGd35qPvu
	b1rZYCwiB3LMG2xHatxYGd/pKQW8N2b4lFMg7Q8e08ijwzrCABlgmKOntZ3Oolsp
	P8wOI0uy5r/STHlS41fww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795046248; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm2:rsa-sha256:ucgvgY3MoF8GtuUhegvJ8YAenWsDKXBIZfzYJmMKmJPBO0q
	CHeverwcoh4nSADiZi8YoklGAyQ0mlC4GHZML6IhGc1VqGdL43ExQbZpu0g114rh
	5j+YAdOFCEXtZCPyS3EJLtlwu/PhtNNX5mf6wqHX5segJ6AI/0d1JmbZbXBpjCXu
	01y+N4CHWwQaShUbltH/3BfznQzmRQHEqZkJT0RvFto8R/XszZr8+TYH4OrSshEv
	35oLF/LHxjOZ6Uizlfkquu3LQTZOSejKSOqMadR6cK2c/McfljirXRoIf6DBr4gi
	dmF16CCzn2KIsFZAIm0wphTAlzEzT5YCdXHd+QQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qog/qb0ddv/KJY5cf9DNh/IItNoaVRZb1M1r5Mk/ZL0=:zdUGlLVrHk0sg6/jTFIok0PVKmmRpFzoo1hWrECnnaY=;
X-ME-Sender: <xms:Zjv-aqfnz5xmurs_GHsqTWy6lXiC0lL2J1trjzRetqE9iXsPfAHA9A>
    <xme:Zjv-arPTiRXQ_nYvYXkFMB5hr9FlB4VMtPzWshvTyK-QC0xlM9jJbOyrfhNR_Op40
    ZfqKomxiUCilnEtutoYyJ13lFEywsc3rpEAdnOzkDxCE2ns2xSQcg>
X-ME-Received: <xmr:Zjv-an0yUoDjq_5V2rAUugRk4GcrVzcsLEpbentKeOXxYwzEK38B2WPHWTFajMnTQ7_KQc6S3u4>
X-ME-Proxy-Cause: dmFkZTETr3a90om7ZcxKHjLHiqlEITvFRz7EG4g8nD0o633cA3uUqXNQzqyRCqHNmFHd0d
    zzK7udLaJMcv0zL0xjQNuLrOosegpV0KyCxl59ibhiuUcdaPuW0gIZ/BO5XlQ24ypBWVMX
    c+3koyrttcdMTEx6oKP82WiXEOp2ZY2ktCOIEZstACd6F+alceiHjDBixJEKURxmB9PUEY
    As8xQ+NktmnMGJIPT2ravKfkS4AvdxWe7CxmkHGqjCUif+f7TZm5FrutIqEazF8ylYiwSd
    lfR2xIhVUJgfis7MYUtXAG4tw5UUZ5KM0TY0M61y0jv5NwUbtXsOR/u6AhRD1A5l5Rofcy
    MdExTJQ2HeZuU8vuLrFvl7X7bh2ObYgm62G/Q/CS3qUEiJ3Meo6fWxZhI8FK8Qg8wEzyHF
    Ob1e1xavbZ+rXIy/Qld57huC2fxa9HIUaAxoC36fOkjrhV2CYCf17C+9q99ANiZ2SI3zOl
    pBTcJe5PUTfgs63+2Mk2TWommQzhhm9+KR4jEzdzbHvUoFzTAGJpRXU6+oDQNns2ebmqWg
    S+dEzIHXPA4/4UwaITH+b7kbX9D0Z0LvcSlw+zJ5laplspIyz6QRx6ax1qb4AbCgvhlH+X
    KU4Jt0oomr1gCRGwiUyuZdmNQztO+VkcjXafPorfNIk7xYzscAIBFhCR10SQ
X-ME-Proxy: <xmx:Zjv-au1jFUxaVkqvTf2_nGHRo7pEFwmRIYqfWMIz-PTGEkOIyNR08g>
    <xmx:Zjv-atV6qbBh_xJ8tB0a0RxVNialdFZXQI2TkGrZM3go_j4scCwaOA>
    <xmx:Zjv-aggzyYqS6mcl6Ey1awRnIhE-m_e8Ge6vqf3sRdgFpCsQ8ckVnQ>
    <xmx:Zjv-agIcA0qovO-trbGtL7hLD3B4qd41NvIRWEpMpdyfKV7a8xnPfA>
    <xmx:aDv-anCw6RIdfILW7MNW1DXCVNCv0UKHb6z_PrXssdXRW1kCf4EsoqIQ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 18:57:22 -0500 (EST)
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Lechner <dlechner@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Eric Auger <eric.auger@redhat.com>,
	Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	qat-linux@intel.com,
	virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org,
	kvm@vger.kernel.org
Subject: [PATCH] vfio: Allow untainted use of driver_override
Date: Wed, 18 Nov 2026 16:56:44 -0700
Message-ID: <20261118235645.2907908-2-alex@shazbot.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Driver overrides are the standard mechanism for binding vfio drivers
to devices.  With the introduction of the support_driver_override flag
in the core driver struct, it's now required for drivers to declare
themselves as driver_override compatible, otherwise driver_override
bindings will be denied or generate a kernel taint.

Set the support_driver_override flag on the driver struct across all
vfio drivers.

Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: Longfang Liu <liulongfang@huawei.com>
Cc: Ankit Agrawal <ankita@nvidia.com>
Cc: Brett Creeley <brett.creeley@amd.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Julian Ruess <julianr@linux.ibm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>
Cc: Nikhil Agarwal <nikhil.agarwal@amd.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Mostafa Saleh <smostafa@google.com>
Cc: Pranjal Shrivastava <praan@google.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: qat-linux@intel.com
Cc: virtualization@lists.linux.dev
Cc: intel-xe@lists.freedesktop.org
Cc: kvm@vger.kernel.org
Signed-off-by: Alex Williamson <alex@shazbot.org>
---

Uwe, this should cover all the vfio drivers that expect to use
driver_override.  Thanks,

Alex

 drivers/vfio/cdx/main.c                        | 1 +
 drivers/vfio/fsl-mc/vfio_fsl_mc.c              | 1 +
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 3 ++-
 drivers/vfio/pci/ism/main.c                    | 3 ++-
 drivers/vfio/pci/mlx5/main.c                   | 3 ++-
 drivers/vfio/pci/nvgrace-gpu/main.c            | 3 ++-
 drivers/vfio/pci/pds/pci_drv.c                 | 3 ++-
 drivers/vfio/pci/qat/main.c                    | 3 ++-
 drivers/vfio/pci/vfio_pci.c                    | 3 ++-
 drivers/vfio/pci/virtio/main.c                 | 3 ++-
 drivers/vfio/pci/xe/main.c                     | 3 ++-
 drivers/vfio/platform/vfio_amba.c              | 1 +
 drivers/vfio/platform/vfio_platform.c          | 1 +
 13 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index 28dc8c825600..fb7679bf92fd 100644
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -358,6 +358,7 @@ static struct cdx_driver vfio_cdx_driver = {
 	.match_id_table	= vfio_cdx_table,
 	.driver	= {
 		.name	= "vfio-cdx",
+		.support_driver_override = true,
 	},
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 15b05b8c0c90..1603f81e0257 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -597,6 +597,7 @@ static struct fsl_mc_driver vfio_fsl_mc_driver = {
 	.remove		= vfio_fsl_mc_remove,
 	.driver	= {
 		.name	= "vfio-fsl-mc",
+		.support_driver_override = true,
 	},
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index c82c59246a3f..5c56aff8db01 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1737,7 +1737,8 @@ static struct pci_driver hisi_acc_vfio_pci_driver = {
 	.id_table = hisi_acc_vfio_pci_table,
 	.probe = hisi_acc_vfio_pci_probe,
 	.remove = hisi_acc_vfio_pci_remove,
-	.driver = { .pm = pm_ptr(&hisi_acc_vf_pm_ops) },
+	.driver = { .pm = pm_ptr(&hisi_acc_vf_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &hisi_acc_vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/ism/main.c b/drivers/vfio/pci/ism/main.c
index cce3bdf1f070..263b377e87c4 100644
--- a/drivers/vfio/pci/ism/main.c
+++ b/drivers/vfio/pci/ism/main.c
@@ -399,7 +399,8 @@ static struct pci_driver ism_vfio_pci_driver = {
 	.id_table = ism_device_table,
 	.probe = ism_vfio_pci_probe,
 	.remove = ism_vfio_pci_remove,
-	.driver	= { .pm = pm_ptr(&ism_vfio_pm_ops) },
+	.driver	= { .pm = pm_ptr(&ism_vfio_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &ism_vfio_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index 18a6d224b1fd..63c89e461be8 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -1451,7 +1451,8 @@ static struct pci_driver mlx5vf_pci_driver = {
 	.id_table = mlx5vf_pci_table,
 	.probe = mlx5vf_pci_probe,
 	.remove = mlx5vf_pci_remove,
-	.driver	= { .pm = pm_ptr(&mlx5vf_pm_ops) },
+	.driver	= { .pm = pm_ptr(&mlx5vf_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &mlx5vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index 5ddec340b73b..946da32c61ff 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -1438,7 +1438,8 @@ static struct pci_driver nvgrace_gpu_vfio_pci_driver = {
 	.id_table = nvgrace_gpu_vfio_pci_table,
 	.probe = nvgrace_gpu_probe,
 	.remove = nvgrace_gpu_remove,
-	.driver = { .pm = pm_ptr(&nvgrace_gpu_pm_ops) },
+	.driver = { .pm = pm_ptr(&nvgrace_gpu_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &nvgrace_gpu_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/pds/pci_drv.c b/drivers/vfio/pci/pds/pci_drv.c
index cf7e33d4d17b..1fcef987f1b0 100644
--- a/drivers/vfio/pci/pds/pci_drv.c
+++ b/drivers/vfio/pci/pds/pci_drv.c
@@ -184,7 +184,8 @@ static struct pci_driver pds_vfio_pci_driver = {
 	.id_table = pds_vfio_pci_table,
 	.probe = pds_vfio_pci_probe,
 	.remove = pds_vfio_pci_remove,
-	.driver = { .pm = pm_ptr(&pds_vfio_pm_ops) },
+	.driver = { .pm = pm_ptr(&pds_vfio_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &pds_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
index 69448fa57df4..8a616f9b6494 100644
--- a/drivers/vfio/pci/qat/main.c
+++ b/drivers/vfio/pci/qat/main.c
@@ -695,7 +695,8 @@ static struct pci_driver qat_vf_vfio_pci_driver = {
 	.id_table = qat_vf_vfio_pci_table,
 	.probe = qat_vf_vfio_pci_probe,
 	.remove = qat_vf_vfio_pci_remove,
-	.driver	= { .pm = pm_ptr(&qat_vf_pm_ops) },
+	.driver	= { .pm = pm_ptr(&qat_vf_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &qat_vf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e7c012febe91..fde2c3fc88eb 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -260,7 +260,8 @@ static struct pci_driver vfio_pci_driver = {
 	.remove			= vfio_pci_remove,
 	.sriov_configure	= vfio_pci_sriov_configure,
 	.err_handler		= &vfio_pci_err_handlers,
-	.driver		= { .pm = pm_ptr(&vfio_pci_pm_ops) },
+	.driver		= { .pm = pm_ptr(&vfio_pci_pm_ops),
+			    .support_driver_override = true },
 	.driver_managed_dma	= true,
 };
 
diff --git a/drivers/vfio/pci/virtio/main.c b/drivers/vfio/pci/virtio/main.c
index 123ff5193812..1e02a8fd4a61 100644
--- a/drivers/vfio/pci/virtio/main.c
+++ b/drivers/vfio/pci/virtio/main.c
@@ -222,7 +222,8 @@ static struct pci_driver virtiovf_pci_driver = {
 	.id_table = virtiovf_pci_table,
 	.probe = virtiovf_pci_probe,
 	.remove = virtiovf_pci_remove,
-	.driver = { .pm = pm_ptr(&virtiovf_pm_ops) },
+	.driver = { .pm = pm_ptr(&virtiovf_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &virtiovf_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index 7dab3e024aa8..e0ab61f604de 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -592,7 +592,8 @@ static struct pci_driver xe_vfio_pci_driver = {
 	.id_table = xe_vfio_pci_table,
 	.probe = xe_vfio_pci_probe,
 	.remove = xe_vfio_pci_remove,
-	.driver = { .pm = pm_ptr(&xe_vfio_pm_ops) },
+	.driver = { .pm = pm_ptr(&xe_vfio_pm_ops),
+		    .support_driver_override = true },
 	.err_handler = &xe_vfio_pci_err_handlers,
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
index fa754f203b2d..2c87caf1b7f7 100644
--- a/drivers/vfio/platform/vfio_amba.c
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -137,6 +137,7 @@ static struct amba_driver vfio_amba_driver = {
 	.id_table = vfio_amba_ids,
 	.drv = {
 		.name = "vfio-amba",
+		.support_driver_override = true,
 	},
 	.driver_managed_dma = true,
 };
diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index a4d3ace3e02d..93d06032cdde 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -116,6 +116,7 @@ static struct platform_driver vfio_platform_driver = {
 	.remove		= vfio_platform_remove,
 	.driver	= {
 		.name	= "vfio-platform",
+		.support_driver_override = true,
 	},
 	.driver_managed_dma = true,
 };
-- 
2.54.0

