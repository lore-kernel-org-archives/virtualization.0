Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E871F542F
	for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482142; cv=none; b=mLVQ7kIjdALzc5F3JTfLgFCnVPP5hTtC8GBSLCFlZPuiE3uhC9G17qCNTov/BFuwI7fYW7XJ7TAdcjbnGgolzBfeTnbWv09Fvys3BmrN8IJsH0YBd7CBWY7H/QxHPZJC/35KxHbFNKelX2EuitWpN4Lfl3XnFpDGGo+LmA/y6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482142; c=relaxed/simple;
	bh=8MGMALB53GqE7pr90y8ipkSuziOt45gftdneWPyARRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU6P4KLLRpt48WLbn/v3k941PGqXtWu42Wd3piQ35e48BQDSof1ykfcEwc6gPP+qevbdw2swIOHz5IRjOylDXUQqM8Y1Z90+Kk+uMlaEc8IDnhbbjUwSDtB8yZdLbI9zqWw7ycmQKgXZtRZl0OnpAXJ0M4afzVrogy9gPu7BR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=urVY6hRJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="urVY6hRJ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216634dd574so69939995ad.2
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737482140; x=1738086940; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMp+ss6Wwfurnp42doFXEAGvsTfQgZrzB8Da9TV6zaI=;
        b=urVY6hRJ0S2kdyV2oGDQecyUj9AOHsOAE4itxYMRy0AMeM8qpc1H7A1YbNLDNao2Z2
         ZIiXeEi42SMPrgcYrWqIsSEEkE30rl5lOStXNGEoJfhFMRIrqaCUQZFv/XfQk9TAAWzl
         vHG3ra0xFTKWMlWAhKkQ1FGrlAp6H/nnYII4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482140; x=1738086940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMp+ss6Wwfurnp42doFXEAGvsTfQgZrzB8Da9TV6zaI=;
        b=YcaL7BTXyOUA8hUOVKRWsr5rUw5DysVvxXSMLjWpt6RNXfDQwPp+VQJmYqBZUtILYm
         b4831ibpKQAtb7MdXNB78bEJFcN3dC9D9qXXND3gsGXssmJgzCVE24jIDqbP/LGBODD4
         p4+eY2zMupXLc1M6zmSTADCwXP/+7J16u3Wv9AbAzQs9rvqlogH+ffE/xEGHNj/8Vkng
         kudX3KtSqPEHklQ3Enn5oUaJ2YVy7teK4bdLHpPSOjYcjhl6XkoKSgfQAyrct5klXgMC
         kBvmKfV2RwtQVEbdtyKH8PXKBYB7ev947yz/LHlKX19ysojjfT1oh0R52sZN0v404z1i
         Qdwg==
X-Forwarded-Encrypted: i=1; AJvYcCX7BXenecdjv/ADf4d7JEb6q3qpvpvjQDekjhn+LRimbgzXnha/7/gJCsxAmRatDWU+LdHDef0AWBzexeCTkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzY6u0IDUiqalBbOspGBwPrdOi24xkoKuXzB9mYyqzcYooM0FWX
	sYeRS9iIgbJxjFC8Rm3IVASIRZdNXfZKmur0xoqujhY0aY3uBBJGCQycsQXEWO8=
X-Gm-Gg: ASbGnctzr+Q8+HRj4frIrqypMZg6/+dqGi8kG25u+RfgM1+o2Teo21aE8E+xdl+RbN0
	+FC+B3RDgYEtfv6pnfzhlUTjVJJWUZVcNT9m2R1XtIbVAoB5uIZotxwAZCZeTagfHiBXhDcNq7J
	B72m3GYhock8moS35Zh1THThIHpKEUbCSvY4NMLJ058o/WfdzrMSlIHhBbqFnT5feTmQXM7EwHq
	L+R6oUasb/tdJTJASep8LK/VNs5869Ix7LTmGfaBuSkbdJ0ouIccwIyc4n8xExwbiUaCtqNrU5a
	iIDZ5n7k8i/+UJs8afTFe7U3NRQAyoaIrmHa
X-Google-Smtp-Source: AGHT+IEBgJwx8lqhufWVr68uCZoTqch8S1RN/wzFz2PZOPH5Pq/W0Y7Zk8vLb/9NhhAf19hQTQLs0A==
X-Received: by 2002:a05:6a21:4a4b:b0:1e0:c3bf:7909 with SMTP id adf61e73a8af0-1eb215ec91amr27186626637.41.1737482140313;
        Tue, 21 Jan 2025 09:55:40 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f0693sm9466532b3a.10.2025.01.21.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 09:55:39 -0800 (PST)
Date: Tue, 21 Jan 2025 09:55:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, gerhard@engleder-embedded.com,
	leiyang@redhat.com, mkarsten@uwaterloo.ca,
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
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Message-ID: <Z4_fmIsLgs3nWvOm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
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
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	netdev@vger.kernel.org
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtaaScVM8iuHP7oGBhwCAvcjQstmNoedc5UTtkEMLRDow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtaaScVM8iuHP7oGBhwCAvcjQstmNoedc5UTtkEMLRDow@mail.gmail.com>

On Mon, Jan 20, 2025 at 09:58:13AM +0800, Jason Wang wrote:
> On Thu, Jan 16, 2025 at 3:57 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote:
> > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > can be accessed by user apps.
> > >
> > > $ ethtool -i ens4 | grep driver
> > > driver: virtio_net
> > >
> > > $ sudo ethtool -L ens4 combined 4
> > >
> > > $ ./tools/net/ynl/pyynl/cli.py \
> > >        --spec Documentation/netlink/specs/netdev.yaml \
> > >        --dump queue-get --json='{"ifindex": 2}'
> > > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> > >  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> > >  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> > >  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> > >  {'id': 0, 'ifindex': 2, 'type': 'tx'},
> > >  {'id': 1, 'ifindex': 2, 'type': 'tx'},
> > >  {'id': 2, 'ifindex': 2, 'type': 'tx'},
> > >  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> > >
> > > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > > the lack of 'napi-id' in the above output is expected.
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  v2:
> > >    - Eliminate RTNL code paths using the API Jakub introduced in patch 1
> > >      of this v2.
> > >    - Added virtnet_napi_disable to reduce code duplication as
> > >      suggested by Jason Wang.
> > >
> > >  drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
> > >  1 file changed, 29 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index cff18c66b54a..c6fda756dd07 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> > >       local_bh_enable();
> > >  }
> > >
> > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > +static void virtnet_napi_enable(struct virtqueue *vq,
> > > +                             struct napi_struct *napi)
> > >  {
> > > +     struct virtnet_info *vi = vq->vdev->priv;
> > > +     int q = vq2rxq(vq);
> > > +     u16 curr_qs;
> > > +
> > >       virtnet_napi_do_enable(vq, napi);
> > > +
> > > +     curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > > +     if (!vi->xdp_enabled || q < curr_qs)
> > > +             netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
> >
> > So what case the check of xdp_enabled is for?
> 
> +1 and I think the XDP related checks should be done by the caller not here.

Based on the reply further down in the thread, it seems that these
queues should be mapped regardless of whether an XDP program is
attached or not, IIUC.

Feel free to reply there, if you disagree/have comments.

> >
> > And I think we should merge this to last commit.
> >
> > Thanks.
> >
> 
> Thanks

FWIW, I don't plan to merge the commits, due to the reason mentioned
further down in the thread.

Thanks.
