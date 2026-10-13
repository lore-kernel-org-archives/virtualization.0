Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C25476EE
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924904; cv=pass; b=u9wSY8wdvQq053kyEMC9p+O9XiJ+y/OkSMrgJfyyEFe9D6os6cu5G/Ih1sxiTqI8yphx/wdwUQJwSOVLXj54+xEufJ0D20rqaizUnlodCC/x6KlE0+NZdZc5UDvefrtSjwyZ69o+Wff2rwACcT3A8LU0HnTu/+IK4ueikClASSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924904; c=relaxed/simple;
	bh=JZCuofIpeJapFWVfdF+8VkTikMT6xa5Y9R7i90xDuFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNLLvff/UueKZr+TyhCLklnG2Wa9V7TsTHQ//WAgrzLlnMaWvif1wAcipIpJ+sHjLBfjxqM7hapJL/SJprn9KjRH9PD0DRhR0J9aQA2PlAY2TZgcK+Iku8V0qNMtv2GyxESkUNA+385nZ6WcDMcU3aNrcAenO9q13FEZSZizvww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GE4XEU5Z; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE4XEU5Z"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-677aec6ddfcso2891599d50.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 13:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924902; cv=none;
        d=google.com; s=arc-20260327;
        b=RD+nMsH4c8R2DYRKUa6PiSVZK6Bu+OQlZmBZ4ZhRKkXMD4zviGbF/SBXc0kK0SkuLo
         iTp3mgO+wBR4gbCIChv6KBTP6t+TlUvzCjG3vFEbqQOd5DITOgjzoIPhEixrVUh6f7iD
         u/8HSYFd2rMfDzdEUosnaTan4ED1Ykdn2ArNH/ytXBFPpt5a+I2nnE2Yzll9CqhAHyfT
         3lxLUWlj+h5qNSzPpStQYpVNu4n3j3oAyCCR1lALLY43aP0if4U0+GuMZcT39wKUycP0
         ZCgBa6WPzmLgFEw7xlV7fAXXTUrQKvxoUimmCCPoMXRUOl0jSqlacAyrBzFPu9YDn/FH
         cjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tDPPTDqcsXaSDPkJD9YhM9lPuiQdYmryZ8CiiWyAbR8=;
        fh=Znq99xk515gNeL/ilel70J2j7crFxyWPaJhPZV6gzDI=;
        b=n9HwGQlNeyXe9yQLOzgo5YVqAo6xMJoRnls0fn/zATcG3EqSS5UpfeLR3bDXxjxKTm
         XMKJ2RMw5X1VjMC2IO3/QXTKQDmNFSQbNPreakZnEeEz9322/DZkeEohgRZcrCtr7udm
         xJMhEQPjzVow9o6i+MeGjPOpT6qturMVy4u+x/4TW9mfGGPoKDVDltTe1lqDcmaaWpwg
         7irvAMI0ZnZyqn8OfDsgowrbcy1Du3XkhJPnd2+KKOoETeT6QdCn8stDB1UcYK6sY1CK
         34Txn9XiwTNgeCLHVBJ0wpaDlNuhhxy2NoE/J+FgTtRXj5Dxb8VwXUIMsspxj6+TOpwk
         Gflw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924902; x=1792529702; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tDPPTDqcsXaSDPkJD9YhM9lPuiQdYmryZ8CiiWyAbR8=;
        b=GE4XEU5ZSjb350NrLqdL1sdijJFH9kjUsPAX8IfZH54BALvNxKb7Si6P0gTCH52b5J
         CFehqAw9FFZEqOc+86pcu3IDTcuWpeUtgwhSv2UArYiwA97oLSDVFrHGRBrXCRAsTz39
         V/Iv07IQLr1jO2WK5vHOZsrPjoUmtMeU9oWTgFticr+S7dRjxAQy/L8NtunPYLzS2AXU
         TPuF29VxFEzQ10eyn47F7ah3Hcids8ZKdmagVgpiEyfZFM484njnN7775T/E9YHgUIEW
         hdOIIUlZxBlR6icRLI3H7FLt6EBZwaTL9e8OsoZ67qatHqwQDct8Jpts/FseUFOUyF8h
         6OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924902; x=1792529702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDPPTDqcsXaSDPkJD9YhM9lPuiQdYmryZ8CiiWyAbR8=;
        b=2VYTiT7nZimmNl0EujybvLAUIjK9L3v70fd8paPkv7RYZxwMFMpeGyRfv9zKaG9cHu
         gVCVsrCJ6iyiJXulXwn08CK26l/uJWJzCxKg0bXDH/1BWkBEzvrfZ+cxGJS6k4VdGZwr
         u8xOQca0XEK8l8vWF5RiUJuF/+vSye+COvpmX3F5RlQCyHcT2Q7iPH1phrxL5NT1i/fb
         Comhp3K/F4c0BtKqF7a5QEGAnJ35uztgjZ2gwRapwfC186/+qrCBpBEMnFQisnpAnWHU
         siqLfjJCEPNk7ZMN1a0TLKh6Kgyalqh4npLAmbESNd9rZg4hJOmOVtN+lljfF6HWBltE
         hfHg==
X-Forwarded-Encrypted: i=1; AKwUvBzdU5pujEdf0ogWPdJOv6Ky9ghEZjdIpsQNW7LCQkjvKoCseOdzY9T6FF0mCWStKTIdX7fg9PeQhl8SDBC5ew==@lists.linux.dev
X-Gm-Message-State: AFq9FYJISVxvgYpKAcVFVYJ0otKpLXmtvsaec/c6c6JuFasJzyz8vyUd
	X4X0F5M9lfotajqnOgNm68VT3hRzXoBzT5Yqld2SB0xuREVFg7x5R8xz4CxIQVPmTR+bBiVOEIa
	oMcZThWsC7YtFX10B1hpccsrhqh9PJUg=
X-Gm-Gg: AYBFou35cv/HvfVSoSu3rUMAbaJXKslQ9emCbU5SERlUIDgWXij709siz8+y7GK7Jdm
	teV1e8Z/3PL557iyOG5cfVntfvUhdLHRT9y4bL3icbaQwifrWS1i8HzWHMy45AsbcRyf3xzXBbn
	cuO/oUDhUqzMjpXlstvFL8Gvd+OCmDq5sNpGLYMk3hndO6p6Vs7Xgg/oYWLDM/mJDbrAB8RTClg
	51ldHwBCt96VF6p2+nUhp3Il+uZYaMcE0hWqvM38Fgpw5ItI7h2EhKDnQzHOt2vhyd7qNE7G2+j
	alljIeeL/U+P4ZrlivnZc9UvL9d0IgQQSEm49+7R/HcZphFDas7ZN9ALQyVc9/DOD7nsxae22M7
	eNPbDDU6gnSty5BeHufwqwS+LdktVgsCLmQ6NCzJj
X-Received: by 2002:a05:690e:bc5:b0:677:d79c:f6b7 with SMTP id
 956f58d0204a3-67935f17bf1mr3978437d50.6.1791924901762; Tue, 13 Oct 2026
 13:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1791887415.git.mst@redhat.com> <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
 <20261013143716-mutt-send-email-mst@kernel.org> <CAF=yD-LLNm1K5r37-y2thyvLJN58ruffUUHy-6BUh1CGVmep0Q@mail.gmail.com>
 <20261013163109-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261013163109-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Oct 2026 14:54:24 -0600
X-Gm-Features: AclHuK8U1HzJlOl1AX2NjtB_mdQuaMcoNZfkwLnR19agOuqNwgvKv4h_E94K76U
Message-ID: <CAF=yD-LtGVWrGzs2shhfxzDdwfid=1=TYBcOVQ8Nt10gAHpjWQ@mail.gmail.com>
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

On Tue, Oct 13, 2026 at 2:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 13, 2026 at 02:29:53PM -0600, Willem de Bruijn wrote:
> > On Tue, Oct 13, 2026 at 12:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Tue, Oct 13, 2026 at 08:41:19AM -0600, Willem de Bruijn wrote:
> > > > On Tue, Oct 13, 2026 at 4:58=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > Allowing untrusted hardware to specify csum start/offset for
> > > > > CHECKSUM_PARTIAL was not a good idea, because, if it edits the pa=
cket
> > > > > outside the actual checksum, and depending on the setup, the netw=
orking
> > > > > stack could be looking at the packet both before and after the ed=
it, and
> > > > > seeing different results.
> > > > >
> > > > > Previously, commit 6785011f8b16 ("ipv4: validate checksum_start b=
efore
> > > > > completing checksum") validated all known instances where this
> > > > > causes the most grief, but the real fix is to make sure
> > > > > that either only actual checksum fields are ever edited,
> > > > > or the checksum is completed before the net stack looks at it,
> > > > > so it is always consistent.
> > > >
> > > > +1 on the general approach of performing the checksum offload at
> > > > input, unless the input can easily be validated to be one of a few
> > > > common protocols. That greatly reduces the risk vs my previous atte=
mpt
> > > > at trying to drop.
> > > >
> > > > Since we do not know the full extent of grief, I think this too sho=
uld
> > > > go to net and stable.
> > >
> > > I think it needs a bit more testing to be frank, I do not see it
> > > wait months out of the tree. So if this lands in next before the
> > > merge window, we are good I think. If we miss that I will target net.
> > >
> > >
> > > > That would mean initially a single patch that
> > > > touches as few files as possible. The helper function in
> > > > include/linux/ip.h and conversion of existing open coded parsers to
> > > > use that can follow up later in net-next.
> > >
> > > I don't see the value to be frank.
> > > What moving code between files accomplishes, I donnu.
> > > Squashing things surely makes review harder?
> > > Does your backporting system really struggle with trivial
> > > dependencies like this?
> > >
> > > I can drop patch 2 and will if I am targeting net.
> >
> > Good. This is not about "my" backporting, but upstream stable.
> > Refactor patches do not belong there.
> >
> > Since patch 3 might have to be backported in the future if a serious
> > abuse surfaces, even if you now land it in net-next, it is better to
> > not depend on other patches.
>
> Right. While this is targeting next, I will reorder it last in series so
> it's obvious for people it can be dropped.
>
> Thanks a lot for the review!

Of course. Thanks for the fixes!

I would open-code ip4_parse directly in "net: resolve uncommon partial
checksums at ingress". It's not a lot of code. Then that patch stands
on its own.

And then optionally squash patches 1 and 2 and place them at the end
of this series as one dedup patch, or send that separately later.
Personally I would drop that entirely and leave the existing code as
is. But either way.

>
> > > >
> > > > > This basically does this: checksum at ingress, except in a narrow=
 list
> > > > > of specified known good cases.
> > > > >
> > > > > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > > > >
> > > > > Michael S. Tsirkin (4):
> > > > >   net: add ip4_parse()
> > > > >   net: use ip4_parse() in receive validation
> > > > >   net: resolve uncommon partial checksums at ingress
> > > > >   net: account for ingress-resolved virtio net hdr state
> > >
>
