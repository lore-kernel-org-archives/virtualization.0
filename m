Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6E1F76BE
	for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482239; cv=none; b=t9Tzwm7BQ1sMprI7A8ZVuPpfw8BYqvfwuZy9AbHbOEOyYENhqiB65Nu5MLdtZBAtAfqhdSdZAP8UhrBytUSuqDTIQg8ZwHpgnkaljDLAAR3SCC6wvOz4/dTLZwesypNcQDTsBXujNkTbcvWXJsOtYZbrEqfSxGHnlYFVPqCyePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482239; c=relaxed/simple;
	bh=XSfquQqmKI2Gaj0dXpHAa/dbcT2l9u6zX+xrg1/pkZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9hsxBPj29JTFBmw8s+ajrNkkpqh63hCwotwijbKVnLn0oMuljruSFGq963fRvN0/MKfaS5P8KntFkp6TwH1rb6PYkkbljUTED01/8hr+d1q5TlK0j1mhheRPy5NxHQTbV0OV18eUyM5KwmNU/2gCXOaXeAjDyDcTDpDH6gHPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dTQEdWn4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dTQEdWn4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb94cceso75112605ad.2
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 09:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737482237; x=1738087037; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loeQ6r/We5SeCLLC6MzCpKw48tXiOliWFpYbk3PaSbk=;
        b=dTQEdWn4tK60uIabX0viN2hLv6FlAXxo0h2Huqp9aPZE7qgFJ43skO8erOzd1PxtPj
         Vlpx25DMlADiKdFWaBTMONrpKMJiV0D3O0ZxHnUky/VP1+EDn8404Qi2eO6ltZWbG/+Q
         W/MNpkR9S7UotkTL4m6Dlq051PPi2qfqun5pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482237; x=1738087037;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loeQ6r/We5SeCLLC6MzCpKw48tXiOliWFpYbk3PaSbk=;
        b=k14e5EzSfwbcJtDjzzCx/Csvn2oOoWTCdA0iqY6fCwVbXbT5CA5smq8OZhFc06jrqZ
         NdEKRxUcH0ahCtbIa7rdzduzNpfn6zNn1wbdgjY0ZU1lunTeVVEpWa3R3QbiFPfFkIUy
         +ilu0iN63FtVd6N5kun0HWrIxgOBrOjQIhIgEU1N0ppLTp9w/IR2iOMn4M1Seo1Wambm
         wOORntExp1jotwnuKDMO+rBSF7psviW1+TAL6QtKXy18V60Sj4uSwBb9h6rhJSbLWYUL
         fsBBRFGTxD+FGFz/Hk9I0+6zPU2LXykoA0/FlaDQjCKGayWtdb2kE6mcQ7ELp/Er1Qf0
         GI/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPkksu3nXdkrsIg1Na0X5cqXbKhDc+NdoecZyQ5lsGSre2owKOjEnaYTfNrdpAZcpJI/VO3WqPDGPdpG1/Ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCApJJGiW7fhQG+Y5DC0TUmbM9q0Yh8dzHAimuBysjSux0omdw
	6QLgvbceQuEG01SNp6Fix9FBUyLpAqnt1iFragETLQEVDxeaP6DaXNro13I2ChE=
X-Gm-Gg: ASbGncuSEylsMMPGV3xkRUf98PwK0doVRN09JmRkjqB8FWGm/K+X7mU8QREj3nxrGbw
	EPXSditp6B+91v9IZQsQnBTG4DTbFAdD0MR6Ik7EZij+G4kwkEPaeofeRplRGnHhjwtB9ITNLlT
	Ks2dOJEEFoE0gO+YtvXS4KT5Vmy9eVhRHF9F6lu7F4P9Ejuo0zXwKaDwCjGC1MPj6gBf68agAUN
	8p/nFsiUQ9ytoSzqG9LG+oxb0fTgA6AFnbyRXJ7clhfP4lAaOClQogUTsI/poPz8dFrzrem/Kk2
	oCBUY9yT2TN7UnUlHvsv98i+/sPCMY14MCRF
X-Google-Smtp-Source: AGHT+IF8nTdSqJGUknuS2lb7RP37aOhCWFkCHgx+4XdAmYkt2v6vsufE7wyH2eVz6huRJPSOUWyXXA==
X-Received: by 2002:a05:6a00:a0c:b0:726:41e:b321 with SMTP id d2e1a72fcca58-72dafbdacadmr27151527b3a.21.1737482237014;
        Tue, 21 Jan 2025 09:57:17 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8e89sm9472195b3a.109.2025.01.21.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 09:57:16 -0800 (PST)
Date: Tue, 21 Jan 2025 09:57:12 -0800
From: Joe Damato <jdamato@fastly.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	jasowang@redhat.com, leiyang@redhat.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Message-ID: <Z4_f-PNEdmBaMkhP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	jasowang@redhat.com, leiyang@redhat.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
 <Z4kvQI8GmmEGrq1F@LQ3V64L9R2>
 <f8fe5618-af94-4f5b-8dbc-e8cae744aedf@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8fe5618-af94-4f5b-8dbc-e8cae744aedf@engleder-embedded.com>

On Thu, Jan 16, 2025 at 09:28:07PM +0100, Gerhard Engleder wrote:
> On 16.01.25 17:09, Joe Damato wrote:
> > On Thu, Jan 16, 2025 at 03:53:14PM +0800, Xuan Zhuo wrote:
> > > On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote:
> > > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > > can be accessed by user apps.
> > > > 
> > > > $ ethtool -i ens4 | grep driver
> > > > driver: virtio_net
> > > > 
> > > > $ sudo ethtool -L ens4 combined 4
> > > > 
> > > > $ ./tools/net/ynl/pyynl/cli.py \
> > > >         --spec Documentation/netlink/specs/netdev.yaml \
> > > >         --dump queue-get --json='{"ifindex": 2}'
> > > > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> > > >   {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> > > >   {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> > > >   {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> > > >   {'id': 0, 'ifindex': 2, 'type': 'tx'},
> > > >   {'id': 1, 'ifindex': 2, 'type': 'tx'},
> > > >   {'id': 2, 'ifindex': 2, 'type': 'tx'},
> > > >   {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> > > > 
> > > > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > > > the lack of 'napi-id' in the above output is expected.
> > > > 
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > ---
> > > >   v2:
> > > >     - Eliminate RTNL code paths using the API Jakub introduced in patch 1
> > > >       of this v2.
> > > >     - Added virtnet_napi_disable to reduce code duplication as
> > > >       suggested by Jason Wang.
> > > > 
> > > >   drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
> > > >   1 file changed, 29 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index cff18c66b54a..c6fda756dd07 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > >   	local_bh_enable();
> > > >   }
> > > > 
> > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > > +static void virtnet_napi_enable(struct virtqueue *vq,
> > > > +				struct napi_struct *napi)
> > > >   {
> > > > +	struct virtnet_info *vi = vq->vdev->priv;
> > > > +	int q = vq2rxq(vq);
> > > > +	u16 curr_qs;
> > > > +
> > > >   	virtnet_napi_do_enable(vq, napi);
> > > > +
> > > > +	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > > > +	if (!vi->xdp_enabled || q < curr_qs)
> > > > +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
> > > 
> > > So what case the check of xdp_enabled is for?
> > 
> > Based on a previous discussion [1], the NAPIs should not be linked
> > for in-kernel XDP, but they _should_ be linked for XSK.
> > 
> > I could certainly have misread the virtio_net code (please let me
> > know if I've gotten it wrong, I'm not an expert), but the three
> > cases I have in mind are:
> > 
> >    - vi->xdp_enabled = false, which happens when no XDP is being
> >      used, so the queue number will be < vi->curr_queue_pairs.
> > 
> >    - vi->xdp_enabled = false, which I believe is what happens in the
> >      XSK case. In this case, the NAPI is linked.
> > 
> >    - vi->xdp_enabled = true, which I believe only happens for
> >      in-kernel XDP - but not XSK - and in this case, the NAPI should
> >      NOT be linked.
> 
> My interpretation based on [1] is that an in-kernel XDP Tx queue is a
> queue that is only used if XDP is attached and is not visible to
> userspace. The in-kernel XDP Tx queue is used to not load stack Tx
> queues with XDP packets. IIRC fbnic has additional queues only for
> XDP Tx. So for stack RX queues I would always link napi, no matter if
> XDP is attached or not. I think most driver do not have in-kernel XDP
> Tx queues. But I'm also not an expert.

I think you are probably right, so I'll send an RFC (since net-next
is now closed) with a change as you've suggested after I test it.

In this case, it'll be simply removing the if statement altogether
and mapping the NAPIs to queues.
