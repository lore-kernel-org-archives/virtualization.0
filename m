Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCB385520
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013714; cv=none; b=uhYan0Uar/aIKPsAe1TDtr09E0ojuLyBGirPcNBs61iak3rEXqY2fz1i+nzK83Uwu47XFN++H91KsGsmzQ18seYOzUlhaVBDiww0w2gFRgfS+nJq2iEdLqBbytriId2/X2VlrQey98imieNQYiqSl2+512nscWErhWZKPisboBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013714; c=relaxed/simple;
	bh=u9CvtSP91YekIS68SSQl4Vt/A8tkQgw8jEa8fPceo7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Sf64lawhHhE+hIcgwxMC71AGTzjIAb1P1jNzqL8+Cm2v/whq6jnBLhzvRqSFdlcFj1lKqVWD+4QnwJmwN96++R1R9lMTF4365W/XAL5jvAcc3voZYFmKAbFI44RrYqgLFigUaxcO4yXLYwkRR+b61PRsnWMAq0nyH+oAhEt5Q2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBPOnjKs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBPOnjKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qItuZ2RIB8SUFWGgO0o0RQca3VPYW8nU8swiC3uXqcs=;
	b=OBPOnjKs0FO8ReiAp2CU/AelRxHUd6odlMcP9DTCBml+Cer6bkrlgLn17lJa4Xv/TBJvdX
	bW89pcuJpXBVLcxwwzdomedyv5nXnhL4R2opS9v3FqkEMnuBJRMg7wUmWOTZQvo+9fzWvy
	tTSWZfRQQYk1XV2c8IS+Ug/4WTvP6C0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-h_7oVOEUNYW1mRxSKDQZvg-1; Wed, 25 Feb 2026 05:01:49 -0500
X-MC-Unique: h_7oVOEUNYW1mRxSKDQZvg-1
X-Mimecast-MFC-AGG-ID: h_7oVOEUNYW1mRxSKDQZvg_1772013708
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836cc0b38eso19278305e9.2
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 02:01:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772013708; x=1772618508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qItuZ2RIB8SUFWGgO0o0RQca3VPYW8nU8swiC3uXqcs=;
        b=oKLRbwd87GpoSarwED5U12pvAj+xE1f7oaMz8NhdwxLSSac7YyQHYX3++Li3zivlrD
         tDVDj5FilpJcGxk3jpA+ktwqEIP3o2Kzb4BFUOcQcP3jRdNYgBXVHEl3a7ydIbIpCjWv
         dw/U+C8Wxwe21ph0zUgG5D3zI+hGpiIEcFD2pKs1RMf2/YBub1wd4FPaKzFQwoNd6hoC
         xbdmiJr6soYEbgEo1kAVBoH+2yguirx8i9/kZY6Ntt1/lhNfj08p+Ukyw7bZUNFAhCpU
         o+sReKM3JH1CX8yS9JSK9rlz0dcxC0eD3MAgj0xtq3syApJGLOswFyRcQztZFmZeL71G
         UraA==
X-Forwarded-Encrypted: i=1; AJvYcCXf/thv0X+ivZCGaljq+lGs8Do0UGFbGUo+eABrYthw2Nkz/lDAriOrE+ewdqlCNI7f8FOoyZNc04tb2vCpOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqZ4+A0OTvjcA6l4Z3eER4ODuzoOUdC6YsZhlLBhN6q/n6PdlO
	I7LDOi4cCUUwCYi8OsWExXngnVNdJ6jK0s/MkllwJgV8gDwHgHX72DigfGBIoQQ9P1czTRxlyhG
	O0kczVGNlrqBwVE0A7QamfsBdQY6h6kcRZXT4k956wePe5Lz0DQ8nQ6B6wbJbtz+GL8MlbxlL6U
	Te
X-Gm-Gg: ATEYQzwCOTIzGEQX4P9rQKkA+N4hcEd18S7UWiyMBbL2RJtt9Pq6DtsKUT9Md+Zt41Y
	1Ny6AvWX9WWPE2V5WgTY8VJXjuCf7FPHRP/j4mtekYSzOLA0CpQtxIkiNWlRI/Virf0yFYDD6aM
	Yzp4ev0j5M2v5DTgY/cxnaULl6EkvtfbP1FvkTqoaIwvCJqXnydWjcHnhE1U/IlUKEIJloI/sS2
	MGX/efxebNfIy2/cpxpxd1Jum6581kWWvX2QQIWoo2wEzYDFaWn1wal1UA64c48uEWuMcMXhH/v
	RRD4zM6AshqfCutltEPlFb75TNxgXE6qksUvAqB2aTPjvaGSNXbR9ird5FUgFtxI+YM42hZ/KYM
	iPdOadvspSaHpReXNBxDEUHi8eS+wIyTvZ4QcUjAwXtT9Dw==
X-Received: by 2002:a05:600c:4589:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483a95dea3emr316809925e9.16.1772013707862;
        Wed, 25 Feb 2026 02:01:47 -0800 (PST)
X-Received: by 2002:a05:600c:4589:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483a95dea3emr316809155e9.16.1772013707338;
        Wed, 25 Feb 2026 02:01:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776easm8576745e9.6.2026.02.25.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:01:46 -0800 (PST)
Date: Wed, 25 Feb 2026 05:01:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Srujana Challa <schalla@marvell.com>, pabeni@redhat.com,
	jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com,
	kshankar@marvell.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225045757-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
 <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _SblEM-FQy57LZR160y-Ow0M9lmg5WmdXEnDvWCR2e4_1772013708
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2026 at 05:52:29PM +0800, Xuan Zhuo wrote:
> On Wed, 25 Feb 2026 04:47:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Feb 25, 2026 at 05:36:06PM +0800, Xuan Zhuo wrote:
> > > On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > > > > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > > > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > > > > > redundant runtime max check.
> > > > > > > >
> > > > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > index eeefe8abc122..768ad5523dfa 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > > >  		}
> > > > > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > > > > -			dev_warn(&vdev->dev,
> > > > > > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > > > -		}
> > > > > > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > > > > > >
> > > > > > > Do we really need this check?
> > > > > > >
> > > > > > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > > > > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > > > > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > > > > > defines this.
> > > > > >
> > > > > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > > > > >
> > > > > > We never *need* BUILD_BUG_ON by definition, what this does is
> > > > > > document the assumption.
> > > > > >
> > > > > >
> > > > > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > > > > > the future, this check would no longer enforce the intended limit correctly.
> > > > > >
> > > > > > then it would fail build.
> > > > >
> > > > > So, does this mean we don't need to account for the case where
> > > > > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> > > > >
> > > > > Thanks.
> > > > >
> > > >
> > > > yes.
> > >
> > > Why?
> > >
> > > If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of 64, does this
> > > violate the spec?
> >
> > not the value of key_sz. If type of key_sz
> >
> >
> > i actually do not understand the question. this is not what BUILD_BUG_ON
> > checks.
> 
> So this is the issue. Originally, the code checked whether the value of key_sz
> was less than NETDEV_RSS_KEY_LEN.


No, and the check was plain wrong:

-               if (key_sz > NETDEV_RSS_KEY_LEN) {
-

so if device supports a larger key then .... we disable the feature
completely? Silly.


But the issue is present in net just the same.

So I think the commit log should be rewritten to explain the real issue,
and target net, not net-next.

> However, switching to a type_max check means
> it no longer covers the scenario I described. Therefore, I think this is
> unreasonable.
> 
> Thanks




> >
> > > > the code makes assumptions but it documents them and not
> > > > just documents them, build will fail if they are violated.
> > >
> > > About this, I am ok.
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > >
> > > > > >
> > > > > > >
> > > > > > > Moreover, you should add a cover letter.
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >  	}
> > > > > > > >
> > > > > > > >  	return 0;
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > > >
> > > > > >
> > > >
> >

