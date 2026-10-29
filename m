Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793277709;
	b=L2XcwLadVXArbAMXOIsj7Wm0+YNmHE5q3S6OshKGuLvr5ojAqFPDVJI0eJaR2P8X6zuY
	 q/jZ4WOl9/+t8tu6FTeqGg9F9hW5pmkZBOkLGnvm/zTuYVbCikmO432FwyCWICBKdb7GQ
	 linEvZ0p8tvSr7uPBf3o+NrTrk6KCoYCeOIjofyhA1XUaWbkcbKxJLYmk6n8TZKkXNjxu
	 sZuH9CPVreaUqWoKUDDfvFz4GGDf701OPma4D4BO6f5yOHIP8+1606JOlZWO2LoakA98p
	 WCJbexI917Qji/uu6lnJAB0TKCeQT5MAAUJx5NYL+ZBlUDeGrIGudsNRnIInLI9fiNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277709;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=IlfCkaxrTaB5puTFuxoOhA7Sw2Q92nX/SaX+B99HdMU=;
	b=E0WJ5T4EIpPtReFUvFwqyfoJPAx8xFNls1O6OZ0tQmN89Z7bnO7G4CxsFnTytVYz8oTB
	 SsiAYABDAUVaEf9fgavpDRyOQslnJhjiiQ2aB6Zr63Kl9p3mBS/S/0bPfDu4JKgvCna/w
	 69GtFkcHkVRbzyGiDBvA5w5evmJam1wa2SMD0phBzWaGE1/MKCbeEdGSa0ZAyf/DEJTGr
	 rPI2SdyF0esxPqOFO2qMxlj8Eq5Q2sZGitAMeRbah+WJKzeKeyS7Fvq7i+4JyktvoG4lp
	 Gn7cxpvNxhu25DSPHA5GEa9Rj16DWIfGUQ3dSAQcPHX5jGgcIKqfuiz1zCD7lry4GfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.eu;
	spf=pass smtp.mailfrom=zohomail.eu;
	dkim=pass header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b="Z1U5hFl/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5D606A31E
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 12:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20D5D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=Z1U5hFl/
ARC-Seal: i=1; a=rsa-sha256; t=1793277698; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jZm/8o3IRNLR3MMAIs1KqAMSNxmCgqKm1sa6HzDm8xJmCbxf8685lAneencYwKjUX/gaw2PMqttidgZtq8zpCRWu8Xv3VS3FrIUujt2Lvf4/83n2qeq2J8tYLIUg4m2b9gftY2Pyu679h5oSS8heCzXvLlZcr1lMafOgKapABgk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793277698; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IlfCkaxrTaB5puTFuxoOhA7Sw2Q92nX/SaX+B99HdMU=; 
	b=HfDz2x7e0Fb+JxwwZ+rYJ3gX3j3LiFonmUtfsSL4+CwtJhkFiEyU2PFpfsM+FuJQPKTm3u5G5xsPKYw3KYYdQ+GdwTHFaiGjMImHN64tpJ8RaSztC8DTqM0E6vp4nEsW4iJge7Hk8I7JBUUicAUmOzDGxR0XyrTkay99f/cocaU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=Z1U5hFl/B4IpEM9YQo+HAq/WOk7UCXOo6lYnF9m2TzV8+OqC7lG9bjhxJxHiHiWUY1ifcV4775CGh+3+FpxksjouqtkqzwoV/g/FNcSiOP9vFPpqhFQ/L6XTIgr9Ed4v+Nxn0L+vBDKFF6gafYe1jOgisNJj93sHqBKSvCKgCJU=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=IlfCkaxrTaB5puTFuxoOhA7Sw2Q92nX/SaX+B99HdMU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793277697278378.4156436187916;
	Thu, 29 Oct 2026 13:41:37 +0100 (CET)
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
Subject: [PATCH v2 0/2] rpmb: add virtio RPMB driver
Date: Thu, 29 Oct 2026 21:41:30 +0900
Message-ID: <20261029124132.2354314-1-harukak@zohomail.eu>
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
 drivers/misc/virtio_rpmb.c       | 286 +++++++++++++++++++++++++++++++
 include/linux/rpmb.h             |   4 +
 include/uapi/linux/virtio_rpmb.h |  56 ++++++
 7 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/virtio_rpmb.c
 create mode 100644 include/uapi/linux/virtio_rpmb.h


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.55.0

