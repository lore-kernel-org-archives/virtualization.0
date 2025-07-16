Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6F19D06B
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674433; cv=none; b=LxU2ieixssNm4RAg2+kTGf6BX6ePgk1VeB6sbCNkmMItyapihV1ucHvJXVopOKym9IGHPWtWiqUhIHSKSZfVb08vAWpWqnPmAhI17T+6Y6C0yl56P/SXJc2HWl6uaKairFSwJKWpBLMK7l3e8ceuuIhvBCtfh15s2zlr8AF7zvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674433; c=relaxed/simple;
	bh=mf9IQWWYiLknSXAG6CS/Y5YdJTtwlua67aPZ8nlgXf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KCqFgQGgM1rK7OAVZ+Yj8xgMLsCjXfRWSiZLpqCUae8r2kVZI0zvMedzIqs4tqRiClFSbXZeNJwq8I9jMAVw7/K0A4H3YxCL0daBGabSuXU+8Sj/tB83fWJySA8rQ/sBxqIk9O80ntfH8Fo+rLlGoocWpDL/TKbgiT9E6Hcgwqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBf+nJO0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBf+nJO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j5G2VIMRjlOLTIkjP0GAmg7JUXwksgxowVtwvUlwWs=;
	b=RBf+nJO0apxdmA+oHiV5uZpnI6YEPfCRJhMc2gR7DENLxRW7E8I6YI+T+UWFBLm4d1JbBa
	ITSBs0tIqvv2cElbQhBeedV99CZd2nxVFWx6eDqy9XDXE99Kx7PCW8PX0amtoOxeGkOSNW
	NT4FaGpGN9ATDqxL5iwyXocqx+56sAM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-nT_ePd-xMPeehL3Rc-T7GQ-1; Wed, 16 Jul 2025 10:00:29 -0400
X-MC-Unique: nT_ePd-xMPeehL3Rc-T7GQ-1
X-Mimecast-MFC-AGG-ID: nT_ePd-xMPeehL3Rc-T7GQ_1752674427
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso17441285e9.3
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 07:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674427; x=1753279227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5j5G2VIMRjlOLTIkjP0GAmg7JUXwksgxowVtwvUlwWs=;
        b=peDqhEjA8he7sosQgMx0+wIejeu6+hXKy4TgX9zGwIulSeSAt/FzhZ0rv3DP8jKFoA
         F8PuEjH2zFbxxVRTCUGz5Fp8Geum9gNfoez4Abel+jUZnLm/OwaZUk/tlq9O+TiA1Vlt
         pLWCEcJIP6dfj1X5aahELBj6MZX2/ZsXFTUFh2riZPQ7ax94gB7Vd0OkB0hJnABEMEuz
         PGOvNlSZl/YFno6aoT54zLPHT8zyIndLVHmo3j3IL3emu7MEbx/I6zK+RA/Vmybq6iRr
         ATrAu7ebNjY9Y9X7n3VcKLhsXMSyUHUkDuIJwXLbt69mUydkblS9yUBGrfk6Iwti7vuO
         E6cA==
X-Forwarded-Encrypted: i=1; AJvYcCULWKCvZ01dRst+FGr+L0HzO04LS8KgkeF6ivOjqB6L70+Irs3FDLNpMY0oy6exio2VmD+jE4Z0W2NKNOJoAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw03Xqfn9syETnmkSO8vGLEVPd+wX9H+fkvUxj6Uv7mnWhqM969
	l06On2bd8BGe2Hz5kKttflzIKhIvy3SKoAsE6yKT8Kd4jynP0EG3dN7Hso6WVgWg7RpvsoboVM0
	w1PyZ0Ue4wsEs8bnZ56AICfryVhA9V7ry0wO9QEBFUeDNuJaGIDon2Q76YYCFMyH2KsvS
X-Gm-Gg: ASbGnctOgXza0Qc+O8Hcig6XPM7k9N/s1Fq3jpE70J0613ufjPT2DxxFPhc3+lD12b0
	rNZ+JPRxA9CoIdZ/G4I85UPuXPDA3RhBijpFFkIGzDJgEjXny2HuvEsUgrY/6DmlKbYpBIVLqnl
	UUaoKqKCeILLSxkti7sfHJgyHaSoTtFleY9pMNjUxspSwwAZPqY7TxtGKPy7DSeRNofDSuDyYHV
	X8T3jn/wJUSs7lyOkPPBoCYtm9cgE5mbOn62jA3AQUFKn2p8jdh8j041d3ouQt9CwnisXjZXtgu
	e2/3vnB5Z/4LJBdy+grg661q5GeKmETy
X-Received: by 2002:a05:600c:c4a5:b0:456:e1f:4dc4 with SMTP id 5b1f17b1804b1-4562e390d79mr30319415e9.15.1752674426840;
        Wed, 16 Jul 2025 07:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8ThKDIOgNJf576TxSWHX/aHnNSPd5z55UpjJKfa775GEBVUvNHy2Nl9JKMWwdi7RBWKzSAg==
X-Received: by 2002:a05:600c:c4a5:b0:456:e1f:4dc4 with SMTP id 5b1f17b1804b1-4562e390d79mr30318665e9.15.1752674426188;
        Wed, 16 Jul 2025 07:00:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2bb4sm21654635e9.8.2025.07.16.07.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:00:25 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:00:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big
 packets
Message-ID: <20250716095928-mutt-send-email-mst@kernel.org>
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
 <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com>
 <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZANqn1uGsTn01XgAUsaTNHWLDftDhAyDIzeJaXyE9r0_1752674427
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jul 10, 2025 at 06:44:03PM +0800, Jason Wang wrote:
> On Thu, Jul 10, 2025 at 5:57 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 7/8/25 4:42 PM, Bui Quang Minh wrote:
> > > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > > for big packets"), the allocated size for big packets is not
> > > MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> > > number of allocated frags for big packets is stored in
> > > vi->big_packets_num_skbfrags. This commit fixes the received length
> > > check corresponding to that change. The current incorrect check can lead
> > > to NULL page pointer dereference in the below while loop when erroneous
> > > length is received.
> > >
> > > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
> > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Remove incorrect give_pages call
> > > ---
> > >  drivers/net/virtio_net.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 5d674eb9a0f2..3a7f435c95ae 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >  {
> > >       struct sk_buff *skb;
> > >       struct virtio_net_common_hdr *hdr;
> > > -     unsigned int copy, hdr_len, hdr_padded_len;
> > > +     unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
> > >       struct page *page_to_free = NULL;
> > >       int tailroom, shinfo_size;
> > >       char *p, *hdr_p, *buf;
> > > @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >        * tries to receive more than is possible. This is usually
> > >        * the case of a broken device.
> > >        */
> > > -     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > > +     BUG_ON(offset >= PAGE_SIZE);
> >
> > Minor nit (not intended to block this patch): since you are touching
> > this, you could consider replacing the BUG_ON() with a:
> >
> >  if (WARN_ON_ONCE()) <goto error path>.
> 
> I'm not sure I get this, but using BUG_ON() can help to prevent bugs
> from being explored.
> 
> Thanks


You mean exploited.

Paolo what's your thought here? Why do you want to work around this
one, specifically? I don't see how we can get offset >= PAGE_SIZE.


> >
> > /P
> >

