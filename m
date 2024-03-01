Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BC26D1B5
	for <virtualization@lists.linux.dev>; Fri,  1 Mar 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293998; cv=none; b=mAoWvGYSqaglu6r2GofbVMJH/vDlD8ivbNK0pJs+MdtznQKr5Ip5HeNlH0raZrfWjLi3wKQ7adbmYdjsKBE5y1SROPkOvAopt/5N5cWtxca3csJQGClfr4pKdhKbVwSGmSqG44Het1OFCZP2iVjy6fDBX6OlNAKqkS68xIB6Elc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293998; c=relaxed/simple;
	bh=WpidZeAtZ+YgQaVLdxWuklMA1DRtSXB3dUMvzxcxpvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YvHmxTpI4mjG0iLbDsKQsNYVQcNxrmcYwe2Axs+Rx0t43HhmEelMvewlVbQTmlvb3Pohny0zuyTIRDF6U6G3Q0olCHrUk+QRucO78ky9HHBz6eKkAtlcUD7jcd9WeB8uv6kBME9d4mC4N8Y7P06HzcnOd9BDPUwGor9596gOGA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJJG7BUf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJJG7BUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709293995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXYuCfdTj1urbCJSi5THRKssGZntXNDUJ+IF7YDUqaY=;
	b=jJJG7BUfdf+wQWAShpl1UtLQTsDfd9iA3qjfCrdxQ8+PQnV96ss8aE83eIvjf/i6OukLif
	ifU/GSOYiCzzt2G3G/QH6M8cNQSniJqtlddiGTBXzPkUEXezvt29AiVcNOk+haKpgVJE5a
	8b3BNZqAaE2IYyHeeXso4i5B+oFl0Vg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-s03ALYa0NbqOnEndZmZl0w-1; Fri, 01 Mar 2024 06:53:11 -0500
X-MC-Unique: s03ALYa0NbqOnEndZmZl0w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-559391de41bso2169190a12.3
        for <virtualization@lists.linux.dev>; Fri, 01 Mar 2024 03:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709293991; x=1709898791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXYuCfdTj1urbCJSi5THRKssGZntXNDUJ+IF7YDUqaY=;
        b=HLuw+sPEQK17JBp6TpyBsA9XzCYOkGqp/esNTPQL2VdbhZfpKPpQHcuC+rppc3o/X4
         jsM7BmmWIao5mNaWU7zJLQPxXHlL96U/hpnVMTMVwt5+PFgNbT0fqQuvnUjwBONsSyv7
         osBQP1gSC47H4zfv6WVykk8atTqWcdcgX1RK11UAxTvzCfgYDPyapr61e7MEZsBRjTL6
         LjP0qeAdX0nmZqGA7pIIQPnG/vbfSKb22oipN+hORGMwQDBU+IXVcWt/e7EL5joiDvYU
         KobYnK/RCmUKoI4m7BmhmivoEhJEpaLl7Oqv3dYlQAIdeQlIRnePiEjZX2sKmh+2OpgI
         eLrQ==
X-Forwarded-Encrypted: i=1; AJvYcCULTCyar7zgxTbCb64DcMMmrrSRkd2N6eKCwEVqnR+AlkjnMyLZRg5c5OKpP+DDDt9cOJcx2x+StljlkDdavq6HHuALdmCDMbc0YWp+vBE=
X-Gm-Message-State: AOJu0Yw5iRpiVoGq+kNBi8LSv66v0JGqgUKTfGADu5grvA/KbQheOe4m
	e+j2uH3wuX0GuTaA8r2gnis0c0GFNAr/UwIXWY/EQdbH7kK24a6zrl3W+DCjLjt9gTVwu1zCbpr
	+rP8Mteylwi5vCND9CuJTcRd8MKgg5+APeJcWTgl8N5rWZMeTbIAGAyvj1a81a7WY
X-Received: by 2002:a50:a411:0:b0:566:47ee:b8b4 with SMTP id u17-20020a50a411000000b0056647eeb8b4mr1225111edb.17.1709293990835;
        Fri, 01 Mar 2024 03:53:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1vmpvGelrIAwSR9YtmqYMH53YWKi9ocFIRHHKWtTOAKDOP50IotWgGwt5cBRTSNWEE/hvcg==
X-Received: by 2002:a50:a411:0:b0:566:47ee:b8b4 with SMTP id u17-20020a50a411000000b0056647eeb8b4mr1225097edb.17.1709293990541;
        Fri, 01 Mar 2024 03:53:10 -0800 (PST)
Received: from redhat.com ([2.52.158.48])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402001200b00566d43ed4dasm439183edu.68.2024.03.01.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:53:09 -0800 (PST)
Date: Fri, 1 Mar 2024 06:53:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	xudingke <xudingke@huawei.com>, "liwei (DT)" <liwei395@huawei.com>
Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
Message-ID: <20240301065141-mutt-send-email-mst@kernel.org>
References: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
 <7d478cb842e28094f4d6102e593e3de25ab27dfe.camel@redhat.com>
 <223aeca6435342ec8a4d57c959c23303@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <223aeca6435342ec8a4d57c959c23303@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2024 at 11:45:52AM +0000, wangyunjian wrote:
> > -----Original Message-----
> > From: Paolo Abeni [mailto:pabeni@redhat.com]
> > Sent: Thursday, February 29, 2024 7:13 PM
> > To: wangyunjian <wangyunjian@huawei.com>; mst@redhat.com;
> > willemdebruijn.kernel@gmail.com; jasowang@redhat.com; kuba@kernel.org;
> > bjorn@kernel.org; magnus.karlsson@intel.com; maciej.fijalkowski@intel.com;
> > jonathan.lemon@gmail.com; davem@davemloft.net
> > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>; liwei (DT)
> > <liwei395@huawei.com>
> > Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
> > 
> > On Wed, 2024-02-28 at 19:05 +0800, Yunjian Wang wrote:
> > > @@ -2661,6 +2776,54 @@ static int tun_ptr_peek_len(void *ptr)
> > >  	}
> > >  }
> > >
> > > +static void tun_peek_xsk(struct tun_file *tfile) {
> > > +	struct xsk_buff_pool *pool;
> > > +	u32 i, batch, budget;
> > > +	void *frame;
> > > +
> > > +	if (!ptr_ring_empty(&tfile->tx_ring))
> > > +		return;
> > > +
> > > +	spin_lock(&tfile->pool_lock);
> > > +	pool = tfile->xsk_pool;
> > > +	if (!pool) {
> > > +		spin_unlock(&tfile->pool_lock);
> > > +		return;
> > > +	}
> > > +
> > > +	if (tfile->nb_descs) {
> > > +		xsk_tx_completed(pool, tfile->nb_descs);
> > > +		if (xsk_uses_need_wakeup(pool))
> > > +			xsk_set_tx_need_wakeup(pool);
> > > +	}
> > > +
> > > +	spin_lock(&tfile->tx_ring.producer_lock);
> > > +	budget = min_t(u32, tfile->tx_ring.size, TUN_XDP_BATCH);
> > > +
> > > +	batch = xsk_tx_peek_release_desc_batch(pool, budget);
> > > +	if (!batch) {
> > 
> > This branch looks like an unneeded "optimization". The generic loop below
> > should have the same effect with no measurable perf delta - and smaller code.
> > Just remove this.
> > 
> > > +		tfile->nb_descs = 0;
> > > +		spin_unlock(&tfile->tx_ring.producer_lock);
> > > +		spin_unlock(&tfile->pool_lock);
> > > +		return;
> > > +	}
> > > +
> > > +	tfile->nb_descs = batch;
> > > +	for (i = 0; i < batch; i++) {
> > > +		/* Encode the XDP DESC flag into lowest bit for consumer to differ
> > > +		 * XDP desc from XDP buffer and sk_buff.
> > > +		 */
> > > +		frame = tun_xdp_desc_to_ptr(&pool->tx_descs[i]);
> > > +		/* The budget must be less than or equal to tx_ring.size,
> > > +		 * so enqueuing will not fail.
> > > +		 */
> > > +		__ptr_ring_produce(&tfile->tx_ring, frame);
> > > +	}
> > > +	spin_unlock(&tfile->tx_ring.producer_lock);
> > > +	spin_unlock(&tfile->pool_lock);
> > 
> > More related to the general design: it looks wrong. What if
> > get_rx_bufs() will fail (ENOBUF) after successful peeking? With no more
> > incoming packets, later peek will return 0 and it looks like that the
> > half-processed packets will stay in the ring forever???
> > 
> > I think the 'ring produce' part should be moved into tun_do_read().
> 
> Currently, the vhost-net obtains a batch descriptors/sk_buffs from the
> ptr_ring and enqueue the batch descriptors/sk_buffs to the virtqueue'queue,
> and then consumes the descriptors/sk_buffs from the virtqueue'queue in
> sequence. As a result, TUN does not know whether the batch descriptors have
> been used up, and thus does not know when to return the batch descriptors.
> 
> So, I think it's reasonable that when vhost-net checks ptr_ring is empty,
> it calls peek_len to get new xsk's descs and return the descriptors.
> 
> Thanks

What you need to think about is that if you peek, another call
in parallel can get the same value at the same time.


> > 
> > Cheers,
> > 
> > Paolo
> 

