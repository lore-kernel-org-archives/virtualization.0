Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC32040B6
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484829; cv=none; b=HynvQ4F66sdS7b6/GkpDZduxvzfcTFconFEKVDD8ixTDqmrls108jUlE5mFZsXBr405sRYOPQG6RzAFvwjmtwRu4anKa3niim+48djFMrh0Up/LVJnHx61Jv03cqxjXa6WHUzp+KtFwsEXBs6HmJDSVC3bj+BkbmA75ewHPHaNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484829; c=relaxed/simple;
	bh=808AlwEZ1o2mA4OcdatRSl+Gb85ZdMLrOwB3CyxK1Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qf/K6Pa/pDpPZOz5pVxHB/W9UGUaAMcbFStG61CkXz2mvPCcNXVC5Y0tbMNDs32pVVIf2OFSMCUByqAp6JZcrSZRkIefLWaAM2T/bYys/WMLordb6nEEQv0WtQmwhr5M7F4E5wGVphSPVojLAcXOvoZn4t5saAIFyklzNZxa17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U57d9286; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U57d9286"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7864cef1976so4062617b3.0
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 19:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762484826; x=1763089626; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hR77XGy8gKTpCV+3sSlL3axBPG4R/F86P0C6FJqRU38=;
        b=U57d9286kjl++rxzhJWXAqNezvu6PxC9F5/pV4c7Gx1Z8rZVhUG7w8ooZaQIsFpeVf
         uTGpAyu1fdST/TpYu27I7S01RGtJhTffnWsw6CM3NKbaAo/pI3q527GhBSZQ3QABc+Uw
         QwAMWVcjQoOcTDkhPC5cjrA9b0V7wn+ovxASTQv1I5GLcjuM3v2+jrZNwhQKwOql3xCZ
         3/+62kceCVsXuN18sHwk5JL1CD8nguXuUOxiriDwPtPJwQziRZGaMWByX6+923ZqhPiK
         eE1ILrbQg4/h5/bTl/Rrv9ztpHGFK/eU63YZ/NYmm+TD2HIb9joKadVgd1svb0ztIhbN
         LQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762484827; x=1763089627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR77XGy8gKTpCV+3sSlL3axBPG4R/F86P0C6FJqRU38=;
        b=H3rjU/vhO5vJTATx6h/RANrDK/iBDHIfKyewofa9BTmVCRYMvqoZqGKt8RAz3Jhw0i
         nQ5gTcRrUMTLDr+Zt1NjnLwImEHGv/j0MbyuagBjbnMiFNX2GcEtAgtd9yiD6jYCmAU2
         7luC3/aPi/x42ctrNsD2eHyTiiJz/DXWSavU4GdoCiad7UlH/+7UyNgUuifx0Rs1iKCd
         JrXRKqV66jK63QKGdSJuuiL6V5jl8Mf5eRjZDtk+uhq78y7d3pBf9usa+26oBr6rKvZJ
         xih8QkkxF5W84z6YkhQC8OaEL7gejlTF77k1mH/X12Auo3tVEiFUYIMFlxTpC2oSsQci
         NXPg==
X-Forwarded-Encrypted: i=1; AJvYcCWFqMR33Hxl4kx2YeV+9jEtdQQqT9mfq0yGB9mWSXmVQhGA6vGzMrttWY/pSPfRlm9DKUL2uyhPPQAK2kjJFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUyLwLRGX1Gs8b+T7ExSjEWds8sfCHHsSp6IrfUQgDe1oUCgPK
	8Np/WFhJpxIvKU4N2AciCE7MvGpmzBpCS/WPxXXq1idMiRN9IGJVS2wB
X-Gm-Gg: ASbGnctV+QxcA9lK0T6iT6ybfKgeEgcDhNx6lZrHGn/rc6KBhr6djzsQ4o4OfTzrP8D
	qyL7BQgPcP6QK9gOjZ4hnSbnBh/9NOzMvEzywPtwmSNpob/l53CGs7ZhA+GjI1MGUAY57EOpnoS
	ilVrvIWonQgb7DfCq6lKyY71I0Oe4/dmyQq6FmMAelx4rJ39D9QSmfQWi2SDxQ8kOk/r+MCRtAj
	8ilwfRL9+XJFa30BlsLELNoGAUDYgnrq9mHXx+Y2XKHOT+YFg370mp6W/4ia6R3NnZ5OVui3DHn
	nVTYE29dst3hNyJH/GsES2agVCYeHpsr7o3Me9tGv1CYbq+I32KXAIEblkxrH9ebJqsS5XtI1Ad
	1xFkmt3sGfLMl0ND1kxXcoY7Yih/+53LuEUHalzbE08ItvGnJfrjIKyQZ6bxAAdpwzQJTAnRteY
	rpXCYO7EVT408VVc9KMWAlQr/Ri3Joo4lrV3ca
X-Google-Smtp-Source: AGHT+IFB590VLlupKmRJu3Xg8gkOtJWd0diOwJuCAD9JFt31fECUBp8uUIrK8y6sj/IrmT+p0bOb1A==
X-Received: by 2002:a05:690c:d84:b0:783:7768:55e6 with SMTP id 00721157ae682-787caaeead8mr1823477b3.13.1762484826556;
        Thu, 06 Nov 2025 19:07:06 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787c68c4025sm2798627b3.26.2025.11.06.19.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:07:06 -0800 (PST)
Date: Thu, 6 Nov 2025 19:07:04 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 07/14] vhost/vsock: add netns support
Message-ID: <aQ1iWCvSdrat1Y5v@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-7-dea984d02bb0@meta.com>
 <juxkmz3vskdopukejobv745j6qqx45hhcdjtjw7gcpgz6fj5ws@ckz7dvyup6mq>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <juxkmz3vskdopukejobv745j6qqx45hhcdjtjw7gcpgz6fj5ws@ckz7dvyup6mq>

On Thu, Nov 06, 2025 at 05:21:35PM +0100, Stefano Garzarella wrote:
> On Thu, Oct 23, 2025 at 11:27:46AM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add the ability to isolate vhost-vsock flows using namespaces.
> > 
> > The VM, via the vhost_vsock struct, inherits its namespace from the
> > process that opens the vhost-vsock device. vhost_vsock lookup functions
> > are modified to take into account the mode (e.g., if CIDs are matching
> > but modes don't align, then return NULL).
> > 
> > vhost_vsock now acquires a reference to the namespace.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v7:
> > - remove the check_global flag of vhost_vsock_get(), that logic was both
> >  wrong and not necessary, reuse vsock_net_check_mode() instead
> > - remove 'delete me' comment
> > Changes in v5:
> > - respect pid namespaces when assigning namespace to vhost_vsock
> > ---
> > drivers/vhost/vsock.c | 44 ++++++++++++++++++++++++++++++++++----------
> > 1 file changed, 34 insertions(+), 10 deletions(-)

[...]

> > static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > {
> > +
> > 	struct vhost_virtqueue **vqs;
> > 	struct vhost_vsock *vsock;
> > +	struct net *net;
> > 	int ret;
> > 
> > 	/* This struct is large and allocation could fail, fall back to vmalloc
> > @@ -669,6 +684,14 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > 		goto out;
> > 	}
> > 
> > +	net = current->nsproxy->net_ns;
> > +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > +
> > +	/* Cache the mode of the namespace so that if that netns mode changes,
> > +	 * the vhost_vsock will continue to function as expected.
> > +	 */
> 
> I think we should document this in the commit description and in both we
> should add also the reason. (IIRC, it was to simplify everything and prevent
> a VM from changing modes when running and then tracking all its packets)
> 

Sounds good!

> > +	vsock->net_mode = vsock_net_mode(net);
> > +
> > 	vsock->guest_cid = 0; /* no CID assigned yet */
> > 	vsock->seqpacket_allow = false;
> > 
> > @@ -708,7 +731,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
> > 	 */
> > 
> > 	/* If the peer is still valid, no need to reset connection */
> > -	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
> > +	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk), vsk->net_mode))
> > 		return;
> > 
> > 	/* If the close timeout is pending, let it expire.  This avoids races
> > @@ -753,6 +776,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> > 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
> > 
> > 	vhost_dev_cleanup(&vsock->dev);
> > +	put_net_track(vsock->net, &vsock->ns_tracker);
> 
> Doing this after virtio_vsock_skb_queue_purge() should ensure that all skbs
> have been drained, so there should be no one flying with this netns. Perhaps
> this clarifies my doubts about the skb net, but should we do something
> similar for loopback as well?

100% - for loopback the skb purge is done in the net exit hook, which is
called just before netns destruction. Maybe it is worth commenting that
context there too.

> And maybe we should document that also in the virtio_vsock_skb_cb.
> 

sgtm!

Best,
Bobby
