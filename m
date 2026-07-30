Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB43D9DBD
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447996; cv=none; b=Ms6Hn2PQ2uhemyOITcyaSB8k1Hy8Ur8Wi6kIRh3DFMaVKK8V3AOXZdEhpLCldIm259wVFFD5+OBzvEXDakN1EqLjV6sI2XvDu3JUZhS0WvdJUWG53QRLAfMiY7iDUQjhdFxf2STSNahWdPSLRfCIucCE988u/Pemqns5GGbrX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447996; c=relaxed/simple;
	bh=3dGuOtRuc7vDNnA6Xn+2Xxz1vdKxTTykCtGHwjG52jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Be7ubAQXZDMgvn3xt0KV6SaNfqGYuDKvyiWlC3PY1L1tPklABgSw4L863fP4E/LxA1y3KOWzHWTmdEwvahB1OnwE3Dfi8Fpf8pE4Kmu2BNWVH8LX7fW2qJUjRNVRSkoH2ft4Qb3vDo6RnLZI1EIHO0lvBpmBp414nbqpXPLixkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQsL6hrw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQsL6hrw"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e58034d05so395113a91.2
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 14:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785447991; x=1786052791; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/LZ3k1OCAQIJqEM26gNRTliKG7NkCB9s3f2/fI53JY=;
        b=IQsL6hrw+LovXmObvABmpNsg6T/YoxSSHdrvHqlvghoQ0IYpNIkWONkXAXX9IZBlju
         IM4+rYTdVb00d7PVTVaZOu56hO6xlt5WqiegtmJQjCiOkoVwLK1PVAi/seJpjJuZP5D3
         FQMCyvf5gGQgbdI28muDXFN8ZfWnDzPD+J/6Mg2Zx7Sf34e+E50BaP0WUOmDV4wudTZr
         rmuZMRFUOi7sxyyQTo8w2pNhzrvkRSLH8vy5ArvFeXxnVUMbZ4Bq/3dknvC6pi9JXJQs
         NSZrYg9L3+vj26gyNJT+nFEzH6Rxzt35MV/Pz7DOEdEwwbkmizSoxciLLoL7DZc7SEmF
         XelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785447991; x=1786052791;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/LZ3k1OCAQIJqEM26gNRTliKG7NkCB9s3f2/fI53JY=;
        b=PmhJRBNXdgLuSuCsTCN7hQJCnrviQEtDvOVg41li/ETs4Gex+KyebT3GmCGn2ISnSb
         7/4WoxghG4gWhd2HLIcu+3q3gAd1dKIvBMgxj5vNaTlbVnb3M15BM/Zg7c1Oe/xTSj4N
         ibkXlJeynVXx9YnslcBECCNtoNdc2t8EParsD/jfAVmIq28Ps59lBY1a5pa+EBs1ihaV
         pRiXHSXdz07IIN2rhRZf1O2cSXfOvQKhPrlA1tRFuUPQmYZ69F+NKWSS4zYXkhIzBfNw
         8BNMfR1dWhU4EL66fPAuYhHka7hDBDOM4mbYC1Cge7SW3cpP+NY23FDFxoeClnBdyKs1
         pC0g==
X-Forwarded-Encrypted: i=1; AHgh+RrypMg2hzmjr1kQytaOpU1YKQbsxHeh6XEq1J96YjssQQihzHZHb42qJGf8Ud56khePmCqavCvTbGraTyI/1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvrmXMpG/S0MO0UC8SHMwaf0iuOD7uaA4BhXwjiJhKd57dI6tr
	fs4eYGFEnd+z0jmZi06HJaGIakj/rcXSqWs6OV0KnuRHZ47B28YgknMf
X-Gm-Gg: AR+sD10MipG0h/WNU2khmzSRTkmMlF0qkKR/Qf35a4Gny0PoWmdm0pSgnNBtOB5Pei/
	Kb/gaWMBTZuoER02qloBt7pugSzuEJee7Z1kvYE0gMqOfMl+tCyvsHxo6GBcwwBc4hx9s3hYCRd
	ggS3/Py3CdjLu89OfJb9LLdzXT7k/idUy7Atv/DxR4sTnXoWljMCLD7aRwF8qyQ6U4oXYuDA6xd
	Lla3VCe+aP5I00iuT7B8Z+3tAKPHclSseekcIUtuzWYTpTY/nNnpEdA6FHtIeQg2UVItwpvLak2
	EPYzKE1Gx7MPUt0/etUYhQVg+rWuqmOpZcaf66i7V63x46VJVNifufOz4U4SCKcjrg36xJSMimX
	EWjQqmULVIhSrNoy8rqUXvY3Y8/4clGZSuaFdmCY3oGP4XwGz1AKwjp8GUDLlT2MH8nBUXwgNly
	9QPQoDZhWbDiinUmIa0e+o5j1HGY9WFWNZedfR4sZ4y7GRVyTTXh7iAwNWEYKetobmfSN0t0dIR
	xfTgX2XIe8=
X-Received: by 2002:a17:90b:55cb:b0:38e:c0f5:7c4 with SMTP id 98e67ed59e1d1-38f9c00dfc6mr3834752a91.30.1785447991438;
        Thu, 30 Jul 2026 14:46:31 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9baeb56dsm1576842a91.17.2026.07.30.14.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:46:30 -0700 (PDT)
Date: Thu, 30 Jul 2026 14:46:28 -0700
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
Subject: Re: [PATCH v3 2/2] vsock/virtio: avoid refilling the RX queue after
 teardown
Message-ID: <amvGNBmggisFqA0k@devvm29614.prn0.facebook.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
 <cover.1785352330.git.bestswngs@gmail.com>
 <f9c8c1d64cad9d262f305d02ffe164c2f900fadf.1785352330.git.bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c8c1d64cad9d262f305d02ffe164c2f900fadf.1785352330.git.bestswngs@gmail.com>

On Wed, Jul 29, 2026 at 12:16:55PM -0700, Weiming Shi wrote:
> Commit b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
> made the RX worker jump to its common exit when rx_run is clear.  That
> exit still refills the RX queue when the buffer count is low, so work
> queued across virtio_vsock_vqs_del() can add buffers after the virtqueues
> have been deleted.
> 
> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
> Read of size 4 by task kworker/0:1
> Workqueue: virtio_vsock virtio_transport_rx_work
> Call Trace:
>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
>  process_one_work (kernel/workqueue.c:3314)
>  worker_thread (kernel/workqueue.c:3478)
>  kthread (kernel/kthread.c:436)
>  ret_from_fork (arch/x86/kernel/process.c:158)
>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> ...
> Freed by task 141:
>  kfree (mm/slub.c:6566)
>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
>  virtio_device_freeze (drivers/virtio/virtio.c:658)
>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
>  device_suspend (drivers/base/power/main.c:1968)
> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> 
> Jump to a no-refill exit when rx_run is clear, leaving the normal exit
> to replenish a running queue.
> 
> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Assisted-by: OpenAI-Codex:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index a8e1dd95ba8c..96c9fe8d357c 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -638,7 +638,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  	mutex_lock(&vsock->rx_lock);
>  
>  	if (!vsock->rx_run)
> -		goto out;
> +		goto out_nofill;
>  
>  	vq = vsock->vqs[VSOCK_VQ_RX];
>  
> @@ -692,6 +692,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  out:
>  	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>  		virtio_vsock_rx_fill(vsock);
> +out_nofill:
>  	mutex_unlock(&vsock->rx_lock);
>  }
>  
> -- 
> 2.55.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
