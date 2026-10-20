Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526479;
	b=WnBJUxRE1NAG+JtnRKVWYp+33Fsjn7RPY8SAT8BsUM1f50acacCUuPKmzlygJGKk0Yjm
	 kZXHqEHF6E3/igwhJAsGzQl7uUwswRX+pYpphJTNfvijSyNMtyedcD7lX1sDa0wQGFavJ
	 rvdJ812H86NH06p9k7hA1gzSGiiSGwPrkgslx9lfg4gfTuYigTXgGJ7gJJKQAfvT86xQe
	 StGiCCphXe30l8JR9JG9LmPeyGKv7LoJL8rfN6+TtJeLiENfVkkye7jPvCZnK1fWI1QnC
	 Kn5IwpDWONNL+6TGyGEvgA7vPlQJsS89mmrI1uBTp2V2ta1f363at7PYwI5ghEMHwfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526479;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=zI4sbiHutLhUzts3GNlZ8BZlCgpCPi+nYzjoB3+wLIE=;
	b=jHKjU8RCo3xOT3uCdl8k2p/5zauJvxvpqEjf3h4caoQhXy9L+VGPBeuVVBDHsrsvEBCw
	 ZVRa1ySGGYgmgzCyymjJzRO9qXNAeMhU8AbqeBzMvDUCjsMSeaf+JLtI3Iml7nsd2uBDy
	 bCey0aFBmaLle3ShMs7xDw+UB1+kuDjhCB0Li+n8ubYLm2iZPDseSXJzuQkjuUUFgXdpQ
	 40KjZrVynJR8xJzUQ03ew9ugtOrJ449KtyjC9FyE/yrwkxkW9uL0OMNgytAz6o6PTcMKO
	 cGI72uqQ9EZ6aqJ+5qCtRp3E4tRB1ks4ItAogNJHtQf8r8qCTRMUA32NMh+IFfLfYhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="LWZoQ/Jn";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A83606A32E
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 20:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0A83606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LWZoQ/Jn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792526477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zI4sbiHutLhUzts3GNlZ8BZlCgpCPi+nYzjoB3+wLIE=;
	b=LWZoQ/JnI4eVSHRA4zmEkUm9ZAdqNN0k8jQXeRQ6j6oWFAli7GzbXxAPdlMrZdmdplCdfv
	h3m75uoYm+jIbWW7EP0dg6x4eTgVVBF/sLeWKi+4796oaYG4XoXIsJZ706XM/6Wa+8EcD4
	5dxCw5XOPTG0+0+juYLstxhcVmO+4/I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-C3IKMvhSN1alm2CnWeNJlQ-1; Tue, 20 Oct 2026 20:01:14 +0000
X-MC-Unique: C3IKMvhSN1alm2CnWeNJlQ-1
X-Mimecast-MFC-AGG-ID: C3IKMvhSN1alm2CnWeNJlQ_1792526473
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49953abe51fso27717515e9.1
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 13:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526473; x=1793131273;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zI4sbiHutLhUzts3GNlZ8BZlCgpCPi+nYzjoB3+wLIE=;
        b=ooDpnP7fyzjZL19ZGeWu+h2XN/PFbesdYKE2dLiCU0D6s6NlPSvladLHFUjfgmqlm8
         BzUY/0SPdUU3TGaff50jpZjTegdRJelY9W49ZqCyAo5mGXjOeIRNmXcf30aNCfdO7LP6
         hiUrtr0Ii8/q7U9sctv5M73IQwAD4ts3Qxt9MRQWFEH9nwz6jcEgMjQUNmWIzldckfEl
         7kEToJqfiFj7H5CH4NxIKkC3xKtvGehrIs8R2XHcRZmsN9c89RsUvI+g9iZXyv59RYGP
         Cm3WA+4ATFMF7YoKiMIAaeKFQP/P7HPhvAzBMKibnYHpLhxCBBPiM1l66MeC2kxe7Zsn
         2HIw==
X-Forwarded-Encrypted: i=1; AKwUvBxZFl3JFST0UC5zt9DXRLvviLRNNvH8uZWi6re9cQMSM9qXtZX09aud+AhUcBVCidzu2e1xebhMIUxvm2bw6Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLRsOneDfKZTcYCH5QWfEqVQaI+lpRMRpuoOi+NUB8aPgTdBF8l
	MOfDRXzDk5nwdXeOj6M3yFHppbFGgNYAyRsl2vabm5u0viUW2Ef47huS98eMdhENx5i4vvbkaXY
	EempQstkry1wCEFqXiiNdZOehDNP+Bq+h8jIezX3fjPH9c6MS3zE41lLDPSMJ4ikNRQv6
X-Gm-Gg: AYBFou2UzYz5xBO/ai8hQzH6mxTo9gRj8gBBIkyugRdiR76Q5uKuRPhE4u+y7UOkEDr
	KPT7DM2kofEDsa3VNBwKvc8DPCX7AUFloZpW6EdK8bXU+1WfNaClCRIw9VZjn8BSv0so1fU9DD9
	7tyzK/sXtlIRtDn48ifk3BVrs69gWiV3MaOYUZ1geuT2DOI1y+JCJQeOcsRtrjd8Mm0Pcfbh9Ev
	U47dWkOEqophxc3ICoUhilhA6VzJj2Cg8RQFROMC+NiPpc6QJl4FpPjobBkAja7pbehmtSjUHKr
	qDHP7Mz93xDqeP7R3yuWH82wJXVlPSJIQw4uvbPeCtPdfXHii1dB1oUIUeT6RuJhjC+QFg==
X-Received: by 2002:a05:600c:8010:b0:4a1:fbf8:55c9 with SMTP id 5b1f17b1804b1-4a1fbf8577emr14172755e9.33.1792526472946;
        Tue, 20 Oct 2026 13:01:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8010:b0:4a1:fbf8:55c9 with SMTP id 5b1f17b1804b1-4a1fbf8577emr14172305e9.33.1792526472489;
        Tue, 20 Oct 2026 13:01:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb96bc7dsm22498245e9.15.2026.10.20.13.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:01:11 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:01:08 -0400
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
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Message-ID: <20261020155917-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 80pmlfGw0J_J_HE2BId7gTVelf8TV0N_R-NJeyNXSt0_1792526473
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > The ingress validation as implemented by the previous
> > patch is stricter than what it replaced: GSO
> > packets whose checksum metadata matches no transport header are
> > dropped, and non-GSO ones get their checksum completed in place.
> > Such packets used to pass with the metadata unvalidated,
> > and with no overhead.
> > 
> > I judge that this should not affect any deployments, but there is still
> > some risk that it does.  In case a deployment depends on them anyway,
> > provide a per-netns switch to get the old behavior back:
> > 
> > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > 
> > The default is validating.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
> >  include/linux/virtio_net.h               | 23 +++++++++
> >  include/net/netns/core.h                 |  1 +
> >  net/core/dev.c                           |  6 +++
> >  net/core/net_namespace.c                 |  1 +
> >  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
> >  6 files changed, 110 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index e586e17fc7a5..b1a1c4714b22 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> >  Default: 1 (on)
> >  
> >  
> > +virtio_net_hdr_csum_check
> > +-------------------------
> 
> virtio_net_hdr_validate? In case we do have to add more validation
> later.

If you insist. My worry would be what if that validation is again
user-visible somehow and we need to distinguish users who want
to disable that future thing and users who want to disable
just this current thing.

Hard to predict the future. But I will go with your intuition.

Will check the rest.

