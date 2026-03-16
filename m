Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9A392C20
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662693; cv=none; b=HepFkuIPaaX6Me8rl9H1tYgi3wBJm21acG/dxzHgd0se+RBL+fek1UIU/XkMbzwJ9xbtETC083V8nrr6S++TtC9OLLW1igJfI4CgxtGIgOT2nxL3fKCnmmoDrnCglKtz/WbQMiSeApPIXhSB45DFzRWTG+EvTfDnP248lmGr8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662693; c=relaxed/simple;
	bh=CN3BB8jMqtpHX9v247an8eQx/ZrNnfSh/VbSD9NzPqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gdNKkmldP1MnT6AYP+fi4+0Y1MM9/49pJftdDRkqluB0lPSfSjY9v1ZIq/ShaYkbYlLii5C8mbUWhOssJiUChsfwsyuaVYFcmBXMIMVSbOHQK8URRoF/A9cIM1vSO1rcg0Dhdtyanj5YP2lJ3xodqt/QxBYHd93nYX4saObZUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6qk/CCO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6qk/CCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773662689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1ThxgnukPZdnVsAXkBiIHRauBYKnXhO8ujaThY4wrs=;
	b=B6qk/CCOIDDu4d5C2GaX7UJl2f6iHespLdxQx8qAMfnYPIBR3gOmHIF20o64nh9t27Hx+y
	hXbgyrO5CN80v6ZPTLQ03FO1qRn2FkRC+pmG3UzRotTzsWwTHptYjuk/iASyqep6E9G5nY
	fhME/5CpAoHS6Fkv8pFGdNshpqMfwsc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523--ptp1lnIMMebvR-Nma-_ng-1; Mon, 16 Mar 2026 08:04:48 -0400
X-MC-Unique: -ptp1lnIMMebvR-Nma-_ng-1
X-Mimecast-MFC-AGG-ID: -ptp1lnIMMebvR-Nma-_ng_1773662687
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439c112b1a4so2906240f8f.3
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 05:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773662687; x=1774267487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1ThxgnukPZdnVsAXkBiIHRauBYKnXhO8ujaThY4wrs=;
        b=A+pJFdW/tVbyes+5y9VFu3GBAdpH+30u5xSDZwa3+LGPxR7N0Ul0YYgytPROjP8AlM
         w3bMvvSAn1TEXz3CwsEN5DOusLchfPrWvU5UYjjlrGB9abF1JKr5VnzIp48mdvak3Zvj
         tUUCIc1rbgAjE8N7l3ugiFlqOXd11Vz94cRaR9ZnonDiBHnC4eMisaN1aGTHpHWCJh0f
         ssi4hGsCuL1gveZ9eTvAO2nhMiKRwNVZb+HVJ8upbeHpN0QbFCX4Ktfr8kSyqNSmesR6
         wsPshkDoSQATxc/N3xPde3JVjOu/nU2kOXBCt2meU+2uBsdn0nTzza1QTbkhBESBLGIB
         18EA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZXvWEm3x/6FO+7Ij33qHRcnPJfjvg7/JhF2CLlveQJjUU148BQ4bENpx8gqRbynojUJHvnfAaCpUdMae6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXjGln86cIVPDGpyiQcb0VLhiNpeoAATfKydu91SbzPYyBl/6q
	/0VX1yTGjjkR69ltWXHj42+oQasqpNGbAYOpjWAI/SIfPOY6cnHahFPMmQOg6XQjOEWndScBVYP
	il97p815zEU9HjTLLow/WAkQt8k6JSjKGk/uUj6dFqLu37c6vSOIekuYygRV02b73WCJA
X-Gm-Gg: ATEYQzyYeF7VxL1OOT4VAAzvjkSHnE+pKU761NKUUGi/TuIQFd6ogO0ZMX4uWuq0jDr
	WwnE/SurBN/O6yt8evR3OPj9/ZfiAmsEwsCLp+6NNROcF0S4s7NL6qVSrHuvUgRw1xwTNiAHn+V
	KLxz+3mktZz2IVxjYKTblYuUPYfOa7zUJYExb94Nu9k5YCM3i1d79aMIl9erBfxB9U5xok2m6HE
	AC0rQkiOogxhAYS8V9eaTzYsjr30erayjjqCsJKyDO5qrvUYCw8SeTOVZf7xqkC8rEOIDRv+4Hs
	SsiTODy2Qx4uVXNRF3TXreFpCgPhSo2QvKmKpMjg5cn3E9r1FBrVu+Wb2+IVpsoMCqPmf6E51B2
	ZGaXFiv7IWWLmn2wM37KU/g6KiEHFx7qNvhDHfB33OVF+Bg==
X-Received: by 2002:a05:6000:2383:b0:43b:41b5:e02e with SMTP id ffacd0b85a97d-43b41b5e19emr8017952f8f.4.1773662687013;
        Mon, 16 Mar 2026 05:04:47 -0700 (PDT)
X-Received: by 2002:a05:6000:2383:b0:43b:41b5:e02e with SMTP id ffacd0b85a97d-43b41b5e19emr8017848f8f.4.1773662686464;
        Mon, 16 Mar 2026 05:04:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b45e5c233sm6464487f8f.33.2026.03.16.05.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 05:04:45 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:04:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260316080419-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260316054232-mutt-send-email-mst@kernel.org>
 <20260316064256-mutt-send-email-mst@kernel.org>
 <6d43dbbb-7d04-4442-8743-3963b61195cd@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6d43dbbb-7d04-4442-8743-3963b61195cd@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _nzQm_P7y2sRCThVRJo0tAdUpH9LK2AMJaNfXxyOuxM_1773662687
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2026 at 05:27:57PM +0530, Vishwanath Seshagiri wrote:
> On 3/16/26 4:13 PM, Michael S. Tsirkin wrote:
> > On Mon, Mar 16, 2026 at 05:56:20AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Mar 10, 2026 at 11:31:04AM -0700, Vishwanath Seshagiri wrote:
> > > > @@ -5857,7 +5863,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
> > > >   	/* In big_packets mode, xdp cannot work, so there is no need to
> > > >   	 * initialize xsk of rq.
> > > >   	 */
> > > > -	if (vi->big_packets && !vi->mergeable_rx_bufs)
> > > > +	if (!vi->rq[qid].page_pool)
> > > >   		return -ENOENT;
> > > >   	if (qid >= vi->curr_queue_pairs)
> > > 
> > > 
> > > 
> > > It seems that a qid that exceeds curr_queue_pairs would previously get
> > > -EINVAL and now gets -ENOENT.
> > 
> > Or maybe this if (qid >= vi->curr_queue_pairs) is dead code?
> > I looked at it some more and I can't find a path where this
> > triggers.
> > 
> > > Maybe reorder the checks:
> > > 
> > >          if (qid >= vi->curr_queue_pairs)
> > >                  return -EINVAL;
> > > 
> > >          /* In big_packets mode, xdp cannot work, so there is no need to
> > >           * initialize xsk of rq.
> > >           */
> > >         if (!vi->rq[qid].page_pool)
> > >                 return -ENOENT;
> > > 
> > > 
> > > Alternatively I think we can completely drop this chunk: we already seem
> > > to init page_pull at all times except for big packets mode, so the
> > > current code is fine I think.
> 
> Yes, I agree qid >= curr_queue_pairs appears to be dead code.
> xsk_reg_pool_at_qid() in the XSK core already validates
> queue_id < max(real_num_rx_queues, real_num_tx_queues) before
> ndo_bpf is called, and real_num_rx_queues == curr_queue_pairs is an
> invariant in virtio_net. Both paths hold rtnl_lock so no race is
> possible. That said, I'll adopt your suggested reorder for v12 to ensure
> vi->rq[qid] isn't accessed before a bounds check, even if the check
> is currently redundant.

I think we can just take this as-is, and do more cleanups on top.
Acked-by: Michael S. Tsirkin <mst@redhat.com>


> > > 
> > > 
> > > -- 
> > > MST
> > 

