Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31205581FD
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925033; cv=none; b=JBd3jQTe2/FnO5oQHJ3Kz2cXMzz4Uv+x0pz3LF/sCkmP30K2/QCm+V/vb5YTNVMbeKYXDH06vi2kKrFF1Cdi4z9RwUmkkJEKHufj51vaUQ+uR7nsA7ZbL4Y7juKVUTYlP1Kpx8elvGH+WqJsxK16vNKbkBnz98TheRndEn+dGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925033; c=relaxed/simple;
	bh=4+SSE6EU8udPXmhUPtFyuoXGs8hahHA+j3OUghNKKrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ReXyWjkKaWvVMtgww/0wb8FeWqzX9YbDT6vWs52ns4RFfjfQpm4LAELWb2RtZo6SsB2h5TrvdpkVOG44PU9cQ6tnF7nsfqTZ3JFgHOHIqp4VyrkvLQiLSOz3hf2wwiPaTqUpYCBfPj3BVB7mxV38YYr+gsI6EmYDd1vLS1l07ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOnrLfBz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOnrLfBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791925028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwPXkeY12Wi/XtJvw9dMwqYtHY2GvFteBkFGECaSB9k=;
	b=LOnrLfBzMPVCHWEFKQSEj3y1YjT5/HW/cOepBeQIY7NPqyIa/R6wnGpV6dJkY383XaS9YY
	yMdRm7bMxc6qaILJWwP+LEe8pk/8efpK3i2xGXasv1PruuV6vKloYUiQanoTg7GrFFq/ME
	EPlgGtH3pawg9i8sdeM2YJLVmOUGYXk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-ElgQfQd2OFeHEVAlsXVtGg-1; Tue, 13 Oct 2026 20:57:07 +0000
X-MC-Unique: ElgQfQd2OFeHEVAlsXVtGg-1
X-Mimecast-MFC-AGG-ID: ElgQfQd2OFeHEVAlsXVtGg_1791925026
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a01d1fb07bso2957485e9.2
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 13:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791925026; x=1792529826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pwPXkeY12Wi/XtJvw9dMwqYtHY2GvFteBkFGECaSB9k=;
        b=wUfqNyLjDMBjZ46vko83wHWFXU/fSJSpwX5HR5KDhig/2vl4L500UrghUUPhtIU4my
         qmsx6WLirbBFeY7RXhhN3jz3/EZ54s9WfTlRGLSHwt1MN7aUXXp3+Qiz976tGQoYjPAf
         Ubvo/dSKi2xq0+JaxPH8FG3mllqGsR6QyQTKGIAAfIBlKhBnVN0jjrfxgSFEVbm/ZmIn
         7LhCa/LQGyivLJKsVlbq9gZPwkzuJ4o2S3/Wg9uuPHjI6AyNcSWyoyQOGIjCzeKjm/Wy
         VDf/EilB8sDbwJv0cDE9Rn8Bx3TjrdfxAZL1guRUeOLSFPwiDexOVVy0U45YWKpP2o7s
         jJ5g==
X-Forwarded-Encrypted: i=1; AKwUvByjLTPx4WI3gOVUyVVvafjAdzEwNbleMtEISSywWFKDLZZ1PGhf4eK/S6JMp9QWKzmsQ60iFiHBljLh6S9b0g==@lists.linux.dev
X-Gm-Message-State: AFq9FYLP/ZU0C8QWMEz9qEPswHbumBWV+b0zgcR6GoBun5O+2Fk0ObDY
	a81/JV2JJFGo1rvmJG483qi8PXmlMKO1szgkC9VV3RILoowPdZs+bSbGRV1erVtcZTstbzJIG0x
	/s2eG4wqn31QkbBgnMenp7yR/0x+wtpE66RRnySDFnP7W3KvUiBrxIb5nbOkZpS7O42ey
X-Gm-Gg: AYBFou1gvq1EnOZAyu2zqX/41LkS9koXUzDZ+8worK6opgjjaH9RWfMLhGHJcAsdn0o
	WcohOqVMisv0yc1Ui/R8w6h/8vKmUcXdzFABd1AE6oJodg3dtN2GMZ78sT3AfTO4ou7C23q+ezl
	u3ZL3UZi+xkHVhB0Onev74N2OhIiTm0hYtQ51/E0LFM/s5Ps8MxAWahHgVj3w+vSyiWC8qvQHm/
	mHlWJuaLIQS5Mqp3OfgAu6cS1GjOtbLrjNWM2o3sT3dnknaH+WMXAyckKHVl6F7DMMYVjEOsjLY
	o65iF91RDr68w3Vx2gFDUkcLTJzASs3nxv8Yqx/lvJs6zCfPRlRoyH03gAAe0BDtWtDnew==
X-Received: by 2002:a05:600c:4e47:b0:4a1:813f:2a65 with SMTP id 5b1f17b1804b1-4a18e4b1a6fmr240282285e9.15.1791925026057;
        Tue, 13 Oct 2026 13:57:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:4a1:813f:2a65 with SMTP id 5b1f17b1804b1-4a18e4b1a6fmr240281265e9.15.1791925024016;
        Tue, 13 Oct 2026 13:57:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2387988f8f.29.2026.10.13.13.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:57:00 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:56:56 -0400
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
Message-ID: <20261013165547-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
 <20261013143716-mutt-send-email-mst@kernel.org>
 <CAF=yD-LLNm1K5r37-y2thyvLJN58ruffUUHy-6BUh1CGVmep0Q@mail.gmail.com>
 <20261013163109-mutt-send-email-mst@kernel.org>
 <CAF=yD-LtGVWrGzs2shhfxzDdwfid=1=TYBcOVQ8Nt10gAHpjWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAF=yD-LtGVWrGzs2shhfxzDdwfid=1=TYBcOVQ8Nt10gAHpjWQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yw4ERzOrofa8stkB4LTR00JtxX3LY1-bkUuvpqGBA_Q_1791925026
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 02:54:24PM -0600, Willem de Bruijn wrote:
> On Tue, Oct 13, 2026 at 2:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 13, 2026 at 02:29:53PM -0600, Willem de Bruijn wrote:
> > > On Tue, Oct 13, 2026 at 12:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 13, 2026 at 08:41:19AM -0600, Willem de Bruijn wrote:
> > > > > On Tue, Oct 13, 2026 at 4:58 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > Allowing untrusted hardware to specify csum start/offset for
> > > > > > CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> > > > > > outside the actual checksum, and depending on the setup, the networking
> > > > > > stack could be looking at the packet both before and after the edit, and
> > > > > > seeing different results.
> > > > > >
> > > > > > Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> > > > > > completing checksum") validated all known instances where this
> > > > > > causes the most grief, but the real fix is to make sure
> > > > > > that either only actual checksum fields are ever edited,
> > > > > > or the checksum is completed before the net stack looks at it,
> > > > > > so it is always consistent.
> > > > >
> > > > > +1 on the general approach of performing the checksum offload at
> > > > > input, unless the input can easily be validated to be one of a few
> > > > > common protocols. That greatly reduces the risk vs my previous attempt
> > > > > at trying to drop.
> > > > >
> > > > > Since we do not know the full extent of grief, I think this too should
> > > > > go to net and stable.
> > > >
> > > > I think it needs a bit more testing to be frank, I do not see it
> > > > wait months out of the tree. So if this lands in next before the
> > > > merge window, we are good I think. If we miss that I will target net.
> > > >
> > > >
> > > > > That would mean initially a single patch that
> > > > > touches as few files as possible. The helper function in
> > > > > include/linux/ip.h and conversion of existing open coded parsers to
> > > > > use that can follow up later in net-next.
> > > >
> > > > I don't see the value to be frank.
> > > > What moving code between files accomplishes, I donnu.
> > > > Squashing things surely makes review harder?
> > > > Does your backporting system really struggle with trivial
> > > > dependencies like this?
> > > >
> > > > I can drop patch 2 and will if I am targeting net.
> > >
> > > Good. This is not about "my" backporting, but upstream stable.
> > > Refactor patches do not belong there.
> > >
> > > Since patch 3 might have to be backported in the future if a serious
> > > abuse surfaces, even if you now land it in net-next, it is better to
> > > not depend on other patches.
> >
> > Right. While this is targeting next, I will reorder it last in series so
> > it's obvious for people it can be dropped.
> >
> > Thanks a lot for the review!
> 
> Of course. Thanks for the fixes!
> 
> I would open-code ip4_parse directly in "net: resolve uncommon partial
> checksums at ingress". It's not a lot of code. Then that patch stands
> on its own.

Ok if you prefer, except I'll make it a small inline in the same file.
Easier to then dedup at the end.

> And then optionally squash patches 1 and 2 and place them at the end
> of this series as one dedup patch, or send that separately later.
> Personally I would drop that entirely and leave the existing code as
> is. But either way.
> 
> >
> > > > >
> > > > > > This basically does this: checksum at ingress, except in a narrow list
> > > > > > of specified known good cases.
> > > > > >
> > > > > > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > > > > >
> > > > > > Michael S. Tsirkin (4):
> > > > > >   net: add ip4_parse()
> > > > > >   net: use ip4_parse() in receive validation
> > > > > >   net: resolve uncommon partial checksums at ingress
> > > > > >   net: account for ingress-resolved virtio net hdr state
> > > >
> >

