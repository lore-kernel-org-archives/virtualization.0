Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A5395AC7
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448025; cv=none; b=Iaz+MJCdYdKqw3+IfQmzNtN8FRurkB3kwkoPokVMzOvFhsMQGPc32sn12QP4nClkwqx95opPGuIaVlebDROFoeS4wz3m3r2395oqPL8b0bMzipuUIvKhJst9PGLgCsr9PFlT3N6No5J2ULH8f+wLZiAgijXc8WqkFVteYMPzGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448025; c=relaxed/simple;
	bh=w7iSUrEkyKIfpcXJr36ZtXbPrCa/n9wTF5n6WkXijcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJkcf/YWUpUXLc9YGjWlonwpC85cSlGTRyt5KQ2KPcOmoLhmCrxPNTPhOxkGLYXGDVrf8XNHRHbBU9/V+ZkpoGeJ2ALANTBsvYASpZ2WNKUz9Ic6txz7GbV6oL5aKq78iJ8QVgZTMH++eHsXmR6Oyv9XI61e02cE9gwAtBNnehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcdVMKM7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcdVMKM7"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so3942235ad.0
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785448024; x=1786052824; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HgSFHsXVsSy3LRIldCAG7H7RU31CdwstWIeTWGMAIC0=;
        b=CcdVMKM7rKeyHoPha4Zlc0S1BFhmEzQrbbpILAvc17S09VYJOFweT6uPfPXWlc22aQ
         nH7cP2rbJhVjBcmA5quoSTqkoRFahTdj6oA1NDe4t7T8ZlAfqa8BQQTm+u7fPt2dbbn5
         O3tEzyuTyDiz9/jEP/cuBs9VgdLwHgNhUDvYAJh3yEpn61nC6c3LxFZKWb97/n1UPRoY
         zVBtBU1wQaKaT77lhBisSr5EPkVETc14u3MrquoqF1+kBy4ort6dwP9fnexUViOy5Ujz
         SAESCpBdRSxkaHCPsPX1j9S2h2ZJV3OeiArztCtieyB6Ld2a+EFiumWM2npb7jF1eJ4i
         QdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448024; x=1786052824;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgSFHsXVsSy3LRIldCAG7H7RU31CdwstWIeTWGMAIC0=;
        b=GIY0JhwRf2InTj5z8OZSFX2UWmr/QTEWjEzCbjdzA6MGGDnv2aMOKlplE9BbPPtaTT
         6B0ACu24WiqTLLR8vQ/hOVykv1MCQBXoxfGAZJxQwPfj2q2Bh50LEPO94oj/Wc09MWyW
         lL3L0mH7yTHJXmZ2GAEXOJF01pGnIgtlhH68f2ziWPCafd3pE9QB4fe8haO+6vGGroXv
         ZGxa6L8kSQpNSd5oNpdgg9WlnDb2Z3kGdlHZSY0eBRUPR9YMZEe2kjBemZpwRvQyZqh5
         cj/v98XEvHVhet6zst9PWBoynnH9NchOHjbljmZGt4nrLbW86TQyZgrgqz0y5cCWwbrQ
         Wzwg==
X-Forwarded-Encrypted: i=1; AHgh+RooWI1rYw6SfJOLceqD/AsHS/EBEq1/vqM0/eXSdioig6NlliR5vqRhcV1en2PaG0t2r05JfPrCJOIyvQnzBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywr7IW74og30lwAP86RVF3OQl3wm6xcleC/P1mF+qIGGk5pfRLv
	oAukmXRzaMSTTx7vL6jUJ/kn9AYn55TYSS7dmXWelNDhIHVmQPDf9XHF
X-Gm-Gg: AR+sD11F1Q6VUg59SEpzHa/jGgtS+fuQyucmaCtNR/8tTc+ssWoe33qhAS3tXk0qN1H
	dfm2zlhkSu5nAHM6mQNrjiPSycnKXcenE0nIle8LifXXf9BIVT87l8V9iI2E/DxGXSdOD6pER0Y
	IsnKoSzp8DAbOvTEZv4c68cMpAfYFqVit//sK22nKJSKpj5QCXyZ7O1y1IQudNg0/mixucx3eXx
	xf/iBKFIbIVnPs25vTS2dxZtCFc0/YpjWMWzvrXJ6ynBEH/VeM9PPeyv5LQ9LO8At/cqHsKnPp3
	BqmrVeyxX/tx5PuoOlxkHCyH6hQAAyAEjeEEzh2Q0a+zp8H91kFUQ0+Bwl1ewpIjwQ+CB+vJ4iq
	j+o5Pe/e2H6P3z0gWWG710TfbXvJIdiK57FTErULTa4JfZvkslwh1WBWc6YiyfnH7rqb+DJ0AsY
	cQwVbrynA53IuYYw0amEq2eXsrfMF/SZXf1VIWbhLXVyjCuSYRUjjHyF1d0C9yGJU7l4iNDFXW+
	rmlcIckmhE=
X-Received: by 2002:a17:902:f652:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d035b9ad39mr42104245ad.8.1785448023652;
        Thu, 30 Jul 2026 14:47:03 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a151fbsm31736035ad.10.2026.07.30.14.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:47:01 -0700 (PDT)
Date: Thu, 30 Jul 2026 14:46:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH v3 1/2] vsock/virtio: read virtqueues under worker locks
Message-ID: <amvGU9j4lHl7TnS8@devvm29614.prn0.facebook.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
 <cover.1785352330.git.bestswngs@gmail.com>
 <e79f68ad9284c983364fc3ac46904b6d9ef50231.1785352330.git.bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79f68ad9284c983364fc3ac46904b6d9ef50231.1785352330.git.bestswngs@gmail.com>

On Wed, Jul 29, 2026 at 12:16:54PM -0700, Weiming Shi wrote:
> Commit bd50c5dc182b ("vsock/virtio: add support for device
> suspend/resume") made the *_run flags transition from false to true when
> restore installs replacement virtqueues.  The RX, TX and event workers
> read their virtqueue before locking and checking the corresponding flag,
> so a worker delayed across freeze and restore can observe the replacement
> queue's running state while retaining a pointer to the deleted queue.
> 
> Read each virtqueue under its mutex after checking the run flag, keeping
> the pointer and state in the same queue generation.
> 
> Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
> Assisted-by: OpenAI-Codex:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 57f2d6ec3ffc..a8e1dd95ba8c 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
>  	struct virtqueue *vq;
>  	bool added = false;
>  
> -	vq = vsock->vqs[VSOCK_VQ_TX];
>  	mutex_lock(&vsock->tx_lock);
>  
>  	if (!vsock->tx_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_TX];
> +
>  	do {
>  		struct sk_buff *skb;
>  		unsigned int len;
> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, event_work);
>  	struct virtqueue *vq;
>  
> -	vq = vsock->vqs[VSOCK_VQ_EVENT];
> -
>  	mutex_lock(&vsock->event_lock);
>  
>  	if (!vsock->event_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_EVENT];
> +
>  	do {
>  		struct virtio_vsock_event *event;
>  		unsigned int len;
> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, rx_work);
>  	struct virtqueue *vq;
>  
> -	vq = vsock->vqs[VSOCK_VQ_RX];
> -
>  	mutex_lock(&vsock->rx_lock);
>  
>  	if (!vsock->rx_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_RX];
> +
>  	do {
>  		virtqueue_disable_cb(vq);
>  		for (;;) {
> -- 
> 2.55.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
