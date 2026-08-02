Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C730C353
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692477; cv=none; b=MKnS3ya/gawcYlb4nfO1eDo4UKwdnXYD9Jy4hTQTQIP1Xyp/H7lMcJYTZzU55fmoJwbxUxvoke2FQX4nejbYXyeMfGdnP556IdO+b7OiN/X3vswc0+PwJVp3Cb6xl7DhIL2oWwsnJNUv8CD9h9nz7CH9zeNrWc6fNriwOxL3gwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692477; c=relaxed/simple;
	bh=YTfmMGELnFD1PSu159ETFqwFo7TIsfNjR6vA/8zppps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=incAbi7VZ06hU/V+MaGnknD6BCr2cASUCqTFKgN3DQyCXnklDcXQzdSzba7yTP0CZKQqwSNHHFqfGmshzAUJ4tYXGll8trJCQ0h/ZgcSZAn/McdnJByBpX5/9V1VEfDDJVlFl14r4GKlfpLBG9fqQo4PCtSkhZo/qTjQSuzOw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4Ojo4S6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4Ojo4S6"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso11029375e9.3
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785692474; x=1786297274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OhSlk96+XMRumlCtLR/Ln1APQ5h4yT2HFyCrvso93oY=;
        b=U4Ojo4S6B3IHpDpx8celybyCrXsROMrOWIUtxiQa//Xx3ihdNuee196swLsoQlRDVZ
         5wpyL18EW/UUofT3Oqie7HMdZ48wrZ8A+r1ROEUD2xJlqedis4VU+bkeC7uq9EhPJov6
         p+JxPiAHVwMG8oG152LJH1yMGBTKrQaVvHkLn4Jn7vWlvE5/kuMCqWIDXE5Oh6a6beCf
         Q1IdvKXGb0qHTdiYsW2+JOYLhPU1tneUzxGJSYNP8XWANJluJ9SmdG9wGfN5z28qryza
         w1/YtWcEh3OvcPBBHl1tAssRg6SWiKeU2vi251+GjDLtat3x21bDJSg9iGkYyHxkfKrl
         8KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785692474; x=1786297274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OhSlk96+XMRumlCtLR/Ln1APQ5h4yT2HFyCrvso93oY=;
        b=VNGXfHlc/2U/DrNw5Z0jG9bd6bDJqK36RTGcTYWC7yitERgSZFDmfU64AjunDoug9E
         ymzVujVpXk0jSMR120LAlyet79QuHCCf5lph2jRb/zWh6SJ3eVoB5qiqt9TwoYvw6FZf
         g8N2xrI1LUQ+dz9OqGpIO8v8U+IIA1YwXhr4e9BZNh4Y4oUpjIJ04bJInt05ZincPA/1
         CR4Yu5p72F4BMubgw6nnnVnY817nYs+4kvFf9sLjrLTPubkV7e0b6dlyAcGLs1DAAoPH
         mifw4LUSWQhwd75wOns/LdXJfxk0z8rzC/qeriVQyg7jeXlUFCmkwBvYVoaBYy+YuBjR
         wY2w==
X-Gm-Message-State: AOJu0YxC89mtHwcBBySbXtfQYWJM/le53EChB+hQgebJ8blDT9wdwBWj
	6FYtRwTvhbRHxScuzAkc5OFirl7XQPid2fTW3ZugBMo17QVVg3RU3/P/
X-Gm-Gg: AR+sD11TQSCmiBp/us7LQet4GP/1pbOpow4oR38jVtMeKiRzp7EFtHnZMUY10AbagE9
	JatU2VZOJtGA3ZajC7EDiU30eqyYyYXBGpYkoRVBSp3HBqGEW3UmF6h40JWb/BDns+z524u5qpW
	V2jcJxERjfqMFmJyAcATAzeVCorl8tZC8dygxeRHiSW8MTvmiwq1FC8ktdh68sXeBlKqvmo9Cxw
	B09bu+DKp4ZY4GpGIP+ov3IqFmrvwZr3c+tR/iy3jIKp7g6t3fnVcnaJKrnmGhnPRayM/Aka1RY
	ymgSWadZYeK/rnYjMfz9T1AeXlTLh4Xe5qt+aAHGs3p5ng1jqkd7s5eb6lKkIJ85vhPzBxSnXat
	axgK7/Zy/YBIO5EYLed/65MJxwmNeTTlsVI2u5NqeqMM/6hADPL3jM6FbaJVIIkvRRoy4fIfST4
	wu8GL8vvJqZDryv/ZLt1+otbgzH6OrCW8wa2k4XBrAgQaIMAAvn+cwVs5BhV5zvc8e26Wl8X99u
	pNDq0kDZTQj5I2pUXhrZ1zygXvzj/w9pAOj1V/uoVAt8EMuf3fIoRUy1GaCTKmKL/A=
X-Received: by 2002:a05:600c:354a:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-4980c673874mr153659615e9.15.1785692474347;
        Sun, 02 Aug 2026 10:41:14 -0700 (PDT)
Received: from a9d4faf53c34.fritz.box (dynamic-002-214-008-136.2.214.pool.telefonica.de. [2.214.8.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458ab61sm25607861f8f.25.2026.08.02.10.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 10:41:14 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH 2/2] virtio_pci_modern: avoid infinite loop in vp_reset() on invalid status
Date: Sun,  2 Aug 2026 17:40:59 +0000
Message-ID: <20260802174059.4082-3-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260802174059.4082-1-abhinjoses@gmail.com>
References: <20260802174059.4082-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vp_reset() polls device_status in a tight loop, waiting for it to read
back as 0 after the reset write. device_status is read via MMIO from
the common configuration structure, which requires the PCI_COMMAND
Memory Space Enable bit to be set. If that bit is cleared while the
device is bound -- e.g. by writing 0x0000 to PCI_COMMAND (config space
offset 4) -- the MMIO read no longer reaches the device and returns
the bus's synthesized all-ones response instead. Since that value can
never legitimately clear to 0, the loop spins forever and hangs the
caller.

Use VIRTIO_STATUS_ERROR() to recognize such values and bail out of the
poll loop instead of looping indefinitely.

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/virtio/virtio_pci_modern.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..209fa3b36c90 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -547,6 +547,7 @@ static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	u8 status;
 
 	/* 0 status means a reset. */
 	vp_modern_set_status(mdev, 0);
@@ -555,8 +556,11 @@ static void vp_reset(struct virtio_device *vdev)
 	 * This will flush out the status write, and flush in device writes,
 	 * including MSI-X interrupts, if any.
 	 */
-	while (vp_modern_get_status(mdev))
+	while ((status = vp_modern_get_status(mdev))) {
+		if (VIRTIO_STATUS_ERROR(status))
+			break;
 		msleep(1);
+	}
 
 	vp_modern_avq_cleanup(vdev);
 
-- 
2.51.1

