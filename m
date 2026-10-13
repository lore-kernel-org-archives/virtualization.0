Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9454DAF4
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923914; cv=none; b=eO9O5xYcPSy6doeRbdp/KGkmZ1Eb21wd8PG8F7cTyPmjFYPDlwQmehVLX4LUMkMsQXwsG5merG0IUQtHjkQM5v1utsfLoqwD/6r0WI4AAYO2eqV4VMKwt5sKEnm72HO/vfBLxZywV+lN3VuFz3Wik9e/sPT/wMh+GdkcBn+6sk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923914; c=relaxed/simple;
	bh=31zs8sR/R/SmtXARin9KLj4k0/40iZWjwag/VVg2T3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=D01mdZHV/nAwZqgLBqbuKpsxaHuVNHFPtxPEAooT/DCa3D8DAu+P9KP4uMGIxMlvfWk6XaSCE8X/bHyWDJzT8vBCwF7UmB78ivmYnjkpbhmkEaxGXDUz+GT2Pfpm5GaGJ43q9ANvYpizd83R0fBtHAfJY7giRJzZcWp1b2vZTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBZ4YipF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBZ4YipF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791923911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1QlmvDXTmRUU9nYKkcaNrdZ6s9iHMpAA+451lF8KTl8=;
	b=KBZ4YipFmwoQtDm7yUuSjw9scp3zzQU2DN6TbQi21AmH/VokPRtQ03zl4IZZ6cgQsJs+y5
	nZphi+KqfmNvQZBmAUCqNDrRdDvAiSjKBJAa8W8vq2O9Z/yizG9heS/TlRehSfyJlgzuNq
	HfHOvyssydysqsgvFY9r9+cfvtoetAs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-kNsp0v5wOSWdataeMNsJlg-1; Tue, 13 Oct 2026 20:38:28 +0000
X-MC-Unique: kNsp0v5wOSWdataeMNsJlg-1
X-Mimecast-MFC-AGG-ID: kNsp0v5wOSWdataeMNsJlg_1791923907
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1ad49096fso9835405e9.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 13:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923907; x=1792528707;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1QlmvDXTmRUU9nYKkcaNrdZ6s9iHMpAA+451lF8KTl8=;
        b=cP2BW0cWAT104mNrcoB1EC62Y3rGG/LoahUGyjCUGArn40odQp1VaiOk1efDiv6tHY
         ZOIz84zqg2R/Qgtd+FBq/LHV73c6kOFhUt/EdiHns5uFmqo+GoUgQdIpCuB/uJqpmzbA
         wpbas18hDOG8cxoKnPec80xO+m4xVE5i69XiDwQNCcJKIhO44fXmXxaiCL+z3yuDPK/j
         neKAGgOjTD1PVQr6d42DHEKB+/T1TBuSarfAXdt1/JM2bMvOKxQaS0So4h0jfMnyLB18
         Rs3/dLcrD7+aPVkQ9TyAwJN8zfZ2Vr2qn4kfTX9D2ykqEfbY4Ew+nbC/3ruR3yTeIiLF
         P7fA==
X-Forwarded-Encrypted: i=1; AKwUvBzTg8RH/ocnYao85i61qVs0UfXiXZEf5bAq4kurasmgz/dNI0iKatNWM4waDoPLwiDUH1rMkPNeowkpDNlGhQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ15lLVIX4HBDtS1auLcXN6U6qeZWeibWHP/YlcHRZBFuB6tU10
	SCYUkp1SWPTn7+5NDK0q+XFk81F8PMkTc9Iluq/smN6mnZXP93I5yseXGt1Awt61gkT57MKIhsH
	3KnJfjH9EXb0JnnJMO1X9c4Yvlw7Qh13KH1BU7tGtrvGDQoyxD32vui47LFRGFYWHP5KL
X-Gm-Gg: AYBFou0CZ4mklyuxvCo7O152TXJa3/5IQ3Z6+vXluA1qGv4/ej8D3Gc4rzeO9n5TvbZ
	cXi5Q2yXwKOnyNbJ+V0ir/plxjVNnRntq2KiILeEkVun/ljfOr6mTleBLxWL3MDyx0DDwT3Uqms
	wzPtp2+yn27kJQ6Zn1DRW/L5erMPnlevVZaC580+KmQmsocvbmHMc5BpnJfjatygtlKcrQXXtom
	9bDOzASPcmdV0gkbaVvAg9l3Kadn82zzOqVZomPT460ynfoMkdiYf+J06ZYAxZhZ9txmK9p2GUO
	JXtCXbQbHNc19fbhznXbZYDoHK2Wq7V2JtHnGWjjgqnxizK3D3NGB1H1qlOJEGv+Yj+r/Q==
X-Received: by 2002:a05:600c:58d3:b0:4a1:9388:7f40 with SMTP id 5b1f17b1804b1-4a193888295mr163024035e9.4.1791923906950;
        Tue, 13 Oct 2026 13:38:26 -0700 (PDT)
X-Received: by 2002:a05:600c:58d3:b0:4a1:9388:7f40 with SMTP id 5b1f17b1804b1-4a193888295mr163023725e9.4.1791923906449;
        Tue, 13 Oct 2026 13:38:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4edfsm7923045f8f.26.2026.10.13.13.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:38:24 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:38:21 -0400
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
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261013163706-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org>
 <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
 <20261013143335-mutt-send-email-mst@kernel.org>
 <CAF=yD-Lz92nGVFab1Dq8M9VusDsKf-ioda8KrZoyh28x3Xtg4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAF=yD-Lz92nGVFab1Dq8M9VusDsKf-ioda8KrZoyh28x3Xtg4Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nVmpT1itwO0_KArSIEHbPG5jbOuuE2j5ip5MNFGcTI8_1791923907
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2026 at 02:32:26PM -0600, Willem de Bruijn wrote:
> > > > > +
> > > > > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > > > +                                            inner_proto))
> > > > > +             return 0;
> > > > > +
> > > > > +     if (skb_is_gso(skb))
> > > > > +             return -EINVAL;
> > >
> > > This is a risk the commit message will have to call out.
> >
> > I tried with this:
> >
> >         > > > We can't easily "complete the checksum" for GSO we don't recognize - GSO
> >         > > > assumes knowledge of the protocol. We could segment ignoring the
> >         > > > checksum then do whatever csum_start and csum_offset say, but that
> >         > > > seems like an overkill for something that should happen.
> >
> > I guess I can add a more detailed explanation about what the risk is?
> 
> Let's just explicitly mention the consequence: non-standard GSO
> packets that previous would be sent may now fail.
> 
> >
> > > I don't see a simple way around it. We discussed segmenting here too,
> > > but that requires intrusive changes to all callers too.
> > > Alternatively,
> > >
> > > 1. call segmentation, but only to see it remove the SKB_GSO_DODGY and
> > > thus verify that the TSO/USO packet is valid. Still drop otherwise.
> > > This also does not add overhead, because it would be called later
> > > anyway.
> > >
> > > 2. a failsafe off-by-default sysctl + static_branch that skips the
> > > drop when set. Messy, but so is the situation we're dealing with.
> >
> > Tack this on top or do you feel it's needed straight away.
> 
> Not urgent. Can even wait until a report appears. But worth taking a
> look sooner if either of us gets around to it.

Maybe if people intend all this for stable, I'll feel safer with this in
there.

Just to make sure, the branch would just short-circuit all checks, yes?

-- 
MST

