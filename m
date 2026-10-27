Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793086022;
	b=Fd8Nb0MFPlG1mWarYmsdYbreDkoqHgwlCGFzRkyAcPWIMD194gIu2hxHU31T2RBxC3U3
	 pu93ToCDfS6MBuBpLRao+FCk7CsrHrrV06LLLhiksMdzg75W5bHLe/zXwLqczLIu8GIFZ
	 W7ECIYh/oMIomj5Ik5mFizPtUWQpZe7qpdK8V27DSFZVEVcpDknw8yieeZn+L6yFiZoiG
	 G3YLweZ1AvLnkQhUiV4jI9Nklk2G+EB0CLlHLO698UqNk90lRKWuXApnpbEiSr86efMiJ
	 vilo3WHmgg5LFUZQkk259/RtS21jim+qNS2NU1R4fiF4moaES1idXn8lLERrrsmwwkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086022;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=YvrNepu80f9cFpozwNcGaYtrGlqF8wlvl1fpjkfzFEY=;
	b=begFUh4+7Duo47HWfikifOBUVz8ATgG9Jb7KCZgfZrrROSXROYB4Uai82GnHBHhWkUcD
	 hgerXRce5p+8uhgWdSIWHtUdNLtTEpFZ7RmHEcQlm5Aqq1P2f2s7tfK0k4shdy9mf56EC
	 JnC+nZmJj2nNMRM8x7xdtNyBrRe6PIoUISANAlcWPSNpiBOSqZEy3o32jAZF1dWSGoqYf
	 0iyNWT/1tldbFff/7idMfPM2wQ6u4uj+J9Vg8N7jB0BBrx+BNdkb8tylYsQ/fvaXJdmRx
	 ASgAOFVdPadcq2SJOkhrQi7dHoD4kAWqcJrfX+uPXF5XxyVvRjwLGNS+P4KblDigiaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=CbwVbF8B;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=THd7U1e8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.6
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87332606A31B
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87332606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=CbwVbF8B;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=THd7U1e8
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-cczw.prod.antispam.mailspamprotection.com; s=arckey; t=1793086020;
	 b=JBpdyEBFc5juwKxNinxqjaRPUp2dmc0mSpCQNX43OXg6lIFr3dAw9joVImtRMCHUjz45x80LPT
	  4fG3Q3L/6Hg/3AaS+XD28DswDKquZYaGknFlkrNdId3ZojTW4idaCMsl7WVXF4XIIJXx89aYya
	  yYM3IS4wp/31DcG4/RXQznhjvohoo41lzas/q3Z/EcXpWIK07Rv3pYvuCwCVoKa3PrN/JTJJXe
	  oVGrn5qJNpnHuom3bgUBREY+gES6LLFQJiu1X/L2PqAA1wdYQkEWWJ+N9VDUQTXQS3HrHgnHNN
	  5mCDfdnb4TfrGZ7/fnCwdHHQMtw7Lywgk641p+GpVLOvOA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-cczw.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-cczw.prod.antispam.mailspamprotection.com; s=arckey; t=1793086020;
	bh=QTK7KrPu2P6hFh9JC7pq1+BhiXAD6x7kBDIU1gAKmDw=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=6NL6RvcovumPICmEFYftahq3ZRuqJUlRZHwDWHgjkXxhcWpt7NYTQfbvYBhNhvOKaMAJp7Kx36
	  qinMBiFFMtXN9qVKFfm+Ez5jOTrtvegoCTCh/OvfgG/1zFkt1h2FSCjm4WKtV2ip9Q3fhYeT+V
	  bH4jPVOaSO+WQXNQp+3AP3FxoZG4TtZn4zpO1vmyHFmqjfwvbXK0XdZEnBvt+0SpqvYpalkEgq
	  nSPLykyS5gHbXeX0TRlA+xceoZHqmrC2xJBEUzo4JoY7uLnu40lM74YkRLoHgX6JjtKorXbELf
	  JTkZeER6wWWaB/f5P6MtGUfw8vPLHc0hnxVlGaqBb+KYew==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=YvrNepu80f9cFpozwNcGaYtrGlqF8wlvl1fpjkfzFEY=; b=CbwVbF8BkXL6KW9GP45lvvehd4
	7n9m997+ai0mXVtCf4wbxd/3sza8G+o2+240WNiZyNL2bXPNeKstK1Hr5zFZxU2jXV4Lgcbt3/mUC
	t8xhTVz5rXEIbBQTOppFxV0GbGKZB/BuA/TfknUb52lWKXTftA/YOXHn5uu1YBsGT6FY=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-cczw.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLba8-000000076jb-19hT
	for virtualization@lists.linux.dev;
	Tue, 27 Oct 2026 07:26:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=YvrNepu80f9cFpozwNcGaYtrGlqF8wlvl1fpjkfzFEY=; b=THd7U1e8Ot2Xu0BT3NaiWJ9PWg
	UGZKiEexHkquhH0KeMCA9TAHTvwte8KXijbw3h6xSZHrK4mCBS0ZTu4wtm1rq7eZqfdJlK66DHHvc
	39ZBnCfc/fXUxzYV2atTaoEksrwFCtdMamVEaGMYyx+YZCjCp11IuQtLG950fyG1chbY=;
Received: from [87.16.26.129] (port=61474 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLba4-00000000J9d-1J1C;
	Tue, 27 Oct 2026 07:26:48 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH v2 0/2] Add devicetree bindings for spi-virtio
Date: Tue, 27 Oct 2026 08:26:32 +0100
Message-Id: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr2Jm7ZjSKgRX3sOwaGGAMaSQTm00h
 LsLGHcuX/L/ezMIBSaB62GGQImFR7+CPh6g7q3vCLlZGbTSuSp1gTIxJg6RR3TsG/adYHsmc1F
 OF6q0sD6nQC2/duu9+rI83YPquKm2Rc8Sx/Desynbdr9C+beQMlSYW0XUGp0ZZ27JDoM9cYRqW
 ZYPXbeTfccAAAA=
X-Change-ID: 20260927-spi-virtio-bindings-f4e350b2709a
To: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
 Jason Wang <jasowangio@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2664; i=francesco@valla.it;
 h=from:subject:message-id; bh=QTK7KrPu2P6hFh9JC7pq1+BhiXAD6x7kBDIU1gAKmDw=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkPgrSOzmX4rOs6b6ukbtJFO4EHPVt3Nci9XLJsQ4UU8
 +bnrUJJHaUsDGJcDLJiiiwh627c2zPX/FvaBsZHMHNYmUCGMHBxCsBE8mIZGU7npT3O3XY98IVi
 6PEDe1k89bb++dnV9Oma6PonzSKPbGcxMjSsv8M7uVni8vWF5/fw71uQeNh4A9s0GZE9DkkCtpc
 7P3IDAA==
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
X-SGantispam-id: 8fd7bdc72a5a433d0ee62f463637afb9
X-AntiAbuse: ID - 8fd7bdc72a5a433d0ee62f463637afb9
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xLba8-000000076jb-19hT-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-cczw.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

When a virtio transport exposes a non-discoverable bus, the devicetree
can be used to declare its child devices (if any) and/or other
properties. To allow for that, the virtio framework searches for a node
with a suitable compatible in virtio_device_of_init() when registering
a device [1]; such compatible takes the form "virtio,deviceXX", where
XX is the hexadecimal representation of the virtio device ID as defined
by the virtio specification.

This patchset thus does not introduce a new functionality, but allows
proper validation of nodes tied to spi-virtio devices, aligning SPI to
what is already being done for e.g. I2C and GPIO virtio devices.
It was sent initially as part of a different patchset [2], but since it
complements a functionality that is de-facto already there and is useful
beyond that specific use case it was sent separately (also following the
maintainer's feedback there to separate it from remoteproc-specific
changes).

This was tested both with virtio-mmio using qemu-system-aarch64 and with
remoteproc-virtio with a Zephyr backend (with relevant remoteproc-virtio
parts still not not upstreamed - see [2]).

I added myself as reviewer for the spi-virtio driver to be CC'd on any
patch involving the new bindings.

Thank you!

Regards,
Francesco

[1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
[2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Changes in v2:
- Expanded the commit message to better explain the functionality and
  the chosen compatible.
- Redundant pieces dropped from bindings.
- Link to v1: https://patch.msgid.link/20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it

To: Haixu Cui <quic_haixcui@quicinc.com>
To: Francesco Valla <francesco@valla.it>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: virtualization@lists.linux.dev
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Francesco Valla (2):
      dt-bindings: spi: add spi-virtio
      MAINTAINERS: add Francesco as spi-virtio reviewer

 .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +
 2 files changed, 48 insertions(+)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20260927-spi-virtio-bindings-f4e350b2709a

Best regards,
--  
Francesco Valla <francesco@valla.it>

