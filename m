Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7362A483830
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336277; cv=none; b=M8+htMCsHgi/09Us+oKiTy/+4t3McA3dD5Wi3UCYqP/EdZe4ntnrlbN4O2YgbpvJFpWE1z6uLNjmdr9jn4do2kFw/ZdtsmjEy/kfEzjN2phId4kTABU28DpazWzB5ycpNEp5R6LqrNLAeBIBt5Nn2m69XrbxsUJJINXUU59XbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336277; c=relaxed/simple;
	bh=BJS1HA8rokFIiV0ne5cRaLj+3cbfWQFKkW4X/b+NT0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JOXiWL3ChNxVlwKF3A1hT8ObWO5hMzKuhzt+QxwLyNLh+/ttGNkU5/ZlkFB2AcihqmspWNQEcoAD/JMXmnuPIz07JjQ8Er0iAGmN3rf2VQDTIFzu8IFYStU0PDMHyiu/v3YgGSKxL6iQDDinRqGwc0jSM2HKis3vhxebD8WEaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNWcPWPn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNWcPWPn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785336274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
	b=YNWcPWPn9bvAPNDTNyD2ILT5WLEI7d/1jOq4dpgpaLzenlwxMGF/XU2WLVa/vLq1u6VZKJ
	g+ZOI/W2pWL6E13TVrj9aatcGZ3t2u3miOaCvVp26h4zpIWMhRQCJrx2qQ02AyOdegEs7j
	C/6E8lnswo7449EYUtRc1NypluOrXHU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-4cVTDkDxNQCif871PX3vNA-1; Wed, 29 Jul 2026 10:44:33 -0400
X-MC-Unique: 4cVTDkDxNQCif871PX3vNA-1
X-Mimecast-MFC-AGG-ID: 4cVTDkDxNQCif871PX3vNA_1785336272
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so999879f8f.0
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 07:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336272; x=1785941072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
        b=iB6uLTyJ3brzZvN+rgWMyeWWVTrj3AGmWtGWD9blM7/JVIEO6LoPqFcwkBLw6mreqM
         U93NHc8JGnvaxMmgU2KCvyFpNlC1/JQ/9+3HNXA4ri6D2Gjtdv3HVuIlSqc60+R3jG/T
         Cwl9SOk5/dHQrS/CXmRa3jdxlLlIiWthEfvCzPfu3+XLKDR3RgbNRij1BK9S3gNIt+Qy
         Ua/rcWejXfFfaq3uBRK0lzpMu+zxuhUCX7SQXRTNO7FncSBxCBTQxiDpTuhUX/Mlk3S4
         VAXOYhxUU/Tt0FYSe/ndql54FqLJVRkgyGaIduVfQGpayh9jdKMRXz8b8c3Vns7lDKdy
         lyUA==
X-Forwarded-Encrypted: i=1; AHgh+RpOwR0/j9/TzGRUD+ewDyEUInQIrXTvQVoJSwnNPw/59haZZziP8wtL9qp+IHpO5O3WgofqcxErutckQn13wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuQENAYMXeoEH7bLP6Ti5ezx8f+ewdmj7TETslFgsLoUxUCOOg
	y0U2YT1BhnSPG5/S3UpBvpQpZBSaZ5WHyAgGaCBd+nmfdRzuUhxTOtTbQwH6jgdSSjxAzKUfB1Y
	VdW4BfVkzn5v/Yw8wg+HRN8zS7lSBbIhZhHFg1NpOGmrkXLupl6Mp5D40tcULQGxCrQ16
X-Gm-Gg: AR+sD11pSY77RUu7dVhhcDeiXUR2bcSxxMpYhh0RFjB+ITAyO3FOIUcJ68zcXvwIwrg
	EDmtl+rD2SEfy1cbc1RwIBD1NpqZoT9eqyIZnaL9gU0Lo28Iv4KgzPy5tLDFzJQJ3oIcfjFXANI
	76X31J08P9C0HtqIJke7cDeu+pzWtw2RcB5Y89dYphAR7Mn+7hDKsL73npEuSkm+eTMy+SOlqG5
	BZZyF8IpcEy14GYIJr734m5ywDtUyXZdpz6/vOhzOJxzPbiONW2ITjjLw40LEfk+EfJ4qW5//iW
	MPnWkR8XpbeZUWpSqWcG2AwM21mwAV1+wZ61/a5SLzBY7K1RR2hq39yGvpG9qR7O0WYG5d5uB0z
	hoPHrKzPSk7fliiXwTr+9DtBKf8FRvRcttnVFNgLjb+s=
X-Received: by 2002:a05:600c:c162:b0:495:7285:a498 with SMTP id 5b1f17b1804b1-496c656540fmr82603595e9.18.1785336271637;
        Wed, 29 Jul 2026 07:44:31 -0700 (PDT)
X-Received: by 2002:a05:600c:c162:b0:495:7285:a498 with SMTP id 5b1f17b1804b1-496c656540fmr82603015e9.18.1785336271121;
        Wed, 29 Jul 2026 07:44:31 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd52f3fsm36693245e9.0.2026.07.29.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:44:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:44:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted
 virtqueues
Message-ID: <amoPm0aVfnadsJaF@sgarzare-redhat>
References: <20260727035804.1860862-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260727035804.1860862-1-bestswngs@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yuWl6I5QK_NtkRqOInjpsz4hnxi3jBqf4pahYK-rnVQ_1785336272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
>The RX, TX and event workers read their virtqueue pointers before taking
>the mutex that protects the queue and its run flag. A work item delayed
>across freeze and restore can therefore retain a pointer deleted by
>virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
>and use the freed pointer.
>
>RX has an additional path: when rx_run is clear, the common exit still
>refills the RX queue. A queued worker can consequently call
>virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
>
>BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
>Read of size 4 by task kworker/2:1
>Workqueue: virtio_vsock virtio_transport_rx_work
>Call Trace:
> virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
> virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
> virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
> process_one_work (kernel/workqueue.c:3314)
> worker_thread (kernel/workqueue.c:3478)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>...
>Freed by task 141:
> kfree (mm/slub.c:6566)
> vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
> vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
> virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
> virtio_device_freeze (drivers/virtio/virtio.c:658)
> virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
> pci_pm_freeze (drivers/pci/pci-driver.c:1098)
> device_suspend (drivers/base/power/main.c:1968)
>Kernel panic - not syncing: KASAN: panic_on_warn set ...
>
>Read each worker's virtqueue under its mutex after confirming that the
>queue is running, and only refill RX while RX is running.
>
>Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
>Cc: stable@vger.kernel.org
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: OpenAI-Codex:gpt-5
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 57f2d6ec3ffc..79cf19f58943 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
> 	struct virtqueue *vq;
> 	bool added = false;
>
>-	vq = vsock->vqs[VSOCK_VQ_TX];
> 	mutex_lock(&vsock->tx_lock);
>
> 	if (!vsock->tx_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_TX];
>+
> 	do {
> 		struct sk_buff *skb;
> 		unsigned int len;
>@@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
> 		container_of(work, struct virtio_vsock, event_work);
> 	struct virtqueue *vq;
>
>-	vq = vsock->vqs[VSOCK_VQ_EVENT];
>-
> 	mutex_lock(&vsock->event_lock);
>
> 	if (!vsock->event_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_EVENT];
>+
> 	do {
> 		struct virtio_vsock_event *event;
> 		unsigned int len;
>@@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 		container_of(work, struct virtio_vsock, rx_work);
> 	struct virtqueue *vq;
>
>-	vq = vsock->vqs[VSOCK_VQ_RX];
>-
> 	mutex_lock(&vsock->rx_lock);
>
> 	if (!vsock->rx_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_RX];
>+
> 	do {
> 		virtqueue_disable_cb(vq);
> 		for (;;) {
>@@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 	} while (!virtqueue_enable_cb(vq));
>
> out:
>-	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>+	if (vsock->rx_run &&

Instead of adding this check, what about adding a new label...

>+	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> 		virtio_vsock_rx_fill(vsock);

out_nofill:
> 	mutex_unlock(&vsock->rx_lock);

And use it when we check `vsock->rx_run` ?

Since we are taking the mutex, we don't need to check it again.

The rest LGTM, but I agree with Bobby about the split, since the Fixes 
tag here is confusing. I'll reply there.

Thanks,
Stefano

