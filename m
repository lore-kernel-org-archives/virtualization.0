Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200687;
	b=C3pn+yrU+YJv6UrOjuWsSVQyrafcl5pFuUOXvGj5FgwbmeaU3ZpPv9W+rNiEEr8+Xw+K
	 xq1IvRLetrkORz9rDPbYeAL/bqDldIRTs/B57kT0kwSnGesPPdjQfCMbazuMx6Cq0FXmo
	 t+oGeli3qUDOgdzdTS9580esi/R5j7UudIvSGCaLOzobarhL6e6YVgk5FKvAiYX3TT1gL
	 XTly/cozhMx/jWpsp3BoEMI31peV4DI4M2M5BsiVpe/zJJG/TDQl4ot3d6cPghs+pngVf
	 kWuIjPMgtnEOkO0Kllv/WDoRrfZ8R/a0V7RIpP8CZsMkV4LbdX/Cu1VY0osB80jRX5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200687;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=ufMEsT+0UZj2JmdW++38V5jHMZ2SmFc52c/mrSsLj0A=;
	b=38vRuBHFfAoPHAnA4J4FCKRVsQ+6Rw/m979oOHP6C0AFAXSxHkNdMYKHQp4bODgYF9ly
	 8IqSxXsEEGy980+DAgu/AxTD6qNGRgJjLgP6I/kV2uyJ/g41j0VUHqQc8rnVKAd3Ehjmk
	 8yzQJe+NEwqAyoaDctww5tdSZxnkOHxkZTppMK2doBhj9F88q5TexaaQHOy7MrrASgGYF
	 2waooP3lYnC2KhfWifWBQNuKKcVNqfep2MgwNx6sDtIhLJdhSdcgszMfVGTOTFx4MiDvw
	 t2PFPNdI1PyL9V+t6BGNcg1IvmgZWBwdpwBGttDUE/DRdfIg6CjbEj1QDkiFAXcR1QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="dYZvX/T/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53440606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 15:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53440606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dYZvX/T/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793200686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ufMEsT+0UZj2JmdW++38V5jHMZ2SmFc52c/mrSsLj0A=;
	b=dYZvX/T/WJ1tNIMkwC6cjo79Y8Um9pwbDGrnB77nmxz2oarNSXZd8DWQggk5L9Y+UyLj4+
	tHYJX3hcvPLz2csGU3Csz/avmzHXz7T3D+8xQ3ryFdNob2RHr7jkewVKzX6hXTVKQkYvjE
	igdBR3rXEn+MB7jrPWFkVakQeDXz+dE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Qo1Q_auAOXK28rtC4CYK9g-1; Wed, 28 Oct 2026 11:18:02 -0400
X-MC-Unique: Qo1Q_auAOXK28rtC4CYK9g-1
X-Mimecast-MFC-AGG-ID: Qo1Q_auAOXK28rtC4CYK9g_1793200682
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a77c1cbd15so10193495e9.0
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 08:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793200682; x=1793805482;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufMEsT+0UZj2JmdW++38V5jHMZ2SmFc52c/mrSsLj0A=;
        b=Q5HubrLjfm4qFh/VcCuvmo0v0sBoeWNrBInmEpk+UBZxRMwjSeeBRfxeFWPgc48Vuw
         yJH4Ia4+xQB2v8h5QHS05H2cbaKyKM+qS/4cSymJ7cxpIzf+mZJvzrjSxz5JWQrehAp8
         V5L5NWlPxdqrEOFRm1ZLPE6HVksDAyBskD5I6uIMS+0mMqlYcsO2eyokkM2AKhuXGC5V
         KwpLBQ5lX5Qnd/y8lwzDUjFZf9O79WwHULIAA14z1shOKlEE1d2xU7KnCwfYo6h7ybty
         mx7MqLzvfUKFsGc9pup/OwPkXcYD9Oi0KT2W+hQKGMZ1aFWImhgcYL9yTTzoNr/ddl3S
         185A==
X-Forwarded-Encrypted: i=1; AKwUvBxnnRY8ZEVcgu+iPhGqLtv09+ZrIM+/73IavH6Nsp2PlhbNj4yYg3kpHGa/74xKWVNAJHaRbpcB9ohVPFMLwg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ+lQPKXejS+yiYlLSxeyZDdwQwxsItuaqfxW+bgmi1NLodYPmE
	obii89/J7Z+m805jbFgYFaXvq4bqZ04q+ROsXDwcshPSMHSwA690hWtyfe1V+d+jQPrsXbWFmzB
	AHUZXRnWHZmuVQg2OMDexBBQZyD6TZQbLib0asQvVIASetSSWRuf9l2Fth6TcwuEPN2hn
X-Gm-Gg: AYBFou19peHoV4XYBrjV90tAfNVAQWThzVMafpalyH4VsIF1F4dwFfaBrzGqBE1F6yi
	k5KsDUUY0mqcB1SSXXWrFqSlw/6DaeDaIa+IewuW+1j7CJAHcM6UqbDOvmcD9NyGMnz2cNoI9FF
	nn6x7ZEGBg/ejm93/MTpqnKPuoyUpjZHCLOm8GPiDrqWyWqH3I7QMhCy9sUmH2sUBv01wZ61VLT
	L2IPg9d1Nmi2u7lM1gQ3rJfIxZ4Z8V/VzjP9+oO9VGEjeMpUovtGOY6qMX6glsEiDhmxjRjXJfW
	odcu1LvoQ+GsKd/xwUZJFoWHJ+rf8wr7C7R7IWIawP6PDBNoAEzr7YWnbXKC1EL8KQU/rB0OzE8
	jmGBSv57zVtqbYT2kGnwiMJRSHG/q/PGvmVhzxd/j
X-Received: by 2002:a05:600c:3516:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4a966c4175cmr58229865e9.18.1793200681570;
        Wed, 28 Oct 2026 08:18:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3516:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4a966c4175cmr58228755e9.18.1793200680906;
        Wed, 28 Oct 2026 08:18:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97c9f1403sm56168915e9.9.2026.10.28.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:18:00 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:17:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
	Linfeng Sun <linfeng.sun.dev@gmail.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Jason Wang <jasowangio@gmail.com>
Subject: Re: [REGRESSION] vhost_iotlb: bound map allocation in add_range
 breaks vhost-vdpa on hosts with fragmented memory
Message-ID: <20261028110041-mutt-send-email-mst@kernel.org>
References: <0f51918f-88c9-4930-ae5a-616bbe73e7cb@nvidia.com>
 <20261028085839-mutt-send-email-mst@kernel.org>
 <808a6e4e-085d-4723-9489-f17f023949c0@nvidia.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <808a6e4e-085d-4723-9489-f17f023949c0@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yzBjUZAGO_VEyqy_W8D3_2qYqHB6fff1KoQV0RJbkYo_1793200682
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2026 at 03:46:05PM +0100, Dragos Tatulea wrote:
> On 28.10.26 14:05, Michael S. Tsirkin wrote:
> > On Wed, Oct 28, 2026 at 01:44:30PM +0100, Dragos Tatulea wrote:
> >> Hi,
> >>
> >> We've started seeing regressions for a while in our verification CI for
> >> vDPA Live Migration tests. Occasionally the FW returns a syndrome
> >> related to invalid mappings during device reset.
> >>
> >> We've narrowed this down to commit 1ed35ac7f3fe "vhost_iotlb: bound map
> >> allocation in add_range" which limits the iotlbs to 2K by default. On a
> >> host with fragmented memory you can get easily more than 2K entries.
> >> This results in truncated/incomplete iotlbs mapped to the device and when
> >> the rings happen to be outside of the first 2K mappings the FW will complain
> >> because it got addresses that are not mapped.
> >>
> >> I'm not sure how to fix this though:
> >>
> >> - LLM suggests setting the 2K limit only in VA mode and using 0 as
> >>   before in PA mode because PA mode is limited anyway. Does this
> >>   work?
> > 
> > Well no, we do need the limit in PA mode I think.
> > 
> > But we should maybe  bound from what's actually being mapped rather than
> > a fixed count. e.g. X entries per pinned page?
> You could have many 1 PAGE_SIZE mappings though. It wouldn't help
> then.

it still mostly is 1 entry=1 pinned page

sharing is possible but uncommon

> > Bounding by bytes instead of entry count is another option.How to get this limit from userspace though? Would RLIMIT_MEMLOCK
> be an option? Although `ulimit -l unlimited` would need to be
> capped to some value...

guest ram no?

> 
> Also, if the entry limit is still there some kind of precedence between
> memory and entry limit needs to be decided.

I'd steal a page from rlimit then use that for the entries, when out of
that - steal another page.

> 
> > Also 0 is now rejected.
> > 
> > 
> > 
> >> - Can we detect this and reject the device / stop the device at boot time?
> >>   Probably not as this doesn't cover Live Migration.
> > 
> > Exactly. Besides, failure is not at boot.
> > 
> >>
> >> Any thoughts?
> > 
> > Does boosting max_iotlb_entries help?
> > vhost_vdpa.max_iotlb_entries=65536? Or sized to guest RAM?
> If set as module paramer? Yes, it works. But the user should see some
> kind of error to know that something is off. Otherwise things will start
> failing silently and randomly...
> 
> Thanks,
> Dragos

