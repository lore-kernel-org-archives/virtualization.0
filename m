Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883A17E010
	for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727624001; cv=none; b=pFNno1yD9bQLEvQUWuu/yobK7CMWn9xWRB/XpbjXCf7wjscMyvG1G+t5eyc6wPpgn/iRrzaUG2fTzc+PVP+VGTNHeKJtfkec0Ysy9ZyTzES7XvcCiqkzvNAJZnR99FqhL8mL6yL86ckfP1LDCVHmIbdYoWyQjCAaUwtpl0xk/kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727624001; c=relaxed/simple;
	bh=R/KAIucJR64DhM14PlnEqlxirD95bh38Qn5Yl/jW8RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZRodEhZZmkW8is956dhOyfgZ8Q5NGsaRjdHlwRvUTsqdBMXqHTGh8gA9mMpOsUUmp/El9ZDx4SN3ybtpNYAEHQxXQKRv+Pnft3JO4GACiR0bO9r0X8WQt5oMnnzBXnW30SShg6PHOesWSZBaVrm9oIpU51Tz90Z1pmZusZ5aTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=QnxEdOIl; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QnxEdOIl"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25D83403AF
	for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 15:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLGzidHO74ao for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Sep 2024 15:33:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=stephen@networkplumber.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A721040361
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A721040361
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=QnxEdOIl
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A721040361
	for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 15:33:18 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-71c702b2d50so371587b3a.1
        for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727623997; x=1728228797; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/KAIucJR64DhM14PlnEqlxirD95bh38Qn5Yl/jW8RQ=;
        b=QnxEdOIljiR19t/McvRKiNpVhQ8l+mqcqi4Lo9KTeu4Kc5m5d+nivBPmItIIFzKpLX
         NSRoN+r9Qo1OSare7fWLtpSvf8BA7IKxsMK2qAksqwLslmWebYLIs1A5mlrsAukEKFVA
         Ei8Vw3YYs84QP7nllmkwn2Gs8QmL8sLhN7Pj4HFOoKtBY1wEtMgsc2UzFF4+qkkC4nFc
         l0Sf/JYfinvtgrQgK8UFb8YNXttMILTmqQOSXg6T/Tk1on+aJHA9c2w/Er3l8PQ1Co1v
         Tz1lo0tSEoa7bcgwt4qiSIEp7Lu6hLkOa7wJsiAZuuwfns7D9viDLFq39scY+8rYPp9n
         w9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727623997; x=1728228797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/KAIucJR64DhM14PlnEqlxirD95bh38Qn5Yl/jW8RQ=;
        b=eTHuz/KfnF38Tc+lg101CQ4P3nCCUZfSkA5IIvCno2nC3hCyb15tolFR8ADwXZhVB8
         +lSMCnb84I5pypaBW1jUZjVcR2hTBZiStLERiQ2ge0S6usgBFexyRWuhvx/MzUFge6lB
         GKQfC2aGqINhTe1VG0bEa3jZNUtpaCmC8LqKe8E6buwQdCXvSxdAbEhzRWLPefoT9N3B
         jpB1hHxZF+FLIaReqF7OKJWJ/NUk+Z2n5EV/9UXRy+Xsj6PzAHnWz0kE1RoVkj08taf2
         tACuPEzWQx+S4hQeFztsaUV33Zqlr3aYI+aXJsANGB50EMvbYSDuXYwrMt4jrOH98/fG
         bESw==
X-Forwarded-Encrypted: i=1; AJvYcCXkk3ob21+Jobf+UX9FE6+A07h27AQVALuis3ZTnGpHxsNkcVvtSTPBaMdrQ4OYdrPmt1Pkz4M72H62JTfTiQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxM0ryvR9eaTYaE0jRFS0ONbH6WS+fmFPBz3HB2nRt+T+JmOB3x
	yyubSiz7Hho01tXUy1iFgJqqh2Lomk3wwcU7ycFpKb8Z/HQyq2ZDN8knwoZGPmg=
X-Google-Smtp-Source: AGHT+IGuZ2ZQ2xF0vqQIURXhh3/WO6fyMaueh6tDYx0LjIXGb2PeQu34yIj5VrsYQjGUWlhTfeQehQ==
X-Received: by 2002:a05:6a00:80f:b0:71b:64c:814b with SMTP id d2e1a72fcca58-71b26062754mr15148322b3a.23.1727623997547;
        Sun, 29 Sep 2024 08:33:17 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2653663asm4681814b3a.187.2024.09.29.08.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 08:33:17 -0700 (PDT)
Date: Sun, 29 Sep 2024 08:33:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan
 <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko
 <andrew@daynix.com>, gur.stavi@huawei.com
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
Message-ID: <20240929083314.02d47d69@hermes.local>
In-Reply-To: <447dca19-58c5-4c01-b60e-cfe5e601961a@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
	<CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
	<c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
	<CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
	<6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
	<CACGkMEtscr17UOufUtyPp1OvALL8LcycpbRp6CyVMF=jYzAjAA@mail.gmail.com>
	<447dca19-58c5-4c01-b60e-cfe5e601961a@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 29 Sep 2024 16:10:47 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> On 2024/09/29 11:07, Jason Wang wrote:
> > On Fri, Sep 27, 2024 at 3:51=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote: =20
> >>
> >> On 2024/09/27 13:31, Jason Wang wrote: =20
> >>> On Fri, Sep 27, 2024 at 10:11=E2=80=AFAM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote: =20
> >>>>
> >>>> On 2024/09/25 12:30, Jason Wang wrote: =20
> >>>>> On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote: =20
> >>>>>>
> >>>>>> virtio-net have two usage of hashes: one is RSS and another is hash
> >>>>>> reporting. Conventionally the hash calculation was done by the VMM.
> >>>>>> However, computing the hash after the queue was chosen defeats the
> >>>>>> purpose of RSS.
> >>>>>>
> >>>>>> Another approach is to use eBPF steering program. This approach has
> >>>>>> another downside: it cannot report the calculated hash due to the
> >>>>>> restrictive nature of eBPF.
> >>>>>>
> >>>>>> Introduce the code to compute hashes to the kernel in order to ove=
rcome
> >>>>>> thse challenges.
> >>>>>>
> >>>>>> An alternative solution is to extend the eBPF steering program so =
that it
> >>>>>> will be able to report to the userspace, but it is based on context
> >>>>>> rewrites, which is in feature freeze. We can adopt kfuncs, but the=
y will
> >>>>>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (=
KVM
> >>>>>> and vhost_net).
> >>>>>> =20
> >>>>>
> >>>>> I wonder if we could clone the skb and reuse some to store the hash,
> >>>>> then the steering eBPF program can access these fields without
> >>>>> introducing full RSS in the kernel? =20
> >>>>
> >>>> I don't get how cloning the skb can solve the issue.
> >>>>
> >>>> We can certainly implement Toeplitz function in the kernel or even w=
ith
> >>>> tc-bpf to store a hash value that can be used for eBPF steering prog=
ram
> >>>> and virtio hash reporting. However we don't have a means of storing a
> >>>> hash type, which is specific to virtio hash reporting and lacks a
> >>>> corresponding skb field. =20
> >>>
> >>> I may miss something but looking at sk_filter_is_valid_access(). It
> >>> looks to me we can make use of skb->cb[0..4]? =20
> >>
> >> I didn't opt to using cb. Below is the rationale:
> >>
> >> cb is for tail call so it means we reuse the field for a different
> >> purpose. The context rewrite allows adding a field without increasing
> >> the size of the underlying storage (the real sk_buff) so we should add=
 a
> >> new field instead of reusing an existing field to avoid confusion.
> >>
> >> We are however no longer allowed to add a new field. In my
> >> understanding, this is because it is an UAPI, and eBPF maintainers fou=
nd
> >> it is difficult to maintain its stability.
> >>
> >> Reusing cb for hash reporting is a workaround to avoid having a new
> >> field, but it does not solve the underlying problem (i.e., keeping eBPF
> >> as stable as UAPI is unreasonably hard). In my opinion, adding an ioctl
> >> is a reasonable option to keep the API as stable as other virtualizati=
on
> >> UAPIs while respecting the underlying intention of the context rewrite
> >> feature freeze. =20
> >=20
> > Fair enough.
> >=20
> > Btw, I remember DPDK implements tuntap RSS via eBPF as well (probably
> > via cls or other). It might worth to see if anything we miss here. =20
>=20
> Thanks for the information. I wonder why they used cls instead of=20
> steering program. Perhaps it may be due to compatibility with macvtap=20
> and ipvtap, which don't steering program.
>=20
> Their RSS implementation looks cleaner so I will improve my RSS=20
> implementation accordingly.
>=20

DPDK needs to support flow rules. The specific case is where packets
are classified by a flow, then RSS is done across a subset of the queues.
The support for flow in TUN driver is more academic than useful,
I fixed it for current BPF, but doubt anyone is using it really.

A full steering program would be good, but would require much more
complexity to take a general set of flow rules then communicate that
to the steering program.

