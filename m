Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F338635D
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258660; cv=none; b=H5QFl+KHI01+tO9IiiU6by/cQ3YnnSJh0p1m/20bHowNVFRtz3CZZMfy3PnGA+HU3sFsXvT6bewpTTegveHKrSy+HsLT5x054L5qEQoqvXILNBLmIPNuZUOBiDn6FnplJHSEWGk/MW9HAgqKPgv+QGSjQxbuGx29Gbrdwc5csOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258660; c=relaxed/simple;
	bh=6HxONNuo9hUowvo/qEANYYQGQ+cuOD5myJfGdZBXDF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sJDxZQd1lzRMXzYUUAX4LXhIdJRtNqiMYHVX2hbNm+p5icWy1HTscZIWJk1nwonedtvE1oLsLmmkFw57V52HJAoX9C1Kg7ahKZ6nXsD0uMvul0mdoSRkHpkoN9W/mSUfJ73KZXzQhpmwDMvcnZF8VlBChqlw29IZASl3AZcDMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akgeV0Hd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akgeV0Hd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N/FCT893ObSbmlIhFuQ0JD4F9cxfAK4253dqNQw9BmM=;
	b=akgeV0HdsS5FbID1c58wJ6FoW2yVLptu2P9rrXFeNd4sXRTRKHBn4Tk7vwAgai4pTG/WU2
	j8TZlGPKVMsWmOJgULz69MfVFG8zgXf5kpUJnmQvJSXbzkLKBo7AI0tmDK1USkwRS86Zj2
	ydz47kvOVwbxdd39PnAoUotepQmz6p0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-FjLt3XkUMbieQR2Ta-225A-1; Fri, 08 May 2026 12:44:16 -0400
X-MC-Unique: FjLt3XkUMbieQR2Ta-225A-1
X-Mimecast-MFC-AGG-ID: FjLt3XkUMbieQR2Ta-225A_1778258655
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a589c7879so23945385e9.1
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 09:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258655; x=1778863455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/FCT893ObSbmlIhFuQ0JD4F9cxfAK4253dqNQw9BmM=;
        b=Wrjzr7GfBYqkCR8ErrMq77Tb3YPmG2WQEBembTubO5l0cbo/jg1ZkWJ44HUCwQWIsF
         C5+6Ic5ZbQWKyJJ3rzp74RsvM7isn9lDYddhTaWM8INXQnfuO5W4yVkfXQvrxDaIX+qI
         vOXj3i41cgkpLBKKoCwf8MTD9COMyE9goCuFHYmluBOOA+cIb/NISQXLtLlX8lG87WkS
         KseXkeOwvYBnElS/ZNUCLLRTkaWsvi7YhklZRGvHH7yPIUskSuRRYO78kCjs0bHK8eq5
         segtGHu6cjmMI4KOgOb3ulgyf6p+z8Rr0AFozRAJiDo1e+cPmBLVSsX0U1NUxSxDcCm3
         FKaA==
X-Forwarded-Encrypted: i=1; AFNElJ+8Pc79pkM3FYB6JyZzQeTk8qSvi0EwGqL7hp94SQ0ler9NHsXLsIQixfG4dLjSODTay4JEvXdAV3eSe5bSIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEXCdh7CaFJW8uinr2kNnf/JksKluUFLnaSm6HyqiDPqmtvm5I
	QmREUVSiTtisfCIXdlMwE2RwzHib04JXiBU/F0FvSssPrNj7p9xPbRFG1BVkKXZkVhRx9tLLvit
	4EKScFaoYaW0JnDd2IwDysiswhbk9LRJ2KWxLPewuPhSOrKmqRJ6fvWPjArsPcQs7J7rP
X-Gm-Gg: AeBDiesNdNfTmfLvx05eNd9Urc9ozABsttGdb+AsiwL34xZuO9POyzqo3gYeLsfIqpQ
	Rq8XfKXbN8TuJh7YLjA726SKakFAwQAm+akrey92SQ2aCrG0MUReGjmJmEXUdldXFIQ06Z9ODfw
	WUp/+z43VHu27ikrcw1kz7iQMJsOHm50vNyq5TsNoJ4y7vW/hwMatr9rHtoGbuhzaLeQRIXwBQm
	2ZCPBLAqSGK7UHxekHhA6nTjLNNQY55GfYFxvjUJC6Zj1IVW8feqNehHjxBkW1H/jdaHDT6aNd0
	PnJRYIt83rrsxh11tjSvz43aioxO4APjn1XJ6/oLIMF7OUI7+7XclkDcW/DXdxsaJgqQ5uLWZy9
	H3nYQIo2wP6uLWRH5NOGPsRF6fViVU7dbei2j7BW+MSJ5r0JuzY31i2pqhORhcmcBMw==
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr89000895e9.12.1778258654658;
        Fri, 08 May 2026 09:44:14 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr89000315e9.12.1778258654041;
        Fri, 08 May 2026 09:44:14 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd3b31bsm6561025e9.10.2026.05.08.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:44:13 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Yiqi Sun <sunyiqixm@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net 0/2] vsock/virtio: fix vsockmon tap skb construction
Date: Fri,  8 May 2026 18:44:09 +0200
Message-ID: <20260508164411.261440-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5Oq3ZTE4uK7peLMD2LI1PD3N3oqfB1eH5ekDrTKCeXI_1778258655
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

While reviewing the patch posted by Yiqi Sun [1] to fix an issue in
virtio_transport_build_skb(), I discovered another issue related to
the offset and length of the payload to be copied in the new skb.
This was introduced when we did the skb conversion, and fixed by
patch 1.

Patch 2 fixes the issue found by Yiqi Sun in a different way: using
iov_iter_kvec() to properly initialize all the iov_iter fields and
removing the linear vs non-linear split like we alredy do in
vhost-vsock.

It could have been a single patch, but since there were two affected
commits, I decided to keep the fixes separate.

[1] https://lore.kernel.org/netdev/20260430071110.380509-1-sunyiqixm@gmail.com/

Stefano Garzarella (2):
  vsock/virtio: fix length and offset in tap skb for split packets
  vsock/virtio: fix empty payload in tap skb for non-linear buffers

 net/vmw_vsock/virtio_transport_common.c | 47 +++++++++----------------
 1 file changed, 16 insertions(+), 31 deletions(-)

-- 
2.54.0

