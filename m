Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9604BF93E;
	Wed, 16 Sep 2026 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593094; cv=pass; b=V+ALnW7gKLjsMP4z4V3UrA2OTYvc9weNC+t5hKlQ4BCHtohLWZ/DLfRtvj9i1aK5KF9uBoQBCjCeuKdm/Lz65MNEkW1my0mfY/RC0XoIvcaWYvDXj6kPW7ClQlceDMK9vG6iqugWiWosKhxDP3SAPdg+32KqZ1QlYYuAsOB0wqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593094; c=relaxed/simple;
	bh=2LZ1fVhkv85MRMHADmROzKC+YrFJIScmDdtzlVxHDq4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CLP2ca9b0y2RA/dFqm4QJm4pyI8vNQMnNvO/2vkajlvvreT+pY4759dPlFC9HabnyohcCC7guP9ju810hfYgj14tztf3tyjcZ1Afj2NzVN1oFGzffQReCM6Zdkhu8iO3aP4vpRgqUVy+eP0XG2zIbOotT4EAJe0RQt0aNDtMrxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=te1fvP2h; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=AFSi5nlo; arc=pass smtp.client-ip=185.56.87.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="te1fvP2h";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="AFSi5nlo"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; s=arckey; t=1789593078;
	 b=LeMiDEj7BR+rayleEUe35W+unpvAx/uSTx5NGHYDjOVDhGFLFQPhGpL49KogXwEc0UJzpeXJkq
	  ZnrKJ1ybLLUJPpuEQqvfPvT++y9i8F9lc6L3RDa9t+TNw9eRDdAbk8y2bJAlSCVxybsaeMEg9a
	  qgw6ojR6BZV6MemEXfyXuBENaV/QsockvNapOArEVOqD8H5yF7QtSdDPixH73GJLGa8v7mQOFD
	  6ApBc9qrObkRzToTuh3YeAAqKFSHRwMDRSah0X0YeRgB3lCYaJHL7ztBAgmsj80/bdJECuT1ac
	  5kiWLq0hADBp+/EP63IstiPdViqKDm2X5Zae6NclKWt6Hg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; s=arckey; t=1789593078;
	bh=2LZ1fVhkv85MRMHADmROzKC+YrFJIScmDdtzlVxHDq4=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=bkpSc1e6ShcQ5Ux+QppiZKFztLypzXrkADH+Cmcfd4JxITAVQtbjVFsL6T3S5+T0yhb2+e0bvT
	  ZjL2JUrGMU0/28k0bSloUxHM/kz+qaTMj/N+ZPFgO65aeA/YUjY7ckSl9AILdM9fzXtHMGydyX
	  tzJJLpGQP7QJzJP6eP1VFkDFVFDKkVzQpkcYxq2rBlihwfQKcPxyHsLxygmPJomCDun2ZEzwQI
	  PPh1AGO4uFZkzeZBtocy5bEFQu93TtUbcTQk0mWN58B3JAS+WMBTj7aBvedkbl6zps1chQ6oFj
	  WIbt1uiTq9zDzjt4k1SVrlUQHv7yk+sLqdbTLQfg3kB6qg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=Po+RokqT72xi6/swJRWA/WKK6DdGWwXE5nveqQhmzsc=; b=te1fvP2hghS75TOhthasnpStga
	7dXEwlz6dX1ywMp64lBD8pY7LH1rZfbJYlzLEhQTVBOGD5l8V2OjcyQwIwBiQGdDKdqzGRt23xlU4
	yIC/NsE6hxhXf75HLzkhnC5+SRWRBfoM5ZwJgY/Lzz85d6qb3H9fGZ6WxWeunvI9UO5g=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6wuI-0000000BheF-3Jhv;
	Wed, 16 Sep 2026 21:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=Po+RokqT72xi6/swJRWA/WKK6DdGWwXE5nveqQhmzsc=; b=AFSi5nlorg4P4NoThB2KNHBMzt
	OuTdtUNPCXJ432GM3Mk36q/a9SaksyLoDIANMC277HJa1Hds6agkwg9UwGK3ZfpG4lovY0PEgqbe1
	NBxkNiWSnZPd5RLH4IdYfjx99TnI7Zg9/UusqVZeQhPxuyD3YyjnQ1HFJE+mJsyPal80=;
Received: from [95.233.221.121] (port=62880 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6wuD-0000000058P-2zEG;
	Wed, 16 Sep 2026 21:11:01 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH RFC 00/12] remoteproc: add support for any virtio device
Date: Wed, 16 Sep 2026 23:10:45 +0200
Message-Id: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBQFr1Le2kAbjaBbwQN0K1KS+KNfaBN+Y
 hFK727U5QzMLMgkTBnHZoHQzJnjVKHbNPAPO91J8a0ydKv37aEzSmiMhZJEP8wsheMw2qScD1t
 tTbDO7FDbJBT4/fte0J9PuP5lfrkn+fI9Yl0/ay11Wn4AAAA=
X-Change-ID: 20260915-remoteproc_virtio_map-bcf32a5fab54
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, virtualization@lists.linux.dev, 
 imx@lists.linux.dev, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8074; i=francesco@valla.it;
 h=from:subject:message-id; bh=2LZ1fVhkv85MRMHADmROzKC+YrFJIScmDdtzlVxHDq4=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmrWR/vXhFxs1O+ZeNzaR+WR9EbP8ttnyMXWhxp7Mv2L
 qdEO2RTRykLgxgXg6yYIkvIuhv39sw1/5a2gfERzBxWJpAhDFycAjCRpxcZ/plsdVz343C7wAax
 WPGU7orpm26Ui78507JUnPG39fbYnwmMDD+nfuphvLDs5hav9z6vt0trb5OcyLrrWbF8ADPb68r
 TT7gA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 1e67c402b852c0b2be038bcff4eb799f
X-AntiAbuse: ID - 1e67c402b852c0b2be038bcff4eb799f
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x6wuI-0000000BheF-3Jhv-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello,

this patch series introduces the possibility to support generic virtio
devices over the remotepoc transport, whereas today only rpmsg and
virtio-console are supported.

== Introduction ==

Support for devices other than rpmsg was originally planned [1] and is
declared inside the documentation [2], but is in practice not there for
the majority of (if not all) the platforms that provide remoteproc
capabilities due to memory allocation.

While vrings are pre-allocated in an area that is reachable by both the
local (i.e.; Linux) and remote processors, buffers produced by virtio
drivers aren't, since they typically get allocated through kmalloc.
The aforementioned rpmsg and virtio-console drivers instead use a trick
to overcome this limitation and allocate these buffers directly from
the remoteproc device's coherent memory area, somewhat breaking the
separation between the driver and the underlying transport.

== Well, nice, but why? ==

Main usecase is sharing/virtualization of devices in hypervisor-less
mixed-criticality contexts, where a subset of peripherals are controlled
by a "safety" real-time processor but still need to be used by the Linux
world. Several solutions have been / are being proposed [3] [4], but
none of them re-uses the existing, standardized virtio specifications. 

== The proposal ==

The proposed approach is to introduce a bounce buffering mechanism that
is transparent to the drivers and can expose to remoteproc devices only
memory areas they can access. This is obtained by defining the .map
memeber of each registered vdev and use the map() and unmap() callback
to bounce data to and from the remote processor, just like the swiotlb
framework is doing in other contexts, using the device's coherent memory
area and the associated functions to allocate the bounce buffers.

During the map() callback the address of the incoming buffer is compared
against the coherent memory address base and size, to pass through
buffers already suitable for remoteproc usage (e.g.: the ones allocated
by the rpmsg framework).

== Status and open points ==

The series was tested against a custom Zephyr application [5] running on
the Cortex-M33 processor of an i.MX93 and exposing six different virtio
devices:

  - rpmsg
  - entropy (rng)
  - gpio
  - i2c
  - spi
  - can

On top of three of them (unsurprisingly: i2c, spi, and gpio) several
devices where declared inside Linux devicetree and successfully used
(well, technically I'm still experiencing difficulties with gpio
interrupts not firing on the M33, but that's not really related to the
series). 

Several open points are still present, and needs to be either
investigated or discussed:

  - for each bounce buffer an entire page is allocated from the coherent
    memory pool; this is a waste for most of the allocations, which take
    on average 32 to 64 bytes. An option can be to initialize a DMA pool
    on one page and allocate small buffers from it?

  - the support in its current form allocates more memory than before
    (for bounce buffer tracking) also for existing usecases (i.e.,
    mainly rpmsg).

  - an additional issue still exist - and is not solved by this series -
    for a subset of virtio devices: communication through the device's
    config space. The remoteproc transport expects this config space to
    be somewhat constant, and there is no provision to sync changes made
    by the driver with the remote device. This prevents e.g.
    virtio-input to work.  

  - device de-registration on remoteproc stop is causing oopses (under
    investigation - might no be strictly tied to the series)

== Patches breakdown ==

Patches 1 and 2 are cleanups to the remoteproc-virtio driver and could
be applied independently of this series.

Patch 3 was submitted a couple of months ago [6] and paves the road for
the actual support of generic virtio devices, removing the fixed number
of 2 for the vrings associated to a vdev.

Patch 4 introduces two new APIs for coherent memory areas associated to
devices that are used later.

Patch 5 might somewhat be controversial, as it unconditionally defines
the VIRTIO_F_VERSION_1 feature for all vdevs. This is required to
support some virtio device types, and there is no other mean of
defining it, since the field reserved for features inside the resource
table is limited to 32 bits. Given that the 1.x virtio specifications
are ~10 years old this still seems reasonable.

Patch 6 is were the bounce buffering mechanism is introduced; another
feature (VIRTIO_F_ACCESS_PLATFORM) is there unconditionally defined to
force the virtio framework to use the new map APIs.

Patches 7 and 8 are new devicetree bindings, the first for spi-virtio
(modelled against the existing ones for gpio-virtio and i2c-virtio) and
the second for declaring virtio device inside a devicetree. This is not
required for some devices (e.g.: can, net, gpu), but for others is
necessary to declare child devices and link them.

Patch 9 is used to convince the remoteproc-virtio transport to parse the
bindings just defined; it is worth noting that the virtio framework
already has the support for devicetree declarations and this adds only
the glue between the existing support and remoteproc.

Patches 10 and 11 are i.MX-specific and enable the usage of the newly
introduced support on this family of platforms. The first one might
probably be sumbitted as-is independently of the series, as it aligns
the behavior of imx-rproc to the other platforms in relation to mailbox
usage.

Finally, patch 12 is the PoC that has been used to develop and test the
series and shall not be merged.

======

Thank you in advance for any comment you may want to leave.

Regards,
Francesco

[1] https://lore.kernel.org/all/1330589497-4139-1-git-send-email-ohad@wizery.com/
[2] https://elixir.bootlin.com/linux/v7.2.5/source/Documentation/staging/remoteproc.rst#L26
[3] https://lore.kernel.org/linux-remoteproc/20260721204704.400781-1-shenwei.wang@oss.nxp.com/
[4] https://cfp.embedded-recipes.org/er2026/talk/PCYPJP/
[5] https://github.com/WallaceIT/zephyr/tree/multi_vdev
[6] https://lore.kernel.org/all/20260621-vring_flex-v1-1-c6c582fbe94b@valla.it/

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Francesco Valla (12):
      remoteproc: virtio: cleanup rproc_add_virtio_dev error path
      remoteproc: virtio: replace commas with semicolons
      remoteproc: virtio: support dynamic number of vrings
      dma-coherent: add base and size APIs
      remoteproc: always report VIRTIO_F_VERSION_1 feature
      remoteproc: virtio: add bounce buffering for data buffers
      dt-bindings: spi: add bindings for spi-virtio
      dt-bindings: remoteproc: add remoteproc-virtio
      remoteproc: search for a fwnode during vdev registration
      remoteproc: imx_rproc: always use non-blocking mailboxes
      dt-bindings: remoteproc: imx-rproc: support virtio
      PoC: arm64: dts: imx93-11x11-frdm: add multiple vdevs

 .../bindings/remoteproc/fsl,imx-rproc.yaml         |   3 +-
 .../bindings/remoteproc/remoteproc-virtio.yaml     |  89 +++++++++
 .../devicetree/bindings/spi/spi-virtio.yaml        |  52 +++++
 arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 128 +++++++++++-
 drivers/remoteproc/imx_rproc.c                     |  49 +----
 drivers/remoteproc/imx_rproc.h                     |   1 -
 drivers/remoteproc/remoteproc_core.c               |  43 +++-
 drivers/remoteproc/remoteproc_virtio.c             | 222 ++++++++++++++++++---
 include/linux/dma-map-ops.h                        |  10 +
 include/linux/remoteproc.h                         |  24 ++-
 kernel/dma/coherent.c                              |  34 ++++
 11 files changed, 562 insertions(+), 93 deletions(-)
---
base-commit: 9b87fdc9af2fbfcdb5c24a64139685ef80f6573f
change-id: 20260915-remoteproc_virtio_map-bcf32a5fab54

Best regards,
--  
Francesco Valla <francesco@valla.it>

