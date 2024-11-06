Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C61CF2A6
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878959; cv=none; b=r0aXgxYK0nj3ALvUsCvPGxMDaq0hUvhsWF89ux+OYE4tF098D6Yfv0CehpQWRmRA88bPyZQ4u9ue7N7+n6a4LgYM2omy+dtF/JsECZ4zy1enZkXCdQfiaL1k96NCdH61ZIbwJeoyTge8GfOdINWwB8qCHAV18tz7g57mUz1MNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878959; c=relaxed/simple;
	bh=87naFhcpflzvVNi4oKK41OMWqAcB7NuYDDSruv3y9lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p7r9S+j+3lSlUqgM/QR36GBzN1jjMw4cBCXC5tOBwolTPFEhJJWWFOiWPmGYHEmTh8w8J84GNjQS6uIdvKltuk1zs8K5CiNNWtpcFo6oIiee7YTtnzy+6MGhQbG5sRdjvu7c0srC0zAjN07dHMxRkaCyTecgJTd0Ke0mZBelquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+hJUMs0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+hJUMs0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWR9zcSGFhCX887b0B/GPsWncKD7+3L6Qhwgrepk+0M=;
	b=Y+hJUMs0/xVR377H1SWJapVAkNDqjYRutHl8a37QvpW+rKpB56Ca5VacJDOLIoeUF8kQ+4
	xJ+M8il/9Bm1bdgCUS7PIJPsBpDUjxyVJVdN3EzYmy3xFHfoqygVvLO5opEM3Ehx/Fhfhc
	8TdNc9QNerIH2U2BelTbGk/3cIp97xM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-AwicFkAEN-yBwUGAKZjOhw-1; Wed, 06 Nov 2024 02:42:36 -0500
X-MC-Unique: AwicFkAEN-yBwUGAKZjOhw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d45de8bbfso4397496f8f.3
        for <virtualization@lists.linux.dev>; Tue, 05 Nov 2024 23:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878955; x=1731483755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWR9zcSGFhCX887b0B/GPsWncKD7+3L6Qhwgrepk+0M=;
        b=NLKZOcM/DxMCLRnAGzfNZ2AaJVTT7ZqorpGDuO25LyTzpCp8YSrYlcDxRKVeRjmEvU
         PerBZPQCJUGnDlYLJyHTYQ1RZ0ghDW3Xhg2FDSXxY7zbBXD9/Cp0UXeSqd7MT8WB7z7z
         nrddWDhQRxQHa8bBPPBydyWDxJQ81FjQRMwkK0HU5Jv/zh6HmeU3pZsPL+foHeL3zImL
         C/6sKzyMT1uSCVFyBodzYUHRPJ+YRo7BZbUXM2FrjcV28ggwMZaZ/9BB9zHGnszFL0F2
         5hr59mJ0Dvc1BfS9KQqM6ASz5Qi1m5PSORswCiOaDKgN4NgPU5GhdgGUhcfNy/JHRvYj
         o7rw==
X-Forwarded-Encrypted: i=1; AJvYcCWvUB2aIKjoAJzduLvZLdQo9vQ+XgAgDDWTLn7xKVaaC3kBxkB+iD+ACtlPVody+RJBPY89S4PdJ8uBU2QYLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkZJJ04wi3HljiwmU6ClLu75Z/TGVfD/0M3w3MUOvRtBSz2bh7
	RCz0lpBXXh4ZGuB0gBE2XPx04W7QllqrKgu/yACIS9SLYM0b6n3TD157bk8C13SLO+p94sjdVO7
	a9jd42aJbkzDjEA/LpM4psumknv5Rk03n+LkkbNi61mYLz+Q4gZzzPeaCS4090m47
X-Received: by 2002:a05:6000:1885:b0:37d:332e:d6ab with SMTP id ffacd0b85a97d-381c7ac4120mr17584462f8f.43.1730878954812;
        Tue, 05 Nov 2024 23:42:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgNtqpF0tJni5pYGtoHDDU6pOi20AGMmYrQIEMtMqT7zuCSRaMIZpdZQj9fUZ5DU6Gb1R3xw==
X-Received: by 2002:a05:6000:1885:b0:37d:332e:d6ab with SMTP id ffacd0b85a97d-381c7ac4120mr17584441f8f.43.1730878954464;
        Tue, 05 Nov 2024 23:42:34 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d49dfsm18389413f8f.46.2024.11.05.23.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:42:33 -0800 (PST)
Date: Wed, 6 Nov 2024 02:42:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/13] virtio_ring: split: record extras for
 indirect buffers
Message-ID: <20241106024153-mutt-send-email-mst@kernel.org>
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtP7tdxxLOtDArNCqO5b=A=a7X2NimK8be2aWuaKG6Xfw@mail.gmail.com>
 <1730789499.0809722-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 09:44:39AM +0800, Jason Wang wrote:
> > > >         while (vq->split.vring.desc[i].flags & nextflag) {
> > > > -               vring_unmap_one_split(vq, i);
> > > > +               vring_unmap_one_split(vq, &extra[i]);
> > >
> > > Not sure if I've asked this before. But this part seems to deserve an
> > > independent fix for -stable.
> >
> > What fix?
> 
> I meant for hardening we need to check the flags stored in the extra
> instead of the descriptor itself as it could be mangled by the device.
> 
> Thanks

Good point. Jason, want to cook up a patch?

-- 
MST

