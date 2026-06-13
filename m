Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB636AB5A
	for <virtualization@lists.linux.dev>; Sat, 13 Jun 2026 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381715; cv=pass; b=L+Ry56thS6myLgNNcorenhV3T10BWXwmKD+HJdGOJUeF0iDCvKTtnVwBEovmFEZkiP2dt/k+dXyrHJlCf1yAYogjJ0Lz7eEIByRCCGrbGvtt4RFLbtnD3bep+l5d2y/olFc2J3H7jkjSAFFFxTLQreECJfhDxsCTokJ/knleCGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381715; c=relaxed/simple;
	bh=ePGH4CGDlZXPrmEQA5xZMF3lKEmANEf+sW/SF7aVJ1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqKZmrdj++e6ZeV4+hbbOf0qGuZKC7C7n0CG8kV0t1dBSyCookQUl+PIlEujseH9LDEBEiIR2+KxaBUMbv0gm/P2QEQWVdUo5aeuTDoYsyvy+stYdiDh/eHrA9UTzUdieUdiSLAAvlHXr/epdNbfHapUDnYfbn6wsjOPsXBegVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=gFhz/S9T; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="gFhz/S9T"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b903567fdso2495582a91.1
        for <virtualization@lists.linux.dev>; Sat, 13 Jun 2026 13:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781381713; cv=none;
        d=google.com; s=arc-20240605;
        b=KPwdDPZ3Ofd8zoMy1YjjHQwx1xB45+RXdC8/+O2EHk7Zznsk4hH9qAoQBIVmsyblz0
         7qlxTN+J0GAirXStSx/ZJhn5sSSeyEHSozJtX6qsgU+VJ8NKHYUaGqGdCUHIrSWJ/icf
         DuoQpkofWHhxP+fiZAjleWpHO4O8omJNHMkJPdW62U6a86Kp6bLPM5Hm2pyLMvoRwz+b
         Xb7AfD17eNkVm93eW1Ykpro6cFkZXsNiS835ITUquKajOUGbrpuiPXQo5kcdJh1Cu6Zh
         c9d/kWfVS9HwjzECTHclq3Iqu2YCDDm264cdb7fonTnt8/kcnJQrg2ixUsmG5Mc/PxWB
         HJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CBkdmPdZBk73lVMnTi8CPgubS9GT5yZjHd5e2IMjwN0=;
        fh=r7X8UYqF65/fEkOTkrJvI5Feiaos7LpGB2HxPLL4yyw=;
        b=XgRluFekJTT1oZJK5XoHiTSW4lFaUawx5HZ6cJiKfb4dFK/0nXaK5Eq886xoBzOGfJ
         pqkv/wkqB0UUyCujBl2vuZfgeYEH8e/afq4a/mOrQBbJzymM4qTpRQUzGopWodXnYj9u
         JjR+z4q1aR/y+IKFJFXWYwsvIAqF9juW4Eux8Au8C5OAk9I4NDxW+cJMe7oLD2PSoupd
         4Jt3c0Flo8rlhA9DZ280+WjsGzflYYIsWGLdaS50MlwQLuAKDbYdiaDzqPsawL7LCyfs
         HYojH1s5q5F1s1lZPdzSboDmT5yKDb3/kXPdGez0PDVml25z6h9SIAE3nCcBi+Seq0P+
         nd2w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781381713; x=1781986513; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBkdmPdZBk73lVMnTi8CPgubS9GT5yZjHd5e2IMjwN0=;
        b=gFhz/S9TJRAtBDok5QREv5qjG622Ak1sClGFnBNdTMaehFALY8T6WBfPoydFYkKR/+
         cZSiTwOrjhmpzOVdrTeK5TtuyOHN4dsx2+/NTAARAU3W59XgLVKYmvOya6cNl9CwSU60
         1kcQ7VGwbbm2CS4eZCIBvqhfeC48g/aXljNqAtcO0ocLp4AvOsp+c3GaI8jx9t2dfXp9
         tFu6oyKTq6C6j4yhOJhWmz3sDWWwgrySqWkFpP5/LP90zb32Qg/gBzV6EOuojLJMKOGv
         Bznz2pTz8bDQUxxVcTSNULW0f7tvp2tYbIjhN54Pextu1pTMAcoJep7TFOggqVEigmr+
         FsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781381713; x=1781986513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBkdmPdZBk73lVMnTi8CPgubS9GT5yZjHd5e2IMjwN0=;
        b=AgfyeG2OjgfUjwtoo82iECha1bUK4/M1lajAgsdr3ONgb9BGAItxWey19qlIuwAXq/
         mCojjQCoqQWhFSiCRPfp6wRNqu72IcM2gY7GuvnQmgls5xti97ViaHUZVIwdFrwk6yPE
         lpqJNTdTfgEttz30J5ncbFb9UcPWPUNWr6Q9qDtmGFJbGTu/aTAZMYZzMS3tHGOaRmgw
         EpY3VFsMos2Ors3JZC9DD4WdviunUdggGb1/uTwdhQAIGpPGnop4/Pnoygl+AejAdJo7
         KTEJBIdsdkwNFqC+TH2dHP1vGYJRIhbdJMkYacLU2h2+++CphzpQvVbRrTFn46C/3ETe
         KNCw==
X-Forwarded-Encrypted: i=1; AFNElJ/TntkzHocomfI1IsvK2yt2aQdpZOrztcnftj6qla4mal+e+o7BMaSjT6wQc7GaxA54D9HggJbzE3IAHAtwvA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkp1tnN+vferA0DxGVs+XK7sqjdbmaeicee+McAeaZXgcgFMIO
	b3BiycJyxY5J7s/LfTQ8ZZnOBMj09L+aukLx5c+okAmlLdIRj+QVs1c9/VBZGiBQ1zqrdSnejVM
	Q/4iHx0cGacc6iPX1nvTbWcrXk/K7jvXBRHFQiau4
X-Gm-Gg: Acq92OFcwUQs5Um9NZLwRSZWAE0Bjwfi+x9v3Jy2ayOgIcvVE7nNGqj7mH8EBzndGMw
	JIAUjOxuKOT3o79zCgIyVjHK0OQcZBbXaZjrcgQlHzVBefJTU13HCNud06HZW11edGAN6lpGnYL
	/iTgQzzEovc3+8/VM0nw/duOg8OfF3TArrYPSEHFLXMWxki5dJ9zMleqriAJHSIO3YzvTwo94ZA
	5c8Vbh/lnimXCu1nEtEhqUOyW2i3OnI3HcXJJwTMHg2uFktPwycgkt9TutLYR/UeZDAaeo7CSzX
	a0whk8j4tOejKTTAzCP0p+Y1mg+bKekTHksPMPE=
X-Received: by 2002:a17:90b:5102:b0:36d:df4f:ab2 with SMTP id
 98e67ed59e1d1-37a036ea6c5mr8876392a91.13.1781381713644; Sat, 13 Jun 2026
 13:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260611024616.1408317-1-xmei5@asu.edu> <20260611014519-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260611014519-mutt-send-email-mst@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 13 Jun 2026 13:15:02 -0700
X-Gm-Features: AVVi8CcSRgUFlk_J8E0QCNoWVZMQzkut3tYo8Tc6XpdRmW9vbeCZhKv27M80tXA
Message-ID: <CAPpSM+Q=NM0WeBmZvyOEkyx73VU10AOHQjPbWDSet675B7AnCA@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: fix len check in receive_big()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	minhquangbui99@gmail.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Jun 10, 2026 at 07:46:16PM -0700, Xiang Mei wrote:
> > receive_big() bounds the device-announced length by
> > (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> > add_recvbuf_big() sets sg[1] to start at offset
> > sizeof(struct padded_vnet_hdr) into the first page, so the chain
> > actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> > big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> > check allows for the common hdr_len =3D=3D 12 case.
> >
> > A malicious virtio backend can announce a len in that gap.  page_to_skb=
()
> > then walks one frag past the page chain, storing a NULL page->private
> > into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> > write past the static frag array and a NULL frag handed up the rx path.
> >
> > Bound len by the size add_recvbuf_big() actually advertised.
> >
> > Fixes: 0c716703965f ("virtio-net: fix received length check in big pack=
ets")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Thanks for the patch! Something small to improve:
>
> > ---
> > v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
> >
> >  drivers/net/virtio_net.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..afe73eda1491 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_d=
evice *dev,
> >                                  struct virtnet_rq_stats *stats)
> >  {
> >       struct page *page =3D buf;
> > +     unsigned long max_len;
>
> Assignment can happen here?
>
> >       struct sk_buff *skb;
> >
> >       /* Make sure that len does not exceed the size allocated in
> >        * add_recvbuf_big.
> >        */
> > -     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE=
)) {
> > +     max_len =3D vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_=
hdr)) +
> > +               vi->big_packets_num_skbfrags * PAGE_SIZE;
>
> Took me a while to figure out what is going on, but I finally
> understand:
>
>
> Reducing
> (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE
>
> (what we allocated)
>
> by sizeof(struct padded_vnet_hdr) - vi->hdr_len
>
>
> right?
>
> So clearer as:
>
>
>         unsigned long max_len =3D (vi->big_packets_num_skbfrags + 1) * PA=
GE_SIZE -
>         sizeof(struct padded_vnet_hdr) + vi->hdr_len;
>
Right, that's the same value. Yours reads better!

I'll fold this into the next respin. One thing I'd like to settle
first: David suggested storing this in a vi field computed once at the
probe (it's a per-device constant) and just comparing len against it
on the datapath, instead of re-deriving it in receive_big() each time.
I'll wait for his take on that and send a single v4 that covers both.

Xiang

>
>
>
> > +     if (unlikely(len > max_len)) {
> >               pr_debug("%s: rx error: len %u exceeds allocated size %lu=
\n",
> > -                      dev->name, len,
> > -                      (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > +                      dev->name, len, max_len);
> >               goto err;
> >       }
> >
> > --
> > 2.43.0
>
