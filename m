Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D242A83
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 04:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727411502; cv=none; b=D35nD9I4Jlb32Av9qwJ+pfFpn+7/cbATU1elJbSoQMVNPpF1zOqqyj09jR6hsG1ylaTI7Y+sF313MHmjHkXCDusjxsKTvdDl66SO3ozFd4i8sq2zuzNFDLhJtzGwbLXzRsZiq1Gv7vw61jFt+tLolZCAMI5xyFuD7dNqY3+pXVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727411502; c=relaxed/simple;
	bh=uBFmWoNeX1W+Cqs2iNWdisHneux0lZanwha6u5m3aww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2exMJOx+c8FZiIAVfn9s0FeHc1pM6xB9u+W7N/abWAnEmW9GbxBsCcaNZIXaICLdhjmytzxT+0f+6ys7dbLVSOEXMzzjj7lcx6KWKIn3w2dtAIiXGJyb7LJWASwYEy0xJ690RMRux3P45zkkG6M0M6rGDM+ahKkVXETD3SGngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eceOl/hf; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eceOl/hf"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56CB780A9C
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 04:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MKiD_TzL8h9n for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Sep 2024 04:31:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9695780A8F
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9695780A8F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eceOl/hf
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9695780A8F
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 04:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727411498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBFmWoNeX1W+Cqs2iNWdisHneux0lZanwha6u5m3aww=;
	b=eceOl/hfxFC6N2gsnjPjFnA+kySEiWcXXuwUtWECgY6uTtyDMCuq1uwxjOky+Q+vAUEJZ4
	mzrcy7yB3wI2i/INsKMAHkpRvbCECDrVUU+ED0/9Ankc9FDub0Yoa4uGmtOiWCi4l5OiFd
	LZjFw0ciCaHkd/Xf3km30dmIpRGjhrQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-WUwx03DIPMS1L_Yh5GqRxg-1; Fri, 27 Sep 2024 00:31:36 -0400
X-MC-Unique: WUwx03DIPMS1L_Yh5GqRxg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7d5a54dcaefso1455634a12.2
        for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 21:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727411495; x=1728016295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBFmWoNeX1W+Cqs2iNWdisHneux0lZanwha6u5m3aww=;
        b=EsWV9G2Zd3Zx79ODA7WvqTIbY1VgsGuOfhkjBLL3FXmXZIGinJgCOxIE6DqTeBg4TI
         5jBUIjsuGLeMU+j/RBsxZfHvtzxo1CFSiaAUdFJ0OV5bf1Xiwnwx4VLLS0Qvdmk9uq/j
         B2XGuZj7mWnqLhVDh/MbQFuMbkC3L9yTDiIkWbDRQ0MoKWCQGQgiSwUobKwMhL2vLfNM
         LMpP8iaI8vgABYKfsJEWTSSXSGgTrtbRKT+lD1lO41+vnavEYAS5/03epoNQfjzfRJ0v
         HiWK9cfG+Iqp9XH9ssZ0sJxz5YhcneF3O1TMz19biqBwxVia7wfKO1xoJsfnO/c33inR
         0iwg==
X-Forwarded-Encrypted: i=1; AJvYcCXPxxVgU7VWmBwB+cde2+dCjx+AIZXhEZ4d00hcQDeM8K3h7zLpE0lobDLaY8IAogmEqNAzq1I8rhy11MJ49w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxsdhByjp5gDyu6T9FsZdW/qJxpaLfBlVGua2ZaZx3LaelK3yKg
	DHiGdHp/JFoVmbA8Y7IJafBdzmKRquu+rFXpfEBiQiFz1sZHJfVRabF22seaetCkKTkSD2gsw7t
	IWg0RfeZPvv3c4EejLFFSrIdW8UmmCXd3lyYnZ/gbRoMyeGiqG/ArFdjOVOB6Juf5hi14V9FZCG
	41FaA4cqTEZLYyHxhRQKk2AtCQiFQyHlPynryzvsOc7h7Fia3DLilyuw==
X-Received: by 2002:a17:90b:234a:b0:2c2:df58:bb8c with SMTP id 98e67ed59e1d1-2e0b8b149dcmr2167107a91.18.1727411495486;
        Thu, 26 Sep 2024 21:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIh5lwZF9CJKh17SEpxaaZJy38bFfod3VEXz7y4ASCqLDiCeaKdZmiGJ67AwnOYjAbQZ+yUYlkT0W4m1tjn8U=
X-Received: by 2002:a17:90b:234a:b0:2c2:df58:bb8c with SMTP id
 98e67ed59e1d1-2e0b8b149dcmr2167084a91.18.1727411494914; Thu, 26 Sep 2024
 21:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com> <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
 <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
In-Reply-To: <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:31:23 +0800
Message-ID: <CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
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

On Fri, Sep 27, 2024 at 10:11=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2024/09/25 12:30, Jason Wang wrote:
> > On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> virtio-net have two usage of hashes: one is RSS and another is hash
> >> reporting. Conventionally the hash calculation was done by the VMM.
> >> However, computing the hash after the queue was chosen defeats the
> >> purpose of RSS.
> >>
> >> Another approach is to use eBPF steering program. This approach has
> >> another downside: it cannot report the calculated hash due to the
> >> restrictive nature of eBPF.
> >>
> >> Introduce the code to compute hashes to the kernel in order to overcom=
e
> >> thse challenges.
> >>
> >> An alternative solution is to extend the eBPF steering program so that=
 it
> >> will be able to report to the userspace, but it is based on context
> >> rewrites, which is in feature freeze. We can adopt kfuncs, but they wi=
ll
> >> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> >> and vhost_net).
> >>
> >
> > I wonder if we could clone the skb and reuse some to store the hash,
> > then the steering eBPF program can access these fields without
> > introducing full RSS in the kernel?
>
> I don't get how cloning the skb can solve the issue.
>
> We can certainly implement Toeplitz function in the kernel or even with
> tc-bpf to store a hash value that can be used for eBPF steering program
> and virtio hash reporting. However we don't have a means of storing a
> hash type, which is specific to virtio hash reporting and lacks a
> corresponding skb field.

I may miss something but looking at sk_filter_is_valid_access(). It
looks to me we can make use of skb->cb[0..4]?

Thanks

>
> Regards,
> Akihiko Odaki
>

