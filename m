Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773290;
	b=NVmY6gw+hEdcRfo8/U8zqZ53D0lspGpxkgw/IkKLoXA+koA3ft5Z3A9v9CaE5VAr3feI
	 +lG7afDcUhEMeivRyCT7Wd1nXmz9U5xJ6DBmq6IGWssYPrbILvIQFOhE9nZgk/WJtYcni
	 ZrL63o6BBHuLEIHyZEm1IhotYFvcPdwCd3Gq+06s/77G92nZbOyeRsNiAnoLd/rRZanFW
	 XsdYy69Ykw5gmyi2zOCSTjAPsDmLtyAT2A5rmFH7Uzqn4ujmLYlPNlQhGCO6FTj5B8Kp2
	 tjXwQuXAlX9dFZCgvRZfaJ1prdUKalGn3q38bANENQxQbFwa4QGIELjtuDJdbCA8nRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773290;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=fEHLxHVmO7FJjZpKsvuinG1U7k9znbZ8wdMBda76NbU=;
	b=ma9qp5axuJn4IPRGfbm9tOpjK5X9d6cBYd+ZMy0mty11ox+VY5ziWGVW+IP3Bzkps2FH
	 5+yI40D8/INhzwPuF2bh24zeeVfHuDCpiV5FFO8yHuUISCVED+/ukB2ZxJQhnuT68Opwn
	 /1e8xT1Z6zQYM6vJozAc/tvGv0rgZjwl8/NQehymkgPvZ5O8XI2O1QS1kAYyaYqKfleHs
	 jLSHeBoYkLQlOyupO9+joRXRyKj17l/TvdmKP7fA4JbDO/X6dLrgxOwjwJCu+0yY9dtrR
	 aOhim+nLsu8wZKQGLYa63ArwSIeZ4i5beZiBp7f2NJFKpk3o9enr96JY6UNlBkTbfOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Za3CDu1P;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F083606A31A
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 16:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F083606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Za3CDu1P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792773289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEHLxHVmO7FJjZpKsvuinG1U7k9znbZ8wdMBda76NbU=;
	b=Za3CDu1PoD99Qf3+euc1Ez19uGPeG4jgogrWYs0vLd1WewI9NtfU56Lj4+W5gubNKU7YiM
	BVaLEH4MNSrKGP7mxzaNT8Y7mAaqlv64slaEUkMynzGaLnqt3kU8gAq9BDwIZl9zCpzgLF
	KzwmKCe1PgIFGGiCfr8Tp/p1NXlw3a4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-Xjpf2D8lOxqjZmL9xZFheQ-1; Fri, 23 Oct 2026 12:34:44 -0400
X-MC-Unique: Xjpf2D8lOxqjZmL9xZFheQ-1
X-Mimecast-MFC-AGG-ID: Xjpf2D8lOxqjZmL9xZFheQ_1792773283
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4870142f030so673026f8f.2
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 09:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773283; x=1793378083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fEHLxHVmO7FJjZpKsvuinG1U7k9znbZ8wdMBda76NbU=;
        b=RmZWPbsjEH+oUleVqOgajbHlhsT8pNxP1SiLmAkbssoY7T7ynBYRJNVSOZRsOKrhUV
         K+to+RgQdPaOcl9XCiLIiO4dFv/D0YTkebBGFQLzxEE/ylb4OwsQ19yvzADwO+LBZLMx
         nFr+wCRbPLcI99RhHTIlgepQQ9PzRVg04HT406kNL+0Y2MLiG++0HWFIkRx4MlycdWBo
         2klKuEazAbll2GeF1f/ng9gf81qzktHtkAyM/V/35bz7YQSTL//qH8aBKqrvBj1A9gdw
         rhn10M1NiQysTDwjNXF8fiAFuLEaXAdhtJYLGJPlaCLi54KsLjOXVMGSzgOjvxbf6z9r
         UdsQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9BIcfk1Z1tQepKW1PptlGmw1zgMl9viRlr4rAhr8SWx4nposn4Yh6GGfqFg7eEMDRtLBm+c2KTyX/C65qvw==@lists.linux.dev
X-Gm-Message-State: AFq9FYI+eNNCb+ICH/4BHMBu0j9zT04gBr0V5JTHP+Oy6n3jzQvlgIJP
	+manx480a9HluPMgQ5e6Y6TUiGfoXNpgLHEkCMKNIroyVKbYRjZMrfXgWMz9mmORP4NUGCjTayi
	NzzuxKIAFd+4FLJMFyvI8X+7SoVIM3JUszwTVDXJ3PpcqkpFQmBoblYJ7ORmJUoVxpTk1
X-Gm-Gg: AYBFou0DlSR3YulC/KbJNH4awM4UOwKVd1orcfaw5uWWGcik54OiWz06F5ecUM520zx
	ryMDDxf8c8eUmMaY3rVnIRUb4VDwGmmSVd2727k1PUhhFzPW1ABGCLrvQu9XmZhsco09h4JB+PJ
	iW0BafdQ61LuT8uir34+JbOxMDT4dxPfN534kVx+rIqJK/Vz+J6kx3i1bvVmXVUMv/7bx6d3z+f
	I2l7jlUFnKsBKbQw3WdqkBYN5wvMLgq3CqZ0BQHKNeVRGsmoaFsqaMFfBTKCFpqmE8I6Kpp6rYV
	l6DzAYLHpnGCrWKoFDF+0y0Tw4+jbTi5NtL8RyYFmGqsCMWYFKOndtdIqaBvkFhlI2LPEA4=
X-Received: by 2002:a05:6000:2b12:b0:488:8931:b1b2 with SMTP id ffacd0b85a97d-48e385962ffmr3200825f8f.28.1792773283363;
        Fri, 23 Oct 2026 09:34:43 -0700 (PDT)
X-Received: by 2002:a05:6000:2b12:b0:488:8931:b1b2 with SMTP id ffacd0b85a97d-48e385962ffmr3200797f8f.28.1792773282701;
        Fri, 23 Oct 2026 09:34:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d405cc0sm789801f8f.30.2026.10.23.09.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:34:41 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:34:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Cheng Yongkang <teel4res@gmail.com>, virtualization@lists.linux.dev,
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH net] net: virtio_net: decode tunnel csum_start as
 little-endian
Message-ID: <20261023122951-mutt-send-email-mst@kernel.org>
References: <179268538303.70821.1734486381476363942@gmail.com>
 <sashiko-outbox-182939@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-182939@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DGz8BSwE19WGF-BxfyKRPkVL80Jza963yvjUwUUrS7k_1792773283
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 23, 2026 at 04:09:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] net: virtio_net: sparse __virtio16 mismatch in virtio_net_hdr_tnl_to_skb()
> --
> 
> commit ba7ce0ae4b2dfb77c6b110ada68faaf66de9237f
> Author: Cheng Yongkang <teel4res@gmail.com>
> 
> net: virtio_net: decode tunnel csum_start as little-endian
> 
> This commit changes virtio_net_hdr_tnl_to_skb() in include/linux/virtio_net.h
> to always decode hdr->csum_start as little-endian during tunnel header offset
> validation, matching the subsequent call to __virtio_net_hdr_to_skb().
> 
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index d6466f96cdd00..ddc6341747e53 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -324,7 +324,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> >  	inner_l3min = virtio_l3min(inner_isv6);
> >  	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
> >  
> > -	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
> > +	inner_th = le16_to_cpu(hdr->csum_start);
> >  	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
> >  	outer_th = le16_to_cpu(vhdr->outer_th_offset);
> >  	if (outer_th < outer_l3min ||
> 
> [Severity: Low]
> Does passing hdr->csum_start directly to le16_to_cpu() in
> virtio_net_hdr_tnl_to_skb() trigger sparse endianness warnings when building
> callers such as drivers/net/virtio_net.c and drivers/net/tun.c with C=1?
> 
> Unlike vhdr->inner_nh_offset and vhdr->outer_th_offset, which are declared as
> __le16 in struct virtio_net_hdr_v1_hash_tunnel, hdr->csum_start is declared as
> __virtio16 in include/uapi/linux/virtio_net.h:
> 
> struct virtio_net_hdr {
> 	...
> 	__virtio16 csum_start;	/* Position to start checksumming from */
> 	__virtio16 csum_offset;	/* Offset after that to place checksum */
> };
> 
> In include/linux/virtio_byteorder.h, __virtio16_to_cpu() performs the forced
> cast from __virtio16 to __le16 before calling le16_to_cpu():
> 
> static inline u16 __virtio16_to_cpu(bool little_endian, __virtio16 val)
> {
> 	if (little_endian)
> 		return le16_to_cpu((__force __le16)val);
> 	else
> 		return be16_to_cpu((__force __be16)val);
> }
> 
> Should this use __virtio16_to_cpu(true, hdr->csum_start) instead, matching the
> __virtio_net_hdr_to_skb(skb, hdr, true, ...) call below and
> __cpu_to_virtio16(true, hdr_len) in __virtio_net_set_tnl_hdrlen()?


Ugh. In fact it does. Should be __virtio16_to_cpu(true, hdr->csum_start)
and I had exactly that in v5. Not sure at what point I picked
an old version of that (

It's just a warning - functionally the same - so if v6 goes in, I'll fix
it by a patch on top.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/179268538303.70821.1734486381476363942@gmail.com?part=1

