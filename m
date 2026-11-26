Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661113;
	b=iK3bwjc1+e/4gODSBrrD6hRpDdp3N/7B6dS6p+93qgSBMZpjmNkT9aAHZ0foW4HRicvS
	 txOqVgyZf+fJgDR/imkoKRZTQRgNfXLTUmVdYkW7/S37wxNTZq6XootJa0slXpXWBotqw
	 8mm46tnVj2hul2q0JPSY30aFsZYqkURG6y3Ug29nIuCXvNt9jE376zvNK2Crld8fcWAFF
	 +Yqy/Qitv/plu+43HFC+C2WX1WPaZnU87c4LF2J1yWUy26dQm5NLLZKHQouZsU2VKwUXt
	 ASq5TMCtMhtGCdjwvXnSxJDpMTxgai8q8IfG8VLGfu8GyPLsyOH1dhW9wKZbbvixksw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ALLFS86xd4RGFa8E/7vxrVdTFwuvnAUj+VEWzSUqH4E=;
	b=U/kEgBhCPGkxF+xYaXZoFw/KdYTyKGL7PpZERQP6WqEm0wyJTmPZWAWPPBV/413h1vex
	 YWJUHzv4I8eg74MIf0Un660q9J9w45/DOXht37ZigtL3wIEJAQXV4kfWif3YylXchVZfj
	 NpxQCMAmJZ2UK1gmbrk9i7fjJ/ePBM+RP2pqGdyC+nsEaXakCIJE6z65xQELQfM6nCYSf
	 CrDUrX0ds5yltikjQXqyNExe0Jk+pH7m/Cn+lZ3/UwWPDvETRt/AgHYRwbuRU3q++9p1y
	 Cg6WcZv/eiUC/bhN49xmJwRB6BxPYuSiLdGsNoqvA8kmIDBm5h01rBchZxyYDIxBOXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=cPlmAnT5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D112606A334
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 02:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D112606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=cPlmAnT5
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-675617e81f9so7459494d50.3
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 18:45:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661112; cv=none;
        d=google.com; s=arc-20260327;
        b=bbGFeXfG2dyzLyi47Q8HA/0jFAtLTCdWPOQyX0zB1U6upfkDejCQal1BEXqimPK/Z9
         tmLOLgJdaVgw5ZYhSKeuJMPD54wpo4zzQYhK8tKx59Un1pl+Y0S2ylGbkC4n3fMF+Wyt
         ebXdWNUgEQAX831Ov8bFuxv3jQHkAbkAyulRY1OddHtcofkkjRreocjlD2nj+oAEtzCu
         1psPe6k+ev6U9VWwFglc14RkGvBeWe7iFNqUyzlf5R5ZW9nget2CCKyWkLY99mF92pqe
         ZcWNgqsF6F90j8EcJb6jEP/XNx0w/RohPaeLt1RzJywFtUdfyYJucqklLu3eHeJ9IxaS
         LpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ALLFS86xd4RGFa8E/7vxrVdTFwuvnAUj+VEWzSUqH4E=;
        fh=7Iz7GRdWyMCB6aiJU7+8YQ6mV6twrY1JlWQazhtxnPE=;
        b=aVSkaF2t+ffGWFXrbNJWcf/TY1u2ajEtOcGoOAYTMKdp1EzoZLfR+sILISqZP8mLM3
         XIt/eCj11jPBIXEpLI73hFBjBQO5+FdFgRVJ8dUYjIzryQrjvPIx2HBRdB+ARwvSV+Mz
         QLFGFJcH8YaUCutRT9Uz3Iv8aBvOyvAfwnHgKdcWtrWkYo+ia7nBxTHG6q2OiIpYvGt7
         7af8P6SrR3iYZYUnmjG2P8aFmE7UyPVwnj8nBAqwqLt9weg+he41uzySqKP0QlOaOYD+
         tNVZyKpJ6K+1ACCx68fR55c/0rMb/0/KVfGXvQGklmtZSvQwOBpkoj2p6+9JZJUDILr7
         W/yg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661112; x=1796265912; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALLFS86xd4RGFa8E/7vxrVdTFwuvnAUj+VEWzSUqH4E=;
        b=cPlmAnT5ibLvnYdMAwZgvP9sAvkobdqPcOY/4m3RqZjkUo3f3Ux507b79VnxtojG1D
         orG+5nMumcLDR0B0KuFQabea4z7gUzkJUzPLQCDb2r59fFwfLl7DjbfOfQ+VcY93OMXb
         Jzd63OKut8gGavBz3cFRRiOUMM8FlJg76yOmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661112; x=1796265912;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ALLFS86xd4RGFa8E/7vxrVdTFwuvnAUj+VEWzSUqH4E=;
        b=waZYJdgdyTab7LYAGJiVcwjJqLPEqMoT8y129zhlKuG9QmmDITspzC2+UFjcs0yz/r
         wkjTxZ5OKcI3gQxI1Zzd7aRFjjX2jIzGJLM58VocrejYh4e5PAe3lClnN+BzqBkH++b1
         luug2vNhFzhlN4v/8w6Fdi5gbpityasm0XUKGuEWHeDszhjvlmi3SVuZ1P8pkOEGj7NR
         ReVycQX97RSRtX9PtWPOjFzvGRmZspFhNDb7LyHzP7e5YaSTDE/CFfciiTFVVZrZ9OiF
         OUp12nBqESVJcqzKlj9EOuKA/obeYBZi0HRsRzZNNbv0VaWA7IbPUeabQB8eB+cKe6lH
         83ag==
X-Forwarded-Encrypted: i=1; AL+hErE4mm3rhMhRA8VjV2IRG8TNDyNI3ik31oOimTeHEwFWQcT11yiLWs1vh+FFROyCKvrePAOPP7QVA5Qyxf+WUQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/T+KfHgwu3ImZkCfb9m+VmLTPygqR1glAMbXELnw03H5jvfTOv
	6j2MjNGIqYyOxHrgau8r/kIU6MSxYYu3Wi4DwjEpS85aHeB/UdEAZExqAyxFTI71yMQtlX9atZF
	khEHkdzLWp38ZXg6MTIIb53XQGyzr2bx21N7CaZTDaQ==
X-Gm-Gg: AZFdTZcIrTwFQWYfjZRAQ/KZrpJxZFGJLZhcjyvBZyA0jlPXBFhZaAx4B0lfiMWDqGZ
	CV04/mpavKfwIf2BGCrWHHlv+lgJmWIYWwJ3jC83aqHTC3oKN38PzMmlOfjuVDCtgKtmSLgyzUj
	AE6fFTumWHeYrUVVt8O/E94i/yTmLyIxoIAJUXbCOq+MT+db9UcLn0xWcVtzjD2vdet8HpQq47O
	WKbHLdYAlOckGsTjIp428XeCUZKJQP3Grz1pEFSsofGuGj8uteKDRllUKXo6WWI1kes2SmaiU1f
	Jmvx1vvmU6XM7NqWVFQ+9Sefv9AcnJBZQS9G5v4pDEewu/6CBrLZX/MgSU3Tr513HfWtawOp4ei
	FnshSlUD30jgicB7HXMNg7T0kqpBAFde9mV/J2+qZFumRRSY1eYvZfCxXSrNXGW+seUmVdsrWq7
	CQ6hv/QHbZt5oKw7+Zk4SJkEa9p+G5mZ1bJdNR6faLF5D4kb0RC0FXDp+qur/QTgiNWrUXGipB9
	ICy1FF9H8Wrc/ptfKmgCwve7CVfLb6Dhqil
X-Received: by 2002:a05:690e:408a:b0:679:a183:27f2 with SMTP id
 956f58d0204a3-67df42ba9c4mr11119420d50.7.1795661112046; Wed, 25 Nov 2026
 18:45:12 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 18:45:11 -0800
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 18:45:11 -0800
X-Gm-Features: Aa3M54pg_p5M7dws-uZCLLDjGlQf6GfLFqOjUXWLdOYMZYdkJ86Xa9O1blHnpDY
Message-ID: <CAFaZ9eovUow4CR0U-iaUtFHbvf2Dk97Vs6hz6hZWh747R6Xr-Q@mail.gmail.com>
Subject: [PATCH 6.12.y 2/4] virtio: add virtio_device_shutdown() helper
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: "Denis V. Lunev" <den@openvz.org>

commit 0d8aebe089b4ba887e792884cf041ce9f1040ff4 upstream.

The generic virtio bus .shutdown handler, virtio_dev_shutdown(), breaks
and resets a device once it has established that the driver has no
.shutdown of its own. A driver that does implement .shutdown, to quiesce
its own activity first, still needs the same break and reset afterwards
and would otherwise have to open code it.

Factor the break + synchronize_cbs + reset sequence out of
virtio_dev_shutdown() into an exported virtio_device_shutdown() helper so
such drivers can reuse it instead of duplicating the core logic.

No functional change.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260624140846.2616797-2-den@openvz.org>
[ adapted to 6.12: no virtio_irq_get_affinity(), put the helper above
virtio_dev_shutdown() ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 8241024f0890..f70ae3a672f7 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -379,6 +379,32 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }

+/**
+ * virtio_device_shutdown - break and reset a device on shutdown
+ * @dev: the device
+ *
+ * Drivers with their own .shutdown method should quiesce their activity and
+ * then call this to stop the device the way the generic shutdown path does.
+ */
+void virtio_device_shutdown(struct virtio_device *dev)
+{
+	/*
+	 * Some devices get wedged if you kick them after they are
+	 * reset. Mark all vqs as broken to make sure we don't.
+	 */
+	virtio_break_device(dev);
+	/*
+	 * Guarantee that any callback will see vq->broken as true.
+	 */
+	virtio_synchronize_cbs(dev);
+	/*
+	 * As IOMMUs are reset on shutdown, this will block device access to memory.
+	 * Some devices get wedged if this happens, so reset to make sure it does not.
+	 */
+	dev->config->reset(dev);
+}
+EXPORT_SYMBOL_GPL(virtio_device_shutdown);
+
 static void virtio_dev_shutdown(struct device *_d)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
@@ -397,20 +423,7 @@ static void virtio_dev_shutdown(struct device *_d)
 		return;
 	}

-	/*
-	 * Some devices get wedged if you kick them after they are
-	 * reset. Mark all vqs as broken to make sure we don't.
-	 */
-	virtio_break_device(dev);
-	/*
-	 * Guarantee that any callback will see vq->broken as true.
-	 */
-	virtio_synchronize_cbs(dev);
-	/*
-	 * As IOMMUs are reset on shutdown, this will block device access to memory.
-	 * Some devices get wedged if this happens, so reset to make sure it does not.
-	 */
-	dev->config->reset(dev);
+	virtio_device_shutdown(dev);
 }

 static const struct bus_type virtio_bus = {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 2759e2c24d6e..2d8820c0832a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -180,6 +180,7 @@ int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
+void virtio_device_shutdown(struct virtio_device *dev);

 size_t virtio_max_dma_size(const struct virtio_device *vdev);
