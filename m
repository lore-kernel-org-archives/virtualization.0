Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA5377ECA
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 05:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845985; cv=none; b=mfHVk8CBC4HDTFRx/gUNc8l3W/wvbV8VyxzYYr1Ga6CHiCzKa3TYmB0RWHEEQnDX6vbqSrRztZVVhvS9f6BZuIZugn0O+eKtccEBhpYRP9YPy3Kb31RtOmUhIVHJSu0xsUIP7ksvvshv+JCz5PwxCxwLTMtHHpmt5CTOFyHtnnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845985; c=relaxed/simple;
	bh=faRvsNO+3ng5yp7scD2ooEy+g3RDxAsErW36M1n5UGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ccoD9hRlhNfMGVSgvPXetpgaJbCHtPgUmq/nL9dMjiWqimaHhfvmnvHeNASiGZJNf7sklS2AxAjU7z7BfOeYfjxYFIts6jFJguSmudS+2lHo174h94fsdK8K+sRYgC3IrFWm+oClFNjCnGOTCZbkAadG/JrrQrel76HCb9/pfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tF+O1as8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tF+O1as8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so42197015e9.2
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845979; x=1789450779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Ry5IsRI3u6+OA2QrlJEuTetR9sltFKry3tbM/33hEE=;
        b=tF+O1as8yICYgxo/jndufA+TjQnPlYsOhlGcgKZ3c7bglGNWezG1v/8+0Wej0dgwts
         65J6QZu75oWA46fd3nsDdWZb79TXGbJAmlavrPRmFkJ0r1SW2QpUWxh1w5jolpW5PsRT
         xiGpH4SXEZD0oRCk+rhGh4BAPmrf6VHeRzZSf93QHJKISG1cWyCpXYqI0YCdVB226shp
         A3zrs1aWLlazMDSht4AqkS8r1YHwT9odAzpeOs9tYKZQ4NC1KZMVQ83Yyj8yMKEGmFnx
         Txbk91N8nRJj5mlSMNNMOZNbNJWqEwTOnX4lK2ZOsnoUdA1WaxVbrgvZqs1lsPTPV2uj
         vPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845979; x=1789450779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Ry5IsRI3u6+OA2QrlJEuTetR9sltFKry3tbM/33hEE=;
        b=XIUug3Rgi1yWB4EDJwfJFewNFsWQvXSVmCxJMUXPMQH2eSVpIuGL9AMsmGSb/ysY9/
         fKoJE/fL3gC0dT0DH+Glf5qb5j7iMiqy1PCPEzM7qA1SzkKjwlVOEqFGxwlme4WySYyW
         59JT1HvIGA4S3qObWBdgXjmjy9nRNwIj9RJrTzeW4geWE2Z2GUmu35JJjBYF216vJb8a
         AYuFSqF9MMF/y9R+q4+Bm/FDpwgQrEBAFX7sP1uST6mFKOl13Q4k0mTd4jn5znKn5PXy
         Dkt7rtebsVwWx2A6uDTmbrLGXFUSwXI7GFAM9GC0g6HDkFQAZH5+AlYrqu9S8hRE2kRz
         aAUw==
X-Forwarded-Encrypted: i=1; AKwUvBxEhzcfUTCM8eqFqpv+DYoh+26Woix1burF5rrBUmcUDGQxdVqLYptb6YPk0PVIpPLYbWj3cN/6t+7jmLs4TA==@lists.linux.dev
X-Gm-Message-State: AFuF++nNFNyYl6Mg9YiJuXNkjX+ekkId1NJsZK5FwGMa+X7wd7n1clfI
	Hq0dPfaaRqMRG6o2bQgWBIJhUNp0Y/D5C4XF7U4PA7pRx6cfXcjksuaR
X-Gm-Gg: AYBFou3SJWXaoDqXDT1us7mdGEUWI3vyRd1cZuCMyd/U07H2D5MSxClwEt6jXWvWO46
	FjHVfh6xGfXwnf2BzSN4Z10OXmXxxv0cw2iOmgSHlwJ/cSSpfZ6vp70pNO8jBbIzGIM2UqmGaOr
	WgYAr/6hQvY/m3KnJZByzOO4ZmgqBq7oqdqYrKJCkdFyUWk72wP472Vfs2XhlFYF9A27xTmYjyl
	f3mlWoYbf9sF0ybTpLUfa+xzxRk6cNkAKe4ZfaqlamVu1BgFZ2Uh47mFvGYpfIBAljsHdCd5mpQ
	HFOSXGYX8h8sQP9QkUBu1HrF0UEY3qp67bn5km4Gv4ONJBV27hcsKZCIxqZNXINWpnFIFXUiPIL
	GqtqJPZR+wUKezrza8OSpZwzJtnyl42pEeMcVZoP+88/nQpjWBJfgAeT/kE7x5VcIktLHZyl2lw
	wrSqeEsgrvK/YIItzuDJqx19ym2/vbIR7Uv1qkE/0SK8yZyTZWXxhMaSrJVHI3wXPdXibUbxGmW
	eBFpZp4dw7HFTLuO8G2bRZtchLn0RhUWdI0jsxuY34n2OTEqW5wIXLTWBmkDTpr9ykeH8lxhBCU
	YDG0zWmVPaO3GLdXaMxrqcCIIeKyX+qFsvFJKTwjCg==
X-Received: by 2002:a05:600c:6748:b0:49c:fc6c:bdfa with SMTP id 5b1f17b1804b1-49cfc6cbfa2mr234336305e9.17.1788845978942;
        Mon, 07 Sep 2026 22:39:38 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:38 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 1/6] virtio_ccw: fix synchronize_cbs() after interrupt fallback
Date: Tue,  8 Sep 2026 07:38:12 +0200
Message-Id: <20260908053817.26065-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_ccw_synchronize_cbs() assumes the device uses adapter interrupts
when vcdev->airq_info is not NULL. If registering adapter indicators
fails, virtio_ccw_find_vqs() falls back to classic interrupts but can
leave airq_info set.

With VIRTIO_HARDEN_NOTIFICATION enabled,
virtio_ccw_int_handler() invokes callbacks under vcdev->irq_lock.
synchronize_cbs() instead takes the indicator area lock, so it does
not synchronize with those callbacks.

Use vcdev->is_thinint, which the fallback clears, to select the lock.
Keep the airq_info check because is_thinint can be set before the
first find_vqs() call, when airq_info is still NULL.

Fixes: 3a232277c1ac ("virtio-ccw: implement synchronize_cbs()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/s390/virtio/virtio_ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index bab6cad3fd5c..b90299205698 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1062,7 +1062,7 @@ static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct airq_info *info = vcdev->airq_info;
 
-	if (info) {
+	if (vcdev->is_thinint && info) {
 		/*
 		 * This device uses adapter interrupts: synchronize with
 		 * vring_interrupt() called by virtio_airq_handler()
-- 
2.39.5 (Apple Git-154)
