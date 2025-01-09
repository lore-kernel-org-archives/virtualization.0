Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D9214A81
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408471; cv=none; b=cEp3rRHxKdiaJnqmUTjbCV+KzFaP+lgIIIOlNxcTq6dsqsc/PiiMJCatUoTuXxeGnSeH2KlUY+eRtl6zOx2oLmLT4uy0QInE2dZ4giH9uqj0xtjQgu4X7kd0HWje63ff+c/0GX9GyMmcF8Xv6C2JhEVDJpBUlXKB7EdP2yoVHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408471; c=relaxed/simple;
	bh=Qk38VXpNNITAt7xRhep592aDF5AOkqXBIeZKZMfgj1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=knZurNwnHFsfFxmRb7FB8sag/nV/mttb0V2NQzPpq0BQfbihBp1Bi+1oqH/SVL8l/isy6tX9lBRwY1xeHVJ0hfeb3DxWuhwAtpawFYd0npyJb8WKHwiV6XD2FfmPyV3e7YPzWxtgOzB7otGmISd9bh9DfuE473eUl4ExLCpeM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fzq7nAtk; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fzq7nAtk"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 437B0405A1
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:41:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jT5N2mIHrcLK for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 07:41:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B864340025
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B864340025
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fzq7nAtk
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B864340025
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736408464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvMHmhw41jW2VMbkE+Q7qKoGQkCDW1O/R8raW3Ad35s=;
	b=Fzq7nAtk+yva78lKVdQSanr1CqlSzr8ZI4tnyrC3zqQ+f9Fqu0EvtauISutbTstufTx35c
	TjkWqTAF7C0FDQrOdK+cBNHDUMwGNVvOYqSwVV1KTFzqdzu+HGTdPR0AW1kOjErvlLq7dW
	Y9Gwx1zQwFZ4wfJU7ro9fT+pUlHSKF0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13--EmlDBzUNVC7bCBv86UU8g-1; Thu, 09 Jan 2025 02:41:02 -0500
X-MC-Unique: -EmlDBzUNVC7bCBv86UU8g-1
X-Mimecast-MFC-AGG-ID: -EmlDBzUNVC7bCBv86UU8g
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa69e84128aso46853366b.1
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 23:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736408461; x=1737013261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvMHmhw41jW2VMbkE+Q7qKoGQkCDW1O/R8raW3Ad35s=;
        b=mfVCS6KprgmofRJbkZTzwfXFYcdA/UUA7Ji15eZUVYlwf3TKbl0FfegcQH/xRKyEu+
         pTbYS3asb5YP7R82hjksSLfI2UcSEKe60xGmozzrb14xAdkxPVwaV7RujDMlIQ1SSHdV
         JOx1hRHvxSiZL/RkEoavHtwbk7E46IcWfFIGMcWtTg2u0DJ+6KGgnHjzmghc/OLYTKGD
         D17ecr1k/u6/e61R7pnoytfcIPO2wvLJY3j6WCFPe56N2fivYHOK8pe6DjvId7hXSfUk
         6PH4dlxbBfyT2hraqQpQdNH+Fg7617K8ssEp1IeNlfrK9Ca39m3zkwQCd69EGmeyt9wg
         MT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOQMPUBq2n1fMFuFUeoIvXTYwb3XL09OhPkORsRLEmflj2HVOWcdT+NTpvlm/MKTPaz4g40TLN2VdE5EBWsA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxVJXuJjM/PreXXxvosKc8gJL6GsgPpJtN1bRe2UiyWJvHRSexp
	ywZ1BsjhMR9tN9WzYTkXXHDYljZFC4T0XaI1XIwYxPZrynJvFbumImzOTqA9qdJW8YTY1a3p+c9
	dQGR/ISttM8IjdqSgpdQ42QAf7fAJZrCBrAzJcOC5ulYbHJPF7P2QdKdeBsQgMXInDO0Htqol2n
	6ZAIQ=
X-Gm-Gg: ASbGncscuwOYLitn7v71QGaNK8R3uBSNj1a3HoKkK9okAsNG0bicuPMgbneNLJFsb1s
	KcewltuPZYak7mVmDEuJvKRvSnEhLVgCh9FRD7p65cLnnRKCu8k5hjw3X+LiaciYd84cDL3YtgS
	LGgGEIoDJeCURTzne+NLYKMwCxmBItPIjm/HPmoSRAR51UkFBLIKeO1Eax4pEgG1nkl9sVbijib
	uKJU8+Y332YXDh4pWmPkpkjC5d0TWLvmGu/PtjKED2YpFsksmE=
X-Received: by 2002:a17:907:6d01:b0:aab:d8de:64ed with SMTP id a640c23a62f3a-ab2ab6fcf85mr565432066b.25.1736408461315;
        Wed, 08 Jan 2025 23:41:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDzuwKOL/SH91ITfaKkGp53CDAvxvv6OgtnJor6T2CNBRRh8F6ch+wN71Fz8qty44wy1eohw==
X-Received: by 2002:a17:907:6d01:b0:aab:d8de:64ed with SMTP id a640c23a62f3a-ab2ab6fcf85mr565430166b.25.1736408460902;
        Wed, 08 Jan 2025 23:41:00 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c91362a2sm42852366b.85.2025.01.08.23.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 23:41:00 -0800 (PST)
Date: Thu, 9 Jan 2025 02:40:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
Message-ID: <20250109023829-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <20250109023144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250109023144-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nm1BQJXIhEqki7lSoqKDAMZiGzjXRo8A2wiFFhl5Kc0_1736408461
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2025 at 02:32:25AM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2025 at 03:58:45PM +0900, Akihiko Odaki wrote:
> > The specification says the device MUST set num_buffers to 1 if
> > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> 
> How do we know this is v1 and not v0? Confused.

Ah I got it, you assume userspace will over-write it
if VIRTIO_NET_F_MRG_RXBUF is set.
If we are leaving this up to userspace, why not let it do
it always?

> > ---
> >  drivers/net/tap.c      |  2 +-
> >  drivers/net/tun.c      |  6 ++++--
> >  drivers/net/tun_vnet.c | 14 +++++++++-----
> >  drivers/net/tun_vnet.h |  4 ++--
> >  4 files changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > index 60804855510b..fe9554ee5b8b 100644
> > --- a/drivers/net/tap.c
> > +++ b/drivers/net/tap.c
> > @@ -713,7 +713,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
> >  	int total;
> >  
> >  	if (q->flags & IFF_VNET_HDR) {
> > -		struct virtio_net_hdr vnet_hdr;
> > +		struct virtio_net_hdr_v1 vnet_hdr;
> >  
> >  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
> >  
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index dbf0dee92e93..f211d0580887 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1991,7 +1991,9 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
> >  	size_t total;
> >  
> >  	if (tun->flags & IFF_VNET_HDR) {
> > -		struct virtio_net_hdr gso = { 0 };
> > +		struct virtio_net_hdr_v1 gso = {
> > +			.num_buffers = __virtio16_to_cpu(true, 1)
> > +		};
> >  
> >  		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
> >  		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> > @@ -2044,7 +2046,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> >  	}
> >  
> >  	if (vnet_hdr_sz) {
> > -		struct virtio_net_hdr gso;
> > +		struct virtio_net_hdr_v1 gso;
> >  
> >  		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
> >  		if (ret < 0)
> > diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> > index ffb2186facd3..a7a7989fae56 100644
> > --- a/drivers/net/tun_vnet.c
> > +++ b/drivers/net/tun_vnet.c
> > @@ -130,15 +130,17 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
> >  EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
> >  
> >  int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> > -		     const struct virtio_net_hdr *hdr)
> > +		     const struct virtio_net_hdr_v1 *hdr)
> >  {
> > +	int content_sz = MIN(sizeof(*hdr), sz);
> > +
> >  	if (iov_iter_count(iter) < sz)
> >  		return -EINVAL;
> >  
> > -	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
> > +	if (copy_to_iter(hdr, content_sz, iter) != content_sz)
> >  		return -EFAULT;
> >  
> > -	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> > +	if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
> >  		return -EFAULT;
> >  
> >  	return 0;
> > @@ -154,11 +156,11 @@ EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
> >  
> >  int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
> >  			  const struct sk_buff *skb,
> > -			  struct virtio_net_hdr *hdr)
> > +			  struct virtio_net_hdr_v1 *hdr)
> >  {
> >  	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
> >  
> > -	if (virtio_net_hdr_from_skb(skb, hdr,
> > +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
> >  				    tun_vnet_is_little_endian(flags), true,
> >  				    vlan_hlen)) {
> >  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> > @@ -176,6 +178,8 @@ int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
> >  		return -EINVAL;
> >  	}
> >  
> > +	hdr->num_buffers = 1;
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);
> > diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > index 2dfdbe92bb24..d8fd94094227 100644
> > --- a/drivers/net/tun_vnet.h
> > +++ b/drivers/net/tun_vnet.h
> > @@ -12,13 +12,13 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
> >  		     struct virtio_net_hdr *hdr);
> >  
> >  int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> > -		     const struct virtio_net_hdr *hdr);
> > +		     const struct virtio_net_hdr_v1 *hdr);
> >  
> >  int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
> >  			const struct virtio_net_hdr *hdr);
> >  
> >  int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
> >  			  const struct sk_buff *skb,
> > -			  struct virtio_net_hdr *hdr);
> > +			  struct virtio_net_hdr_v1 *hdr);
> >  
> >  #endif /* TUN_VNET_H */
> > 
> > -- 
> > 2.47.1

