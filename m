Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA8548EE
	for <virtualization@lists.linux.dev>; Tue, 22 Jul 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192900; cv=none; b=IQKM0hcsR1BPp3ltAmM3t1SaL9AEOc5BWpM6WL2mtESXcC2jJ2AeEsViUh7A8+41RuvdAoU4lQyC+W7vM1OOxA4ny4gTLqxRyi8t8O+Hx3vFCi7w7bFKb0i0ofCHEUIYcVCiSFrh7fq/muH/gebOVysZR/kLw3otDNg2VgOuEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192900; c=relaxed/simple;
	bh=rLhbKeMGlKtq2qqpoIx9GD2rFy1CZas52/3EGbn75sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ondS3rh7umlC3rmJ5WCbt9LCHg4kb1dRSp3udwvBsdGWCBHqtCzwNOTPBMsz93/AWRgcRLN44DkKi0RrxhBroyvXzpo7TH8NPk1lyb4yACmrntEFeaO43T5wubvnv7oJ5ISzoK/+KwDGzc65WGjg6bnuiznzgspxzKue9VJX4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THEGhBgk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THEGhBgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753192895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0p5ikzOpbDLH0UbPpUrEk8y7env/9ggdXGp32RRYhI=;
	b=THEGhBgkAyRSv8iuWZMFpKHXnyqh0vIDhYFfoPNvjphx0xjyzLy2SOjqOAmWPYXuhFZy88
	th202gwwHh3rQRlQpHF2CgxGlYzPf5X64yNYs4YnJF8zgeG8PIEmGn4pBEHC/2TmPyKHGS
	uhRZG2NCk4z2y11AkbU0Q+4GeC3tp/E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-RLeBJXFnPEWjq3YycaqKwg-1; Tue, 22 Jul 2025 10:01:31 -0400
X-MC-Unique: RLeBJXFnPEWjq3YycaqKwg-1
X-Mimecast-MFC-AGG-ID: RLeBJXFnPEWjq3YycaqKwg_1753192889
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso2351518f8f.3
        for <virtualization@lists.linux.dev>; Tue, 22 Jul 2025 07:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192889; x=1753797689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0p5ikzOpbDLH0UbPpUrEk8y7env/9ggdXGp32RRYhI=;
        b=VO9OD0YrCshHxoyfpdx9LvTmknNAZIlw57aQiG5cFoQEbp7O/GC+6mKoTV5zXrYWzD
         F/8Z/TmZ9hcNzqZ//mLsmIO/ZteJqgXOxNutkfqzjUxGQto5CfUWd+FNjfzGzWsEMuqs
         dLUyAzN5w9yP6Abjn9doEBJ/iOerGKAvGO5FGkUYxJ2cu36cCx9O0iEho8S0S2IJeGs/
         C2ii4n7HJeAK+7+ftKhqY/xPCKpaxs5iCE4x6koq52jpFABVHJOYZz51ZRhC5Dq/smS0
         e00luA/rh8pntatCb8DlJO/sDdlBYKLJ3F0D8NM1KsaspZJImeMQbcTmGucG/41C8txv
         eVzA==
X-Forwarded-Encrypted: i=1; AJvYcCWak4KJ8KprN0t2DbBr9Bsy3k51MI5r/w9BoZwKD3RXUt1LcdxcF1zuJfXda+4Abz7UvyaSUxXA9Hkqz6+N2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlpqjuPtzQl0cJPpnLYlKsrrx3GO+fGdfJgfPr0oehmo+LQb+H
	Di5kbQhQp29RqyCQ0bgUY4ibJoWonC+24CO6xthfs4SczQhdrQ69dryorX2P7be7NG99Bk2/Svv
	O2LHyr1Nqxp3HPK6J5wUjJI8LEnJggKCX5/Ka8FcPco6wmOFBLpcwOgXgSceBiGNXRF7V
X-Gm-Gg: ASbGnctUQhNSjMpmjRNBoQUt5aq2Ih+izjbbPJzTlioD4J3JOFPkh5nxRi20Ki99Elf
	o3dSK47hvx8ioj1aVsV7YchFut2ogI8vThtEA3HPO5vjsk5xtboa3ewGZer1gHUSrUIkXh1vNOa
	r/PGed5UvC8vupHA/rhzCIVNwUwyVjKW6flr4uhyy0KNOK2y8ZaI+aC5inFm1FscYd0Si6uNh2Q
	NPbDTR+h/bPgHoVZcJWP0qmcjkMj/Q+5nljDoYyDr8fRiPQo+gkZAR1zubOGAo2BKqaKqEWa5qF
	5JbWlVftD2XqU/TheP0choQX6yDTObLTXSg=
X-Received: by 2002:a5d:5c06:0:b0:3a4:ec23:dba7 with SMTP id ffacd0b85a97d-3b60e523dd1mr20763199f8f.31.1753192888541;
        Tue, 22 Jul 2025 07:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ3rSNVwHPJ6Ng2M1j7QSPWGFRjSkUOx6fR5MAPIP7OudPNK9d59DFqx5h8HC6DddfVseKSQ==
X-Received: by 2002:a5d:5c06:0:b0:3a4:ec23:dba7 with SMTP id ffacd0b85a97d-3b60e523dd1mr20763116f8f.31.1753192887870;
        Tue, 22 Jul 2025 07:01:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886286sm196509885e9.26.2025.07.22.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:01:27 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:01:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 7/9] vdpa: rename dma_dev to map_token
Message-ID: <20250722100106-mutt-send-email-mst@kernel.org>
References: <20250718091616.6140-1-jasowang@redhat.com>
 <20250718091616.6140-8-jasowang@redhat.com>
 <20250718053156-mutt-send-email-mst@kernel.org>
 <CACGkMEue4Wh3ocM2Pmn5E_nMzjHkJqd-MhYbPDY9pXdwMtqgXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEue4Wh3ocM2Pmn5E_nMzjHkJqd-MhYbPDY9pXdwMtqgXQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RytRpnYuwDB8C6Mj8hdssgzN-wREZ-pO9m60A-UmNu4_1753192889
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 18, 2025 at 06:09:35PM +0800, Jason Wang wrote:
> On Fri, Jul 18, 2025 at 5:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jul 18, 2025 at 05:16:14PM +0800, Jason Wang wrote:
> > > Virtio core switches from DMA device to mapping token, let's do that
> > > as well for vDPA.
> >
> > Pls switch to imperative mood.
> >
> > And add explanation about what is going on and why please.
> 
> I think this has been explained in patch [PATCH V4 6/9] virtio:
> introduce map ops in virtio core?
> 
> """
> For the device or transport that doesn't do DMA,
> they can implement their own mapping logic without the need to trick
> DMA core. In this case the map_token is opaque to the virtio core that
> will be passed back to the transport or device specific map
> operations. For other devices, DMA API will still be used, so map
> token will still be the dma device to minimize the changeset and
> performance impact.
> """
> 
> >
> > At least, document what are the actual types stored here.
> 
> It is opaque to the virtio core and will be used as a token to be
> passed back when the virtio core wants to map/unmap a buffer. So it
> doesn't have a type.
> 
> > I checked and it looks like vduse actually returns struct device * here, too?
> 
> It's just a token, vduse can return anything that can be used to
> identify an iova domain. For example, it can return a pointer to
> iova_domain which will also work. If you prefer to use iova domain, I
> can change to use that in the next version.
> 
> > So why do we need this, why lose all type safety?
> 
> If you worry about the case that assumes map_token as dma device in
> virtio core. I can keep both map_token and dma_device and make the
> mutually exclusive, then:
> 
> - when transport reports dma device, use DMA API
> - when transport reports map token, use map ops
> 
> Does this work for you?
> 
> Thanks

Sounds fine, to me.

