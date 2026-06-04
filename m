Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9C30D3E1
	for <virtualization@lists.linux.dev>; Thu,  4 Jun 2026 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614863; cv=none; b=n5atPbb+QVmtWFDIYaWtK16p2Er8SjLzQfnDqw3RcKPfiaXa0fW/ldOtLHJY+Jksyg6rjCId/bFFOv1KDhSXXn5nkDjmWMEyqiA2osi0XazZ0RSDGZq1PLYKZoajYJkC/hksEF3xJbTsTxu0MYL5+pMqEvALm2gI1lyHmarTYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614863; c=relaxed/simple;
	bh=5y3PcmFRYqRP1NnGXJUwB0A0KdsvIgR/FJxx9aWTUsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZrwDZErUiMAP3Bq9o2UOJYRP5HkI27GX2oH3e+87+31pXwklrd3NMwHoI+299zSOSdMb2py1p1RYY4YYricsVx72KjMTMTNT9JkDjW8FN56P0dRWLXF1/sXb7+9EU6nP0mpOBlYWRrBib7ghj9csPsYWc3BZ3EgXvzzIF2U9HuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtDAYQvQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtDAYQvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780614861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLGZz3723Aln9n0iz1W4fVsSKoXjcy4jTxlM5UdbXW0=;
	b=gtDAYQvQ3fHS9MN5Pta9lV5QG5V9T4BVoR+uyZ5jNa5vjruDV8eyPUnop+3v/oCHvqrOYI
	0zEqNdWL6EWssieMVEUe3GytFc9iWFAUTpO54JmrxPLaki/siFMZb2o/MSaj/oY1bBGdNj
	oo91iAqxHuvXoq3Jlpf1mjbgJIeH+s8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-uNhjrbGyPd6yEo4Rx7AG8Q-1; Thu, 04 Jun 2026 19:14:19 -0400
X-MC-Unique: uNhjrbGyPd6yEo4Rx7AG8Q-1
X-Mimecast-MFC-AGG-ID: uNhjrbGyPd6yEo4Rx7AG8Q_1780614858
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45efa2f7009so752599f8f.3
        for <virtualization@lists.linux.dev>; Thu, 04 Jun 2026 16:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780614858; x=1781219658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLGZz3723Aln9n0iz1W4fVsSKoXjcy4jTxlM5UdbXW0=;
        b=rnb03XWSfityPAIne0UJRXkVPfvWLEQQ+xhyM620EsaMLpTuSnXB2ljMbekozp/frh
         QWdGOhXFjZxtnx7kWHUfiW+nxskxlmK8wt8dPWpqCDNcTdFp98XPhXj2EkSh6YiLubnL
         3OWOAuVI/MIBTNMlG2mCzlX4qpshwr7AEsGco97a/Y2WoMsHpEaL0KKq9UWPLpwnhI93
         l3MbqSFKMBwXTjxQl/19hmkpnxQGPH47jgn6dqcAiKJoFFuuGXoR6FTzqtE6JzyY1wDC
         sQ8Yq4ogrLLt2HyZmfuVueEoGocg7SRBOOWRH9uEzpbnMijlgPn0ieC/NuMztJGfXR7I
         JefQ==
X-Forwarded-Encrypted: i=1; AFNElJ+BmFXkfxBp1wc2CUwAn3nd2o1FmQACl5RDTRtfVoQntTAtugtcFGuPTupkvJ6EIrzdh41dUtXhQWss045eHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFevOAZzbro4hBC1MK8JKjK6yAzLT12Y+qVPWWwEWfc6rCrmoY
	nGXm0Uf4QuOxVEibZgJG1RRqNJewDDbHuYj8MnhJPWXB1BfBkpwdPymCyO3VKvAPsXKIbYhKxzW
	CByCTUcC9puKkJf47zi1zOjzZJ+fgOulAZq6bS953Y7YOxGX1YHoVqjLwdYQib2yk5azJ
X-Gm-Gg: Acq92OHHFUieMVRKNc7cEBJrDWutAsMgLA0dkVShUKQISkWeUe2k6UoEOWC4628gUU7
	bU1TwmIc7xhIBWyeN8FHLxhp+QppwIb01f57SEnRn2e1if260YjhhdGFNQF1JFZau3V1hjaZpzm
	iSx/p+cNvXRPSod8lLQgWYracBW2CNwoALVx3eflZciqiJzKZyQzY5WwyMUjADScZBb8cTYqN/q
	VY3abZGnwDNjBpmEpKpYy6amAlkN7dIMlgf08lF/aOdrJMziYfipnPghxUKJMcZ6+NoprSndIGC
	eR+PzBjt0WDtUtZjh2RnC1xjOfllkPPWZIVMQzXq4zQDjlA83G6MIU6Erk8PsAwJ5kg8Ax3SrG0
	MvW2Smiar/64IQJrSdgDYunbOtamVARSVeUWXBVirtGjRZbnq1za4Xvs=
X-Received: by 2002:a05:6000:b82:b0:460:1301:dec8 with SMTP id ffacd0b85a97d-460302dc4a8mr1134267f8f.3.1780614858152;
        Thu, 04 Jun 2026 16:14:18 -0700 (PDT)
X-Received: by 2002:a05:6000:b82:b0:460:1301:dec8 with SMTP id ffacd0b85a97d-460302dc4a8mr1134244f8f.3.1780614857676;
        Thu, 04 Jun 2026 16:14:17 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm19910295f8f.3.2026.06.04.16.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:14:17 -0700 (PDT)
Date: Thu, 4 Jun 2026 19:14:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Qing Ming <a0yami@mailbox.org>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shirley <xma@us.ibm.com>, "David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/net: complete zerocopy ubufs only once
Message-ID: <20260604191341-mutt-send-email-mst@kernel.org>
References: <20260601104300.197210-1-a0yami@mailbox.org>
 <b6182472-503c-43e9-a850-87cd40f86aa8@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b6182472-503c-43e9-a850-87cd40f86aa8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: daLgaLoW0QndD-KQazm-TWiQ0fzeoY08j1TI6-qCZgY_1780614858
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2026 at 12:55:49PM +0200, Paolo Abeni wrote:
> On 6/1/26 12:43 PM, Qing Ming wrote:
> > vhost-net initializes one ubuf_info per outstanding zerocopy TX
> > descriptor and hands it to the backend socket.  The networking stack may
> > then clone a zerocopy skb before all skb references are released.  For
> > example, batman-adv fragmentation reaches skb_split(), which calls
> > skb_zerocopy_clone() and increments the same ubuf_info refcount.
> > 
> > vhost_zerocopy_complete() currently treats every ubuf callback as a
> > completed vhost descriptor.  It dereferences ubuf->ctx, writes the
> > descriptor completion state, and drops the vhost_net_ubuf_ref even when
> > the callback only releases a cloned skb reference.  A backend reset can
> > therefore wait for and free the vhost_net_ubuf_ref while another cloned
> > skb still carries the same ubuf_info.  A later completion then
> > dereferences the freed ubufs pointer.
> > 
> > KASAN reports the stale completion as:
> > 
> >   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x1d7/0x1f0
> >   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x101/0x1f0
> >   vhost_zerocopy_complete
> >   skb_copy_ubufs
> >   __dev_forward_skb2
> >   veth_xmit
> > 
> > The freed object was allocated from vhost_net_ioctl() while setting the
> > backend and freed through kfree_rcu()/kvfree_rcu_bulk after backend
> > removal, while delayed skb completion still reached
> > vhost_zerocopy_complete().
> > 
> > Honor the generic ubuf_info refcount before touching vhost state, and run
> > the vhost descriptor completion only for the final ubuf reference.  This
> > matches the msg_zerocopy_complete() ownership rule for cloned zerocopy
> > skbs.
> > 
> > Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")
> > Signed-off-by: Qing Ming <a0yami@mailbox.org>
> 
> The patch LGTM.
> 
> @Michael: to you want to take it via your tree?
> 
> /P


I wan't copied) Alright then.


