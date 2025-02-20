Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E914D29B
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740016013; cv=none; b=dCvcBXO+Sb1we8o+FcWyCClju/Ug3CUP7taFp8Yq61z5XbcD/njpUUgoWnBJsz2lnuoTHLBDPvrSd/3shWS0HSp4xwTdF9AJK3qUK80v97zCOShWaEzSr8GP7VYPtnmUQDVRjf+5sZrkBEK9+9kHCek85RgfrCCvr3yLqQd29cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740016013; c=relaxed/simple;
	bh=arHaMf1VlgzmwsFpfVOXP4yaHpMS0ZNgicYCaJisT68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ompLUkODb2ciEQxo1e23bUXQ6Rj1ogy0EvB8n87340GhY7JRIQf25oE1YRfHUW7YdsL5YGpvSVdkhYzKvHPo9SBKpVzdozyyIeEWbeO+oUhuxFM855ZsquUqO1sFpIo05C5s92pNx1Qrqb8FxS4EFAkacLcDXq/iZjBBMFGyKY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npvBhzIF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npvBhzIF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2212222d4cdso73485ad.0
        for <virtualization@lists.linux.dev>; Wed, 19 Feb 2025 17:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740016010; x=1740620810; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arHaMf1VlgzmwsFpfVOXP4yaHpMS0ZNgicYCaJisT68=;
        b=npvBhzIFzBP01Sk/0uDUFhJO3uRxbZEggwbTT54N/JeC3M7+cYxd8s7upTl3xeKX2d
         KPc6v6+TiRuxJVSZX7iUBRGdhndVRKnUBuUjDrOodfVvos+Ni7SkujTiGQY9ep+xSNTm
         9qvzxbmIJRISwWkBJQ904mLxHS/XU8qNGQA6qNlcA01PhVCledLDB7X/pBxds7sfuAYC
         GSUc8PWaEYjXRDf1O+yD0+VrcpZgPpgeyXsiARMr6TLJ449UEKwjvvu+wb0ft19D4Xgp
         OiF95ryPwyMbiB49Z4SsdfrBlLysIWe9bq1uJRIHD0Ur8Qnw22SVm4AkZcl/EQaaQV1q
         YCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740016010; x=1740620810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arHaMf1VlgzmwsFpfVOXP4yaHpMS0ZNgicYCaJisT68=;
        b=OGYcTfw9Df/MZ3krs0UOG3NM79ZukkwjxT6+1OaFbPGpge0euebXwGzJs4Qm8yotGu
         XGnyPTr9Zi4njfbhJKSrT2qyPPMvNqbNeN0uKgKKKkFOUrHprbVX6shiXNP+wEKWnnYK
         wt4MM5hD/tkHr7WP85OoURjsvUAVOzKSHXQ/9FE98tjiu5nbSZIXEAqXS8b/h+whKiBK
         YXPzbtGpuseKVHvaUAB22cVVbfCJ0ZI7OVFJq78BL0DZivgYpM1wc5+8N+5JFo6VucLs
         rbgwzESeQ8TbNEGXTz/9QqYQl8G+6vbi7mVLxD1TzIz3D1+3zTNMWSVceeZatDGxYDCb
         wW5w==
X-Forwarded-Encrypted: i=1; AJvYcCXTQyYvC8EmMEoZqeYGpdY9m41GfuCEoRH8+WU/FlvUjPVttN8bOHlGIH8R13ieKGoU5QJUjru96kvJgJvTDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyANR7E3r1YsZ4LyBvi0yHhlLcxVhRGSfo3REbG+bL896ga5676
	NqP/JMXXtAPhmrQNmBw4EKQUuGp6YBuYrzDCat1xMZNGSGUzANN0dYbATP4GcvpOqABAquhTU4i
	wzUujGEhqlRB3mqxHU8sxosuaga6YqNtxc9jR
X-Gm-Gg: ASbGnct0lXu6ppjScAS9/3Ej/Tmsl+Y5oiPl5yTKPr4L1TmrJrmFJHwEP0rbpvuZtQ+
	OJjRrPq4FEqwlIrsjPFB5l/TfHqsopxEMaQeApyhbePkLsMYWqUDA6z7Hg6RparIIZrpZe9YZ
X-Google-Smtp-Source: AGHT+IEz/wy+PbvayGyl/ZC2Oa91Z8b/neItdKm+4+1vyV76jCH3mzoPtf/GRrixk+9Ls+oK+3gmWERSJ245t2qC3RY=
X-Received: by 2002:a17:903:19ef:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-2218dd576f9mr1423265ad.14.1740016009988; Wed, 19 Feb 2025
 17:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-6-almasrymina@google.com> <abc22620-d509-4b12-80ac-0c36b08b36d9@gmail.com>
 <CAHS8izNOqaFe_40gFh09vdBz6-deWdeGu9Aky-e7E+Wu2qtfdw@mail.gmail.com>
 <28343e83-6d93-4002-a691-f8273d4d24a8@gmail.com> <CAHS8izOE-JzMszieHEXtYBs7_6D-ngVx2kJyMwp8eCWLK-c0cQ@mail.gmail.com>
 <9210a12c-9adb-46ba-b92c-90fd07e1980f@gmail.com> <CAHS8izPHtk5x-W05_svxU53X-V4+++PiYErCgfr-3iDGgEaUig@mail.gmail.com>
 <4cdfaff8-0623-4d3a-9204-5165ccbb84db@gmail.com>
In-Reply-To: <4cdfaff8-0623-4d3a-9204-5165ccbb84db@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 19 Feb 2025 17:46:37 -0800
X-Gm-Features: AWEUYZkdYTArMvyspFK_MTvc6qB9T7tm4wBNfrCPa7PpZJsZ-6EA0AUf_amyQgU
Message-ID: <CAHS8izNHT_VjztrDk6t-OJoX=zB3vV81w2CYZTKA1yGB06tY-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/6] net: devmem: Implement TX path
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 2:40=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/17/25 23:26, Mina Almasry wrote:
> > On Thu, Feb 13, 2025 at 5:17=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> ...
> >>>>> It's asserting that sizeof(ubuf_info_msgzc) <=3D sizeof(skb->cb), a=
nd
> >>>>> I'm guessing increasing skb->cb size is not really the way to go.
> >>>>>
> >>>>> What I may be able to do here is stash the binding somewhere in
> >>>>> ubuf_info_msgzc via union with fields we don't need for devmem, and=
/or
> >>>>
> >>>> It doesn't need to account the memory against the user, and you
> >>>> actually don't want that because dmabuf should take care of that.
> >>>> So, it should be fine to reuse ->mmp.
> >>>>
> >>>> It's also not a real sk_buff, so maybe maintainers wouldn't mind
> >>>> reusing some more space out of it, if that would even be needed.
> >>>>
> >>>
> >>> netmem skb are real sk_buff, with the modification that frags are not
> >>
> >> We were discussing ubuf_info allocation, take a look at
> >> msg_zerocopy_alloc(), it has nothing to do with netmems and all that.
> >>
> >
> > Yes. My response was regarding the suggestion that we can use space in
> > devmem skbs however we want though.
>
> Well, at least I didn't suggest that, assuming "devmem skbs" are skbs
> filled with devmem frags. I think the confusion here is thinking
> that skb->cb you mentioned above is about "devmem skbs", while it's
> special skbs without data used only to piggy back ubuf allocation.

Ah, I see. I still don't see how we can just increase the size of
skb->cb when it's shared between these special skbs and regular skbs.

> Functionally speaking, it'd be perfectly fine to get rid of the
> warning and allocate it with kmalloc().
>

More suggestions to refactor unrelated things to force through a
msg->sg_from_iter approach.

> ...
> >>> But MSG_ZEROCOPY doesn't set msg->msg_ubuf. And not setting
> >>> msg->msg_ubuf fails to trigger msg->sg_from_iter altogether.
> >>>
> >>> And also currently sg_from_iter isn't set up to take in a ubuf_info.
> >>> We'd need that if we stash the binding in the ubuf_info.
> >>
> >> https://github.com/isilence/linux.git sg-iter-ops
> >>
> >> I have old patches for all of that, they even rebased cleanly. That
> >> should do it for you, and I need to send then regardless of devmem.
> >>
> >>
> >
> > These patches help a bit, but do not make any meaningful dent in
> > addressing the concern I have in the earlier emails.
> >
> > The concern is that we're piggybacking devmem TX on MSG_ZEROCOPY, and
> > currently the MSG_ZEROCOPY code carefully avoids any code paths
> > setting msg->[sg_from_iter|msg_ubuf].
>
> Fwiw, with that branch you don't need ->msg_ubuf at all, just pass
> it as an argument from tcp_sendmsg_locked() as usual, and
> ->sg_from_iter is gone from there as well.
>
> > If we want devmem to reuse both the MSG_ZEROCOPY mechanisms and the
> > msg->[sg_from_iter|ubuf_info] mechanism, I have to dissect the
> > MSG_ZEROCOPY code carefully so that it works with and without
> > setting msg->[ubuf_info|msg->sg_from_iter]. Having gone through this
> > rabbit hole so far I see that it complicates the implementation and
> > adds more checks to the fast MSG_ZEROCOPY paths.
>
> If you've already done, maybe you can post it as a draft? At least
> it'll be obvious why you say it's more complicated.
>

I don't have anything worth sharing. Just went down this rabbit hole
and saw a bunch of MSG_ZEROCOPY checks (!msg->msg_ubuf checks around
MSG_ZEROCOPY code) and restrictions (skb->cb size) need to be
addressed and checks to be added. From this thread you seem to be
suggesting more changes to force in a msg->sg_from_iter approach
adding to the complications.

> > The complication could be worth it if there was some upside, but I
> > don't see one tbh. Passing the binding down to
> > zerocopy_fill_skb_from_devmem seems like a better approach to my eye
> > so far
>
> The upside is that 1) you currently you add overhead to common
> path (incl copy),

You mean the unlikely() check for devmem before delegating to
skb_zerocopy_fill_from_devmem? Should be minimal.

> 2) passing it down through all the function also
> have overhead to the zerocopy and MSG_ZEROCOPY path, which I'd
> assume is comparable to those extra checks you have.

Complicating/refactoring existing code for devmem TCP to force in a
msg->sg_from_iter and save 1 arg passed down a couple of functions
doesn't seem like a good tradeoff IMO.

> 3) tcp would
> need to know about devmem tcp and its bindings, while it all could
> be in one spot under the MSG_ZEROCOPY check.

I don't see why this is binding to tcp somehow. If anything it makes
the devmem TX implementation follow closely MSG_ZEROCOPY, and existing
MSG_ZEROCOPY code would be easily extended for devmem TX without
having to also carry refactors to migrate to msg->sg_from_iter
approach (just grab the binding and pass it to
skb_zerocopy_iter_stream).

> 4) When you'd want
> another protocol to support that, instead of a simple
>
> ubuf =3D get_devmem_ubuf();
>
> You'd need to plumb binding passing through the stack there as
> well.
>

Similar to above, I think this approach will actually extend easier to
any protocol already using MSG_ZEROCOPY, because we follow that
closely instead of requiring refactors to force msg->sg_from_iter
approach.


> 5) And keeping it in one place makes it easier to keep around.
>
> I just don't see why it'd be complicated, but maybe I miss
> something, which is why a draft prototype would explain it
> better than any words.
>
> > I'm afraid I'm going to table this for now. If there is overwhelming
> > consensus that msg->sg_from_iter is the right approach here I will
> > revisit, but it seems to me to complicate code without a significant
> > upside.
>
> --
> Pavel Begunkov
>


--
Thanks,
Mina
