Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757AE1AB50E
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880520; cv=none; b=jlffuMhmr1XT3bsQ4K3Phv8d5zUH+EwBHQzHA1OMezJNu+uWVIEb4W4jeK2dbAGDqJ6OxGjh8WKoOC/Wd5DcxgJl3XXmKsBDXTgXmlRjPSqyZdUQtd9cJ9HVX7n/Gyk72MKPQdCXJRgRhKxU4uw4Au+jgyBpeeZr6+rMkgKn0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880520; c=relaxed/simple;
	bh=Esbbz8DxthG1H39auhHjtQPDB7fwYFEeOZT0QKAbq+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CvpTinF7pMS3T3iwTFkOfqdAJ14Cg8wpoR68xarhZarLOZHgiLK4cQSGnOzV9og/FnSrsD6lb1AXJXyCr244c+cO/rYcAyPAQzDUNz35VbNu+aImuDoHNsaB0OUZxiTOXRlvrFuYYxBkdhaziiZgOxOkq8Dz7IJrFl2bcckVYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGOBBkTo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGOBBkTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718880518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gvLoEiL6M3Ecn2PWS+83Cift4+fMJo1jASRKaS5VqNk=;
	b=GGOBBkToMMuoSSKPSzfSYOTX/zKmTVPzCOhq+7GWQHyAoMFRmMlegKoj9wJ+sCouI5++bv
	w/wSBUcr3dRyG2v3wUNn8oIMXaipav8dlhf7HZTq4zkzVVqvELlJ8kBKAGX8zmUhbsyKPO
	J57lmBIUKeqX6v/m5bwfhcfu1omoanA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-f5TFkCIpN7uRF3MFqSqGpA-1; Thu, 20 Jun 2024 06:48:34 -0400
X-MC-Unique: f5TFkCIpN7uRF3MFqSqGpA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6f381ea95dso83245166b.0
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 03:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880513; x=1719485313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvLoEiL6M3Ecn2PWS+83Cift4+fMJo1jASRKaS5VqNk=;
        b=ZHZZHP4WdPaaYC1/Td1QqNP+jbxEXuPBaELhnlEPzBvzrx5QWvTiShI1iwxB+QwoSm
         jS+trM3P1Rl1Ab3iPdqNLvapWDkv70u75uHf4p2JxOlg5Y887mu6F34V9Ft5yqoHD/Zn
         PJSioKu6VLNMfdC+oC9SaHE9Cgx+f04QnTyDspRpJp4Chx3q1Qd3S4ZvI+zCFI3960mO
         KOCuOjBYjW1ABokM5ZmxdaK4RuobDEuQzQURfuJMfapvuPQ1qS8B9FPVXQY/0stkXpfZ
         25YgL1u6Ks6DzJ6YMD6ZIx5w+5VCbVzJn35Kt5K9511PCLn70XjM4aEv1z48Fnzb6yiB
         dVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUM/ki7/rtPkjfpre7RgwGqUXpS2a5PXQXtPPOmlCzrURiSRiQejF2cpczxP+cKVQHd6jYg8TEDJWw9V1BqBwIrzzo3moE/My0uRDIE2PY=
X-Gm-Message-State: AOJu0Yx3rMLHzB/SNwrSfmiQsMwRQ8G9v8myD9FAGvy96fqfvnzJMPpu
	q6lIHwQZE2hM5IzG8jLiSUx50VG144Q19MDVkIRIviddO7Zv03FzaKT95T1VjG/EXfkMMTxRmFr
	kGjYqwMwvrcxj0HYG/O66NvUqAn+iLt7pXaSe9T8ZstwGXq0uWEJYIn/c2X/Lj0iM
X-Received: by 2002:a17:906:b093:b0:a6f:96c9:8413 with SMTP id a640c23a62f3a-a6f96c9844bmr486206466b.1.1718880512822;
        Thu, 20 Jun 2024 03:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxm5CK1H/t+3GpM5+8lsyLlBVkMoa7cdCIk3pXWs0yqp1VCYZUDSArK0iA4te8i1gL0nB8xw==
X-Received: by 2002:a17:906:b093:b0:a6f:96c9:8413 with SMTP id a640c23a62f3a-a6f96c9844bmr486203666b.1.1718880512262;
        Thu, 20 Jun 2024 03:48:32 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f43220sm749966966b.185.2024.06.20.03.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:48:31 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:48:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 10/10] virtio_net: xsk: rx: free the unused
 xsk buffer
Message-ID: <20240620064818-mutt-send-email-mst@kernel.org>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
 <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
 <38db3facdfefbefecd367ccce2e9b094d0b0314d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <38db3facdfefbefecd367ccce2e9b094d0b0314d.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 12:46:24PM +0200, Paolo Abeni wrote:
> On Tue, 2024-06-18 at 15:56 +0800, Xuan Zhuo wrote:
> > Release the xsk buffer, when the queue is releasing or the queue is
> > resizing.
> > 
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index cfa106aa8039..33695b86bd99 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -967,6 +967,11 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> >  
> >  	rq = &vi->rq[i];
> >  
> > +	if (rq->xsk.pool) {
> > +		xsk_buff_free((struct xdp_buff *)buf);
> > +		return;
> > +	}
> > +
> >  	if (!vi->big_packets || vi->mergeable_rx_bufs)
> >  		virtnet_rq_unmap(rq, buf, 0);
> 
> 
> I'm under the impression this should be squashed in a previous patch,
> likely "virtio_net: xsk: bind/unbind xsk for rx"
> 
> Thanks,
> 
> Paolo


agreed, looks weird.

