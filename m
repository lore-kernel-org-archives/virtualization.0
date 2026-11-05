Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873973;
	b=qntLAoTBDY/OG7KENgLKCul8IxkXBiWy/4U17D0ZdgcEqltH7B0JgCiP+F1pGvMbsRQn
	 EbhMX4wZUrB/BmDs5psvpbaaVxWY1VcA3+FdOzsBn+I0Tbo+eASBx39d90YaVvgjbRckq
	 yBBNUxeUVtJkTjcH/eNY6QckH+/wweJZ5hCp7AscaBSnELeXI3oH2G151/ODbV6LlLlh/
	 3/pcCann5biTS/cWeceY54+dAcXOvNHSBsECo1NWpaNlPZbSitEsFO7brmFtAMl1pyAvl
	 EVQR/QgjQ3Kj5W+n/vggrvA7dFNFUmyKz0dpF+gBk2HtH5NkSlj/X+7Os203UBeUIVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873973;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=/2+xR7h3rNPHrZb7MEbP97PuNvaX3QrmpfP5OQT5IHk=;
	b=t9EvSFhQqq2eJ/Ef/AIrjhTFDaEuBmgp7B4HfUqQU04UN3ERB3Llus1idjAx5oNfEwF+
	 A1kIBf0Q4Hl6HgMDIEjdB+gFoXD7O2mRyi+EFO6K6izj2ry6X8bYMrx9NsPfNnoeHEwvx
	 FaZHdYlY2tprEO0zfgpKK6qf0W5+hDO/8dcXgenhlN4Jc4NVzANWDt1gmJ2D+aTkdnBSP
	 RtygkSN8/innlZ6XqH9o5yqBUyprCaDRgwG35B2I0TuDF0qsk9z6Or8e7Gk92TlVN7XkN
	 7ZUzqoHanuq85zAYKq8vTMVEX7ABaZMRrlSCKOctFeTOGxA+F6h7d7/qXHU5C0vQRww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PY8w+zYA;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50F606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 10:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F50F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PY8w+zYA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793873971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2+xR7h3rNPHrZb7MEbP97PuNvaX3QrmpfP5OQT5IHk=;
	b=PY8w+zYAXiiVifm6btqV+p5uDBQw5cQQYVuimHjxqdacJfiJcVuJAgaOTL3MWKRWVKDitI
	mCsjOWf0L6ZcIug3KS6evtUDA2nG2AFeSAohzEmzEMrG97dg0RH5BrlnRceL6KZLKnizB/
	7WdZy/6eIV3q/m+xNIGWscRxWYF2xy8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-CG1pQ9vHMWiKyKa67iXTqA-1; Thu, 05 Nov 2026 05:19:30 -0500
X-MC-Unique: CG1pQ9vHMWiKyKa67iXTqA-1
X-Mimecast-MFC-AGG-ID: CG1pQ9vHMWiKyKa67iXTqA_1793873969
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-490c1867460so583614f8f.2
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 02:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873969; x=1794478769;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/2+xR7h3rNPHrZb7MEbP97PuNvaX3QrmpfP5OQT5IHk=;
        b=qiRWKL1ubQpfVxdFyleQiGRiYcHQv9X5MJ7cl8SByA+p5HA/8Ywx/1LOtOSSPdsnCa
         kvH2pVEPsC22B3rYhAMl5TGwmXfzUTZx6BdksQxUdrDvYMxtqKGJej8nRhIIeD9IJ5mJ
         DwiMu6+AY2RlFK+9Vu3gsEoJyqncZgW9ExGbrYPreR+Z7OPWSSlx5yGI6mE1AD1cdeqL
         jpwZ8/riTch1JV58X2q6p6BBQ4NvzqmI9G7sFdWb5kS3oaIdHmB/o/5tRiXeARr2QWlY
         dggmh9TwE2fr129iivPHjYZsHx8SyGTPUsJYTutASH26VJDOBuS8Shqr4KYDPCVUvkpk
         DdTQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+jWmzTgV9GjyZzlTZ1PoAklksb5JMDbEdjS5XYKjdt85H911iaCWhVNhWs3Ij3J59eR3qJxoH+W5V4JOM4A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8jjSjWn7ku2YB5RLB7lsDvjS5sSSHFPwkOzv73wvR/aqPhTDnT
	hCHC5qBzQEyFy9HdDNKmYU0CS/rVxUhcSb3op6CbHiW8C02HwIhKRIlidJUsjFrMlMn3Xc/6mvl
	dOl1a1Uk5RrAJrY1sPYRfIk/WHlmsD0IeffJs2QdZEIW5+IFnT2aetO5SMKCs82Qy/0VS
X-Gm-Gg: AYBFou3nyy19PSfDvBcfO8PRdjDpaPwdXMUBr6x6iLPwtZ676F3hHCuRMU7JBATQrpM
	+SggdDsTw8FEeQm3fLnSYASYCUjuvWq7YMLCwp5t1qlNcuLEQotCxU9dX+3Jv1fnXYXKHKoLPT8
	YVfuJ8l+Ak39fYf/XuN/R/Om1384dp6uslP82NoFZReK8MnCyoKMnHGTtuoXtvjh0blp30RWATo
	aiGSezE5CJIgXvOdAcsPfkvXmdbuVuYeRIvA4JszjEyxD4+YdpBaK9KRz4+V70ySS7qGyFxA288
	Gb3lXKoQXBxgllp+H4IdCaFbwa+zE9BT495xWjU2mEg+ti+EN4Pxc/qG4mXTeu5M1aocSTf6oHQ
	lnzicx7gQicsD6MxZ9L61OBfB5FuuzNwtSRQD8lm4KjI3+/+3v+RH
X-Received: by 2002:a05:6000:3109:b0:48f:bcbf:26fc with SMTP id ffacd0b85a97d-48fbcbf2c1cmr13670545f8f.53.1793873969143;
        Thu, 05 Nov 2026 02:19:29 -0800 (PST)
X-Received: by 2002:a05:6000:3109:b0:48f:bcbf:26fc with SMTP id ffacd0b85a97d-48fbcbf2c1cmr13670494f8f.53.1793873968633;
        Thu, 05 Nov 2026 02:19:28 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844c8sm9640157f8f.26.2026.11.05.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:19:28 -0800 (PST)
Date: Thu, 5 Nov 2026 11:19:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
Message-ID: <auxVKMavkOw3Ia-6@sgarzare-redhat>
References: <20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uNQ-H6fqTZf1T71miNIYfZIBnNHWTaa9Bt2eU_H0IdY_1793873969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 04, 2026 at 05:26:43PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>virtio_vsock_vqs_del() frees the virtqueues but leaves vsock->vqs[]
>pointing at them. If virtio_vsock_restore() then fails, the driver
>stays bound with a dangling vqs[], and the next freeze or unbind
>passes a freed virtqueue to virtqueue_detach_unused_buf():
>
>  BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
>   virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
>   virtio_vsock_remove
>  Freed by task ...:
>   vp_del_vqs
>   virtio_vsock_freeze
>
>Clear vqs[] after del_vqs() and when virtio_find_vqs() fails. Return
>early from virtio_vsock_vqs_del() when vqs[] is empty: a second
>del_vqs() would free virtio-mmio's IRQ again ("Trying to free
>already-free IRQ").

Is this an issue or just a warning?

>
>Found with the help of Anthropic's Claude and reproduced on virtio-pci
>by failing the restore with failslab; the virtio-mmio IRQ issue was
>found by the netdev Sashiko review. With this patch neither report
>appears on virtio-pci or virtio-mmio guests, and the vsock vmtest.sh
>single-VM tests pass. A find_vqs() failure after some virtqueues were
>set up was not exercised.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
>Changes in v3:
>- Shorten the commit message (Stefano, Michael).
>- Drop the two comments on clearing vqs[] (Bobby) and shorten the
>  remaining one.
>- Drop the tool note below "---"; it is in the commit message (Stefano).
>- Comment changes only; not rebuilt or retested.
>- Link to v2: https://patch.msgid.link/20261028-vsock-restore-uaf-send-v2-1-675aad6da714@eldare.de
>---
> net/vmw_vsock/virtio_transport.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 4f9aa9c4c3aa..ffe7cd93463d 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -714,8 +714,10 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	atomic_set(&vsock->queued_replies, 0);
>
> 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
>-	if (ret < 0)
>+	if (ret < 0) {
>+		memset(vsock->vqs, 0, sizeof(vsock->vqs));
> 		return ret;
>+	}
>
> 	virtio_vsock_update_guest_cid(vsock);
>
>@@ -781,6 +783,14 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
> 	 */
> 	virtio_reset_device(vdev);
>
>+	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);

I'd prefer to move this before the virtio_reset_device(), because the 
comment on top of that is related also to the next steps (detach unused 
buffers), so having this in the middle is not really readable.

>+
>+	/* After a failed restore no virtqueues are live, and a second
>+	 * del_vqs() would free virtio-mmio's IRQ again.

What will be the issue of freeing virtio-mmio's IRQ again?


The rest LGTM.

Thanks,
Stefano

>+	 */
>+	if (!vsock->vqs[VSOCK_VQ_RX])
>+		return;
>+
> 	mutex_lock(&vsock->rx_lock);
> 	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
> 		kfree_skb(skb);
>@@ -791,10 +801,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
> 		kfree_skb(skb);
> 	mutex_unlock(&vsock->tx_lock);
>
>-	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>-
> 	/* Delete virtqueues and flush outstanding callbacks if any */
> 	vdev->config->del_vqs(vdev);
>+
>+	memset(vsock->vqs, 0, sizeof(vsock->vqs));
> }
>
> static int virtio_vsock_probe(struct virtio_device *vdev)
>
>---
>base-commit: 363c8c79220d0db4d65dcd570529ddda15067cb5
>change-id: 20261001-vsock-restore-uaf-send-1fc7396fa1bd
>
>Best regards,
>--
>Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>

