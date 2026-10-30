Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793367027;
	b=XD4H2kLbQkSw6/A96Lf8oxPh11/BDknU7RFk1oe4wXWQluHLfxGfIl6qHF8cJWdpTosR
	 G3THJ4A/WxRmThbHBjyallyUzL65qGgwI6A14DCnCBA4kLC+5obSoqXvIZMpW1X9tAnNz
	 Rv5vLi37+Vs8QaFVm8XtU2q/prqkDYlf6W4dnUlQ5w9qqiHmnsR435/nGVHrR84nClPur
	 twcI3PjxPHHmVuJ8Xy6IWtTMLi4dLj1XGj8uvqNbRsoTyHhpIeksroClNOwESlSZ3jENa
	 /kXLQsxgXKynzTdjynao7iAXDXL8Df8ZUraH6uVi5Go96iSgmMGx/xgnG4zynaSZyXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367027;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=tSXBp/mM3Jor62eoR+K0nfkcpAJny/xKBd3jSXD8N24=;
	b=3tIutjtHzhy9dJSKR1mjL8uOn2j4VnoihiaMBuR9pCOwFiijOB8NOldaNvTrLv38t655
	 czqTv34XXB/dRgbYSUnj2jKFADJ3Ci68qRob1Tmzd3PbEDZ6gISLuU4bOKzuqKtz1zhLZ
	 dQMYigp4evvqORu9NYFj8ph6R26QV4aKJmrefkSHpESTBzt/l+5LuJ7nc0gGYKudAvU4I
	 c4N2ry5YiGb7Xghyo6g0jAGYoKy1y5UbsTQDqSHsCYCLMf+Nx40sl0YFY+c/ctTDS2o4f
	 49zHpiEM+aVwBPFI5iCe8isrcTTG4XEV9XCZI38OOWXvFOCLsRKYOASg74BM4LJkaMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.eu;
	spf=pass smtp.mailfrom=zohomail.eu;
	dkim=pass header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=RalvWQ8B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C49606A31F
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 13:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C49606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=RalvWQ8B
ARC-Seal: i=1; a=rsa-sha256; t=1793367008; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=A9QTYqSOo3bLQJAgR4tIp6ph8ZuH4TcVzPv+rsQmJU/LwKPWURUNF7FP10N/Svbnc+xqmJsx8WQs/0J1VI/uZo26LmApNwefq47KtyxXnUGpnoMbIYEng/gH5AIpTBfgUI0Dg4BfEIMZGIoOoscYnRyplzx3rePbFgd8zNw+ZMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793367008; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tSXBp/mM3Jor62eoR+K0nfkcpAJny/xKBd3jSXD8N24=; 
	b=gmKkpzbjBAM1L6k5XrY/PVKCzxoVx+U8p1pd35Ft2fK3ocu+I0ljT5RNawN6W1dewLby3y4uRc7jV97LcJYuGyJCLozwiEJwhYzBaEDNFWnz1XUFsCpFGOsec4yMiqpf46ogYbm5OCfKzkpt4+W893W7vNf5MzkIJjj5mhina7s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=RalvWQ8BXTsUpsi+4S/3Dgoky4EHifL+ya2v85ZkxqAFWxP9utljouo/4UMtBA+MCpIM1TfHV16Oxe13oBtfJIOP84pge6445lNSU4yX4Hgs+wTFeQtRlt6DR5byfTc5t1CFmG/S+gRxrqOWmMYXWT/jo6SEOrvKOY4m//LPOfA=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=tSXBp/mM3Jor62eoR+K0nfkcpAJny/xKBd3jSXD8N24=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793367005105963.2039853294061;
	Fri, 30 Oct 2026 14:30:05 +0100 (CET)
From: Haruka Kuze <harukak@zohomail.eu>
To: Jens Wiklander <jenswi@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Tomas Winkler <tomas.winkler@sandisk.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	virtualization@lists.linux.dev,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] rpmb: add virtio RPMB driver
Date: Fri, 30 Oct 2026 22:29:58 +0900
Message-ID: <20261030133000.24147-1-harukak@zohomail.eu>
X-Mailer: git-send-email 2.55.0
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
X-ZohoMailClient: External

This adds a driver on top of the rpmb subsystem for virtio-rpmb devices.

Alex Bennée had an earlier virtio-rpmb driver in his RPMB series [1]
but that stalled due to the user space API.

The one that merged later has no user space API and OP-TEE routes frames
through it so this driver only needs to implement route_frames().

I added patch 1 to fix a use-after-free that I hit while testing
removing the device (OP-TEE can still route frames after driver unregisters
the rpmb device).

I tested this with UML (virtio_uml) and a vhost-user backend I wrote
for this on top of rust-vmm's vhost-device with KASAN, lockdep:

 - key programming
 - write counter
 - single and multi block write and read
 - MAC and counter failures
 - max_wr_cnt
 - unbinding the driver when the rpmb device is held

With OP-TEE 4.11 on QEMU virt arm64 the secure_storage example TA keeps
its objects in RPMB through the driver and an object written to in one
boot is found in the one after.

I have added myself in MAINTAINERS. I would like to maintain the driver.

Changes in v3:
- Take a spinlock around the virtqueue operations, so the completion
  callback can not call virtqueue_get_buf() while a new request is
  added (sashiko)
- Do not delete the virtqueue twice when restore failed (sashiko)
- Explain the reliable_wr_count calculation in a comment
- v2: https://lore.kernel.org/all/20261029124132.2354314-1-harukak@zohomail.eu/

Changes in v2:
- Use guard() and scoped_guard() for the locks in both patches (Greg)
- Call virtio_device_ready() before vr->vq is set, so a request on
  restore can not kick the queue before DRIVER_OK (sashiko)
- v1: https://lore.kernel.org/all/20261029081317.2264887-1-harukak@zohomail.eu/

- haruka

[1] https://lore.kernel.org/all/20220405093759.1126835-1-alex.bennee@linaro.org/

Haruka Kuze (2):
  rpmb: stop the routing after unregister
  rpmb: add a virtio RPMB device driver

 MAINTAINERS                      |   7 +
 drivers/misc/Kconfig             |  10 ++
 drivers/misc/Makefile            |   1 +
 drivers/misc/rpmb-core.c         |  14 +-
 drivers/misc/virtio_rpmb.c       | 300 +++++++++++++++++++++++++++++++
 include/linux/rpmb.h             |   4 +
 include/uapi/linux/virtio_rpmb.h |  56 ++++++
 7 files changed, 391 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/virtio_rpmb.c
 create mode 100644 include/uapi/linux/virtio_rpmb.h


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.55.0

