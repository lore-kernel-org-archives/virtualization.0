Return-Path: <SRS0=CB8P=DZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447E2C433E7
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 16:35:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B9B20874
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 16:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcXtCnKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B9B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1DF44228D5;
	Sun, 18 Oct 2020 16:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lEiJ1OSbmIh0; Sun, 18 Oct 2020 16:35:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 29EB32288F;
	Sun, 18 Oct 2020 16:35:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19D48C088B;
	Sun, 18 Oct 2020 16:35:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82727C0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 16:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 77D23228B3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 16:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0rgS99b0d+Fc
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 16:35:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 2A7062288F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 16:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603038935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwtWnuB2kSY8HFQICilrmvB9NiLAnGrV11+EFgQMsrc=;
 b=RcXtCnKGUpmQTcsIPY51r/9r+ca9V94BCQy4UkVcYZmXOG5F3OrqvfJfQkMQC9E4Tnn0as
 P9DXuFOVBVf/06I/EIdm2f/EdiCfPRgz04ydFlwz+y7H+cGbRi2Xyhq1y4gOt2hkJI/u2a
 u+zhSyrpbcrtBxLzP1f/AgtFD1jF64E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-oK46LfG-NheSQOZCUQ93kA-1; Sun, 18 Oct 2020 12:35:32 -0400
X-MC-Unique: oK46LfG-NheSQOZCUQ93kA-1
Received: by mail-ej1-f72.google.com with SMTP id k23so3713130ejx.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 09:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=RY0f+Ml007JAsH07kY6MGpcOC0lcirSpPFKLKx43wmI=;
 b=fM0TcKaoclIYM+NSzMciLcxLcmr0nNLn/YddkUYtHgD2zdYIyIsTNGP8R6dqbg7GBA
 krc6sSAZpYr2TocWtenhbKkZ6dCCuQwZDfxLMdyRlLr8V9LlQJUqu8q+2MjQaE0zOFRU
 YA9Cr044490KPoICZ1+4YFuatyxCU7ghwhVNUv6IkniGhKyHge32BGvq4eb4ZjyrrtRl
 ahq7ixlzxZNERNi+C7BJycmi2Hx9F7bLi6IAOObfDk+P7JURqDKy6JLZYMe8oC1e6AHb
 7D8pi+ZjDFhYzTkyEd7pHgEuTXB7kNqOTBww7mVCocG4Lk0F6EOMkPjRrMxethWTCpC7
 zxcA==
X-Gm-Message-State: AOAM531GCPU3GIC85SwYfUXEamhVfqVQmQXWirT2KRtczRe5e2Y6+jLo
 /I6miUG0tKfAOkncZyPKu6pct/qL7nl0/Blrz0eiQNWY2BGidUcHt265FDwh6suR1s5krMvOoCX
 o3NO0KaARqB5Nlx5xlHGPthfHj3gMgiFFY9wUoEVxqg==
X-Received: by 2002:a17:906:f2d2:: with SMTP id
 gz18mr13312084ejb.542.1603038931369; 
 Sun, 18 Oct 2020 09:35:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi1qZzl/6znUyZOzcb/F4zOcFn3HuKD3/8mDE/7uN9jKVozUvtrDX4cd3jS1AGLUL8Kc3Vpg==
X-Received: by 2002:a17:906:f2d2:: with SMTP id
 gz18mr13312066ejb.542.1603038931204; 
 Sun, 18 Oct 2020 09:35:31 -0700 (PDT)
Received: from [192.168.3.114] (p4ff233d0.dip0.t-ipconnect.de. [79.242.51.208])
 by smtp.gmail.com with ESMTPSA id 59sm7524881ede.73.2020.10.18.09.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 09:35:30 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 00/29] virtio-mem: Big Block Mode (BBM)
Date: Sun, 18 Oct 2020 18:35:30 +0200
Message-Id: <045CE408-5E44-4334-8FC2-2C6E88D4EA07@redhat.com>
References: <20201018124954.GA51680@L-31X9LVDL-1304.local>
In-Reply-To: <20201018124954.GA51680@L-31X9LVDL-1304.local>
To: Wei Yang <richard.weiyang@linux.alibaba.com>
X-Mailer: iPhone Mail (18A393)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
 Oscar Salvador <osalvador@suse.de>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3438899272660346102=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============3438899272660346102==
Content-Type: multipart/alternative; boundary=Apple-Mail-763CD893-7BF7-4854-9F45-FB7ED5189371

--Apple-Mail-763CD893-7BF7-4854-9F45-FB7ED5189371
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable


> Am 18.10.2020 um 14:50 schrieb Wei Yang <richard.weiyang@linux.alibaba.co=
m>:
>=20
> =EF=BB=BFOn Mon, Oct 12, 2020 at 02:52:54PM +0200, David Hildenbrand wrot=
e:
>> virtio-mem currently only supports device block sizes that span at most
>> a single Linux memory block. For example, gigantic pages in the hypervis=
or
>> result on x86-64 in a device block size of 1 GiB - when the Linux memory
>> block size is 128 MiB, we cannot support such devices (we fail loading t=
he
>> driver). Of course, we want to support any device block size in any Linu=
x
>> VM.
>>=20
>> Bigger device block sizes will become especially important once supporti=
ng
>> VFIO in QEMU - each device block has to be mapped separately, and the
>> maximum number of mappings for VFIO is 64k. So we usually want blocks in
>> the gigabyte range when wanting to grow the VM big.
>>=20
>> This series:
>> - Performs some cleanups
>> - Factors out existing Sub Block Mode (SBM)
>> - Implements memory hot(un)plug in Big Block Mode (BBM)
>>=20
>> I need one core-mm change, to make offline_and_remove_memory() eat bigge=
r
>> chunks.
>>=20
>> This series is based on "next-20201009" and can be found at:
>>    git@gitlab.com:virtio-mem/linux.git virtio-mem-dbm-v1
>>=20
>=20
> I am trying to apply this patch set, while found I can't 'git fetch' this
> repo. Is there any other repo I would apply this patch set?
>=20

Sorry I tool the wrong repo. It=E2=80=98s on my github:

https://github.com/davidhildenbrand/linux/tree/virtio-mem-dbm-v1

> --=20
> Wei Yang
> Help you, Help me
>=20

--Apple-Mail-763CD893-7BF7-4854-9F45-FB7ED5189371
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto"><br><div dir=3D"ltr"><blockquote type=
=3D"cite">Am 18.10.2020 um 14:50 schrieb Wei Yang &lt;richard.weiyang@linux=
.alibaba.com&gt;:<br><br></blockquote></div><blockquote type=3D"cite"><div =
dir=3D"ltr">=EF=BB=BF<span>On Mon, Oct 12, 2020 at 02:52:54PM +0200, David =
Hildenbrand wrote:</span><br><blockquote type=3D"cite"><span>virtio-mem cur=
rently only supports device block sizes that span at most</span><br></block=
quote><blockquote type=3D"cite"><span>a single Linux memory block. For exam=
ple, gigantic pages in the hypervisor</span><br></blockquote><blockquote ty=
pe=3D"cite"><span>result on x86-64 in a device block size of 1 GiB - when t=
he Linux memory</span><br></blockquote><blockquote type=3D"cite"><span>bloc=
k size is 128 MiB, we cannot support such devices (we fail loading the</spa=
n><br></blockquote><blockquote type=3D"cite"><span>driver). Of course, we w=
ant to support any device block size in any Linux</span><br></blockquote><b=
lockquote type=3D"cite"><span>VM.</span><br></blockquote><blockquote type=
=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span>Big=
ger device block sizes will become especially important once supporting</sp=
an><br></blockquote><blockquote type=3D"cite"><span>VFIO in QEMU - each dev=
ice block has to be mapped separately, and the</span><br></blockquote><bloc=
kquote type=3D"cite"><span>maximum number of mappings for VFIO is 64k. So w=
e usually want blocks in</span><br></blockquote><blockquote type=3D"cite"><=
span>the gigabyte range when wanting to grow the VM big.</span><br></blockq=
uote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote ty=
pe=3D"cite"><span>This series:</span><br></blockquote><blockquote type=3D"c=
ite"><span>- Performs some cleanups</span><br></blockquote><blockquote type=
=3D"cite"><span>- Factors out existing Sub Block Mode (SBM)</span><br></blo=
ckquote><blockquote type=3D"cite"><span>- Implements memory hot(un)plug in =
Big Block Mode (BBM)</span><br></blockquote><blockquote type=3D"cite"><span=
></span><br></blockquote><blockquote type=3D"cite"><span>I need one core-mm=
 change, to make offline_and_remove_memory() eat bigger</span><br></blockqu=
ote><blockquote type=3D"cite"><span>chunks.</span><br></blockquote><blockqu=
ote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><=
span>This series is based on "next-20201009" and can be found at:</span><br=
></blockquote><blockquote type=3D"cite"><span> &nbsp; &nbsp;git@gitlab.com:=
virtio-mem/linux.git virtio-mem-dbm-v1</span><br></blockquote><blockquote t=
ype=3D"cite"><span></span><br></blockquote><span></span><br><span>I am tryi=
ng to apply this patch set, while found I can't 'git fetch' this</span><br>=
<span>repo. Is there any other repo I would apply this patch set?</span><br=
><span></span><br></div></blockquote><div><br></div><div>Sorry I tool the w=
rong repo. It=E2=80=98s on my github:</div><div><br></div><div><a href=3D"h=
ttps://github.com/davidhildenbrand/linux/tree/virtio-mem-dbm-v1">https://gi=
thub.com/davidhildenbrand/linux/tree/virtio-mem-dbm-v1</a></div><br><blockq=
uote type=3D"cite"><div dir=3D"ltr"><span>-- </span><br><span>Wei Yang</spa=
n><br><span>Help you, Help me</span><br><span></span><br></div></blockquote=
></body></html>
--Apple-Mail-763CD893-7BF7-4854-9F45-FB7ED5189371--


--===============3438899272660346102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3438899272660346102==--

