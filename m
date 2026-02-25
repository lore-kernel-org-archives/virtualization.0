Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C618787A
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012851; cv=none; b=OghCtcXWnI5LfwwyvxPncO45+vL+pQgs4qrw49dnR0uy06cej+5t1MvQMBkd2X8MUfnVaSkZQdQtYMHzQVk2eFMr2J58a4FdZ4qkX8rUecw8zynQzOnWvlAoq0bbe9POfh7H0liKRd5E3Rqt2w0p7XTgi73ewXQRb0SAKOS5+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012851; c=relaxed/simple;
	bh=HvwqqTyWU4MEM1BeyGiTaHQSwuFe1MwTHpZ2P4LmB9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gW1QMIzdSRLK12cIQtYo5nUsAzitcWFgO6fv54sL6QvX+VvwlDYuJh+CjCjUboP7JJr3EJlMG5HdxIkgtpI3b+XxeNdlmvY+zbYnV0Ajl3jCWsiD//iPd5m70SzVskcQNJFgK2fxrdYamba8Fce/j3CTw/PlYQeYu9OasSHIoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCAOYOr9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCAOYOr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772012849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSquBuVZ4YagCMgghq5ihwJ4c1q9qnubzSm6xWsh3ic=;
	b=hCAOYOr9wwlepxEq7lAJ9adLbaRYArDqIjbWVG4xAdrbuOzvjWYB4JTfDfX5yOZnyR3C+z
	yoG1cFBUjPkLIp352O47fPZnsRidcqyu+l0cksJ/hE0FjdoeNYujeS4CF3cVXVJdW6raff
	kETFsyocPzwnawEiTUAUIFMuAWbLslU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-die-9fswNaS6ctsRw3Kbjw-1; Wed, 25 Feb 2026 04:47:27 -0500
X-MC-Unique: die-9fswNaS6ctsRw3Kbjw-1
X-Mimecast-MFC-AGG-ID: die-9fswNaS6ctsRw3Kbjw_1772012846
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435db8ebc98so6549758f8f.0
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 01:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012846; x=1772617646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSquBuVZ4YagCMgghq5ihwJ4c1q9qnubzSm6xWsh3ic=;
        b=aUvzZZJj1p8DlChz+EHQjKzqO7PltrbaeaVY0Bu//Y8Tbnof6qwfweFl9d61PczSma
         rD7krn//oxcciRioHLKOktEcjiOtKC4wkg+B5OUsQzYQMxQr6z5sGpCtyxlg2Z6acV3a
         bVc8iwSWEi3dPkrSmyEb6ZfLeJh1+Ko44asZlC9w+StHBHUTWyB6N6mGkkw48X0PbHyJ
         O8D83hEwKEoJpe3AtOCcbtYTAeqdOPOt76K2pZXp3hQWZwvT94dUrrhKs0Z+12JBWmz8
         WTMWk+DRa7AJ61H07dxdTeTtbEvSxf0aeSvd3XGqb4eYClEF0cguFuyTEYK8ACbgG0KH
         qsbA==
X-Forwarded-Encrypted: i=1; AJvYcCU+YbyqtpMLhyDQSm/yDM/Htv7/lDQdBfPNTa56FlTxixB9mdZ3QbpOXusmt12ZO4v5NjLVsUF+Vtw6GIbE4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOL+hGSB/wXtqO082OXTYtWfFsnUg9gU7o7wqSACU7RYkNcpku
	OulF4Rc8pZo5cMMyrwygzZ82OD5NSEZDz2ng/UXotJMAVw3VbWrk+NUHooSyYPYOleHTMIVIo9q
	Y4NzGRDQX11eAXb4zNsILwg8Zs/3Tmz7hGfxbKjAJIcd4Apvx/43Woupea/h3NYVMuhRe
X-Gm-Gg: ATEYQzz7B18oMmgPuo92nZuJPo4DnpNFLWXEp32UgdegeAmDny8ZU+nc2+QxIgg+KSu
	YgQ1INkYBR9aUudSKbySKNuc5rWsnGAFKxqXY4ly1717JX8O5zpizwJ4ZI+9IMrp8WnmpF0tjN1
	wEkdRdhnkIw+sAj/EniOnHLMTh5gbBSucgMfujLssEu40Ho8CRHleWkWwHbQ0QNhAm4GkE2Oj9f
	KuEMkdIyTrq4MEfvw0nM26ooe+2bkVfmV/im5kztAEDE9Hn+l8OjrGa9KyLTArlm3EAuSciStRe
	jlTqo/DWZip7Tq+BrhkgOYUaT26yXW44v5VJBBYoezhO2eDEN6DOAlMFNCK0JeYUdrXagRnB3IM
	U+OSvA7wBnlqlPCs9hOt9qt2GVLCebe2EhUO9a0v1EO6Ieg==
X-Received: by 2002:a05:6000:2311:b0:439:8f6f:1b25 with SMTP id ffacd0b85a97d-4398f6f1e2amr3163506f8f.1.1772012846311;
        Wed, 25 Feb 2026 01:47:26 -0800 (PST)
X-Received: by 2002:a05:6000:2311:b0:439:8f6f:1b25 with SMTP id ffacd0b85a97d-4398f6f1e2amr3163450f8f.1.1772012845720;
        Wed, 25 Feb 2026 01:47:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff27sm34467347f8f.22.2026.02.25.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:47:25 -0800 (PST)
Date: Wed, 25 Feb 2026 04:47:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Srujana Challa <schalla@marvell.com>, pabeni@redhat.com,
	jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com,
	kshankar@marvell.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225044528-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E5hax7wL95BhUT8i8-X1gQlSoBuVluisUCrG8nQ11TE_1772012846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2026 at 05:36:06PM +0800, Xuan Zhuo wrote:
> On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > > > redundant runtime max check.
> > > > > >
> > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index eeefe8abc122..768ad5523dfa 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > >  		}
> > > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > > -			dev_warn(&vdev->dev,
> > > > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > -		}
> > > > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > > > >
> > > > > Do we really need this check?
> > > > >
> > > > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > > > defines this.
> > > >
> > > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > > >
> > > > We never *need* BUILD_BUG_ON by definition, what this does is
> > > > document the assumption.
> > > >
> > > >
> > > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > > > the future, this check would no longer enforce the intended limit correctly.
> > > >
> > > > then it would fail build.
> > >
> > > So, does this mean we don't need to account for the case where
> > > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> > >
> > > Thanks.
> > >
> >
> > yes.
> 
> Why?
> 
> If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of 64, does this
> violate the spec?

not the value of key_sz. If type of key_sz 


i actually do not understand the question. this is not what BUILD_BUG_ON
checks.

> > the code makes assumptions but it documents them and not
> > just documents them, build will fail if they are violated.
> 
> About this, I am ok.
> 
> Thanks.
> 
> 
> >
> >
> > > >
> > > > >
> > > > > Moreover, you should add a cover letter.
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >  	}
> > > > > >
> > > > > >  	return 0;
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > >
> >

