Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5BD154BE4
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054128; cv=none; b=uNAK3WOhAulN0nrC2mz7ezt8tn53fzv9FZ6hN1EpJTLz2/pvRtGeRukkHKP1yClzlpPA7c/JG1LQHhCzd72SrP0H2kmKHvfusOTGxFJh0ttSQR55ioVvDvgPl02YO+Jti/xUr7vcKoOeSpS1+/cD0QmrzXrH2Xuu5ovlBlwlNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054128; c=relaxed/simple;
	bh=4qh5VK526gLJCKyAtpJ7CQCiCpZ0f2OJAqyu4PMcOqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vBEURdwlX57DGB8gGFjUwLy6w48utt0pGC/p+aqC4yBkrZc+P7dPcsouvm5ogBQJja5+5QB6XIwmvp5DU0QJgFbnxlOFK5ah6m6xu+gcNEpqAi9BT52s8z4C+UGxYAzc4MfhD+5LbJuuQzExGeHwRKSOXMerBLfJaFzXnk6HxLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7VtAthN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7VtAthN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726054124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BAmyKuMNqITkrSfy8qg6MUrMSNseX/neKbDPXn2drV8=;
	b=V7VtAthN2A8O8xNfvsAEfNryZ055gRwbYY0WCydaT3GVNLfvLFtO0AaSKR++YGbb6n1YGl
	twZ6DDeXzdtTp3N9VN3fnxHq9I9pit3zJq/fNTDpw2v0ORTYzWnkzmzo2KUJcRw0Ty9hhM
	4Y3RUT9E+96/iLNkMw7to/CcVF1PU6o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-aR0i4dZuOGWRyOnRM3Y-Iw-1; Wed, 11 Sep 2024 07:28:43 -0400
X-MC-Unique: aR0i4dZuOGWRyOnRM3Y-Iw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f74de42724so52917491fa.2
        for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 04:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726054121; x=1726658921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAmyKuMNqITkrSfy8qg6MUrMSNseX/neKbDPXn2drV8=;
        b=qCQWdHt3ZF1XpPwS+q5UWRklHnZBiFbqU6bz2zIq5Y0q0yz4Br3xWOoOlnXos5kce8
         AoiiF4z8bU/+w6kZ6iWb7q/RKajQ/gfm9A1GWqYeTntPqMcgFMR1rZ7yuCeji0awz+oz
         SvFeJ/RmEoGYCvhoRdkQAXAXzTA1Df5e3JX17vtiZ1VWbbqbNZjBOjEIRSpVLOYoRUZM
         bNjJDSnrNYzA9KpUpJivqVVUJpAKJpusl+pRen6ChBfJIj8L7OV2MpFQBXCX9jno8cD1
         8sP8N6hiohhZn/WLeDugpL+f/wcxf17KxHNvUsvgDYJW8gt0GlQDxTMvFgRoMGcReUH/
         YM/w==
X-Forwarded-Encrypted: i=1; AJvYcCVaaXrLd05g6o/TVQtvzpzsZ+qE2ZbeeYI5AJulMXoZthu4BmwQv13P/Ermw3MJA/6/xdvJdV/HkVIjq7P9tg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywn7o87FZ1+t4E2FlUPYz5BIqcLKF3eRLZIEFXIeogf1MautXwe
	4pcklOjOo//eQX8WK7yV1IRiGYt0S2cBBpdAWieESA9X3CajXhPu6/MIhKzRMktU8OgaVoLsh8X
	zYDNjH5bUsEDTTZmQS9+dLo5geBD/cJTZ8EUtE3b3gvXfuO9W52RlWbmahMy9Faig
X-Received: by 2002:a2e:b8c5:0:b0:2f7:603c:ef99 with SMTP id 38308e7fff4ca-2f7603cf586mr90362051fa.16.1726054121563;
        Wed, 11 Sep 2024 04:28:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIKTns3rMOAydZQgVabYfA2U4q50Qe0gkibAVCl1FWXltjSMrzgK/bbPrPG4mSYk55jQJFUg==
X-Received: by 2002:a2e:b8c5:0:b0:2f7:603c:ef99 with SMTP id 38308e7fff4ca-2f7603cf586mr90361621fa.16.1726054120483;
        Wed, 11 Sep 2024 04:28:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8c4c6sm5307012a12.86.2024.09.11.04.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 04:28:39 -0700 (PDT)
Date: Wed, 11 Sep 2024 07:28:36 -0400
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
Message-ID: <20240911072537-mutt-send-email-mst@kernel.org>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240820073330.9161-4-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As gcc luckily noted:

On Tue, Aug 20, 2024 at 03:33:20PM +0800, Xuan Zhuo wrote:
> @@ -1617,23 +1617,24 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	}
>  
>  	if (vq->indirect) {
> +		struct vring_desc_extra *extra;
>  		u32 len;
>  
>  		/* Free the indirect table, if any, now that it's unmapped. */
> -		desc = state->indir_desc;
> -		if (!desc)

desc is no longer initialized here

> +		extra = state->indir;
> +		if (!extra)
>  			return;
>  
>  		if (vring_need_unmap_buffer(vq)) {
>  			len = vq->packed.desc_extra[id].len;
>  			for (i = 0; i < len / sizeof(struct vring_packed_desc);
>  					i++)
> -				vring_unmap_desc_packed(vq, &desc[i]);
> +				vring_unmap_extra_packed(vq, &extra[i]);
>  		}
>  		kfree(desc);


but freed here

> -		state->indir_desc = NULL;
> +		state->indir = NULL;
>  	} else if (ctx) {
> -		*ctx = state->indir_desc;
> +		*ctx = state->indir;
>  	}
>  }


It seems unlikely this was always 0 on all paths with even
a small amount of stress, so now I question how this was tested.
Besides, do not ignore compiler warnings, and do not tweak code
to just make compiler shut up - they are your friend.

>  
> -- 
> 2.32.0.3.g01195cf9f

