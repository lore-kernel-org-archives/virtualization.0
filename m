Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE78B549390
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923797; cv=none; b=qtUlZoppxcl0GVZNiKlwUybZCYU2wEgClcJEJT8WW3DR56S0iE75xhD4BItSy3Xxnhi+pv68uGTxaz6edkJEb9Vf/VpUwfjCpTP2I1svJwS9ZiAOBvdfTuGPIgBnGWN4OGGxWk6xmDpgoRxnHgskwDrfjy0FoJMsPzzeuX0BqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923797; c=relaxed/simple;
	bh=qr393F5r/2jQO0c4JjlHJv+eISvyBv0hBTxf+c47mwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rO1TpAkymccqTvO2ZZAhlSlbehYxWjcXCyV+tGUppfMd/dcta+bkDbjmi+M576BVSSJapXM67PDPV/4vIIxo2CkH/3sYBy43tTtB6Zu/An+ZgHVBCc5wD6G9EgZ3AA03YcdpLntSAzOoDmyJ7lX2gCeY2OClh4G+PrJgtNUBAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQLgyQJq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQLgyQJq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791923794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gob6f96K1jvvU2I5Uy71RxEi5G9EXcKMzspTIBE+Z0A=;
	b=SQLgyQJqyS8yonQvvJTxs6Hvi0gkZJK30i+yjYXDx2GRMfOjPWHPOaD4hI7KaxpfShpz/w
	8GdzKADgtiJ0EhXR9vektpg7PMteYuTsVYmdpYKQUkkU10E3xoTx3uHIGZThUpCeVb/Db/
	sAjTppsY8UXaN4jWJvtP8Hy7PPC1qko=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-2zgGMQ-4M_qmB9nqLCAvsg-1; Tue, 13 Oct 2026 20:36:33 +0000
X-MC-Unique: 2zgGMQ-4M_qmB9nqLCAvsg-1
X-Mimecast-MFC-AGG-ID: 2zgGMQ-4M_qmB9nqLCAvsg_1791923792
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48589603501so2409191f8f.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 13:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923792; x=1792528592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gob6f96K1jvvU2I5Uy71RxEi5G9EXcKMzspTIBE+Z0A=;
        b=RKuTWW8Qtx+h7fkevRUl9+rIuX0Ekme+bgXmfZXeaIDLcFeUHUR6r3/kYWSnvBVSjF
         dXOtaKI0VxxaM3pHso6hT9KThF0J9AZVOicPh+Y3AgE03WI/oR/kGwbWm8uvfj9PfpFA
         X1x9LLgO8wSCYxXvQ2jb0CSOE2mW4otZqKyKmqvf9I6+dBnoVr5o+EauwmgXT/6hvRW4
         iXJN4FlmS1DwT3MJDRQp8bxDMrn5oAA0VUjMUkWFR9eVEQm1YVnyXhyYpB+KM60zujUI
         JEqDBeH+NvcDFB2ft1Gs9QiBZaKdvONEpSBjB/BPXP7z1OcdBt3ZpaKfRCBbQGF/UzTi
         eslg==
X-Forwarded-Encrypted: i=1; AKwUvBwQWZk5WTgci23aJDrvhIsRoTqo6emK8zn1NViKQ+oCG543s9PVyuefH5A6G3dtqsJOrT6iFwfcZvYcr7CxAQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLG099GuN8WD6iqj1bio1fHKX8K23rzF9ffBG5ZajwzYXdGeQg4
	uZ0XSa13pYpTw4vWygV8bFzqSz4FO+YXhyFcE4D1YoJdIx0C8iHIcwXWcmbGcw2YzWq7HD9GMRU
	e95SamCzvEHiI2SHFts6s9xVqqVW4NKPYj6KePacMp+LFMAaWvyKYjDA1tXn3ZF36dRHZ
X-Gm-Gg: AYBFou3VjCM8dxMNDSm2kRC+O5C2qafoRAk33rN6l0z6CwYJOy+0319koOf4OnemKsV
	5cNOex0n+Ej0ov/GCyb+kkYfpBeblHvAm7q0QIvtnVrIjaYhssrZinwNnsZRRJrenxJY567dVHg
	EVAjeaYWgH4OZs/zTzLLvjRpZnGRj1hPDbNGLUzbgYhNHSb312FMcgwXMD/gneaK/i7DeanVw5R
	UsYK3F79oQXfl1MUDqNrUHbJEZu4ExE6KIPCahpL6pp3iUX6MZePywLNbfshFd+7lsoLt+6dTdG
	dUNtWVDU9B/6PqqZFuZRAjNSXP5wcYjqNsXf9GA0ABtZMnds/KaJXb8rI6V6s8lMLFcTbg==
X-Received: by 2002:a05:600c:4fd5:b0:4a0:5b:7bc0 with SMTP id 5b1f17b1804b1-4a18e49a7e3mr282057215e9.21.1791923791997;
        Tue, 13 Oct 2026 13:36:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd5:b0:4a0:5b:7bc0 with SMTP id 5b1f17b1804b1-4a18e49a7e3mr282055705e9.21.1791923789690;
        Tue, 13 Oct 2026 13:36:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f318c31sm158812405e9.3.2026.10.13.13.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:36:28 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:36:25 -0400
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
Message-ID: <20261013163109-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
 <20261013143716-mutt-send-email-mst@kernel.org>
 <CAF=yD-LLNm1K5r37-y2thyvLJN58ruffUUHy-6BUh1CGVmep0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAF=yD-LLNm1K5r37-y2thyvLJN58ruffUUHy-6BUh1CGVmep0Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6fk5Chngl6Lk8z4I_F11RTzdX_IoxMXSGO2Uy-mblxQ_1791923792
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 02:29:53PM -0600, Willem de Bruijn wrote:
> On Tue, Oct 13, 2026 at 12:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 13, 2026 at 08:41:19AM -0600, Willem de Bruijn wrote:
> > > On Tue, Oct 13, 2026 at 4:58 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > Allowing untrusted hardware to specify csum start/offset for
> > > > CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> > > > outside the actual checksum, and depending on the setup, the networking
> > > > stack could be looking at the packet both before and after the edit, and
> > > > seeing different results.
> > > >
> > > > Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> > > > completing checksum") validated all known instances where this
> > > > causes the most grief, but the real fix is to make sure
> > > > that either only actual checksum fields are ever edited,
> > > > or the checksum is completed before the net stack looks at it,
> > > > so it is always consistent.
> > >
> > > +1 on the general approach of performing the checksum offload at
> > > input, unless the input can easily be validated to be one of a few
> > > common protocols. That greatly reduces the risk vs my previous attempt
> > > at trying to drop.
> > >
> > > Since we do not know the full extent of grief, I think this too should
> > > go to net and stable.
> >
> > I think it needs a bit more testing to be frank, I do not see it
> > wait months out of the tree. So if this lands in next before the
> > merge window, we are good I think. If we miss that I will target net.
> >
> >
> > > That would mean initially a single patch that
> > > touches as few files as possible. The helper function in
> > > include/linux/ip.h and conversion of existing open coded parsers to
> > > use that can follow up later in net-next.
> >
> > I don't see the value to be frank.
> > What moving code between files accomplishes, I donnu.
> > Squashing things surely makes review harder?
> > Does your backporting system really struggle with trivial
> > dependencies like this?
> >
> > I can drop patch 2 and will if I am targeting net.
> 
> Good. This is not about "my" backporting, but upstream stable.
> Refactor patches do not belong there.
>
> Since patch 3 might have to be backported in the future if a serious
> abuse surfaces, even if you now land it in net-next, it is better to
> not depend on other patches.

Right. While this is targeting next, I will reorder it last in series so
it's obvious for people it can be dropped.

Thanks a lot for the review!

> > >
> > > > This basically does this: checksum at ingress, except in a narrow list
> > > > of specified known good cases.
> > > >
> > > > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > > >
> > > > Michael S. Tsirkin (4):
> > > >   net: add ip4_parse()
> > > >   net: use ip4_parse() in receive validation
> > > >   net: resolve uncommon partial checksums at ingress
> > > >   net: account for ingress-resolved virtio net hdr state
> >

