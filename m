Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.56.87.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793291304;
	b=5n2FmfY5tllJu+Cox+1oXKpRz4nWVJt6cLxYWRAMXEj/A/bhl/M8MxcM60mCC+ZhThQq
	 pjH60PJI/k8a633C7rtMTutdBSaJS5TLQQXXLV9gU+gTg9yhsDAF99xBWYUDWWRJsqK96
	 JkoPDHt7NkL8gnWqlAAvhamLu5JFUPFl0l06mLftY8v1xZJjmqgSOpVK73B6UjmFR4ApI
	 owu6KnrRQElFFAkXuIpQyhpjROeGsB1/pTpSY41/S7dOrIBpr+g9omwzrM8z5q3JZ9hG8
	 ksSmp0Cft2C5481vUsf2e9b/DIYnBN4P+QBnilUDLdRDmvMnwflqTlxzL57If3qd6EA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291304;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=1thP92GAsnoEoj5OjQ6bprJ+2HRz52udeXPZhEvDBmc=;
	b=cyue/bynYFr6kPWZj++fIlsmKY+yX980pomI0/tBO2PKFFicK+OYbp4VYi8NBfd6ts4n
	 GUzpks0TQqkdPFbuvfcaN929u+LPqw26PjIxGkt2sy0N0Zgju6WgMC+/0k6XeBuo+67s9
	 gXpbe1r0YnSnbsp9D0gDxpa++pnN+sJSk1BXEpQyfJLHSZMcKB9+Ox2UuLfnNTCxVaKnX
	 F3bKNTCO/yY2rx38eVMw9MKg1m7QyPhvr8YgOSH9E5xB7sbvaYt+nqKxk6amuroyhVD06
	 k0srIUMObo7nhewNdEa8SN6TDxWt5e/5dz+1xSmNoIun+wFpbUF3I9UhwUDwDm+dQLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=0XZ+XnuU;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b="jNg1FV/7";
	arc=fail smtp.remote-ip=185.56.87.13
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836C606A33F
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 16:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4836C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=0XZ+XnuU;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=jNg1FV/7
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-1t00.prod.antispam.mailspamprotection.com; s=arckey; t=1793291298;
	 b=i0sdGqSgDgIEIBBNNsMkmL+uVPfLPQqcUFo/pbcOJ7YQvm0Rm0WYGxYtvBpYdKAj3ljPaGttyW
	  SMnq5ouTzlfZXbPXFjNeOPaTfmgZCxuucSqKm+4zFXi7Ej3Kd/Av0k8jAku3qL6iojMji5YXyz
	  7m3V7qFXD3uB1O3IpRCOyEqw+3eaNibO0GAFySuQAbgZzrpeU/o0+ymxgzsrLU9CRLiM+Dbn6Y
	  Nt/gQwyJs46lBrByY8i/59dApHVacJMUzas4uwLpD32hvja3NEjeCxU0cs8/r+mlpvvmBsAkcU
	  TvvqCk3qavec8nWDpWzFHzfhFzkLNxDrNrK++/IvIknqyg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-1t00.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-1t00.prod.antispam.mailspamprotection.com; s=arckey; t=1793291298;
	bh=zOojZt68/zZaw2L6iq+EX6j3FuHkpId/jG61pRsqZQI=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=DYxJQhUJtSTdJ7LUmE8Jbg2FCGSUaatEGm04/LFVG++2ETJksa2jZMid/ZlPWgiHg6yy4XAL+0
	  et1TOSDXo/wRi7nuzsKJBZ2I74dHWMEkcnsfH5x9KugzHfANuX2Pa86tH3G3DgyFNaVde4aKLl
	  YW73165LsayiRhcSKSbT1+6CYDK+SEH72vj6wFknWVQgQIWINxgbWAW1m3WWHK+D7wEPBJjVSF
	  FP9AuLFfokzCAo9Fx8K0wa9LczwkH33ncDOaWT0lamEkjwxppL+EH0fEiozPbSZsAbwfZqsmQQ
	  ypHGhfOC4muJ/Cz82Hpszhvxd8BpjQJrE0lrx6kMCS1TmA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=1thP92GAsnoEoj5OjQ6bprJ+2HRz52udeXPZhEvDBmc=; b=0XZ+XnuUH0h2u1NY5QU1xRyecX
	m9U8xlWAvO9lo+dGfoaCNlcL4y5jqCkyofVHLdcbQAs2lb/XmFzJ5mgAC8/1om0ZusTVBliG4Nl+H
	kxoXCYzeyjTeus/OTtEMTH7CUR2dV9rNp2M7/8FswlgslF/NAQJ5ffy8TSTj1J7voMWM=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-1t00.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xMSz3-0000000ACze-3l5Q
	for virtualization@lists.linux.dev;
	Thu, 29 Oct 2026 16:28:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=1thP92GAsnoEoj5OjQ6bprJ+2HRz52udeXPZhEvDBmc=; b=jNg1FV/7kFgQ9c90Kwd5XHLVH4
	WOrJofPT7y9MAO1nKx/bNYTqbKO4gFNhnnaya+/L+AWEHDSZ4LM/O0I72EGzH1CG4elMy8RaMAAMj
	rqJsWAz19tqCAJNf8rrAsFZSZDAxcW8hBB4VRAmVIzmY++Rom6P/vGq7atLAFkR1qrHM=;
Received: from [87.16.26.129] (port=60224 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xMSyl-00000000LSm-1VkP;
	Thu, 29 Oct 2026 16:27:51 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH v3 0/2] Add devicetree bindings and maintainer for
 spi-virtio
Date: Thu, 29 Oct 2026 17:27:42 +0100
Message-Id: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPyw6CMBBFf4V0bU0fCKkr/8O4aGGAMaSQtjYaw
 r/bYjQudHmTO+fcWYgHh+DJsViIg4geJ5uC3BWkGbTtgWKbMhFMVEyJmvoZaUQXcKIGbYu297Q
 rQR6YETVTmqTL2UGH9416vryyv5krNCGjcmNAHyb32LSR597boH4aIqeMVpoBdFJwaeQp6nHUe
 wwkC6L4IDj7MzKKjKjTD0aURrXlF2Jd1yd9lhEVCgEAAA==
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
 virtualization@lists.linux.dev, Francesco Valla <francesco@valla.it>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2630; i=francesco@valla.it;
 h=from:subject:message-id; bh=zOojZt68/zZaw2L6iq+EX6j3FuHkpId/jG61pRsqZQI=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmPSxgCimcr8HAz/Kh8EM4pVXhz66wVrqbP3qt8fhJ5e
 krqlN+TO0pZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJvHvMyNCS2npRwGg9179P
 QZq7XpYG3l4inm/1xc97Un6d1JRvOqYMf0WvCwUK7drguUq5TErhpGHJ1WNzvl3i+uxYdVqr/Za
 6Hg8A
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
X-SGantispam-id: 6bcafab5359745ba94e5e6b394ccf1cf
X-AntiAbuse: ID - 6bcafab5359745ba94e5e6b394ccf1cf
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xMSz3-0000000ACze-3l5Q-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-1t00.prod.antispam.mailspamprotection.com;
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
parts still not upstreamed - see [2]).

On top of that, I added myself as maintainer for the spi-virtio driver,
since the former maintainer's e-mail bounces back and its owner (Haixu
Cui) did not update it after changing employment.

Thank you!

Regards,
Francesco

[1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
[2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Changes in v3:
- Add Francesco as Maintainer of the spi-virtio driver (instead of
  Reviewer) as replacement for the former maintainer (Haixu Cui).
- Link to v2: https://patch.msgid.link/20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it

Changes in v2:
- Expanded the commit message to better explain the functionality and
  the chosen compatible.
- Redundant pieces dropped from bindings.
- Link to v1: https://patch.msgid.link/20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it

---
Francesco Valla (2):
      dt-bindings: spi: add spi-virtio
      MAINTAINERS: replace spi-virtio maintainer

 .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  3 +-
 2 files changed, 48 insertions(+), 1 deletion(-)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20260927-spi-virtio-bindings-f4e350b2709a

Best regards,
--  
Francesco Valla <francesco@valla.it>

