Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1983563F6
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184763; cv=none; b=gHKgPvhgTO01Doq8yEDPsiLPB9ih0jCvt1HsWbp05xT/WIU3kUgNR26Q3Iy38gjOEwMbK33SWCwNX0HNb0p5nbC//E56Lp9XuWNvjjx6CpAwB6Rgs57VyQ8lDweF6AiaIgIkKQqZhNFsAC3/qzvZJdvwIPvYBZA4d3mrfn0eBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184763; c=relaxed/simple;
	bh=YiA1eEseDRCOb+C4MPisetZeRtex0Ar8vxo2COhJHQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X96Kg6jpGBt997CQK/Rt4jNX2X5VnnWcI/fGN19vohJ9STwyinsgahvh29w/81YASoVG3/8nzxZRnI4holCtj2TX5+qglCoJk73ys0xJGqS0IP3G5hJJgqIzHNn1kbmqyhE+yKmu/byCegG2UwwnTabAMIwoy56LztcfCwwDyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQUj/m0y; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQUj/m0y"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8eae9229110so169376985a.1
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778184760; x=1778789560; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CufiyOMzWgsZjfa0uu9olo/GL0CEznYyMUEZlGLNhMU=;
        b=oQUj/m0ydFR3FjIoUFauWkLAjnGk47Ppw/xmC2LVhAMyWrQUADH7+tQPMDUx/aIngX
         MfrAKX7mBMGWWzH4+Z35wequf62FWghVByWaeVpEhvejXf7J5MkTS9gDpltTE09XGJvC
         mMXU+dUEfJpTzF4nduNG1+3on0ithEPw4M0zuxv2WrPa28xIQCjJHFRGCsIHXSY/aQAB
         hdmwPkRNdGS2tuqGUobQpkVAOCvRKdiG9euqdVQ2JoxMzN+dGrJ/zAnahg8CyqCUsbW0
         yiEIbkup4DAVbPYs4XrD1r3qFkU/jUR8K+mWtaEdPDwq6R0Zq6g1TWJRLmmFNly4mkQQ
         Cs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184760; x=1778789560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CufiyOMzWgsZjfa0uu9olo/GL0CEznYyMUEZlGLNhMU=;
        b=dN28xTnh6MeHIssHH6w/Nl3Qw3wOArnIko0zcXxJK49LNq6BU073l3QipMO0tzjryP
         jArZFxqQh9qt/mJ0bP+4YH3RPjLcJDpICEWimenrayD7rRi+We2EKtlPzfVUH+SK+WM+
         iepkJDhnqAN6uFzlScAsKX8cAz0yXg+HNJZjOlJ+ad0LncCTlAUMTN3mXG/sftLzzTrE
         jsoQThCapkGnhWdd80GkvwCkS4y9QNKvllbcFAyM6spFK81GefMmk7uBB6aJXbbTypf/
         j30AAlzqxVKdLmUoyRg5x8Aj9vBwKRGF7B0OEtlA9GcpqufuCJ9AAEzcLiJVvT8cUx+Y
         r+Jw==
X-Forwarded-Encrypted: i=1; AFNElJ+KBx5GdMOk6mdQfqI5hN98fdLoE0DAOk2DkR0hTKUGr8+192HR89Uktwl1z86ZyWvdiL3vYtEvFzl6jmuGCw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzcevw3d5kVrxustx9aohTcJwYGGCIMrHMrX67HxXXRSiAQXykF
	Wf0k37QPu2DAuPs15KBNHxlw21yUAj3YGzKY2BuV0DNIgD1jVZsdn8X9
X-Gm-Gg: AeBDietUK8Lf0+4CDgDELcE0gaLrlQScjl9Lt4yykfhz6ZlRw0jx9f7hWepl+Knhvgk
	z3yT0R1sfd/m9NDikJak5lE9WDHPdrEk/UmtfPTJ8ygf1hauBftTAtKI2OmBXmZSQMz/2wYe+mA
	NCW0f31XlK3G14thRwi4agn290FrnMI0ekcUa0zzX6/wuy8LbizJ+Tdsl5Las1CFx0CbpaEG83I
	Sb+EzuiABovN1soJVBL4/IJf/nG/zs+mHRX5GYaOk7Y5gOxygrpU7q4HqEqVT0N1uAkP/HiROce
	91R6uZaC7tvXG+XSbd1cC6BdmLr0dh3AyevLkunoO2/G+NZLf8rh7IvRdNnHCaPsrNw+8BBBVCt
	VZ1ekTlLaajN0DNyBElO/lJBx8OY/Pov03mcbiZ/ts1w63YaPY/ZZ1ouWFhzNcue5Af4FpsrPFV
	H9zP35mVPXsA2KsqE9AjgpSASay6dC/Hf7jDKnAKhrl0zj3CA=
X-Received: by 2002:a05:620a:258e:b0:8ee:3715:2127 with SMTP id af79cd13be357-904d63e7a0amr1428892785a.38.1778184760010;
        Thu, 07 May 2026 13:12:40 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:31::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd89sm2059382385a.35.2026.05.07.13.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:12:39 -0700 (PDT)
Date: Thu, 7 May 2026 13:12:35 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>, stefanha@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, horms@kernel.org, Yiqi Sun <sunyiqixm@gmail.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <afzyM6fTTAl0Hnvm@devvm29614.prn0.facebook.com>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
 <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
 <afnXIGtswspSEk8x@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afnXIGtswspSEk8x@sgarzare-redhat>

On Tue, May 05, 2026 at 02:44:16PM +0200, Stefano Garzarella wrote:
> CCing Arseniy and Bobby.
> 
> On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
> > On 4/30/26 9:11 AM, Yiqi Sun wrote:
> > > vsockmon mirrors packets through virtio_transport_build_skb(), which
> > > builds a new skb and copies the payload into it. For non-linear skbs,
> > > this goes through virtio_transport_copy_nonlinear_skb().
> > > 
> > > Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
> > > As a result, skb_copy_datagram_iter() sees zero writable bytes
> > > in the destination iterator and copies no payload data.
> > > 
> > > This becomes an info leak because virtio_transport_build_skb() has
> > > already reserved payload_len bytes in the new skb with skb_put(). The
> > > skb is then returned to the tap path with that payload area still
> > > uninitialized, so userspace reading from a vsockmon device can observe
> > > heap contents and potentially kernel address.
> > > 
> > > Fix it by initializing iov_iter.count to the number of bytes to copy.
> > > 
> > > Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
> > > Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 416d533f493d..6b26ee57ccab 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> > >  	iov_iter.nr_segs = 1;
> > > 
> > >  	to_copy = min_t(size_t, len, skb->len);
> > > -
> > > +	iov_iter.count = to_copy;
> > >  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> > >  			       &iov_iter, to_copy);
> > 
> > @Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
> > pre-existing issue you should probably want to address:
> > 
> > >  	to_copy = min_t(size_t, len, skb->len);
> > Does this length calculation account for the offset when a packet is
> > split across multiple transmissions?
> > If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
> > but to_copy still evaluates to the full length of the skb.
> 
> Yep, I just checked and vhost-vsock is the only place where we call
> virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that we
> should also fix it.
> 
> Looking better in net/vmw_vsock/virtio_transport_common.c I think this is a
> regression, indeed we have this comment in virtio_transport_build_skb():
> 
> 	/* A packet could be split to fit the RX buffer, so we can retrieve
> 	 * the payload length from the header and the buffer pointer taking
> 	 * care of the offset in the original packet.
> 	 */
> 	pkt_hdr = virtio_vsock_hdr(pkt);
> 
> Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with
> sk_buff") we read the payload lenght from the header that is always set to
> the right value before delivering the packet to the tap.
> 
> From that commit, we don't to consider the offset anymore since we started
> to use `len` from the skb, so IMO we should go back to what we did before
> it, I mean:
> 
> 	payload_len = le32_to_cpu(pkt->hdr.len);
> 
> @Bobby do you remember why we did that change? Or if you see any issue going
> back to what we did initially?

I think this was just one that made it through the cracks. I vaguely
recall a few other instances where I assumed skb->len could stand-in for
hdr.len, but it didn't hold.

Using hdr.len like the original looks correct to me.

Best,
Bobby
