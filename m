Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79914A8A38
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916885; cv=none; b=c5cIaWQazYF5WrxqfQPAY8iZ6oCckXkWWQnHqlOuD0t4imA/vbeluTrKwCE1tcVJPyrPhOhGXHf0orx9qX5GMdP4ljadUllgTTeZdbhyH2kb2B7RSIdDkwkYhn3vUKdNDT7S1BEFEy4Smyj6mJ3NMUgr65qmAFX44ObIosqmzxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916885; c=relaxed/simple;
	bh=yARy+Nf0dbu9XT9d1ERfBCwuVuYyeCm3xP8uoZbF/fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=h3OEv8yEri9wuyFCKlzZmvx6UnhBww98NX0nmY7oZPXOvpM+NpG/gbuodcUASrjF/lB9KVjqWFQfxK2EvsZEJdrir22iF9DQcSsZXb6+wayWZcMhDgg12ACUbsXgqVv0jFBx1Ai8O7QWv9fa8yG+V3WNmTMEA5IWdg6XpwpuQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAL0CW2i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAL0CW2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791916882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+79dBe7BXsqjXhOxqgwaqCIaKDkT92Pn+PV93QPrx1M=;
	b=gAL0CW2igTOoUOOqplJNlsL1iQ/7oeZ2MgD7ZshhI0D2h5HhdqiW97+QB4QVmhSlkM8Vjd
	99W7wMIZQKyLXMC8+8cd5MClO/vN3AH7wXVvGfEDH/QFth8aWA2jItTha9MgHALEbygstl
	soVVrMy34GW23lQTDOkC6PaFqXrcYug=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-2oOJEcK6Mcef6xi2RSnP1w-1; Tue, 13 Oct 2026 18:41:21 +0000
X-MC-Unique: 2oOJEcK6Mcef6xi2RSnP1w-1
X-Mimecast-MFC-AGG-ID: 2oOJEcK6Mcef6xi2RSnP1w_1791916880
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b00febba3so2593835f8f.1
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 11:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916880; x=1792521680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+79dBe7BXsqjXhOxqgwaqCIaKDkT92Pn+PV93QPrx1M=;
        b=pchk7oQJjSwoq9Tdv215Z2djiQnP6zt+oB3A+XwY+MfoLlbeLy123/P3qvrTd1825U
         hbMP8NIyoLq1Jek+kl0VZLxucAImxamWKdpC9l/sDARWBZbB2r91xvwfU0OmumaK25N1
         pBjNHPfiP49CtX3TmmdN+0z22fT4qA4edk/0o0tx/yqUfYuCeIGMBFc0GFCfy2LiF0x7
         oJoRgs0renGFw90ZsIodPk216w+lFduxcXqrQnaYHJDwns2lo+PTE0IGA+tuOHFTSRwU
         vueLES7HOnd/2pp7QnT8Fy0F+JlAi4MyU+0zbMtopvAFBCExk5uE6tCOeTRKFKcJi9B0
         Xt4w==
X-Forwarded-Encrypted: i=1; AKwUvBxPUdSxPFaVOzCcYVLN742k5XMxaYlMO3fpb4mJwwLQwCakg63aAur9q1XBhzGc2q4RQi9aeKwXmRYBDQhWyw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJVaFHCCoV3Q2klmdm+uYq7bm+Fi1o/CTM046SqKtXLsyZk56PH
	5tLGtgeaDUmtLZTN6edA0mGc+HlVdcTkUL14klM2y98v9WF0BTfftMlNjSuXqmv6nKrX3rW2xia
	PSICmcVOu8KDS3YjOmi0p4gRIIKoByA9CipxwJ+R+0grUQNKMzhTMLqE0IPgrRUK7ek9e
X-Gm-Gg: AYBFou3KejWjWZjc9rMGv81YYfHFUJ1SySG6fJn8epLK4u0Hyk4HSnLEwiq+n7/UKWh
	3q1zF9/Vc7pNCTeF+buuYuhXCY+0Z/P0bCNsY/b2VuCqaQ5DngIEEX/rgkBxMfzXB/sGDff8bjQ
	VmKX6/QceY0K7hcUb+OH0CQIge8F0CLU2EZ4DMIC9E/fmr7+6G3mFafkKm9mwQ8vdNZeRocmdpv
	MIq0XwapRKto7fMEh/Lc1lKG3ASja7mbpH2+ARRY4wU2l2hEl6Nr42S4FsxvmGbXN9ySJ9OzsLo
	o3f+B9yI+eXdh/FUGnh0o+eVS3gINUSc8Jm/N+Ay57rmqZb6vItDOhbg9s12ugcyLRCsRA==
X-Received: by 2002:a05:6000:490a:b0:48c:490a:336b with SMTP id ffacd0b85a97d-48dba7bea0bmr24731936f8f.5.1791916880168;
        Tue, 13 Oct 2026 11:41:20 -0700 (PDT)
X-Received: by 2002:a05:6000:490a:b0:48c:490a:336b with SMTP id ffacd0b85a97d-48dba7bea0bmr24731878f8f.5.1791916879648;
        Tue, 13 Oct 2026 11:41:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc506asm7057620f8f.47.2026.10.13.11.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:41:18 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:41:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
Message-ID: <20261013143716-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O9YXxQ4pS8APHQeyUpDnBXq-mNM6NIkW-oz4HlU4iPk_1791916880
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 08:41:19AM -0600, Willem de Bruijn wrote:
> On Tue, Oct 13, 2026 at 4:58 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Allowing untrusted hardware to specify csum start/offset for
> > CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> > outside the actual checksum, and depending on the setup, the networking
> > stack could be looking at the packet both before and after the edit, and
> > seeing different results.
> >
> > Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> > completing checksum") validated all known instances where this
> > causes the most grief, but the real fix is to make sure
> > that either only actual checksum fields are ever edited,
> > or the checksum is completed before the net stack looks at it,
> > so it is always consistent.
> 
> +1 on the general approach of performing the checksum offload at
> input, unless the input can easily be validated to be one of a few
> common protocols. That greatly reduces the risk vs my previous attempt
> at trying to drop.
> 
> Since we do not know the full extent of grief, I think this too should
> go to net and stable.

I think it needs a bit more testing to be frank, I do not see it
wait months out of the tree. So if this lands in next before the
merge window, we are good I think. If we miss that I will target net.


> That would mean initially a single patch that
> touches as few files as possible. The helper function in
> include/linux/ip.h and conversion of existing open coded parsers to
> use that can follow up later in net-next.

I don't see the value to be frank.
What moving code between files accomplishes, I donnu.
Squashing things surely makes review harder?
Does your backporting system really struggle with trivial
dependencies like this?

I can drop patch 2 and will if I am targeting net.

> 
> > This basically does this: checksum at ingress, except in a narrow list
> > of specified known good cases.
> >
> > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> >
> > Michael S. Tsirkin (4):
> >   net: add ip4_parse()
> >   net: use ip4_parse() in receive validation
> >   net: resolve uncommon partial checksums at ingress
> >   net: account for ingress-resolved virtio net hdr state

