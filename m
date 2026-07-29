Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE437F730
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336441; cv=none; b=q5hSomtCOf6RvMO+EkmrcYqmRSyEDdj3ytZvUX8rAHIIrmQj5FpC9OwQGkUiP7iutrCBAEUJxX+lDzjN98OjmOa1pOzFPbVNbnmDIboynyK2piVNXt4UCcRU1217KLEzxj0Ro6ls4DqKEGuj4+P9iQy0IBXQEQKahUTpI5PDAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336441; c=relaxed/simple;
	bh=F7gJ/ECoIn0yMRAvxBO25GQLBgLR0EPLHh+0r9A2Y1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ubCKxgTjFy/7uR1BnoqxOBDarnAT/uop0h4EZJ2nX/WJqVsa+YBWuQosMWcbbc2XXn8qwWMmepKArSuLbp/TV99d35YkzSsiVhzkd2lIfE73YuPsQ0Z1+Enq8m5Syh3ZYZYbxj/YFE9dTTDSeva+g1UmcDDJc+MYhslwA9ZV7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzPgP1el; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzPgP1el"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785336433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUO+shHcXPXkW8jm7U6qNBfIeZI1sbU1fzZ8TMtvFnQ=;
	b=OzPgP1elEBtI+BthuEmdnk80x0lFbTKlhd8EhM48PNDA1DTOLAP0zi7b+foyGvGZoOVR+P
	x4+2L6ptXa4wRQi9bs16VEQv0dUo5KuRAF21j1E9DETXenb8nE1oKQ6ELXFOfEsClaXuVn
	SyfX41oNR/hy5fu5w5+OxOFHZXQiEcA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-tZguu7DNNyOg2y1IE9ETvQ-1; Wed, 29 Jul 2026 10:47:10 -0400
X-MC-Unique: tZguu7DNNyOg2y1IE9ETvQ-1
X-Mimecast-MFC-AGG-ID: tZguu7DNNyOg2y1IE9ETvQ_1785336429
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955ecd8a10so7214625e9.3
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 07:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336429; x=1785941229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUO+shHcXPXkW8jm7U6qNBfIeZI1sbU1fzZ8TMtvFnQ=;
        b=cZhTItdyPnrVvsEBfWtL+WE1EKZUvqnDLIkBwlcMxXJfB9gWof+3Perc904OGiGhEB
         PD8EYCKdsSHiRCQC0EEoSetbwzVpr+Gh5TD5Qh3rNiV13c/VODvkHPMt7fmFbzvsgV9C
         +ICarMeABbMF1eTyTrU0s4kTvaNjFTDyujudDXlr6wivxmAYV76y6y2JoSBBTq5aL53W
         ITu6XoJaqOtSkXQ5tOIqln+R0S6CMQ4l7HjJPZW46jStejRZ7BosGJlcIBI5fThLN/9N
         lW/qBJIkENF33fA/la7+XEHwvebV5T+o3dqkXnHh4LgU7qFc/gV8/pCcTIF7KJNfQ3Wc
         0AEw==
X-Forwarded-Encrypted: i=1; AHgh+RphDfIw2H8eBM+BtuR1IC9p/hM2ZUeTPcubS+i1okBL6L5aztEpJLUbKuG8DQ/Mkd6VK2DaWW4gLDOJ3qts0g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg0k4hk7WzJKHp4beWNACUuW9vdU8ZDERLxQcfk3nQ/Zs81fDR
	Tp+COf1rUOovsBTxeKoBABVacErh9U2x+h/0yFjvRwUwqnWHZDxt94ivKIjvW9eqlp/rRDaUJJx
	QVfyLp6B67KKPeckuHLehgOyMfEJFNhmfWfcUq/5FlJ198nXuVMaUFP6iND/aLACm0ISB
X-Gm-Gg: AR+sD113oE4OaerKH2TKgawKoyx3v2Q/scL73TQfG880I6Al+twJrofFwxp6izvFBbk
	2mRz65zALErLUW9u7xy0xCvmUPAfbt8Ho7TfElvZTw8ac5mwl4MCsnm0IPC7nRsOqVCbGmtwLJM
	j2pHRcFS8DxigjWeEDpY/OpElA77ZYsQfTqX7MIVWvhi33PAgmlQmyiLtd2KbyhmpWII9NKIH7X
	cZp++2MD8UR82WDj+Rcy3K139wSMKmkKS2M7f0c5Y2p+KRkh75S0/mq/F4nkw3a29QiGrZgJFU3
	GCGcBeLW+Jt24DhIxQ7LJlIyqxdcMyPhjLxkRhbxD2BcW72uU/qAK6WoHTQVNPk/Hl7LfUq/wjR
	DMMwU1ks4eHUATz8S4ll5uSFilMmnGimg+Z4M1cSUVJ0=
X-Received: by 2002:a05:600c:4fc7:b0:495:5dcc:52b4 with SMTP id 5b1f17b1804b1-496c641505fmr101132005e9.3.1785336428933;
        Wed, 29 Jul 2026 07:47:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc7:b0:495:5dcc:52b4 with SMTP id 5b1f17b1804b1-496c641505fmr101131455e9.3.1785336428269;
        Wed, 29 Jul 2026 07:47:08 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd6dcb3sm65934695e9.11.2026.07.29.07.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:47:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:47:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Weiming Shi <bestswngs@gmail.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted
 virtqueues
Message-ID: <amoR0pnMO2OQ2E6z@sgarzare-redhat>
References: <20260727035804.1860862-1-bestswngs@gmail.com>
 <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: onZ8P76foN3Fi7OucrWotAx9O_q_hP2pLvdgsruzjIk_1785336429
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 28, 2026 at 10:17:55AM -0700, Bobby Eshleman wrote:
>On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
>> The RX, TX and event workers read their virtqueue pointers before taking
>> the mutex that protects the queue and its run flag. A work item delayed
>> across freeze and restore can therefore retain a pointer deleted by
>> virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
>> and use the freed pointer.
>>
>> RX has an additional path: when rx_run is clear, the common exit still
>> refills the RX queue. A queued worker can consequently call
>> virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
>>
>> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
>> Read of size 4 by task kworker/2:1
>> Workqueue: virtio_vsock virtio_transport_rx_work
>> Call Trace:
>>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
>>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
>>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
>>  process_one_work (kernel/workqueue.c:3314)
>>  worker_thread (kernel/workqueue.c:3478)
>>  kthread (kernel/kthread.c:436)
>>  ret_from_fork (arch/x86/kernel/process.c:158)
>>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>> ...
>> Freed by task 141:
>>  kfree (mm/slub.c:6566)
>>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
>>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
>>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
>>  virtio_device_freeze (drivers/virtio/virtio.c:658)
>>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
>>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
>>  device_suspend (drivers/base/power/main.c:1968)
>> Kernel panic - not syncing: KASAN: panic_on_warn set ...
>>
>> Read each worker's virtqueue under its mutex after confirming that the
>> queue is running, and only refill RX while RX is running.
>>
>> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
>> Cc: stable@vger.kernel.org
>> Reported-by: Xiang Mei <xmei5@asu.edu>
>> Assisted-by: OpenAI-Codex:gpt-5
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>> ---
>>  net/vmw_vsock/virtio_transport.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> index 57f2d6ec3ffc..79cf19f58943 100644
>> --- a/net/vmw_vsock/virtio_transport.c
>> +++ b/net/vmw_vsock/virtio_transport.c
>> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
>>  	struct virtqueue *vq;
>>  	bool added = false;
>>
>> -	vq = vsock->vqs[VSOCK_VQ_TX];
>>  	mutex_lock(&vsock->tx_lock);
>>
>>  	if (!vsock->tx_run)
>>  		goto out;
>>
>> +	vq = vsock->vqs[VSOCK_VQ_TX];
>> +
>>  	do {
>>  		struct sk_buff *skb;
>>  		unsigned int len;
>> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
>>  		container_of(work, struct virtio_vsock, event_work);
>>  	struct virtqueue *vq;
>>
>> -	vq = vsock->vqs[VSOCK_VQ_EVENT];
>> -
>>  	mutex_lock(&vsock->event_lock);
>>
>>  	if (!vsock->event_run)
>>  		goto out;
>>
>> +	vq = vsock->vqs[VSOCK_VQ_EVENT];
>> +
>>  	do {
>>  		struct virtio_vsock_event *event;
>>  		unsigned int len;
>> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
>>  		container_of(work, struct virtio_vsock, rx_work);
>>  	struct virtqueue *vq;
>>
>> -	vq = vsock->vqs[VSOCK_VQ_RX];
>> -
>>  	mutex_lock(&vsock->rx_lock);
>>
>>  	if (!vsock->rx_run)
>>  		goto out;
>>
>> +	vq = vsock->vqs[VSOCK_VQ_RX];
>> +
>>  	do {
>>  		virtqueue_disable_cb(vq);
>>  		for (;;) {
>> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
>>  	} while (!virtqueue_enable_cb(vq));
>>
>>  out:
>> -	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>> +	if (vsock->rx_run &&
>> +	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>>  		virtio_vsock_rx_fill(vsock);
>>  	mutex_unlock(&vsock->rx_lock);
>>  }
>> --
>> 2.55.0
>
>Not a strong opinion from me, but since this last hunk is the one that
>fixes the bug and the other hunks are moreso hardening, maybe break
>these out into two patches?

I think also the other hunks fix an issue, but I agree on the split 
since IMO we are fixing 2 different commits. Commit b917507e5ad9 
("vsock/virtio: stop workers during the .remove()") was before 
freeze/resume added by commit bd50c5dc182b ("vsock/virtio: add support 
for device suspend/resume"). Only after that one we can have the false 
-> true transition of *_run variables.

So IMO hunks 1-3 should have Fixes: bd50c5dc182b ... and hunk 4 should
have Fixes: b917507e5ad9 ...

That said, it's not a strong opinion here too, but if you prefer a 
single patch, please add both Fixes.

Thanks,
Stefano

>
>Besides, that all looks good to me.
>
>Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
>

