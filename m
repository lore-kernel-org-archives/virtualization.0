Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795490486;
	b=cjL+5OFUDlFcWmQa1ObC4jeokhx7c+w8W4+mPt4/ig18NbY0opNj5X0p5k1stP0/H87o
	 2WozBF572oKvgknPkH7Bu1b4cip9LLTu8aJ/ggvgc2RGO/tga2MINph/4lbNOjW4iWPaK
	 vLzamTGfPldYELgLYd+xFMsNyER5dXj+ZFqiwCkEjEVTQiEfr1P9MWCu1rn8kWkvZHoJ+
	 L2bJh8Yxc7GjErZmkEVFVLhDWf5wyGRsAXDz+fjrMzd2CusNNYrvQYe5plgO1sp5HrvXT
	 MAgl4NO+pY6FBPeQ70/vupBkSxzHbLscclZfi5wZC+zNrPNNguoqPkuusQckxXhxsTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+Nl+jLjFcED3vClIKXM3yAqVJJrqmqx+RtOw6zm+9fY=;
	b=YTLdSob1SYmDqLEm5ZfkvOpv5gM07HVEZ/BpayPRYeIB6dcoZarVhVKpsk/l2lwNT2vB
	 /gu2ylJiAInODjf4V2PSK8XO/BsADvfuSr8uhG4GGhMFgMkVtTVvIiMgiq+F3wJYfZBJ8
	 tKYV6XJFIpmwPVlqHfO9s95hA4FnVh9c/mPBgtPCmCVd696e+H3AWqHeq9EAF9yU5KhPn
	 xH4RTgcrOMXIOqb+omu5wzJrZh3ApqVL+gDITceTE+iXLAF+4uWp2fqVV2ko2MdH0AIMg
	 1CbTS4AqGvzpS5bVKkmk65BnezCPlZzuRQWFxe6Y1Sb+mBJ5tfYnQ4Zk/PWsexBearg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yOmOXqQH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E44606A321
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 03:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5E44606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yOmOXqQH
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67583c777abso4151699d50.1
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 19:21:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795490485; cv=none;
        d=google.com; s=arc-20260327;
        b=WUr7ETuOx4w2YhOsHeCDxhQr73RUJQfzWlwmjKKUdRJrxdXN+ekKLrpYWGeWdaixbL
         lpOfwuMKB/4EEvH1RTW4itrGsfewldGt8Q9jtPxAp8y4PK5VWZn08y7IG3+yc7CNkazF
         z+oQAPWsc8bw47VOF5Vzup0C2P39VJt1PgFjQg+GW9OmluEBgeOroANizouiXOMiwjSa
         24pBQSp/aA1iJPlNku416XX5Hq2/5IgJInqDOB2W7tPdH7tGto+UZlF40LmQ00vm69V5
         TcMjGH3YSRYgoQzfkyUxSV7+J5V59zit0IdSgDGsScI/nQOTzkSeFBiBGynkQ3glktPH
         kAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=+Nl+jLjFcED3vClIKXM3yAqVJJrqmqx+RtOw6zm+9fY=;
        fh=0TM075DC105kXQoBHdPEkYtTebIv0UpJqb2/Q5OtCFE=;
        b=UVwQpBoZqx+O/hFwKFZccPcrHQrv/80VLnFM364XUDWT/95gMzFHAbBJSwuoWoart0
         EJ2r+pGI3ztwVsxzLMXSLs9e/733k8ZPePAfpE5GgNHhnhXBDJgtDZE3sUcNOx0DQBMM
         8jRH2v96xjzZK2L9+1TqTa65Wzw6mIzHu673OXjfAb271YrnSv8tg6R0FQjqqq7SCGF/
         k+QyOzw0T7Q7ijmTRgYXHU4dGoibr5iBtr48p/FKMxQ2fcZSofqur0DXEOVgYMaIYRIc
         zH12QZbxu05T8ncNLO3f0IzPV12BYBNyXoTX1nrnAlPtWlviJ5uTIjuKgE1ewtz1+yzx
         mGgA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490485; x=1796095285; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Nl+jLjFcED3vClIKXM3yAqVJJrqmqx+RtOw6zm+9fY=;
        b=yOmOXqQHxWmf4b5vq37b+S9TfplgstemOjsTME3kStQ1kLYOdRBTy6gNM97mkqtLpD
         P0AdJ1x7Ebc9V0rBnAZINRiFlJWoVJXj/4H2r3XNJ7+olKOsmA/NWeFKa4d0FPDNolSW
         cBT56+SBnCPRgdjvlVq1hNF7plWuf3pWame2Cq7lp1gu8kq/wDCXiDzbTmYO+09AV4Y7
         6rACmb0oNvUMkUS1/beWcl06fqWYtguVG3Wgr/SGXcvhbRVGblXpO9nIKXHZ4Azt9jug
         ZcaTkbimY2b0LXHms3Oln0Nz9uC0xUS+5GO33L8bxJCFiCIf+QO6WU5MNEDTMyTffILm
         3P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490485; x=1796095285;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Nl+jLjFcED3vClIKXM3yAqVJJrqmqx+RtOw6zm+9fY=;
        b=fsDeAF6533/rMA9bejk3Wm+pa0o1RFX7sDbgJGOERR8LX81V/2Tk1EPvBFMZBHcPYv
         EZTLC41Ju8s/vWHtSKTgxaKig3m6GeN2v2rmtDyh93ufMOaUFoOflXTaQ3qb7OSOVP2W
         UzHccff/vWkMp7UiInuCcPwSK3BMbsnOLNYRPMRGllwhf87J+Z9iUpEr8JcHrWjcWMXM
         0aERWVEyEsHGGwZ+biiKLBOksoMG738zB2m/dEp08yGHzZUCqoKcQuirg7PARwKkkbxH
         hhuN39mLwOg/Wo82D2x0lSvUQs09Ljq3sXgGYEh9BpepFWEI5cZmYfc6tHCIhDkNgDuh
         7geQ==
X-Forwarded-Encrypted: i=1; AL+hErE68OfG26M2poys8aBGyhjH6xAGOXNjOtcXCwrlfq97b8lA5YCTYTOtMlIsVBMMl82m5AOdd6edbeCGSjIpxg==@lists.linux.dev
X-Gm-Message-State: APuU4Z88Dj4dKGYQ0DT+OOv4XJF1aB6MDczaRn2YP4U5hPZhSEdBhqFY
	4EI0RalPS9K/VF21yBhDPlRisOn8s7n6QT0QDgOaqSRcOS+643ik6ZOaflkfiojTswFbV6XIYKp
	kf6sVQWcnYZHTEqwG6X1Aa0EQDcJqc3w=
X-Gm-Gg: AZFdTZd74KoJys+dJvhaNBoC6zEEZFs72/eSjbYivfuYu8sFx8R77CoaRtPDdGL17eK
	O9YNDlkArMzxUHknkwMFX6LUfWesEhYPap0GAsV58FSnXe1amTwsxREQwTuU95YF8U4qgrbeQ36
	JrUyFpaCX2JxUM2lZ9vzhxClYhq2FsGPv+u2iO4gUEQqBnv8DJSL1JITZx7xh5dj86oSgy7eMlP
	l8ZyIXnCuCFa/3aXdlMh+nUroEnacu+WEwywS2TrOuTqolhPZ9zD1pqKOMnZNMvecoXG5B+OVkY
	Wy7VFW13MEi7WzOxpb+ID4aNQuVEdPoltQiXPRQPwjedbVQr3pWKMQXszYsNMHr8ntiobtFqV6H
	2G0P7CkRBqSFGVA/0Hc9mvh2EQTPeWB2jkp8C
X-Received: by 2002:a05:690e:419a:b0:67b:e7b9:7a58 with SMTP id
 956f58d0204a3-67df44dee3fmr4263105d50.44.1795490484576; Mon, 23 Nov 2026
 19:21:24 -0800 (PST)
Received: from 723974502065 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Nov 2026 19:21:23 -0800
From: Qican Ma <goonsomeway@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 19:21:23 -0800
X-Gm-Features: Aa3M54q6MdHyMzgb6kPLo2sKYPoa9HgwIHJfl5UP9FxNmXtO7vZ4QD_33O68uVc
Message-ID: <CA+OT+OMXvfjXQKzXPbTFzECXyNqFLjncKF+ga0bt6TcwhC7RSQ@mail.gmail.com>
Subject: [PATCH] vfio/virtio: read migration buffers and f_pos under migf->lock
To: alex@shazbot.org, yishaih@nvidia.com
Cc: jgg@ziepe.ca, skolothumtho@nvidia.com, kevin.tian@intel.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

virtiovf_resume_write() reads migf->buf and migf->buf_header and checks
filp->f_pos against vhca_buf->start_pos before taking state_mutex and
migf->lock. Because virtiovf_pci_resume_device_data() opens the file via
stream_open(), FMODE_ATOMIC_POS is cleared and concurrent writes through
duplicated file descriptors are not serialized by f_pos_lock. A racing
writer in VIRTIOVF_LOAD_STATE_PREP_HEADER_DATA can free and reallocate
migf->buf_header under migf->lock while another writer still holds the
stale pointer captured before the lock.

Move the buffer pointer reads and start_pos check under migf->lock after
checking VIRTIOVF_MIGF_STATE_ERROR.

Found with an LLM-assisted code review tool and verified by inspection on
v7.4-rc4 (b6a9fa34ce4). Build-tested only due to lack of virtio VF
live-migration hardware.

Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live
migration functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Qican Ma <goonsomeway@gmail.com>
---
 drivers/vfio/pci/virtio/migrate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/virtio/migrate.c
b/drivers/vfio/pci/virtio/migrate.c
index 4b1e5502f0a..5e47f349511 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -918,8 +918,8 @@ static ssize_t virtiovf_resume_write(struct file
*filp, const char __user *buf,
 				     size_t len, loff_t *pos)
 {
 	struct virtiovf_migration_file *migf = filp->private_data;
-	struct virtiovf_data_buffer *vhca_buf = migf->buf;
-	struct virtiovf_data_buffer *vhca_buf_header = migf->buf_header;
+	struct virtiovf_data_buffer *vhca_buf;
+	struct virtiovf_data_buffer *vhca_buf_header;
 	unsigned int orig_length;
 	bool has_work = false;
 	ssize_t done = 0;
@@ -929,8 +929,6 @@ static ssize_t virtiovf_resume_write(struct file
*filp, const char __user *buf,
 		return -ESPIPE;

 	pos = &filp->f_pos;
-	if (*pos < vhca_buf->start_pos)
-		return -EINVAL;

 	mutex_lock(&migf->virtvdev->state_mutex);
 	mutex_lock(&migf->lock);
@@ -939,6 +937,13 @@ static ssize_t virtiovf_resume_write(struct file
*filp, const char __user *buf,
 		goto out_unlock;
 	}

+	vhca_buf = migf->buf;
+	vhca_buf_header = migf->buf_header;
+	if (*pos < vhca_buf->start_pos) {
+		done = -EINVAL;
+		goto out_unlock;
+	}
+
 	while (len || has_work) {
 		has_work = false;
 		switch (migf->load_state) {
-- 
2.50.1 (Apple Git-155)
