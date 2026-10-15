Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8452269A
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068731; cv=none; b=g43O/VpWt6AtfY/+l6WFphwRwUO4TQQnPiSFQ+f+G21wbUEX5/1y2ehsd8MRAukJJ6r3O26e9kPl7xKRU+R6A10cmm2nlah9FOxmVqnViQdLcvxJ/APmzNaPsUC7f3RO/zQK4c4V/zGqklp8bR+6Uq6+pA7bmsHiH1CuN8VOIt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068731; c=relaxed/simple;
	bh=Vqs2r6yrFjKU91M2JbFSTZKNGVccvtHOSjGLjryQhTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hvGJU3bkEyKuemPn3WJAsK3qdDmED4BM4mvJSjTy0LO70CPHPb1NWVXL5K/d+ODOpSZG1vl469tqB7UdiAv/7vmL2N8i/HGCEIZtqZR2kfdTm9PP3UYEfxSWeJGdNTEcqcTwzYhlxanHelwLRqTT4dOTdMAv33GSXWy3kzWpUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByzE9tDl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByzE9tDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcpnk+xBeaA1jme1SdTW5ccMBBDrq+w8aENCxtFQmP0=;
	b=ByzE9tDlhZuR7BUm/yMYbFh6PnZfxcQD02n4Ol/2e7zNKnLrlU3LoIrvXv9nDdljK4P83L
	ssbc3as+3Ihd3zVr/xC4G4sYDTfXdU1l+QYDNKqzz0M0HIaWJ7kW8jVC935rs8YG55EVhI
	cUbzHYbP4QNOyXkLP5Eu5j8ZU2+P3pU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-wRXfF6sUOeeJCV3NpxO7Rg-1; Thu, 15 Oct 2026 12:52:07 +0000
X-MC-Unique: wRXfF6sUOeeJCV3NpxO7Rg-1
X-Mimecast-MFC-AGG-ID: wRXfF6sUOeeJCV3NpxO7Rg_1792068726
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so1086216f8f.1
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 05:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068726; x=1792673526;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wcpnk+xBeaA1jme1SdTW5ccMBBDrq+w8aENCxtFQmP0=;
        b=MUzT/pytks3xm/MNrzPVp9JSnDvRny277alfcbIgDZ+Nymog92jVz+LnH+Fjuylu11
         Amx8ri8jSzL5qgBIiEiLLRqXGtfTfYtuL6642W1c30Vx2LcEBGVFihwkGmIYUHJ9I1OJ
         F/ar9f0tqoDLi9qmTKwp2IFJdPJj4Ct5THEoewZ0FzNsJEoM9OalHg/djxQ9N7OIGwjs
         oKJKSQA73in0jehU5dEPuCMgb9JgqwY/hlWQJTQAYnhJWs7+kMlPxBTWCSEjL/7+taf+
         yaD0UNMkHHS355AXmMIF0mcs+skyodwVoCOupuPCXRJ+gSMR8bHEY0GqmZuc3d6DuCNB
         b6Tw==
X-Forwarded-Encrypted: i=1; AKwUvBwYqOg8esFaYc5B0urQoL0pv9kRF57P3MbcsoZ1nidAarQVbF3wP1k4pAUzp3epU5ujK6/8hDywTWPZigkmuw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKVM9dg8wKUZwOMA51krliKaZeJ3kLqFPt7QAL2T5ZjfRRvUays
	1XPMtEEf++7WQGIZf1eVYJY92wZF2pmimvKjKFSCCMDwZ5YyQW1bYwE2ECsaVf40W0jSNhm/Kee
	nG+ovcwlYfXGA4N/42nd6U5r/94POXA1PftbvLbAVnpYg4jUts1Cgd4dFttz7EAjhAmpx
X-Gm-Gg: AYBFou1MS4loA+Y+SP8CN8NkOr4BvjxOL02f9ISODp/RHS6QPtASiu41uhhuLtVYdk/
	OlSsbCdU2N97zzstTFyhTLRNPJLYJdXzYyM4Bq2uvlkisOcmGgBzeDCmyKlX3+/8uoMMFqjaeTR
	9wY9pgp1jUOcjlAHK75JftAxMJXmBDCsEV995VD8VsbSELR3/+XVdLCsixuud+dMUaa6fCk1meB
	sF81WgA5EoOC2a5bqHa7hQzISvMC+6U0QOQxKzX1mXysU29y+9GIjhFIr6QHvXwv6i7ni3YmE3j
	rB69DBjxkwFlFG7kfSUWzCeRQMWinhPlTR8O6hPh3QAUkZUZJM8s/uAkyJ/jgSO91UMTxg==
X-Received: by 2002:a05:6000:25f2:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-48dbacdc419mr37642969f8f.36.1792068726343;
        Thu, 15 Oct 2026 05:52:06 -0700 (PDT)
X-Received: by 2002:a05:6000:25f2:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-48dbacdc419mr37642912f8f.36.1792068725766;
        Thu, 15 Oct 2026 05:52:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa9f9sm18793273f8f.19.2026.10.15.05.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:52:04 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:52:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
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
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261015085119-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TfKqllGN-6KNhw-qHnEnzzytg8Utz0VXtivpKQbkvtU_1792068726
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 02:47:01PM +0200, Johannes Berg wrote:
> On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
> > virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> > it cannot make sense of, but the vector raw transport ignored
> > its return value: rejected packets went on into the stack with
> > their metadata unvalidated.
> > 
> > Propagate the failure.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  arch/um/drivers/vector_transports.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> > index e1fb2a76fdff..8b7548458663 100644
> > --- a/arch/um/drivers/vector_transports.c
> > +++ b/arch/um/drivers/vector_transports.c
> > @@ -210,7 +210,9 @@ static int raw_verify_header(
> >  		return 1;
> >  
> >  	skb_set_network_header(skb, ETH_HLEN);
> > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > +			virtio_legacy_is_little_endian()) < 0)
> > +		return -1;
> >  	return 0;
> > 
> 
> Seems it'd be simpler to just
> 
> 	return virtio_net_hdr_to_skb(...);
> 
> As far as I can tell, the function only returns -EINVAL or 0 (never a
> positive value), and the caller only cares about negative (error) or
> positive (no checksum needed), so that'd be equivalent?
> 
> johannes

if raw_verify_header can safely return any errno - i did not want to
audit it.

-- 
MST

