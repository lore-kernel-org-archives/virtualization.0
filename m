Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32486299950
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011463; cv=none; b=smpVym0TOXUIxx4LRyFl0Nvp70WtRfAfzCN183SMAUqIAFnXPVCZ8chIdEra1lHRlV/piGQseXzwZLhxBbtmpkDqMioBbKZMtoI0198Uot4h1WlcSiJy+4upV4IAkNpFRTPE8KYWfzC3JqTBwzyJH98aWBAI7iwqAAcATcCHodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011463; c=relaxed/simple;
	bh=7uacBGYBiSdhOUvMcdrU/IsdPqCW87JB2my+jD3wn6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JeM2uepDMoM8AE5k2Ygvv2gKb0Fyne3TlJF1TfMlRUmIAmN4sYD0O20MVQ9ul7wbqeh5om63/qG9zRmUDgjLNHU/w63xJ/tR+EOj1NV2gU5fA4K8exxfR4Es/Nb/qJ0FmJ1FZ4XDATS7duz9bc9JbBRy9iVtK5YoKDsrzSEw6HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkHLlQxe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkHLlQxe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772011461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CAfCd727gg/hE7rTMdRZLpyODpAzeMqClx6IQZcOXTs=;
	b=BkHLlQxeMUitUFVNVXEJ7q1u26AfD5nN7q19Yys29aj4wXv4x7G/wbG50GM86+UB9PJb7k
	O4HNCOMObozCUQaf/NYCGPZ3iijWL41xauClMqV2I/YxCwDmy1pGazrfv2/xe46qxoZoGN
	o93b1IY6ZUBDwDlC/P86B/oBANJMezc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Dkv4XvyMNdi8ITmR-secQg-1; Wed, 25 Feb 2026 04:24:20 -0500
X-MC-Unique: Dkv4XvyMNdi8ITmR-secQg-1
X-Mimecast-MFC-AGG-ID: Dkv4XvyMNdi8ITmR-secQg_1772011459
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso67622705e9.1
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 01:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011459; x=1772616259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAfCd727gg/hE7rTMdRZLpyODpAzeMqClx6IQZcOXTs=;
        b=r8LJYR91amQ4smYN2o1Xe9/iBDfE2MCjudiYKrHz80RQK9ePjDDeUDFbE1aZmp6C5B
         QGEckpIYBjGw4XeJyq2M0j6zV4pFGD2MrrPnb3iKaYcfsxBehVbN+tv81zKLpyjMTltV
         c2NL1aumQLvfjGbHOj1vwep9LXe30NMFBZtHzkIMN8+J7Vg5N1sBeX51uPC7FSgaQ0KR
         HEfkd9NjkGFAeJRvzODuGmfdBj7uA3CYOpxr+omBTpR1GcB4Nb3Dh9XfM2CBQmLTA54x
         YtyalXFMZSzrc7ci9xSZwd/DWLvRrJ9Dx/ihDqg71iy+D2X0lpOLGzAAdVh1epiVU/cC
         xFjg==
X-Forwarded-Encrypted: i=1; AJvYcCWO3iq9EP8cnd3Qjom1iaJpueOoD3QLY7m5w/gJzHrTttj5Pif9QqYhAeBSokqWnwcXN5mTw3UagfZwc1nQUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzWAV2OC2pW14YFgrzdGpGEhjSn5Fe5YPAWzCX6/YoF4S3nF4D
	44CUiCWhKMrWfiy3URfT2a76+gTsyCcwRm10JS22AqDuy4mkCgl2EtlCXzJ35tYrPFev6vLQ6n6
	Qn1zJvP/t+EoaE/DXI2CaiIuZSDk5bxGW9HgcxP19/hM4OrhS9MTOvoPfo1ozMCROEyRY
X-Gm-Gg: ATEYQzzESnQjtIEmb6+OIJVRxXcQMCBo7umMqNYPukdyBOxZ4u4549wEVdEiHME5eNf
	vJPc9avHRsyQDKBMMOZdoVWamxbyjeO61Mi669syAyalAODo+De38v8VbefMQJ7XhKyADFT15+J
	tvXNaCoq6rH/oo9iqRyXU+ugad1qkEAkxNlfLcauvP5ask7ZenidfoggmN4maiuaoJ6zwvuJ294
	eG3UXLFKjx0CiEMuDd0P3zle9Gi/0lEX81d7Oh+clvvwTd0KshxfEQA57zWu7zlOLrANHXwZpAL
	uJDUJogezXDimWZFTkJcvcG7JoB2iP8mUg+r3FxLIzkTxno8ODiefvw6aS7MBcoqwCl7s4VPehv
	wMVdAc5aiGEiL61bQS3fk8nHSndpxFwlKgolN8h7Nogq2xA==
X-Received: by 2002:a05:600c:c16b:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-483bef248f2mr31894455e9.13.1772011458575;
        Wed, 25 Feb 2026 01:24:18 -0800 (PST)
X-Received: by 2002:a05:600c:c16b:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-483bef248f2mr31893845e9.13.1772011458027;
        Wed, 25 Feb 2026 01:24:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff1csm31882149f8f.20.2026.02.25.01.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:24:17 -0800 (PST)
Date: Wed, 25 Feb 2026 04:24:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Srujana Challa <schalla@marvell.com>, pabeni@redhat.com,
	jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com,
	kshankar@marvell.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225042302-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZS_xUtzWIcs5dzoZ9Xu69J5T_KQ5jDmdESXmmQ8UJ-Q_1772011459
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > redundant runtime max check.
> >
> > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > ---
> >  drivers/net/virtio_net.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index eeefe8abc122..768ad5523dfa 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> >  		}
> > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > -			dev_warn(&vdev->dev,
> > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > -		}
> > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> 
> Do we really need this check?
> 
> If I understand correctly, the intention is to cap key_sz at 256. However, since
> key_sz is of type u8, its maximum value is inherently 255, making this check
> redundant. This is not only limited by this kernel code, the virtio-net spec
> defines this.

That's why it's BUILD_BUG_ON. It checks it has the right type.

We never *need* BUILD_BUG_ON by definition, what this does is
document the assumption.


> Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> the future, this check would no longer enforce the intended limit correctly.

then it would fail build.

> 
> Moreover, you should add a cover letter.
> 
> Thanks.
> 
> 
> 
> 
> 
> >  	}
> >
> >  	return 0;
> > --
> > 2.25.1
> >

