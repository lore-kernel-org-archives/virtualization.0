Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85E618BB86
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126705; cv=none; b=uiyybjdC9mA9ODY45VijJ9y4VWkYl+tfGHw+Z1m8CRU8tdisIftSV5kb6hCwI0UNB0LLeHf8MEJMTCXMa0+MvXLO36k752mb+ZYs+a1/TYH/dObZ6z1PtLcaNRM3y3V3+RAJ5NtRHHqJqD8UbcugdBmFdAPXnUp2Tzq0g5sC8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126705; c=relaxed/simple;
	bh=z3/ZlPRYKpImydcKEv/wyodhIpd9NvgY2Js54fR2fdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LHiZW4uiCrqvmJdgKSBYfELt8tlbv7jsNdBRZBfcdVFOYRrTtfae2V1k0CVKzMMvUYkYvdcDPj6Q171IUFKb8nVz2fOOGTdFtA/89MgJxkNp7GnBlKLGTlEfS1y2G90OM2uKumMQ+A9kgoJo4pScdsNSnCYDDNZXtYdZxJcnSDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0CLhH6t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0CLhH6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726126702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4fBuBnCEidjmbeIEXnc/9CKuIY9TAKerLdXJtzxaNI=;
	b=R0CLhH6taolhpGbkRfID/bccTQp6GIiDm+XooqleocA3hxi4n9VxkkLVBmNHJvB1J8kA+L
	atKaVC5obeJupi+PEFp52CmN6WEwM/igePTlGIXfR6ba9e14XWnpP+VpxMbP+Nmq0lzvPd
	eX0CxPV4tbkBDs5y3Ym3FkALhEZHhjE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-HZ80Ll3POzK98BAgUH6Mfw-1; Thu, 12 Sep 2024 03:38:19 -0400
X-MC-Unique: HZ80Ll3POzK98BAgUH6Mfw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so5288725e9.0
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 00:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726126698; x=1726731498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4fBuBnCEidjmbeIEXnc/9CKuIY9TAKerLdXJtzxaNI=;
        b=PLXCxKw6EsJ0sw96TrVZFqMZZxlESirYS2ZWONt4OsE3nTMtAOETCoCE0fVXQcyzyT
         OQJWEtUS4H40X74HNvyZllECNosRJ8fKIO8/BZA8RyF/lwGpBn9VeRd+Zaw4XokFlq8o
         rKnSM2Thi/t3LUnPP8qm85ks8r3rIcOWcvNQ/Q+Ij0hdkZCAfru7mmFDHyX3nJlaR860
         1mME5V8XXNQSBG1M1VxmyQgYHpqjfSPyrqG/bKCcz7phX36lg+sVvdZUVsYTwJOi7GPe
         wQhyOs3gyADeuZkkhmHYlmUKy8qrVwGVk+YkwyY6j7LdhIUp+jN9JPuCp89m3vnoJbKj
         fcug==
X-Forwarded-Encrypted: i=1; AJvYcCXO8veGeJLByE6bfTE4WX3DB4nMvsTHqL/4l3kW9IC1scsmTf2E798TP9ZxNpj9JCvaqWnta+uspQpRj04xIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7nnnLhpz3ezHL0wEkQVJGkno0E1rXJKps+TAHoqypTQBcS3sW
	hCaUxR7cjcD5aBnumsqyRsVDAxHxWfT+q/DvWUJIwdKBmZXxkZF1DO4x+TZXf75ZtttF+4uQRkZ
	cegGBn8rhAKo1TK8e4nTzp08bMteho9uo2jlgw56/lkF4gYw8ETwjh8P+lnTjLkUu
X-Received: by 2002:adf:fcd1:0:b0:374:bd01:707c with SMTP id ffacd0b85a97d-378c2d55876mr1413303f8f.48.1726126698250;
        Thu, 12 Sep 2024 00:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOO68ioJGvs/NwodO5lKd9xytWZxftBSaY9t/pTKbQ/jAAYNVMqH9/p8jEMuTR6sj3X/JFbg==
X-Received: by 2002:adf:fcd1:0:b0:374:bd01:707c with SMTP id ffacd0b85a97d-378c2d55876mr1413275f8f.48.1726126697433;
        Thu, 12 Sep 2024 00:38:17 -0700 (PDT)
Received: from redhat.com ([31.187.78.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956767dasm13740647f8f.62.2024.09.12.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:38:16 -0700 (PDT)
Date: Thu, 12 Sep 2024 03:38:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/13] virtio_ring: packed: harden dma unmap for
 indirect
Message-ID: <20240912030013-mutt-send-email-mst@kernel.org>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-4-xuanzhuo@linux.alibaba.com>
 <20240911072537-mutt-send-email-mst@kernel.org>
 <1726124138.2346847-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1726124138.2346847-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2024 at 02:55:38PM +0800, Xuan Zhuo wrote:
> On Wed, 11 Sep 2024 07:28:36 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > As gcc luckily noted:
> >
> > On Tue, Aug 20, 2024 at 03:33:20PM +0800, Xuan Zhuo wrote:
> > > @@ -1617,23 +1617,24 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> > >  	}
> > >
> > >  	if (vq->indirect) {
> > > +		struct vring_desc_extra *extra;
> > >  		u32 len;
> > >
> > >  		/* Free the indirect table, if any, now that it's unmapped. */
> > > -		desc = state->indir_desc;
> > > -		if (!desc)
> >
> > desc is no longer initialized here
> 
> 
> Will fix.
> 
> 
> >
> > > +		extra = state->indir;
> > > +		if (!extra)
> > >  			return;
> > >
> > >  		if (vring_need_unmap_buffer(vq)) {
> > >  			len = vq->packed.desc_extra[id].len;
> > >  			for (i = 0; i < len / sizeof(struct vring_packed_desc);
> > >  					i++)
> > > -				vring_unmap_desc_packed(vq, &desc[i]);
> > > +				vring_unmap_extra_packed(vq, &extra[i]);
> > >  		}
> > >  		kfree(desc);
> >
> >
> > but freed here
> >
> > > -		state->indir_desc = NULL;
> > > +		state->indir = NULL;
> > >  	} else if (ctx) {
> > > -		*ctx = state->indir_desc;
> > > +		*ctx = state->indir;
> > >  	}
> > >  }
> >
> >
> > It seems unlikely this was always 0 on all paths with even
> > a small amount of stress, so now I question how this was tested.
> > Besides, do not ignore compiler warnings, and do not tweak code
> > to just make compiler shut up - they are your friend.
> 
> I agree.
> 
> Normally I do this by make W=12, but we have too many message,
> so I missed this.
> 
> 	make W=12 drivers/net/virtio_net.o drivers/virtio/virtio_ring.o
> 
> If not W=12, then I did not get any warning message.
> How do you get the message quickly?
> 
> Thanks.


If you stress test this for a long enough time, and with
debug enabled, you will see a crash.


> >
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> >

