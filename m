Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF039254873
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Jun 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688932; cv=none; b=bJTSPpx0Ev139XgJBW8ZHUE3VNsEUA53+lKIanlYJeUTQ0xXAltr8V3T/p86RyNbW+6tqktM+JWeQQgHZZaGr2jpmnLyj2Ucujza0e5qop93GFCdOftL7HLVmLtKWlyzogVBPX5sAlcntWZKOOe7Umaid0+g6ustSOLR9zmEyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688932; c=relaxed/simple;
	bh=/14cwYyKwKubJFvYMHEKWQA22KWCV38zKaWXVdcaG2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMUnU0fE3Uclabxg4Af0lDOX1D30Kexls65MAOD9EFnADMbm70/SIE90Fu3AAsB427n/AqWKcmE2GJAgx8TTCcim7RrbHC1u6qpmLOdq4yX0ZDDN/zz+u+hKuGEnsKwIu/WTeqpZtsTHWU8aF4mN38hiPba8qZC5IqXxrg6wKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=u4glv3HP; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="u4glv3HP"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E9324021D
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Jun 2025 14:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 0.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QQaiOqbJhAVD for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 14:28:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=yuri.benditovich@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 199E840090
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 199E840090
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=u4glv3HP
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 199E840090
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Jun 2025 14:28:48 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4a4323fe8caso25470521cf.2
        for <virtualization@lists.linux-foundation.org>; Mon, 23 Jun 2025 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750688928; x=1751293728; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/14cwYyKwKubJFvYMHEKWQA22KWCV38zKaWXVdcaG2g=;
        b=u4glv3HPQJ4OW+0Ldcwr51deLAvsssv/I8D1GQLEIquLSQFIhAyQ9yONiHlDr95g4J
         VjiUpAU7el24/ffmHRxxlYVmnizYDU1UrJIb/hpqYD0oH1tFvyaTxa9pMRJmbsf+DxKf
         TAvaI7BD9yGghY1TRnP4DSDRPxzNR2tVRM7CkuU+i5DFf+ula0PPYDgLwbQdrdRZ7srh
         H/kiZBhCKutlk8aFJrTMkamZTLCSo22Ns6W+a6lE+l1Ii95UPcx2K7IA5GL/yj6oc8+K
         Kpx+GemTcTQj4h5wxvCLSil+sPdt0JpQJuJLMHPSGqsNHDoTgkWqVqXy5tOl2mzjGvJu
         BwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688928; x=1751293728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/14cwYyKwKubJFvYMHEKWQA22KWCV38zKaWXVdcaG2g=;
        b=waPe3Jzd1T7KM8dJ38eREzv06Yj3CPbwf7jpJFbwAr5GHv5pST7NhsRokK+ovP33bH
         4al8HBrRoEEeGKK3vyRPXvrUgo7fjNUbSMdNFNJzqqGpB5AyhAKK/E2aEtPjaajT/L+z
         8eBZnj5Dyovvye6aEu6CS1B5TX52xdJsvhqV5esPIYuizcd0lcMw1QpCZYV9Eq+B7Dee
         b+XB1HW8X0mrICOkJsDA9qtyxSqfIg/CYqRR0xCioqVpMfWJpIfW+5rCADHtybEIuzwn
         k5ZfF1UiPFzSoSMcxql1lbOol9CsuH7HWI8wsBEbWVR8J/3h2GOfGSwewpmbdlfeaZ7m
         QHoA==
X-Forwarded-Encrypted: i=1; AJvYcCXTBMhdlIghawN9hsKmdGEA5wIJCOtoPghSGYcxDlDCfZxyVKmNBVhzvUCT1X7jlVEO9aW7PnnBj7Bj2l8UFw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzl0eofxJVcXAPwVtX3t/0a+gARxCNdsEIVL/TBuby6MnndiGvm
	yTuhV4WOflcbvCbPdlmuwhrZyjwypbd+bmSklsPtfXZdB3mbx4GDREsfdlyA6As8Uaj6gkL2xr9
	4F4oxjZMbtqNiDYOlNksSIT/GVJZVBJn/epbDVNKN5A==
X-Gm-Gg: ASbGncs0yM7tl1QLmLm0woN5a18Cm5AcsjhjuP4ph3bpI8CvJ9Qh34XSmuk8OPD/XpG
	oK47wFQht0ZJtaZXIEn594TnK9X4VXP+H1hbpupVgdLY6Z7tCgt+ZtEfJkhiZ+bfR8s5Bw8dKj1
	KIa4xHfz0GKSXr4JdjbIo37ZRakthg475REGRF7ObXzd4VUfIq8ZDbNWO+nW5q2C1F0y/dDQPqL
	9QfCA==
X-Google-Smtp-Source: AGHT+IGAEU79vWFsEbGN71mgZpuPejwVzDs9CuFGRu/kIPPECPSaBJWX6S8IOXgJzNmRFrQ3GoKYDSjB9QaqmPokmug=
X-Received: by 2002:a05:622a:50f:b0:4a7:146b:c5e5 with SMTP id
 d75a77b69052e-4a77a20840emr222574351cf.21.1750688927718; Mon, 23 Jun 2025
 07:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com> <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
 <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com> <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com>
In-Reply-To: <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 23 Jun 2025 17:28:36 +0300
X-Gm-Features: AX0GCFu3hePJcE8mBSHlKXkSVpPD8N_41tEP_O5fU60lBvVDsaWZNc7CeBwagRc
Message-ID: <CAOEp5Oet1P2EWTwLJnMYY4CVAzDWgdM8wbvV3+BH6aY0kE+O8g@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jun 23, 2025 at 1:40=E2=80=AFAM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > > Yuri, can you help to clarify this?
> >
> > I see here several questions:
> > 1. Whether it is ok for the device not to indicate support for XXX_EX h=
ash type?
> > - I think, yes (strictly speaking, it was better to test that before
> > submitting the patches )
> > 2. Is it possible that the guest will enable some XXX_EX hash type if
> > the device does not indicate that it is supported?
> > - No (I think this is part of the spec)
>
> There's another question, is the device allowed to fallback to
> VIRTIO_NET_HASH_TYPE_IPv6 if it fails to parse extensions?
MSFT expectations for that are at
https://learn.microsoft.com/en-us/windows-hardware/drivers/network/rss-hash=
ing-types
If I read them correctly, the answer is "no"
BTW, my personal opinion is that placing all these things with hash
calculations into kernel instead of ebpf does not make too much sense.

>
> > 3. What to do if we migrate between systems with different
> > capabilities of hash support/reporting/whatever
> > - IMO, at this moment such case should be excluded and only mechanism
> > we have for that is the compatible machine version
> > - in some future the change of device capabilities can be communicated
> > to the driver and _probably_ the driver might be able to communicate
> > the change of device capabilities to the OS
>
> Are you suggesting implementing all hash types? Note that Akihiko
> raises the issue that in the actual implementation there should be a
> limitation of the maximum number of options. If such a limitation is
> different between src and dst, the difference could be noticed by the
> guest.
>
> > 4. Does it make sense to have fine configuration of hash types mask
> > via command-line?
> > - IMO, no. This would require the user to have too much knowledge
> > about RSS internals
> >
> > Please let me know if I missed something.
> >
>
> Thanks
>
