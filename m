Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150815490D
	for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632172; cv=none; b=Ug2VZ01qInUDJG0dyXO18/LE/GGxSuTC/PXhnXZ6E2W9mxTREW6vfEH98nl4DPqbrZhVkTD8YfvdpeO5SoBboinzHTIgG1XDz6z8ymGcdk5RhLdljepDdTmO/RdWMWrHYH/YX0S8BCLJCJa5DZMdzd8+9w3P3qUiJKIp8vraCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632172; c=relaxed/simple;
	bh=aknFNqqxJry03mMtGqJFoI/wKDCcG2OQaTtQxGeRRpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hHncKdrEKr0rFUeyke7+upSXGKFd1jGsmff9AosIZiRaWTuorej1fA6+2cA3X8PhRHMFoJp2jzhE4f+AVIzycbet7kbImawVLhNqJK3pboFweezKkb4mIdSyzaAZ7sVESsBK2pyRNpudWslwiOArvnUEuydLyaI1mus76XTN6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkIc6wGO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkIc6wGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708632169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip/bb26cz2+ipekHalCr5lDscUM2updhLQwbQoyojpM=;
	b=JkIc6wGOdNyvV00ujFj0cthtQh/iN5Agz5lEUFva0BE+e6EMpkNqtRC2Ep2lwBx15vJp7G
	weSRGjLjsWF/XCvROCOtpzJ1+bQeUp++KgWKReyWAGhdPvHwBiBm72IkeHnUoK7Wa+fiXi
	AHak35FxlvlFt4DvLQ+iFL0fjQG89Us=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-K6Cpy4-bOkiX_SODqi1B-g-1; Thu, 22 Feb 2024 15:02:48 -0500
X-MC-Unique: K6Cpy4-bOkiX_SODqi1B-g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-411dca63c56so413615e9.1
        for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 12:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708632167; x=1709236967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip/bb26cz2+ipekHalCr5lDscUM2updhLQwbQoyojpM=;
        b=DgfvwbjHmhFchIAa8SgMcuURfBm5XDdduiXa+Hz7P3+vlBTE8uJK5sfPtN7nnkRDa6
         2hHJy9d1WrMR9ciGRl3Nr//53hj3LanSP5imksWKmxqalG6LnBD3eHKOhX6BeAHLYLM6
         zp6aKSAHPdPhQCGvQWethvspD86yHFbQTBh8ZKuGYQuWX6VSs+z3hlhE5M9chpzGtHN5
         AUY5j/X1+IAMLIaVevkVUCikX2OyCSRFEfogUsLWc7syKVDgXgnpHIoNjrfN7xw2Wvl2
         /VFNPhkbQxbRlQVtE3f5/WIME6s6niYqEmdc1nmewZfSr7Id45cs0+SBEC0Nnpa9sr4z
         cpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFVIyo8MnxMC5//HOp4ic/sb1KrQiU2X8kZHrv4MrekWl61twhBsL3E//W1eS3A+aD2xb24NIOeT+IwVbJ2V1DwrrPGS7AN2L5akr6Z68=
X-Gm-Message-State: AOJu0YytzhdTkHBbTc0wizjlXOBog5slmEF0qYVm3mLn7Hlx1bD7PqXa
	N+lNGuFDZ1Sjsp86Yxjm/izp5KDqhKCsTKnyAeJk0r3DPkQNq203+FlvyTL3FUbxcHZzLvYuwqS
	zQddHkQOChChkJEy81xm3HcOUlbiIqWDHjxqJ7t0LKygeoJkpVUROqiJOyIX+8h1TPtmjbIeT1n
	k=
X-Received: by 2002:a5d:480d:0:b0:33d:9d4a:b28 with SMTP id l13-20020a5d480d000000b0033d9d4a0b28mr114021wrq.18.1708632167122;
        Thu, 22 Feb 2024 12:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGY5xEB+oirt/8WYolwR+t/b3r7Lw8iYBr645QsLpjupov8MKzMLmF73APkFMsTjyAiTEk6A==
X-Received: by 2002:a5d:480d:0:b0:33d:9d4a:b28 with SMTP id l13-20020a5d480d000000b0033d9d4a0b28mr114007wrq.18.1708632166787;
        Thu, 22 Feb 2024 12:02:46 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b004128808db91sm3049224wmb.23.2024.02.22.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:02:46 -0800 (PST)
Date: Thu, 22 Feb 2024 15:02:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
Message-ID: <20240222150212-mutt-send-email-mst@kernel.org>
References: <20240115194840.1183077-1-andrew@daynix.com>
 <20240115172837-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240115172837-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 15, 2024 at 05:32:25PM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> > When the Qemu launched with vhost but without tap vnet_hdr,
> > vhost tries to copy vnet_hdr from socket iter with size 0
> > to the page that may contain some trash.
> > That trash can be interpreted as unpredictable values for
> > vnet_hdr.
> > That leads to dropping some packets and in some cases to
> > stalling vhost routine when the vhost_net tries to process
> > packets and fails in a loop.
> > 
> > Qemu options:
> >   -netdev tap,vhost=on,vnet_hdr=off,...
> > 
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  drivers/vhost/net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index f2ed7167c848..57411ac2d08b 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
> >  	hdr = buf;
> >  	gso = &hdr->gso;
> >  
> > +	if (!sock_hlen)
> > +		memset(buf, 0, pad);
> > +
> >  	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> >  	    vhost16_to_cpu(vq, gso->csum_start) +
> >  	    vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> 
> 
> Hmm need to analyse it to make sure there are no cases where we leak
> some data to guest here in case where sock_hlen is set ...


Could you post this analysis pls?

> > -- 
> > 2.43.0

