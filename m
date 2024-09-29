Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853CD18C3E
	for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727575649; cv=none; b=iSwW7GhgtitJFgn0pNpBlEC3Hi0E9jOI43cxZdzEp3twA3EQb82ihS/G55G7KCCVMCUb6k3byMqhyrMMQp85cHq+QJBleanrSZG3vAaOAAlv9nKDMH1xWU24zm5TwWbdSZfT2oLreXoIdwFK7u2D/xdm9hvMMwul9qyms2nI9tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727575649; c=relaxed/simple;
	bh=TO6F9WUFFXlq7WPqrSDsnpUMpKF1xFzm56hCVzpmjMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kxskpipjw/ebe8IEiFtIX6LH16Y0Un9XN6IsPOZDw7QMqtmaqvgKDS+mb9j+kruWJnFOGtqdyM9sK76AJU3o4v6RB8LyQvN5oRs/mW/OFyeLd/nNrlqIG240DEDHdNF5k+QfBDvms2IIqAjPcB3pVkIOAGlRR7Ny3mcIcXFIfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFOwkDGf; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFOwkDGf"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1129E80F6F
	for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 02:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SGdleWz2-hVf for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Sep 2024 02:07:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 339EF80F65
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 339EF80F65
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PFOwkDGf
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 339EF80F65
	for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 02:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727575645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TO6F9WUFFXlq7WPqrSDsnpUMpKF1xFzm56hCVzpmjMk=;
	b=PFOwkDGfqZRTdRa+vO2LbLy8UjqJg5awchQ37wMOJg5uTGD3IfXg3eIgD8DLcmn604+jcy
	nu7qpdTEj/tFiaOUHbCN06ICgvLZTOWoyqQbomCT0+HWBHDQGhmmOoBs1T+MA60iR0nsRq
	OYTOTkN77HTlLAFDLO3foo6zKFyztlE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-AbtdwzL1Ml2MSXk_kWYY9Q-1; Sat, 28 Sep 2024 22:07:23 -0400
X-MC-Unique: AbtdwzL1Ml2MSXk_kWYY9Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e08517d5afso3099625a91.1
        for <virtualization@lists.linux-foundation.org>; Sat, 28 Sep 2024 19:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727575643; x=1728180443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO6F9WUFFXlq7WPqrSDsnpUMpKF1xFzm56hCVzpmjMk=;
        b=tCH8bqzdbq+wuD+0MTafPjak61aIRbOr2Nduo3TQy+aG2b2W8S+TMr6yYAbTIeeING
         0kq2TQsLL96w08xZeYsstgzLG6bQHs9xQJv5/P+FLzmZ8Z5DTaERJVj7/6fmO1WvtFQ4
         kAqgj1DbgtQqF7XJjo3qD7KkT/o2OoYeZk/zI+U2rgFVLWMgNmTNr+4187UwugsmbBcc
         xF6+GmUCD5noMGHE0Q8Lj7wkvjcbOWmXGwS7XMfiZ5VmbhBBaJ72E+7DzzS1Qdjw3nq1
         A6DE0n5YLuvfyeh0yZEsiqBxfUNPlLzu+u3FV/1IkjfAPsINXqz7pA0Yxdyz/NMvVN8R
         iovQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjCrvVtDta6W8tPsQwrdwcU3+91yMG3kbEJ/z036n2ghvp01bKgRIY75ER2LdikRmukgPCm+wkvfxGrlzuTw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw2i0j+W53yKvFKpT4Bm8CaTcET1/ix2TaVUMIvdnku9k+stiA6
	l8PQNQVf5LH62ox8XRO6iog7mvkXVp+eIPgQAZfiCjhubP9AT8V+NtZ5zeXrmji5WcDoYJHq/tl
	olcW6yVJdQ0wX8UaRvL4MlT9+zBssRLQAdegAZAucx7LAZDBLfatIJxUKpF0yZ6VuJ3lfE7CwZb
	+DKZUpBjdMQZks2ODtTF2FqhaQn/fekEf9+pAXgHk4fi+y8hAM6+9HWA==
X-Received: by 2002:a17:90a:d994:b0:2d8:e6d8:14c8 with SMTP id 98e67ed59e1d1-2e0b72ebe66mr12848830a91.15.1727575642713;
        Sat, 28 Sep 2024 19:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj0CCQ8up3FJXqhdPxg4H3lCO7LjesFN419E2sMSG36WbFWRO8y7aomLGECK7sl9/s5dIhUxnui4OmPKl9ZQY=
X-Received: by 2002:a17:90a:d994:b0:2d8:e6d8:14c8 with SMTP id
 98e67ed59e1d1-2e0b72ebe66mr12848791a91.15.1727575642243; Sat, 28 Sep 2024
 19:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com> <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
 <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com> <CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
 <6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
In-Reply-To: <6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Sep 2024 10:07:11 +0800
Message-ID: <CACGkMEtscr17UOufUtyPp1OvALL8LcycpbRp6CyVMF=jYzAjAA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 3:51=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/09/27 13:31, Jason Wang wrote:
> > On Fri, Sep 27, 2024 at 10:11=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> On 2024/09/25 12:30, Jason Wang wrote:
> >>> On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> virtio-net have two usage of hashes: one is RSS and another is hash
> >>>> reporting. Conventionally the hash calculation was done by the VMM.
> >>>> However, computing the hash after the queue was chosen defeats the
> >>>> purpose of RSS.
> >>>>
> >>>> Another approach is to use eBPF steering program. This approach has
> >>>> another downside: it cannot report the calculated hash due to the
> >>>> restrictive nature of eBPF.
> >>>>
> >>>> Introduce the code to compute hashes to the kernel in order to overc=
ome
> >>>> thse challenges.
> >>>>
> >>>> An alternative solution is to extend the eBPF steering program so th=
at it
> >>>> will be able to report to the userspace, but it is based on context
> >>>> rewrites, which is in feature freeze. We can adopt kfuncs, but they =
will
> >>>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KV=
M
> >>>> and vhost_net).
> >>>>
> >>>
> >>> I wonder if we could clone the skb and reuse some to store the hash,
> >>> then the steering eBPF program can access these fields without
> >>> introducing full RSS in the kernel?
> >>
> >> I don't get how cloning the skb can solve the issue.
> >>
> >> We can certainly implement Toeplitz function in the kernel or even wit=
h
> >> tc-bpf to store a hash value that can be used for eBPF steering progra=
m
> >> and virtio hash reporting. However we don't have a means of storing a
> >> hash type, which is specific to virtio hash reporting and lacks a
> >> corresponding skb field.
> >
> > I may miss something but looking at sk_filter_is_valid_access(). It
> > looks to me we can make use of skb->cb[0..4]?
>
> I didn't opt to using cb. Below is the rationale:
>
> cb is for tail call so it means we reuse the field for a different
> purpose. The context rewrite allows adding a field without increasing
> the size of the underlying storage (the real sk_buff) so we should add a
> new field instead of reusing an existing field to avoid confusion.
>
> We are however no longer allowed to add a new field. In my
> understanding, this is because it is an UAPI, and eBPF maintainers found
> it is difficult to maintain its stability.
>
> Reusing cb for hash reporting is a workaround to avoid having a new
> field, but it does not solve the underlying problem (i.e., keeping eBPF
> as stable as UAPI is unreasonably hard). In my opinion, adding an ioctl
> is a reasonable option to keep the API as stable as other virtualization
> UAPIs while respecting the underlying intention of the context rewrite
> feature freeze.

Fair enough.

Btw, I remember DPDK implements tuntap RSS via eBPF as well (probably
via cls or other). It might worth to see if anything we miss here.

Thanks

>
> Regards,
> Akihiko Odaki
>

