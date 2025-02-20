Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA871EE006
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094968; cv=none; b=F5zfQXdm5FPv+ZKxgTGTlWu/kmkgIoze3kAkr+gQW/kkDfYTF2ylfiFY3hLNllYrxtU8TAsm8UaEoFm/aHXipi2mCkvLaDFto3jPiQYwc6FDae7kYXKxa59d5dsJBT1xJ3BRTcpLXLnOQl/BtyJAd2xW+4bip0O9i7OUcPagx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094968; c=relaxed/simple;
	bh=cUeKf4PCCVtFVO53wxl3QweJJfWATQQ7W81yy0YfVQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LzapDVfRe9R3vW6yRRNPGRVW72+qwmZoAob4tGhAQCiNX/0JoGieWF/CXQ1ke8C1k8UV1mKqOrDsyGqyS4q9/vOEa+IgK5YukV8n6myET8S2gT3iKBjkS8kqzeSBOK9k8njSvP3Y5Z0Vwf/8qOUyhwTWToz5AkYhJmR/44sVPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuO6zDlP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuO6zDlP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740094965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=64ZpdAsvcI+F+rxDlYFyucFy3wRloEAxpqLq+Ucj4cI=;
	b=IuO6zDlPoAHOFGewXh1wjoFrYUczC8rNbhfSckjPBFjX9VbqZ1Ep9iWrOX3YN6REguhLOe
	Cc/8Ays4V4WSbQIlrVE4suF25pzwDUWxmvYQeFZqIUPBTAGt84nxVDGJvm1g96QIj5YmJC
	z4REoRxtRPUC9KFEJy4zRNWShdzQDOs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-RclReYImMrGtZyis6nVk1g-1; Thu, 20 Feb 2025 18:42:42 -0500
X-MC-Unique: RclReYImMrGtZyis6nVk1g-1
X-Mimecast-MFC-AGG-ID: RclReYImMrGtZyis6nVk1g_1740094961
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abbe5ac36a9so255807466b.2
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 15:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740094961; x=1740699761;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64ZpdAsvcI+F+rxDlYFyucFy3wRloEAxpqLq+Ucj4cI=;
        b=Bk58mQY9gjKEoOGa4e95mitwmYV3xGu7hzTVFj2t4iJ2fW6xf6sm02GfD9tlAK466t
         kaxFhMX9OQqT7ChJKCkqxTwHXilWI+bYrDzeo/yfMly4vCEAwnuDeojGhUf6RTRtpG9a
         zP5jeajbdlpKyeH7F6Zn6oGZFPNgHdBpH5qEHoDMIMM/K/7cPu2mIZNgR7MDbzsHFyuz
         J0+NeZB+hA8s7mHKr0wmeKXndTKRD5EONnfYUxhEWEpFVRMP7yvPpkNrbGSxBGgRt4S4
         pRPlBgjNpiiA6biHNwE0L/HHX3Gxmszl7BZwrsd/vzLa0pop0wvt7OyLa2FYJWlWQ3Ex
         rj1g==
X-Forwarded-Encrypted: i=1; AJvYcCV93dHPloBC/okdnWBpArzbSRySJ7vSYnletb/7BeODrPes1M/47fAKCUJqwDgPT1cKnhuxJGybS7vTBYjyYw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyel4q9GP1j3QZ6Na32pfVPF3nA1wX6OCbSpKl68s5WOr9Ecay6
	+ywDYXVEwLsVWafqZQzHbDu2vbNXblMMCwN19/S7sfgzoDw0mI2Vc3/PyONsHVDR+UoypqzaoKE
	477L+le1UrP3Pl/LpVQp1B5LixTpxJsRlubWOxZdTsx2UtSTMKUsfeq3kqlq3VvIu
X-Gm-Gg: ASbGncsPUHfsFtbV6vQbQXi3UXVSoZ4Ls9iIBsMMJd3HMm4RWAw19TCNZWLFg0ssBcL
	DED+TAoXr3V8N57CgEqnNGQh7p/w16DJRD/Mp81HjUmWbodmM/p3AGB4jLctUdsqI7krXJg97yn
	j4sa38oPJX2lGnLwFJTkdnH29lx7TeO72vBwes6D8sBVFoNffYgKe3xY7fkEJMgPWPBgYzc1RcJ
	XAILfGpvAH6RY2XjhxVXmZLR2ut3wHipddaRSdaE84pa7mZ/TOpl+kZMkI4jmMIghl3RA==
X-Received: by 2002:a17:907:7eaa:b0:ab7:c00c:680f with SMTP id a640c23a62f3a-abc0de4f6f8mr58469266b.53.1740094960931;
        Thu, 20 Feb 2025 15:42:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhhgQ2tD8HKuJBp4jMU5+KqRB/WeK8wqr6fsH8j2hzo2w7lM401/yo0RsV3QgWvZIqWnWv5g==
X-Received: by 2002:a17:907:7eaa:b0:ab7:c00c:680f with SMTP id a640c23a62f3a-abc0de4f6f8mr58468066b.53.1740094960585;
        Thu, 20 Feb 2025 15:42:40 -0800 (PST)
Received: from redhat.com ([2.55.163.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb945da4a1sm934223766b.132.2025.02.20.15.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 15:42:38 -0800 (PST)
Date: Thu, 20 Feb 2025 18:42:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Eric Auger <eauger@redhat.com>,
	Hongyu Ning <hongyu.ning@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] virtio: break and reset virtio devices on device_shutdown()
Message-ID: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n7yO3ISv2BRz4X15XiU7rzJpRJ4b8Vsh0B30cS03cZU_1740094961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
accesses during the hang.

	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
	...

It was traced down to virtio-console. Kexec works fine if virtio-console
is not in use.

The issue is that virtio-console continues to write to the MMIO even after
underlying virtio-pci device is reset.

Additionally, Eric noticed that IOMMUs are reset before devices, if
devices are not reset on shutdown they continue to poke at guest memory
and get errors from the IOMMU. Some devices get wedged then.

The problem can be solved by breaking all virtio devices on virtio
bus shutdown, then resetting them.

Reported-by: Eric Auger <eauger@redhat.com>
Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index c1cc1157b380..e5b29520d3b2 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }
 
+static void virtio_dev_shutdown(struct device *_d)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	/*
+	 * Stop accesses to or from the device.
+	 * We only need to do it if there's a driver - no accesses otherwise.
+	 */
+	if (!drv)
+		return;
+
+	/*
+	 * Some devices get wedged if you kick them after they are
+	 * reset. Mark all vqs as broken to make sure we don't.
+	 */
+	virtio_break_device(dev);
+	/*
+	 * The below virtio_synchronize_cbs() guarantees that any interrupt
+	 * for this line arriving after virtio_synchronize_vqs() has completed
+	 * is guaranteed to see vq->broken as true.
+	 */
+	virtio_synchronize_cbs(dev);
+	/*
+	 * As IOMMUs are reset on shutdown, this will block device access to memory.
+	 * Some devices get wedged if this happens, so reset to make sure it does not.
+	 */
+	dev->config->reset(dev);
+}
+
 static const struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
@@ -384,6 +414,7 @@ static const struct bus_type virtio_bus = {
 	.uevent = virtio_uevent,
 	.probe = virtio_dev_probe,
 	.remove = virtio_dev_remove,
+	.shutdown = virtio_dev_shutdown,
 };
 
 int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
-- 
MST

