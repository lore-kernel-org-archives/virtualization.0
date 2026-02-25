Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027733CE86
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012047; cv=none; b=QRoo9JoSnzJat1f8wrI9jInPDzImeYaj7+863ErXFJJpi5K++l7qyK0++ywXmTHpswgBVTzUEzZXB85/E32Qa+XtjaO0IOjovVBdKRWTTxvzfN8YqV+iyTWMOHsD+q+zuRqODUOXfLugLfiipG1GoYgZ8BibLLmDK2ADlBXbQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012047; c=relaxed/simple;
	bh=vBjaUHm65tGNPiYlWRFPhKJtFf2Ma6GE/uA/rEPtwFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XmZGMjbWmhTOHyTGOj15rmE5xFirAHENqjWxo7NoFlwNTElf0T9nHRbbO5+KAgTgUm8uKT0yPx0/PGou4RFKNgHjnfrX0SDYz/hatrfqaQt3kX/uzSrYulQtK/fQ4eed3LNZ5rOggYNHCD+kEIhzQiSTXkh5KLPUeq18aXZ27SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmAKz+0u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmAKz+0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772012044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zaDdVCZLCjzGBPi9U/x91/R0/36/oNSWSoktsMcUCyc=;
	b=cmAKz+0udoKOPqTNMPCsWRqS0IJusLguurw1fPdNTR4O/mk6R8jvkDLiF7UX78ASF0a8Be
	mcjfAmgqElTkKUZBxbqWtsLKd6alPaFyex/Xuk9vnSGwo3Rjq2HE+hpDa7yjo0Qpycx66A
	XV3pbstw3O+VnisORE8ie78S92tYTZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-80ag-jR6MDGQ8BflVW3ViQ-1; Wed, 25 Feb 2026 04:34:03 -0500
X-MC-Unique: 80ag-jR6MDGQ8BflVW3ViQ-1
X-Mimecast-MFC-AGG-ID: 80ag-jR6MDGQ8BflVW3ViQ_1772012042
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837a71903aso20896475e9.1
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 01:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012042; x=1772616842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaDdVCZLCjzGBPi9U/x91/R0/36/oNSWSoktsMcUCyc=;
        b=V2hDLZa+yjq+MZN8ExUlo92OuJqNaMVEidHJqSXLULiE/YXwzNvwOh7oEaJwOfqcar
         W+i43ouAQYfOlvMywJFxvWzbH08t7c4a8AjYUwAaJpsdpfJSDKL9++UXhdHDqz0sQtiP
         Q2LyZAMWwiCd6D8p5UYIc6Cbxjgvv1MLCjRjfYRHw3yxzWWgrpn2nh1lIjhWStj++RF6
         dqtW6DWC45MkZ2e8qQ9cLcjY1mXdlWwH+nccESzWMy2CGGgVKvv/2SRZWTw3sKvDOmPW
         nczPxJ85imq/lBOXA0xVPAZn2oPQYgPmlD8Tvz79fGyVn71TwnowrwsrK4znIzMfqQuR
         6bcw==
X-Forwarded-Encrypted: i=1; AJvYcCXBartI8YR2xPM/aM0geMqv/Qpm6l7IqJYF6p7N4Yn0mxFCbgo+mfRRgroaZRs/Qu/SwgRx92EoTP3VDDivvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMeVO93M0vh/r4CVwdmEBbrDCXMCqLEAbR/vAVpMmlojCAVgDF
	gXWCynd4HgequmpzVezc7o69vnvPqOp9oY+h//TChokeQtH2/uZy7WjIgw0pj/Tdb6hvLyHmkoX
	cAkunYVMK66ip4IyBvMmaykWu87KZIeC7G6TgcyPEbH/mQxYHm6xkBXCuzu5HwYL8c9vo
X-Gm-Gg: ATEYQzzyWdXz4i7mAky+f0tZonXteS4PGHOiNZHCOYW6OKEnQtlqf0zW3X3OcrvlYT0
	Z6oIzAeKWnYYLpm3dmNxzq2WL+tR3MH0LKJTO3Yd9igE9BrJPwamBODhGuA02n2nQrxpOVLhE61
	/P2nSeQMVdfCaSN3oWyDFm7TEPkSRsWjBCamkOSgGm3tFU5TxxdrQ5cmqd9RGAGMzMxuUJpsbRR
	u8IYWZPz3J6/rLpgJeN0OO+14lSg0fej+L5MthFtCWoayNTLoaSXU8HHJX4M67Ax7BltWz4NSNU
	jrLp7HAN+3ZtEVUv/w/F9184NpmNhHfWYgwT6gIkh8W/LytDo4NG3CAkernvvHv+8bsvRbZ8L2C
	RBWmKiCLTy+jgWdPzchrELGImdI0sd7uVZHoIbX9SbVcbEA==
X-Received: by 2002:a05:600c:4f90:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-483bef2a427mr35084285e9.14.1772012042062;
        Wed, 25 Feb 2026 01:34:02 -0800 (PST)
X-Received: by 2002:a05:600c:4f90:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-483bef2a427mr35083785e9.14.1772012041496;
        Wed, 25 Feb 2026 01:34:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm18140895e9.3.2026.02.25.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:34:01 -0800 (PST)
Date: Wed, 25 Feb 2026 04:33:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Srujana Challa <schalla@marvell.com>, pabeni@redhat.com,
	jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com,
	kshankar@marvell.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225043249-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n7LCSZyVhUeIylLmeoxI5Qh-niwQ6N1mCiLrk0OUrDM_1772012042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > redundant runtime max check.
> > > >
> > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 8 +-------
> > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index eeefe8abc122..768ad5523dfa 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > >  		}
> > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > -			dev_warn(&vdev->dev,
> > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > -		}
> > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > >
> > > Do we really need this check?
> > >
> > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > defines this.
> >
> > That's why it's BUILD_BUG_ON. It checks it has the right type.
> >
> > We never *need* BUILD_BUG_ON by definition, what this does is
> > document the assumption.
> >
> >
> > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > the future, this check would no longer enforce the intended limit correctly.
> >
> > then it would fail build.
> 
> So, does this mean we don't need to account for the case where
> NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> 
> Thanks.
> 

yes. the code makes assumptions but it documents them and not
just documents them, build will fail if they are violated.


> >
> > >
> > > Moreover, you should add a cover letter.
> > >
> > > Thanks.
> > >
> > >
> > >
> > >
> > >
> > > >  	}
> > > >
> > > >  	return 0;
> > > > --
> > > > 2.25.1
> > > >
> >

