Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DAC4A8A25
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917506; cv=none; b=o0AsKC/vPKuZUTFHcKpFUbJWUdSpiFevvkFkZ9FyiFx9XOtVD/ORU/6r4phh56Ny83sPnpCY5t06CKIkgfZ/MpU1l2oWPcq1b1cJ6MFR+jCKOeZ4a8Pyyg3eElC5t78ch+KqPCbQj60GDs+ajaP+86HDBskEFso7zPg5ch1oTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917506; c=relaxed/simple;
	bh=vQQgX5XfftHA7/vosJgmBjICMWrkz0gmawEsGmWcNVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o94Yzy1wb1E7soNR0WsmpdyfnraZfwwcyGXtsmPJ2UFFOJX2SMmWao15BAuntdUQm3vcxaE20psQNB3Q/tBYOwtvJ3ebEyzxHqSaO4Xw8u+TfAeZKu6seH+YrxzSUepypq6cWhrLLwamuL9NND9PUWILok4JxW2hJmxmR40bjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CmRTB2P6; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CmRTB2P6"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6d7e06dbcccso2041888eaf.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791917503; x=1792522303; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NY6xAXXWFY1zXXulN0UI4uvJ0IhzTvnKlTHvFNUGXLU=;
        b=CmRTB2P6Vbpm3qI9Q+pWiTPXE23l/M+Eg8oL71palgGdqX1nX+gNA2rY7lupBjFyFL
         SYoqBWSb6RRDV0xgzdMh72eerj2uzMnnfbs+7hcKx9HQABhC0V/GYvprbZOfhAbsxsyW
         2yJxf6LYX2Ul4lUi/SXYjf+IVpUQ9IT2R4T5gwJ55n7TLqxxx8weP368vHoHe5QHbOrw
         OrFUsaW9eWL43B2Ho6G9aYnzyd17ewihZjJmjmhh1Ht8LsbCzrxWDNE6QBf+myQJEwEu
         4Zl7s0abOg+92FhRmmrA/PGnjwOp9XN94/k4nRR9VQhXrXpzhVFv2xIntJu5KS9MordY
         R+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791917503; x=1792522303;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NY6xAXXWFY1zXXulN0UI4uvJ0IhzTvnKlTHvFNUGXLU=;
        b=fsXv6WgOQPKO+47u0ps4Rly+YB0X31qHj8/wpxBvu+NSd32P/MqBuDCcusb1joVGk7
         6Hc4/V19Mkmafw7O28SNbdTXU4867etLVKVKU6bWJKBbWHZVhP7vHgXpcns3zrtTLsxf
         gbiatFUpMxjTEkceW6Ywl0B2S+ZyEyg8dQiUfHEJHtjEBYbx3B29Ge8jJ9Q0NZNlCzyd
         ptggd4rjILjFvRhyJuHasnBSFYggoGKeHgZMyk1RYggbCuTAHo196Z2hRvLiDhwdmRS4
         ZEgoCYuzF4Ym+7GlyyFbU3R1vWlFYRDN/NQDPsibAveEnpWjB6X5m793DN+a0Lswq9pb
         KU+g==
X-Forwarded-Encrypted: i=1; AKwUvByCk7RNXfS6+yznQhOGlgwgKR2fP3mtApShANEI7ZA9aKR9i6sajQr7bo6wuSbctJmKYUrpp7iKzROyAFEqEg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKmcBxMBjLYl+pB0sUj5ZeWL9M3zEH2ZSn8l0Tc8zxDZQj/5BZv
	qzlqQUOG2Q6xVDEDh4KK3mMNcD4bQMjLt6n14X5E43LBhl4zQc+ylkbRin+wycaujlw=
X-Gm-Gg: AYBFou3RjTe5duNZChEgTlq1brcmMr+uvCYbLqdSgtxAQVMhzGZaXjntyE5YKu9N1JZ
	hpDNJ/gpmtnwx+Mg6XfY+D4yQeOGmFhXZLt2rjJ41zJN4FfJyiJgj1hvr5dXeY9rResupkAsn4r
	5krkqO00YKDFzrK9+VvDcYG2oF4KHCJA4C5QNgm9l3iLP2g52YwUI9p3oDTAkZl8GWWU26uSEsV
	XLFe/kF93I9o23Y4nIusVgt0l9kwLqsWFWcGIifklP75237t1aq3js/p4W+vlJEItATlhPCiSae
	pkyjHj/nqlT48vqxC4Vhx7olFBxPc73DQ4QSy/EU6JvNsF6Tb/dqjvLEmuxydXs7HHCSN620PkB
	JKLbhs0j8AzTl8qgTGK6T0txJafwqToGg6ooyMxmDa88U6HCvYEPrFahzPFJvarxpRjLO1hRYDJ
	uM4u27tpHnm5w4dW3ZOQB5XjnYscB+2tEqtClO3BUPgN3OnKPUaQllcABnwFnA1uQj0w==
X-Received: by 2002:a05:6870:21e5:b0:485:d1ab:793d with SMTP id 586e51a60fabf-4a2a889fee3mr11368650fac.30.1791917502711;
        Tue, 13 Oct 2026 11:51:42 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:15d7::22d:151])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfbd6a92sm409039fac.9.2026.10.13.11.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:51:41 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:51:39 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
Message-ID: <as59u_oxCGn4397B@20HS2G4>
References: <cover.1791887415.git.mst@redhat.com>
 <20261013070259-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013070259-mutt-send-email-mst@kernel.org>

On 2026-10-13 07:05:34, Michael S. Tsirkin wrote:
> On Tue, Oct 13, 2026 at 06:58:28AM -0400, Michael S. Tsirkin wrote:
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
> > 
> > This basically does this: checksum at ingress, except in a narrow list
> > of specified known good cases.
> > 
> > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> 
> 
> I forgot.
> 
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
> 
>
I did some testing of this patch-set and it mitigates my cases in VM
testing.

Tested-by: Chris Arges <carges@cloudflare.com>

> > Michael S. Tsirkin (4):
> >   net: add ip4_parse()
> >   net: use ip4_parse() in receive validation
> >   net: resolve uncommon partial checksums at ingress
> >   net: account for ingress-resolved virtio net hdr state
> > 
> >  drivers/net/tap.c                   |   4 +-
> >  drivers/net/tun.c                   |  44 +++++++-
> >  drivers/net/virtio_net.c            |   2 +-
> >  include/linux/ip.h                  |  24 +++++
> >  include/linux/virtio_net.h          | 161 ++++++++++++++++++++++++----
> >  net/bridge/br_netfilter_hooks.c     |  15 +--
> >  net/ipv4/ip_input.c                 |  13 +--
> >  net/ipv4/netfilter/nf_reject_ipv4.c |  13 +--
> >  net/packet/af_packet.c              |   4 +-
> >  9 files changed, 228 insertions(+), 52 deletions(-)
> > 
> > -- 
> > MST
> > 
> 
