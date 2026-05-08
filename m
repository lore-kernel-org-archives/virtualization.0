Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2B339705
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778279440; cv=none; b=AvgJ5/dOFYrPgJw9hMWtmuKwiHDJuVa62dTe6mxikSEhSdRVqVtlYmMxiAWULTocEgDIioHprKtQbw/zf0WcbVNtH1lSGaSE/qJpyWyevs+nq7I+CCC94K5xL8AnyJZtzOT5lPfrXz1rjYI/VbVr7IFcqrt1BP0RBZxLH5Ka4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778279440; c=relaxed/simple;
	bh=Wu5FDALBvzlDUGj+uhbPz25Y48g8JEEjaRm7yw3xXC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKBJAqKNQl9CqUgU2kcc2TiVV1SkRiQTMMm+MzoiwNeLpSUHUf6w0WneOQGJUtz0w2OVdPTOWPhSKJnx0MhZVZe2pcyiumpKgSP+4AAoNIHRj4uOPTkwkNEX9MyfgVXBT+oWwo1JE2X0xTfMHSoLJQGCZ0ZRzFnusoOLJxvuibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNYzaXUE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNYzaXUE"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ef2118b478so259193985a.0
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 15:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778279437; x=1778884237; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2AUaxYCPCqaIbXtU1GhIn25HX53q6rl1plD/MbJsm1Y=;
        b=iNYzaXUElrPtNIcJ35rqvSBcBxm1Yu1qQ+uSD0Il72DAV9tAxKVtQy7mGmIYqhucbc
         TiKYOVDmKPeti49YDvEY08h7P9BAlAUOcM16cwwIeqFM6IrPvTg8BfQssnpS350ePPdY
         ATDPWnsmA+IVKiMJWArSe70XoBp/Zc61Tfouui6wPML9qoE5WxvhQrBVNIK3cHcOvfSb
         U/2v0uCiUkDGZcrblmdmCacprR5o9NOBXKuzc5t5J07IxCy7k2bdv6S35Ky7xRhcfqgV
         VjD5emD3FGNsC3bDOA7IUygIileSX8dJMy3VxcrogP7Lk+4cWn8OrftrYIrEXEwoHyXt
         1GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778279437; x=1778884237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AUaxYCPCqaIbXtU1GhIn25HX53q6rl1plD/MbJsm1Y=;
        b=QWNBA8TVT2MTu87l33T4/N8k7rtdCOrdIZ6df868JsAUn6I/nXzUtrjq71JnphkWew
         HBJhGowAsFjSb/++bhAM1BXLe57BpGVc6qYJwT0G9uHzJUm5FWAP7CNDBDwa0/vIZe5q
         a+P1TTAjjaF7IeTKRdQ9exV2juH0xyWRT7qCXLq0kMnG5FbC3ELP6D7msLRQbi/RKd8l
         SgjTXZxadEzUIbWf3xyzi3JlXejZ7tOlkXC0HTs4uVqArfGUTGQvqgIxvU4I/LxiN8GC
         CqTnwFjfR9ETpZxF1HsQf/xt6+AxeTTBTx5KeV3jrIjiXXvAJG+aqK+lGBk1+D9y+kcD
         wL0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+3B8M9dqrm1IaLz67zdsFuhrxmP7IO0v12foRwMIxbcrEVGX6oloPZHiLzMUoxKXfUTmFLgJiffA5ZFffduQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3CaKfaFVGYNjTf9HeyaCItDUw01XlNVS0PNHf4aneKmUXVKb9
	jU/SzqXMsnU2dbvAxcgzbTLwJ6Nv8q/vYN3r6U+kDj8pvMZi8+De9y+g
X-Gm-Gg: AeBDietVH7Iyk4NB94gvVGcYUSd9NTyHryiOzU2aaSj1UR5lxhbBSQt43siGGOE/ImV
	oV5nwEl9GtNyRB6lZvAfLdcpfKezzrk4CytoYMYYgW3/fdm3HADnznVhdOW/VdT2c9fWJKtKSHn
	/eGsoOoNst03ZgxE7/3ofUPAOS8oJ5M8oohedVwn5j+VYM4IRoL1E4FvzonrxRvS4azOaQfuoEM
	lJ2q49VU2b8f685ElesxqcbYB7YrYge633AvdLCP6ggTUrmHP0jt4lyJuhnaXYyX5U3a2/HM4Ku
	1K1Ng/IWJ8U3dxUOr6EvW68m+/eEflM/jrM7c5j16bOiHf+8xxvU9x2Q33iMcj4K+20PSxGEZae
	kkRqD8CRXrJIZITZCU8Yf4I8dW/vdWckKlTmXhrjgomcxYe4No6QMOWMH4dM+606zMMRgfsilR4
	QntEzcEi4BZ4tyLsgQl4nTWlzego6BRcWNdCE7l5cEnsdgwEo=
X-Received: by 2002:a05:620a:2684:b0:8ee:630e:350a with SMTP id af79cd13be357-904d72c239fmr2149865085a.58.1778279436728;
        Fri, 08 May 2026 15:30:36 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:38::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04c68sm2382574385a.46.2026.05.08.15.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:30:36 -0700 (PDT)
Date: Fri, 8 May 2026 15:30:32 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Yiqi Sun <sunyiqixm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net 2/2] vsock/virtio: fix empty payload in tap skb for
 non-linear buffers
Message-ID: <af5kCGWtjwGi4Y2E@devvm29614.prn0.facebook.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
 <20260508164411.261440-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508164411.261440-3-sgarzare@redhat.com>

On Fri, May 08, 2026 at 06:44:11PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> For non-linear skbs, virtio_transport_build_skb() goes through
> virtio_transport_copy_nonlinear_skb() to copy the original payload
> in the new skb to be delivered to the vsockmon tap device.
> This manually initializes an iov_iter but does not set iov_iter.count.
> Since the iov_iter is zero-initialized, the copy length is zero and no
> payload is actually copied to the monitor interface, leaving data
> un-initialized.
> 
> Fix this by removing the linear vs non-linear split and using
> skb_copy_datagram_iter() with iov_iter_kvec() for all cases, as
> vhost-vsock already does. This handles both linear and non-linear skbs,
> properly initializes the iov_iter, and removes the now unused
> virtio_transport_copy_nonlinear_skb().
> 
> While touching this code, let's also check the return value of
> skb_copy_datagram_iter(), even though it's unlikely to fail.
> 
> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
> Reported-by: Yiqi Sun <sunyiqixm@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 40 ++++++++-----------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index a678d5d75704..989cc252d3d3 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -136,27 +136,6 @@ static void virtio_transport_init_hdr(struct sk_buff *skb,
>  	hdr->fwd_cnt	= cpu_to_le32(0);
>  }
>  
> -static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> -						void *dst,
> -						size_t len)
> -{
> -	struct iov_iter iov_iter = { 0 };
> -	struct kvec kvec;
> -	size_t to_copy;
> -
> -	kvec.iov_base = dst;
> -	kvec.iov_len = len;
> -
> -	iov_iter.iter_type = ITER_KVEC;
> -	iov_iter.kvec = &kvec;
> -	iov_iter.nr_segs = 1;
> -
> -	to_copy = min_t(size_t, len, skb->len);
> -
> -	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> -			       &iov_iter, to_copy);
> -}
> -
>  /* Packet capture */
>  static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  {
> @@ -214,13 +193,18 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>  
>  	if (payload_len) {
> -		if (skb_is_nonlinear(pkt)) {
> -			void *data = skb_put(skb, payload_len);
> -
> -			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
> -		} else {
> -			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
> -				     payload_len);
> +		struct iov_iter iov_iter;
> +		struct kvec kvec;
> +		void *data = skb_put(skb, payload_len);
> +
> +		kvec.iov_base = data;
> +		kvec.iov_len = payload_len;
> +		iov_iter_kvec(&iov_iter, ITER_DEST, &kvec, 1, payload_len);
> +
> +		if (skb_copy_datagram_iter(pkt, VIRTIO_VSOCK_SKB_CB(pkt)->offset,
> +					   &iov_iter, payload_len)) {
> +			kfree_skb(skb);
> +			return NULL;
>  		}
>  	}
>  
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
