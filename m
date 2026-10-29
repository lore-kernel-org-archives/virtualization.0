Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793261619;
	b=Mk2koYiDMCnjGBHgmlYuD8Wd1N1mBh1GYHDrcpH0Jb1iwajd4+jGzv68cb1bZJg5VeEM
	 Q5ns1i6H3G4jiRF4XMPYLFrkiLB9QScbu3Lkkh6ltLKrEhCUQCrQRU0r4dWTxJ8rPBRD1
	 7C+4GsLJofdS05ow5OJlzOzc85C3K7Oq3UH59GgEBi5BH7wP/ck3DDlCno7Fju7OwfB2f
	 MhNNGFwZGYL6lvE0rRxY1+sjkAZAAO3xZNKw+Z2UKuO08P8AAdbE8R0LgfZCy5Ojnpgjn
	 S0MPirXDNb1JkecgsZTeXLQ0fpwMss9Av22glTE+Eg1sSkH1NTz2/uPzOu3qTuyCWaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261619;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=o+i10nqF5qXBpuSwTxyLUdRhBjEMSTYWSK5VKJ6ipa4=;
	b=K+GAWQsLJa+CbPtHTlt6CZKcOickS0i1ysL2Y5CbRL881yIlbtyyFpdbNDBG0VpFyguy
	 LyEKWzbTA23EE6ikw6MySvylNKwTo4L8+yrbIttfEuwS/j3Gt4004sAQ8YPQXKCz8dAKM
	 61trQiNCz6V2OdhtFwAAroHGGCaTembTwytdY8GI+HGggH6S9TP/LDVJbvi0d1THXE8vG
	 ZM5VZ2+Gz3eig1cpdV+VSPDs5faHlw0m5i7VE2PzOduV5NgyMI/J33CdvqOcslKDvTVmN
	 Vv/fAOt2ntrR7PdKR07LfXiUuu9QFNhfgtd2CohyGMm2Gr9aVVGgnYJaCVKormAMoEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.eu;
	spf=pass smtp.mailfrom=zohomail.eu;
	dkim=pass header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=JIX1Ll9N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D50606A31F
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97D50606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=JIX1Ll9N
ARC-Seal: i=1; a=rsa-sha256; t=1793261603; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VcFJ5VshLeWeokJpto4zw5sToBHKLPJ8tum/jznnU3WxJVdcVoJpyOOh6h72mRmCKAGwlpr69hYMNTemqzvwuQ4AreJRcBZcVuPQDm6Dc5Nk/IJftNqL912zLveZqpCO/V7OGIIqJGFx2KHAWAoUiDK7qqe9fnBKCNJ0j7/7kNw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793261603; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o+i10nqF5qXBpuSwTxyLUdRhBjEMSTYWSK5VKJ6ipa4=; 
	b=Mqq8bUrEeFFSwdhFgWKrkGaK4rL4g/0FhPmn7gTX5cZlP4qYpBAN6ZTk7o6Z5ZyG9jL50xJHI3DtE+iluHKv1u9jq1QoNX+LPqZai14QND88KW+S3Lwrfs9EUr9oS8ANblXiB8vYDS7lRCCyJMo5tLmz1OXPnOjBTLJRDHdI+hE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=JIX1Ll9NlZoXfHuQy6r9be5xVUUafGG480o9XxWugX6A2CNzKf6tTM9+3shIv8DSpQqdLQMn/7A2WlrqgHCH9UwaeEr7OU5PEHuFQ6rqrDdmEBWsrPFHV4xaoO4dl2TXuEdq0VwMxMp6elTxje1eFkjFImrpRNmq2tkUk50qz5A=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=o+i10nqF5qXBpuSwTxyLUdRhBjEMSTYWSK5VKJ6ipa4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793261603070644.342366589474;
	Thu, 29 Oct 2026 09:13:23 +0100 (CET)
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
Subject: [PATCH 0/2] rpmb: add virtio RPMB driver
Date: Thu, 29 Oct 2026 17:13:15 +0900
Message-ID: <20261029081317.2264887-1-harukak@zohomail.eu>
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

- haruka

[1] https://lore.kernel.org/all/20220405093759.1126835-1-alex.bennee@linaro.org/

Haruka Kuze (2):
  rpmb: stop the routing after unregister
  rpmb: add a virtio RPMB device driver

 MAINTAINERS                      |   7 +
 drivers/misc/Kconfig             |  10 ++
 drivers/misc/Makefile            |   1 +
 drivers/misc/rpmb-core.c         |  22 ++-
 drivers/misc/virtio_rpmb.c       | 294 +++++++++++++++++++++++++++++++
 include/linux/rpmb.h             |   4 +
 include/uapi/linux/virtio_rpmb.h |  56 ++++++
 7 files changed, 391 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/virtio_rpmb.c
 create mode 100644 include/uapi/linux/virtio_rpmb.h


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.55.0

