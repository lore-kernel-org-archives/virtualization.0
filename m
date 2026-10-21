Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569129;
	b=LSUyXJJy+w6Vg9j9cbiq/x1qeWucuCpV4IARhJ3ymKCq/bW8SagKytd126rnwRV4tmXz
	 OgoITZ//Plcobz85vFuRlLbqX04m0YiSqoJqKJbrzEu0luKdLcOuYD82xzfBMLvCFmUSm
	 EO9C2KeX6AEq+k+RjNyxcFw3ShUmAl3nLpQrBh0CpKOAYS+2g0yh5LdUAWGYQimChVLaI
	 qAJ64aJtyx19CKG24RUuaifSibaJz5qdKYg6bh9YqXuPfSb/1AfdR7aD5Qu42mdaT8j0t
	 aBSsWdHnDodItAmLV3pOfQXgB/L320jIHW+rNhhsO4Hczkp6oUFu1N9BO9cwy/eZVnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569129;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=QITuyYs5+tqSrKrfIpvUKD41r2Vyp9d2xbchRm7msa8=;
	b=e5U6RWvK+zPzDVO5rgS6cQFI5lguEhStzfB5iQ2LT9SodDMqh79XniuGIB6uDyK5aOmA
	 UCD1T51Ieu19ZH9mOZapXOgh2O5xkJu0M64NlMB287MzNlMe5UcM1VBnyx5S7SqQMu6Pc
	 0FEGvDpYJhhwQICO8rnKyqZI4hY5mqWg14E1xbXrsO3Asxltt7HRTePI4qp9twq1FXrcH
	 0dllDSzdBbL3ziN2zXq+Iyi5aE4xb8wh/r9UIcywmTFTb4MWZYGZUPvQqup0vXoMACB5u
	 63rhIye3vn1ved8OMxyBsKCVgz60a3zebBqEWdDSTLFjkWsskoKkyaIYaB8s4Pm3ecQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SH0g5aq8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E47606A319
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 07:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5E47606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SH0g5aq8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QITuyYs5+tqSrKrfIpvUKD41r2Vyp9d2xbchRm7msa8=;
	b=SH0g5aq88y2bKB/XD2VCrTQcxw7R/ofrLvcwIx1pAptIEaJ3e+6D3xbVdm/2jeqSD2BiZz
	Pvavv28treq+3rE2auWMhsVvt8nG45sWzI2JsUF/U/NY1EfQLFeuOgJUJ2RkL/EUFlZnt8
	s+lVG1UAmojQcuc+4JDA8s/Esq6MkRo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-rAoX76LtNdabPv8FJR0r7Q-1; Wed, 21 Oct 2026 07:52:06 +0000
X-MC-Unique: rAoX76LtNdabPv8FJR0r7Q-1
X-Mimecast-MFC-AGG-ID: rAoX76LtNdabPv8FJR0r7Q_1792569125
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so404532f8f.0
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 00:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569125; x=1793173925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QITuyYs5+tqSrKrfIpvUKD41r2Vyp9d2xbchRm7msa8=;
        b=KsMtaO5om7ydMeM54vjBLYs1R+lEUwJPdSjFd0RdPfkky2N34/0m/lLgAyxhz0shJt
         /rEU1K9kJYYwRPR3W2R9R+H52WJgbV7BgLkIyjbPoQa65u1+0KDuVkefgeKMCu5YLyvV
         Aqh+ii0u7VS65rOZBpeJHIis4kFgqyYsHHcbLe5WmSj7LVgv/AP90Xkg1WqdJPp+VyuT
         zgeHBnzjJcS3TpW6QF3tpLXdTk1BfK49j7QRwbKnW4e/teQDYo5i/C0+2tiMvDORjnOR
         6TCtNt0HXC3P3KO/dccIULT2wc3acW53ef+GJlcbobMnsBwb7Idh198HzWSBxDzbk2df
         JNuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP5wD6YIB+9BUuW8XSIATDRs4THAVp166qb/1EA+Ws9ZDZmJNIJuh1F5rN49HDq3ZrjztbhxfQUOsGYqtmlA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIy6GLtRbD8QaSbV13KuKT+mTyx8xxPqPAkqYhNud+GxSFxENib
	PIhaWZs6UfXvTWHbhQAw9jzPrzAksx8jLjv8XOK2Zy0UMvz/c185ZQr46OK53T2f3e8lLcaIpu5
	hfZdlU4rRdKkYd3TbAhim+0cCO0ZUExsZNqVmiAiVDioDutxpCtJTjrua6lmDpTqwHVe/
X-Gm-Gg: AYBFou1pJesjz+6q4xii43ebGzMWz8p5QPHed5rfbgMA4xaPf1tQ3O02D1fl3sqSTX/
	EB8Jo2uAN8d1v/27IrNAM/qQYTOvqCVtqNoHViSSnQF2nXQjtFroNee+/8mpjVaTSTlIAyrp1xy
	ZvfgvkjtaOHXgwErLxFvtqY1JWn2GP7yP7xvwqiT8qi4Pk8nKRstPfWPwZORScQAOwpfewkXdmZ
	uhTNoNR+pdnxD/5L1q/X6hhgVfShTQPw4F1qBwF394fqOm4RJe0Suym+FAm/Kxuq9d4TlPP6CB9
	npMNI/MHQhpa/9Zmfhu6DLq7rxqVwSSx1GqfSLH6cxIE/jLQDyYymEa2BvtxpoTgC+aePQ==
X-Received: by 2002:a05:6000:478a:b0:48c:7ee3:e07d with SMTP id ffacd0b85a97d-48e264ef9cdmr1191050f8f.52.1792569125348;
        Wed, 21 Oct 2026 00:52:05 -0700 (PDT)
X-Received: by 2002:a05:6000:478a:b0:48c:7ee3:e07d with SMTP id ffacd0b85a97d-48e264ef9cdmr1191026f8f.52.1792569124881;
        Wed, 21 Oct 2026 00:52:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583ffa8sm3908268f8f.51.2026.10.21.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:52:04 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:52:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net v3 5/8] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261021035050-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <9c08d12b3a7819ae03ded6a154e4f908276e93d4.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.2eb449439b094@gmail.com>
 <20261020170908-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.1da723f98c23a@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.1da723f98c23a@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t2yMq6Q6cYxcL-akrt0MqcUUtsFLPmIEY72I0nvTg6Y_1792569125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2026 at 08:05:29PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 03:44:35PM -0400, Willem de Bruijn wrote:
> > > > +/* Walk the L3 header at @nhoff: where does its transport header
> > > > + * start, and which protocol is it?  Returns false if the header
> > > > + * is truncated, malformed or fragmented.
> > > > + */
> > > > +static inline bool
> > > > +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> > > > +		    unsigned int *thoff, int *ip_proto)
> > > > +{
> > > > +	if (proto == htons(ETH_P_IP)) {
> > > > +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> > > > +
> > > > +		if (!iph || ip_is_fragment(iph))
> > > > +			return false;
> > > > +		*ip_proto = iph->protocol;
> > > > +		return true;
> > > > +	}
> > > > +
> > > > +	if (proto == htons(ETH_P_IPV6)) {
> > > > +		const struct ipv6hdr *iph;
> > > > +		int flags = 0;
> > > > +
> > > > +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > > > +			return false;
> > > > +		iph = (const void *)(skb->data + nhoff);
> > > > +		if (iph->version != 6)
> > > > +			return false;
> > > > +		*thoff = nhoff + sizeof(*iph);
> > > > +		*ip_proto = iph->nexthdr;
> > > > +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> > > > +			*thoff = nhoff;
> > > > +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> > > > +						  &flags);
> > > > +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > > > +				return false;
> > > > +		}
> > > > +		return true;
> > > > +	}
> > > > +
> > > > +	return false;
> > > > +}
> > > 
> > > for all this parsing: could we use flow dissection, like the
> > > !VIRTIO_NET_HDR_F_NEEDS_CSUM case?
> > 
> > Hmm I don't see how.  That one trusts the caller's protocol and network
> > header. We could parse L2 ourselves and use the dissector for L3+. But
> > it stops at whatever it does not know, and every miss would turn into a
> > drop or a software checksum for a packet the stack delivers fine.  Our
> > parser deliberately covers everything the stack can deliver.
> 
> You're right, the protocol and network offset need to be parsed
> manually. After that it could be passed to the flow dissector.

I posted v4 with the custom parser, since i had it tested. Let's do
cleanups on top? I spent too much time on this, to be frank.

-- 
MST

