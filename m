Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E32D9EF0
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483941; cv=none; b=dv2rlwsPpyK4w2DlFwFEwzvVtf7nwc+HCGqtUlgvIfkQ8nMUYSIfOg9+7CvEn0Obl1CDIH6rKP9uQP/IMx9AZINtq6bob5maPIkAEXc4lfZ1O4FBkB0BKtJVu8oO3lPol0eMG0FhYuq1nYkwIr7+QaBkAXqBtoGobhYrlNxi19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483941; c=relaxed/simple;
	bh=LGZkf7YP6OLV6kK3Rv7CYUIiRvg3i+u7/aOFPhkBPKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URxQYwFCpE26Omkd30aroVDCj1xQOXNE8NIBHU1uTNFtOBBO7lnqxJiLi70YPrIcWxNW9s6yQVAkAAk50q2DEKqBKqXDydrUBl+cTJURUnjsnMnLTY6YTpp9a7eM6o9lHKzSEfu05QzmwuqZjMSGhQFg57RdinGUSgFBttZuY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1S1HCqK; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1S1HCqK"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63fd493ea10so366415d50.0
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 18:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762483938; x=1763088738; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=to+M3YH5XNWJ8sgc76iueqXwuR+T+gGj83wJZ0qaDfw=;
        b=P1S1HCqK+SBDbmG9VeAg2gEZqQhS71Xj1C2HHWhoJUg8RBeRInwFxLfqLw5U40rlQ4
         VJ0+yZo4jHld2KxgruXfAR6aElbM/OmDjwzec15xZlDQGDnjEux5CqfCiUr/dlRtl/oQ
         g7jYFhGsyZ26SJ3Nl6TlJwTJEIfWzQh9olJV6gNSbR45vDR6hKlcKa4MNP90yEdZnZTp
         jByb3dDStgVrA6S4ztNnc/iP8RsAlwAQGesfFZy70ERjABaalsPwWR8bzAQ6q5EsJRg5
         FsLd8n82fEBOXba20oChs3KURcbpFrzo51vw59m4EulHtni77TkWvdcmLwPuW+ITyxPu
         hB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762483938; x=1763088738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to+M3YH5XNWJ8sgc76iueqXwuR+T+gGj83wJZ0qaDfw=;
        b=QhgjHshWFDw4ciehDrL964gnUJ8OL+na9B3J4tPQGxp7A17FFNEST2vLCLdep1GElJ
         X/2z3VHuie68wZi4wBD0fS3A16EhecBexo78sbaLKUPM8pVnKsCVo88uNrHhWmFcuPjT
         bFk93kww4S3wI+/F2d8spMyDxzUis3/O59WdnnYoXHT2QoSpJ2xAUgm9kzuDvCTy+cSn
         NTO3V0kJVLqoRpp+C2D1NyrvKftOKglIvxzDTMCdQA/3gPF/CFEvSJr8BIWZA1azO0jy
         g1ijFlqAblt7xT4cpPUWreFOuBYr91I2qigl0y+QzJ5xPwiVBvVUy2DwAexWjKPhoxf3
         m17w==
X-Forwarded-Encrypted: i=1; AJvYcCXSD5Yykgu1m5XwvhQmmujqJLQBlYp6c+HvNIdgfxb+mrHEqpOF+FUHNXQcNPmrDMkzlvcy+1nC1+y2EWAwaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNwDz4+hWOTtUTiQTa9qW8TjuLWXix5ojLiCGutwD/czpGOrsC
	wQBh7URftvP5SJJLnpbMEpYOBHwsFDEy9vN+7b0ECKvXFChR0CaQAGTW
X-Gm-Gg: ASbGncu77JGNYVYl0eIBchTlEIE0fOqwKEBN9VbY6z/dlJbLOVfsBTkIZ1porYDZp4E
	tJ5/QG8u9exCqzxjijjCtvOfJQeffqHPbgxTCW23rVqAOA7NqEjyE+AJ6/bICqxDZikALP8RIVB
	skAhR28kvsJnr7JNtwD/RBKyKkzS8ZcVilWAvrtUhwE+r86rPxXNvkPWed5FNrYGGhkAGanLysu
	jxxsEZg4aUO5v9DnP7hCxM11oFLM4NOu8DHTO8YS9QrrIUjw89WmovdJRBMLaJ90U+0YVUXml90
	ljimbEKhLzUqEGryXYM3ZBM5BmPlwoxR8ux+AlTyxczhw1CFEvTnNUayYx4ZRrfxdOnIW03Ov0C
	F06fCdL5kbLcXFRNxSMkp24sprTNgpiDahoABZ2ngRPepqlwUOJGXY5H96CWak71dWXgAFe0Cak
	sk5xHvlf1Tl6qAbvNP5cOmvgak7/dT2l33MiW7
X-Google-Smtp-Source: AGHT+IEjmJ3F7jVxmWzAKOE8ZCFLH8yvuCjB7m8mU8An6yxSyAVDGX/tJUnPe0dCIHSXZMA38QvYjg==
X-Received: by 2002:a05:690e:4185:b0:63e:1563:4801 with SMTP id 956f58d0204a3-640c9d699f7mr96467d50.22.1762483937682;
        Thu, 06 Nov 2025 18:52:17 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5ca70f7sm1358837d50.12.2025.11.06.18.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 18:52:17 -0800 (PST)
Date: Thu, 6 Nov 2025 18:52:15 -0800
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
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>

On Thu, Nov 06, 2025 at 05:20:05PM +0100, Stefano Garzarella wrote:
> On Thu, Oct 23, 2025 at 11:27:45AM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Enable network namespace support in the virtio-vsock common transport
> > layer by declaring namespace pointers in the transmit and receive
> > paths.
> > 
> > The changes include:
> > 1. Add a 'net' field to virtio_vsock_pkt_info to carry the namespace
> >   pointer for outgoing packets.
> > 2. Store the namespace and namespace mode in the skb control buffer when
> >   allocating packets (except for VIRTIO_VSOCK_OP_RST packets which do
> >   not have an associated socket).
> > 3. Retrieve namespace information from skbs on the receive path for
> >   lookups using vsock_find_connected_socket_net() and
> >   vsock_find_bound_socket_net().
> > 
> > This allows users of virtio transport common code
> > (vhost-vsock/virtio-vsock) to later enable namespace support.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v7:
> > - add comment explaining the !vsk case in virtio_transport_alloc_skb()
> > ---
> > include/linux/virtio_vsock.h            |  1 +
> > net/vmw_vsock/virtio_transport_common.c | 21 +++++++++++++++++++--
> > 2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 29290395054c..f90646f82993 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -217,6 +217,7 @@ struct virtio_vsock_pkt_info {
> > 	u32 remote_cid, remote_port;
> > 	struct vsock_sock *vsk;
> > 	struct msghdr *msg;
> > +	struct net *net;
> > 	u32 pkt_len;
> > 	u16 type;
> > 	u16 op;
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index dcc8a1d5851e..b8e52c71920a 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> > 					 info->flags,
> > 					 zcopy);
> > 
> > +	/*
> > +	 * If there is no corresponding socket, then we don't have a
> > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
> > +	 */
> 
> So, in virtio_transport_recv_pkt() should we check that `net` is not set?
> 
> Should we set it to NULL here?
> 

Sounds good to me.

> > +	if (vsk) {
> > +		virtio_vsock_skb_set_net(skb, info->net);
> 
> Ditto here about the net refcnt, can the net disappear?
> Should we use get_net() in some way, or the socket will prevent that?
> 

As long as the socket has an outstanding skb it can't be destroyed and
so will have a reference to the net, that is after skb_set_owner_w() and
freeing... so I think this is okay.

But, maybe we could simplify the implied relationship between skb, sk,
and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
ever referring to sock_net(skb->sk)? I remember originally having a
reason for adding it to the cb, but my hunch is it that it was probably
some confusion over the !vsk case.

WDYT?

[...]

> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1578,7 +1593,9 @@ static bool virtio_transport_valid_type(u16 type)
> > void virtio_transport_recv_pkt(struct virtio_transport *t,
> > 			       struct sk_buff *skb)
> > {
> > +	enum vsock_net_mode net_mode = virtio_vsock_skb_net_mode(skb);
> > 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +	struct net *net = virtio_vsock_skb_net(skb);
> 
> Okay, so this is where the skb net is read, so why we touch the virtio-vsock
> driver (virtio_transport.c) in the other patch where we changed just
> af_vsock.c?
> 
> IMO we should move that change here, or in a separate commit.
> Or maybe I missed some dependency :-)
> 

100% agree.

> Thanks,
> Stefano
> 

Thanks!

-Bobby
