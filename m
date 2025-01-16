Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB8422BADA
	for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043782; cv=none; b=qRdo1kkmBuTzUhJGmlP0oy11wRlO/14efHTJxdKeHkxMNHaIX+VHtjJIp9rAVM941rR03hUijhA8ct0nrm3G5gcTx4aYDIaecx14+3t6rVnRvDsws7wi87bCF9ALU6JWgBcNF+MI6IcTeeBnu4Vwb/nfXCiYhuKABim7s12erMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043782; c=relaxed/simple;
	bh=6r93PtDxADKddNEKMIl2n1KK6HOXUzLNWsnmppK99mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVNZUstGwQelTxTKRAxTLdJfv+TIRZRh5Xq2Kri/lOjCxNWKbha5GK+SiyRkzpvtuConKyvz/O3AKYtIy04mFSnAvxZUu6H/cjJ7aUTVcoYDhX8q4BSS5vfoWx5NYG7C0D0p9Bu9fvR8nsW+ZeeKCtn35cS6fE47ktbJqPLme/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=K82vB6k7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="K82vB6k7"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166f1e589cso26351325ad.3
        for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737043779; x=1737648579; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3SvrDu0caDhzdAVkyBr9gYgBKDDR95aZo/K9YBI7/c=;
        b=K82vB6k7y6Lph8W3NX/3PfRmuh5jCcN8t3ySN9tAXqXheUoDUAMt/bPDmh4wcOfbs/
         9sTpGKGHEzsi8LGJfXKTYKYl7p8DCqNHc4KtSqwHxVJDN8Mi0y2Rp7rsqibUASOY/Dli
         0GSYckTfYq29PVYY5GuUQEdTPqYOJfw83ekhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737043779; x=1737648579;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3SvrDu0caDhzdAVkyBr9gYgBKDDR95aZo/K9YBI7/c=;
        b=S4qE1KhGR9IQ4p0TN31CJfNUzcwRUDXTM04ux9oxPyM7OaiA14aSTxACT4eMtKuhyI
         5GGDoPEMoVy3OJCZDcJVwqU/tqruX8UMWltmRT4aSqGo4czrfrqt/nBfXyCjQVr32GWF
         dWaybCo+qTAwxoQebzbFYUiSTciO7SZYKbgeRtNs11lo/IvnfWfvkDPxYhZ9WBemNm3t
         p3+RQSgIc3YoJyLA28AMZI5q8GdtqerqpBsYxRQfgQCjdC7X8cYGIbe8ZKtnwx/XZoxH
         zXZCent9a5Ni6KTj/tV8UsMS66DJ1hzqXhKs5PZVI/zxkRIvlKyk8hVLGilUf0W8aXn3
         4Rdg==
X-Forwarded-Encrypted: i=1; AJvYcCWBS+XMCBjDo6psO9LXxRfCbCS4aLW3ldyazesk85cJLfSyUAzQeDw7BO2vjVwa8SsJ8mVoUcNsua1izsjNIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVTtUjGnQNyU3pHVLJwZnockksRgMDOOz0YDHhclOfodrxhj/Q
	MtA8pD/jN9C85SGB41CFCeVhG0LRRJ1ge9ZdmwaMv8j49FsM2rAcyS3/HYw7Y/c=
X-Gm-Gg: ASbGncuafvfTyX+zoziZ8yGnVxcLhet7hgl+TLlr0yjUOPaNDnZUIu8KLxZczy90MIA
	pc05SnIvvsr2MC7XvZtpr7WbF5G5QtUwLbznktn/v2d4wq0s0KxARCKAUFp4OUOfdTQlM36HEz7
	aL4bw5uoXwC1zm1LC7hOoGE24/djILpR6UHf7lhmIFt/ZA7cypiMpbyShY3SYMxPj0RK12UkGQF
	QjrUiivRju5qWW+XHolPKYIx9GYX8q3SQMksEQMdc9KM5eR4jWc94aA0nqIAXkihg4=
X-Google-Smtp-Source: AGHT+IFXQCdp082WWpGcpuSjSz2khkKE+kq+/Zwi6NgiDuGp4et1L72GBvo6pH6pxi/Ft6I0r1EIJg==
X-Received: by 2002:a17:902:c408:b0:21a:8839:4f4d with SMTP id d9443c01a7336-21a88395835mr395241215ad.6.1737043779271;
        Thu, 16 Jan 2025 08:09:39 -0800 (PST)
Received: from LQ3V64L9R2 ([65.133.87.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd02b954sm221289a12.52.2025.01.16.08.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:09:38 -0800 (PST)
Date: Thu, 16 Jan 2025 08:09:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: gerhard@engleder-embedded.com, jasowang@redhat.com, leiyang@redhat.com,
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
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Message-ID: <Z4kvQI8GmmEGrq1F@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
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
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>

On Thu, Jan 16, 2025 at 03:53:14PM +0800, Xuan Zhuo wrote:
> On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote:
> > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > can be accessed by user apps.
> >
> > $ ethtool -i ens4 | grep driver
> > driver: virtio_net
> >
> > $ sudo ethtool -L ens4 combined 4
> >
> > $ ./tools/net/ynl/pyynl/cli.py \
> >        --spec Documentation/netlink/specs/netdev.yaml \
> >        --dump queue-get --json='{"ifindex": 2}'
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 2, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> >
> > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > the lack of 'napi-id' in the above output is expected.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  v2:
> >    - Eliminate RTNL code paths using the API Jakub introduced in patch 1
> >      of this v2.
> >    - Added virtnet_napi_disable to reduce code duplication as
> >      suggested by Jason Wang.
> >
> >  drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index cff18c66b54a..c6fda756dd07 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> >  	local_bh_enable();
> >  }
> >
> > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > +static void virtnet_napi_enable(struct virtqueue *vq,
> > +				struct napi_struct *napi)
> >  {
> > +	struct virtnet_info *vi = vq->vdev->priv;
> > +	int q = vq2rxq(vq);
> > +	u16 curr_qs;
> > +
> >  	virtnet_napi_do_enable(vq, napi);
> > +
> > +	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > +	if (!vi->xdp_enabled || q < curr_qs)
> > +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
> 
> So what case the check of xdp_enabled is for?

Based on a previous discussion [1], the NAPIs should not be linked
for in-kernel XDP, but they _should_ be linked for XSK.

I could certainly have misread the virtio_net code (please let me
know if I've gotten it wrong, I'm not an expert), but the three
cases I have in mind are:

  - vi->xdp_enabled = false, which happens when no XDP is being
    used, so the queue number will be < vi->curr_queue_pairs.

  - vi->xdp_enabled = false, which I believe is what happens in the
    XSK case. In this case, the NAPI is linked.

  - vi->xdp_enabled = true, which I believe only happens for
    in-kernel XDP - but not XSK - and in this case, the NAPI should
    NOT be linked.

Thank you for your review and questions about this, I definitely
want to make sure I've gotten it right :)

> And I think we should merge this to last commit.

I kept them separate for two reasons:
  1. Easier to review :)
  2. If a bug were to appear, it'll be easier to bisect the code to
     determine if the bug is being caused either from linking the
     queues to NAPIs or from adding support for persistent NAPI
     config parameters.

Having the two features separated makes it easier to understand and
fix, as there have been minor bugs in other drivers with NAPI config
[2].

[1]: https://lore.kernel.org/netdev/20250113135609.13883897@kernel.org/
[2]: https://lore.kernel.org/lkml/38d019dd-b876-4fc1-ba7e-f1eb85ad7360@nvidia.com/
