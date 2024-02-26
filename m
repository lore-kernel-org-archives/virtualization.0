Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA96027E
	for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949536; cv=none; b=uGKg6DFWGKCTbfltlvIHENcey83pX2CGS6TiEtCBMIbJrn+gZk8MRzL+oACtZtrLE1BLhCTkvAihCGMn6dJAP4pl0+hKg9EQbsKHLgkserh0VLDwDbl0CQehmeqtCQA2Fd42bEQDX9RfuNk2+nIZaFcqawO2Uh4h9AKTwshb59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949536; c=relaxed/simple;
	bh=e0N6/2zQUM1QOqkgabnyahS6/9h1qmMEkf5qlHoAwkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=U8lUgV/vXZSRMwtCT2Ti3FraNYKxRhq1L1eErsd6jVq9l+llKm8W4UqfjegTUhNpoEtaiVOGf4cs2XAv/P4qlLI/kINz62GhGuZotPBZz6SToXn8liNL7N+BG06F/JKySNS/H9hCmLVy3SSeq0j0Ivu8yjbrI7wDPkRJONyPW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8u1Hu/V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8u1Hu/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708949533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVX2aIqulG7pb2ZKAY6wEN/hr8j5RuJ02O3KYwJHnAk=;
	b=M8u1Hu/Vv/0vNE0i88WuFmuJtcQkSdxo0gFdDiwJL1VJdKPTUDl4GlufEU9pFgoZ3vSSpK
	Sc3LWL6crIPduD0Ei3QfqimXpTSYVcmJdm09z+OxhF+jdZ6ztu+c8FQyoKMMt/xCWmI9FT
	4gszghQ79VOV3VEwXcsT7rWVJlMevi8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-lM3btRWIPzSfQdbMwPLWzQ-1; Mon, 26 Feb 2024 07:12:10 -0500
X-MC-Unique: lM3btRWIPzSfQdbMwPLWzQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33dc175ff8fso1225330f8f.0
        for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 04:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708949529; x=1709554329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVX2aIqulG7pb2ZKAY6wEN/hr8j5RuJ02O3KYwJHnAk=;
        b=nAeI0UQYN7/B9d/BXwHaavOE/547LBjJmYovMnNJSwLLyR836W09VELeRg848KZtqB
         OY8Zslm5id3fEdR6WmzJSOUuOnPVn+xkxkdGIG+PoVyiaypJ2R4O3dUnikD5+cs7DBA6
         scUqFf7AoESRAuW2Nh1UuBt9HdZFOfswbTj0NLJ7e6kJ6z9GC9JKZn/BE+rNi6xgkwHQ
         aeeCBak6hdUg6I4DRDJXMQWXxgy5nKa9mgCTfQUNP31AC6IAErhtn2fJ3zAO3E6nU9bw
         oldHXoNNR7VcilOW4iSiCv/cxaYlvkFyFSgd3321gt/rudtrkO+eVLLBB2oy3gAIYs1m
         YMVg==
X-Gm-Message-State: AOJu0Yzsizo2Iv9vHHNTmjQazphQOfyA7MAXIoH8a+rcyBbV86gjBT41
	kjsyV9JcuaRxRbDYEvSCL0Qz2uuGaguNUIprAm4OwjYJRrLj3DcC1/Edfl4w85k8KgrqHCGMBtU
	fG+2jYBKWr2ZLerCSGp4oNHO6DMEZT8op9Zm8PUmZByY8hkzxVL+Azo8IPQz3VgS7
X-Received: by 2002:a05:6000:1961:b0:33d:7ea3:5b90 with SMTP id da1-20020a056000196100b0033d7ea35b90mr5099362wrb.65.1708949529663;
        Mon, 26 Feb 2024 04:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf07k3zYsXuRGP5oY8KvF8nVh4PymH1C6S7+HQTQO4YjooNJ90xav4OKE27dfDSxc5oKl0bw==
X-Received: by 2002:a05:6000:1961:b0:33d:7ea3:5b90 with SMTP id da1-20020a056000196100b0033d7ea35b90mr5099329wrb.65.1708949529347;
        Mon, 26 Feb 2024 04:12:09 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id t20-20020adfa2d4000000b0033de1e1bddcsm1414633wra.26.2024.02.26.04.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:12:08 -0800 (PST)
Date: Mon, 26 Feb 2024 07:12:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Message-ID: <20240226071010-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708946440.799724-1-xuanzhuo@linux.alibaba.com>
 <20240226063120-mutt-send-email-mst@kernel.org>
 <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
 <20240226063532-mutt-send-email-mst@kernel.org>
 <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>
 <20240226065709-mutt-send-email-mst@kernel.org>
 <1708949183.5224328-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1708949183.5224328-4-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 26, 2024 at 08:06:23PM +0800, Xuan Zhuo wrote:
> On Mon, 26 Feb 2024 06:57:17 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Feb 26, 2024 at 07:39:09PM +0800, Xuan Zhuo wrote:
> > > On Mon, 26 Feb 2024 06:36:53 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > > > > > what is dma_map_direct? can't find it in the tree.
> > > > >
> > > > > YES.
> > > > >
> > > > >
> > > > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > > > index 58db8fd70471..5a8f7a927aa1 100644
> > > > > --- a/kernel/dma/mapping.c
> > > > > +++ b/kernel/dma/mapping.c
> > > > > @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
> > > > >         return dma_go_direct(dev, *dev->dma_mask, ops);
> > > > >  }
> > > > >
> > > > > +bool dma_is_direct(struct device *dev)
> > > > > +{
> > > > > +       if (!dma_map_direct(dev, ops))
> > > > > +               return false;
> > > > > +
> > > > > +       if (is_swiotlb_force_bounce(dev))
> > > > > +               return false;
> > > > > +
> > > > > +       return true;
> > > > > +}
> > > > > +EXPORT_SYMBOL(dma_unmap_page_attrs);
> > > > > +
> > > > >
> > > > > Thanks.
> > > >
> > > >
> > > > where is it? linux-next?
> > >
> > >
> > > I see it in the vhost branch kernel/dma/mapping.c.
> > >
> > > Maybe you miss it.
> > >
> > > Thanks.
> > >
> >
> > which hash?
> 
> fd0b29af02bb75acc94eb08c06e2c10cbce2ea67


Thanks. Now I see it donnu what was wrong with me.


> >
> > > >
> > > > --
> > > > MST
> > > >
> >

