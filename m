Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DC54CF72
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923435; cv=pass; b=WFhFiOg8cZZ9nrdCinT/GbyZs7hgXvQrm+C2PAhmyqxUQgNswnh8GCwZJgLr4ySbfO4YzVcWZ+3CusiBDULAzQiPyKUPwHKUrxB9egm9N97BeptTLI0llVizFA/mFXhZbDWjzcs2R7k67O9haFkA0MmVNBQuHuGqAzMkaTRCYsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923435; c=relaxed/simple;
	bh=v91tamJ4lur5vC0yoc8PA+H+9sgMG/EoWrw7MxUej9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTDbaf0UPIRjCCglMjEqEFoIVWiLu5RCaEsto6MZp9zGWnC44g1r/vTPRl8Y2bTFFwxGvOt+S/Cl47bNOBr0z72c43ueRVT1P47vTSxxS9mSE+vVb/ecQVtgjPNMpVsSxK61LZzPoD6gTRyH9kJVUZ5uDYU6Kxqu1gaBYAZ7mY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTQr/7uq; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTQr/7uq"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-677af43eed4so3076841d50.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 13:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791923432; cv=none;
        d=google.com; s=arc-20260327;
        b=s66Bg8ljbQhOzivATawMcdstGpxDKUJqRfO0JXpRxSjVBzkxByyZ6YztrLT0yLold0
         S4tm0jMGH1f2qujhVnjpHhzz39OTmvkwbe7+WDXMwNzne1WMZsNCi+6dv8Q3wijkYu/8
         oP6FybJuKlwADuRWObr7cXXHqF6qTxo+rzf7z63x8IIMYGua9zcodMwXxW5+/XFYfR3a
         9W+3FxfbwWtRRlIA5AUJW/xLjQ3kaa9yOZMdN9b4KGR4ZVUjhb/5h2qFLYG8w8yTBwF4
         Z4qe3Gv0QK1SPFsJuDZecNYsrAjvR2wEsxjQvL+OxUmgtbJ+YUgVTBiL7blPx2YFbDFp
         0LXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZ4+EgAKfEgLHQ/9kN3KZ8YlHNWXSOHDiqf8U2cJ1wI=;
        fh=ub12uKknBvY9LeJnw5cJWJCemv3zkfgjkTsh7P4JEw4=;
        b=WRtk3S2LhCpC+B0cjVSCw0YsozXOzJgbAa5TovVfGUOgR+qzlHytNuqJrnqEc8gPPQ
         ggSoxElXkfXxUkRwEdoC9MVl+JB6HW4FlhhjTVc8S5gjGgIF8jLWIh8vQR4bcqfTmahd
         gMW1ykGhIzAVPb+CXWawUbpNNVwpjqFSfNdjr7fnBSk56Shqc4tJ5pZTcmilx9E9/BtY
         xR7ZiSGGbaBcBP+pgBFoAduRwXrtkAEE/0I34YFuyRL9T5FqKSZraXblKifcVp6LIypT
         E5pcRlPyl0k9+cz8Uhps+ML5Xgo3x/pXNqxgeHsqSuto/knxhTVUr3v5QEqZahzQVlbz
         XFWQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791923432; x=1792528232; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PZ4+EgAKfEgLHQ/9kN3KZ8YlHNWXSOHDiqf8U2cJ1wI=;
        b=KTQr/7uq8Jd8UsbaamObVs2OqDD2c0mAikMc1RnNFiibrNG2CsAS2977n5H7ar3Rjw
         uZO6FYCCmuqOM0514KeJkFEi3ofa8ZEUEKbQghEAncLGdONCZh87y1CdW4ZKeL33kCu7
         qALGWwLEFCPrFUPRJvDg2n+oR94VJcoVVTRHMmKnaoPRHOBD6NJs/WfOUmWpvJq2Fz5i
         G+ktbhNEnZKVX2dfCMks7tF8i4LlR9RhxqMzL7CWsxnlfR35LUtsS8u5HPmKCGCUnvH4
         35lMaeTbVVDAVIvQ8nHTLcHJEOiHxQSEFtPfSeFX9RQtyprXs/nFb+FoXmiS8AXsqosz
         tKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923432; x=1792528232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZ4+EgAKfEgLHQ/9kN3KZ8YlHNWXSOHDiqf8U2cJ1wI=;
        b=iXbubPMuikpMFLMEkTQnO1ZSW0X6DBtrD2Hfq4i/QA3+LqLYHG7Xa5TVbzuqtZ6QN2
         tFgtc2eBxajT6ZWnpe+oo2SguNyjLiuQBi8Qs0pB1febp9h/eSo02/xdR3+z6SLfWd/3
         CAJlx8/xYFIyWiMlEkeucAbo1UgR1tC7BOe5Xuvm26uJjKuZjXhyTK5c1wZ3qfxIl0Jb
         M+5v4qv1+uGvzjQCKIvkLqdTlQSr6D/5djcII8pPwnIsHHSLWMOgOFGbKkp+oGcCQAms
         sk+qs9/VngcY3ecd8dizdLwqYUvg6tjj8KmYdzTPuttNdBxFHe1kq9ECDTHg7bCwLsQe
         eGKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzu/pSsT1Y7XqL1wzBuCiFBfwkeLqnVG3VI+QdmNbcn+ldy5YNXTtcvSzC2oxRj0HTxdPRZcVs0fH+1zIu2NQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKc6/02/EFgYbaa3oW5iWBlMO/7pCGYcJWX6bY8xwp5XuTsBkHL
	WL/C9ZJnbTheDX43nO8BZ9GW6K57GQzqnYfh9YoRAlt5o0bUWihHhfemCfIZvKzRbAn2wzXUiMh
	D66HTQoGE3HndKtL+g/DMDCTwL+FG9G8=
X-Gm-Gg: AYBFou0BiHCcEjN/t9MbzrjIjZM+7XMsXFqSHkn7Is0HOpVrKr/Gy7ubVJmuxDPIP4Q
	OiSqTsLE4DhT5adQ/8RUB3xyiPbDtiE7CLBAiI9jXtOm4UoQjyXc7LyZsQjW3gois6LCti5yfuN
	QhdIIdhgo1UVd9Tsa1XvI9pJZSStkQfhAq2iXDc/bL0FANA+c+zjIHRiOrV99lxZp3SBK0EqZqg
	EkEEcVpRThAQCp/TUh5qekHkPkDuW1guKWFqIsKK0P7rVTrF4Ht7hmmfcZ6jl+DDY0bMiBM7exm
	WwO/2B+EIOWPSat5C+Qx/6gHJ2bJqk3v/GMcgsDwRoXkQGH7xWy2sIQiAygpM5CZqWDw5/hWdlX
	PrRJ2gE19Bfpbh7Q0q1CAQJWu7rPm/7rsfD3E5BGG
X-Received: by 2002:a05:690e:4148:b0:674:cc60:9ac2 with SMTP id
 956f58d0204a3-679369ed352mr4676766d50.46.1791923431579; Tue, 13 Oct 2026
 13:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1791887415.git.mst@redhat.com> <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
 <20261013143716-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261013143716-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Oct 2026 14:29:53 -0600
X-Gm-Features: AclHuK8wZI7uIJlX-2etJDs8Vk1Tx42gw4A7NIBFItdYxL1q3Y6FeTRL8Oizybs
Message-ID: <CAF=yD-LLNm1K5r37-y2thyvLJN58ruffUUHy-6BUh1CGVmep0Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, 
	Paulos Yibelo <habte.yibelo@gmail.com>, Chris Arges <carges@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Oct 13, 2026 at 08:41:19AM -0600, Willem de Bruijn wrote:
> > On Tue, Oct 13, 2026 at 4:58=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > Allowing untrusted hardware to specify csum start/offset for
> > > CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> > > outside the actual checksum, and depending on the setup, the networki=
ng
> > > stack could be looking at the packet both before and after the edit, =
and
> > > seeing different results.
> > >
> > > Previously, commit 6785011f8b16 ("ipv4: validate checksum_start befor=
e
> > > completing checksum") validated all known instances where this
> > > causes the most grief, but the real fix is to make sure
> > > that either only actual checksum fields are ever edited,
> > > or the checksum is completed before the net stack looks at it,
> > > so it is always consistent.
> >
> > +1 on the general approach of performing the checksum offload at
> > input, unless the input can easily be validated to be one of a few
> > common protocols. That greatly reduces the risk vs my previous attempt
> > at trying to drop.
> >
> > Since we do not know the full extent of grief, I think this too should
> > go to net and stable.
>
> I think it needs a bit more testing to be frank, I do not see it
> wait months out of the tree. So if this lands in next before the
> merge window, we are good I think. If we miss that I will target net.
>
>
> > That would mean initially a single patch that
> > touches as few files as possible. The helper function in
> > include/linux/ip.h and conversion of existing open coded parsers to
> > use that can follow up later in net-next.
>
> I don't see the value to be frank.
> What moving code between files accomplishes, I donnu.
> Squashing things surely makes review harder?
> Does your backporting system really struggle with trivial
> dependencies like this?
>
> I can drop patch 2 and will if I am targeting net.

Good. This is not about "my" backporting, but upstream stable.
Refactor patches do not belong there.

Since patch 3 might have to be backported in the future if a serious
abuse surfaces, even if you now land it in net-next, it is better to
not depend on other patches.

> >
> > > This basically does this: checksum at ingress, except in a narrow lis=
t
> > > of specified known good cases.
> > >
> > > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > >
> > > Michael S. Tsirkin (4):
> > >   net: add ip4_parse()
> > >   net: use ip4_parse() in receive validation
> > >   net: resolve uncommon partial checksums at ingress
> > >   net: account for ingress-resolved virtio net hdr state
>
