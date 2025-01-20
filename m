Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A61DF27A
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372030; cv=none; b=GGq73zfnM0t1EL2Ok7MZOwA1Cb8FL4UEDeq5fNm0u2oDAUCV3hYvc8+CPAMZgwu6Dxl5AjNGr3aGDDmAwfqkjFH5qmET8ngEPBDcDTTYWS0riaEaL6B3Mn8ulTJSxMLItcRw3yPM81iCDzd03JZPwleEYrcSOuHYZQqog9XI0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372030; c=relaxed/simple;
	bh=HukkzVgJWy6wIfrwhhW16Kaa45VNmNtSiyTH/3KseCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgPLrzzjGvhACJJ/o0utrOQOilfblKM2IEnLlPPifNLczhJn/EqGEZATK6UaOe9w9ufD0jzOm/V6S+0zRE7+QUghMinu02uYUxKhL64UCHAk91wcPbLrzTbY1f3bGlenBxVHc+pw79qF5cWVc6ecKiY2XlZj0fIgHxBKTMkzeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EW8L18s1; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EW8L18s1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 177C0810C9
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:20:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -17.601
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KKQB3DeJY2Jh for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 11:20:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=willemb@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0634881096
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0634881096
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=EW8L18s1
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0634881096
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:20:25 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-53f22fd6887so4400501e87.2
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737372024; x=1737976824; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=508sHaRatzNmV2AC5YDUok9kXq8AxMjNJqX2AsrhRz0=;
        b=EW8L18s1q4S6gNZhhJAq0/m4gYEwTuJZX2U8hM9ldv7h/6l9hHrkqjRs0QeGypzl+M
         UTxImBmo6L3XUBaDfgUxW6F05+WyRP4bTvyJoNwx3EJur/K9rsRjZ/UkC0+YCPkK98i8
         LqoEK1quS4KMy7McJKeIFc9RhXTAMM3Ab24CuPLS5DWRJYQhodAVncNXPxWmp80Tpc6e
         GioqSa3wn/ow6CZi1uXW1rz8aqgquLG9ngXNsSiitJBSSNXp4tL729iojVfeJoaSErBk
         IChGBBsB1ihBRC2/2kfj6RVkhZlFkxU7j+80LmdPwoVNVKKVlRF5V9870uijfF26pbvg
         tydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372024; x=1737976824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=508sHaRatzNmV2AC5YDUok9kXq8AxMjNJqX2AsrhRz0=;
        b=UbQE1lrmgBuIy6YXmZ7zCb3tIWnuVq94CshL470Fxqo1UgWQ6vdm7fxVnQsavm6sg5
         kg1IKJpe/xoC1oDh2bZyORL19SnfZZrOiLUXUL+JUx6MwmKGmGWg0x50ejy74TVZlSfP
         t+w4khGbnc1MObhlohBEM1llBQ7REYSHryDu4gdegv0fXbWuewMltJMLUnYhJs13UsOG
         MH76HgH5GTg1+ho2QJiokOpf5ikaw1K/4C5AmcKBOV1DZhubrOas3R/zBv//HcDnC4aZ
         h2i5cQoOE4RBBg9fwjSkO/8w3aGOJYjSSNfbnmpYnGKldHnyCl5GF34W5YTnEIvLCiK2
         OhDg==
X-Forwarded-Encrypted: i=1; AJvYcCWdbq2+ePvBJhoRmo6igr+ocMQkJEDmpAl9Ya63JMDbMUxmHZSwF28gKoRuYqRYoAqSCqVhSaqTQemRlLlfxw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzYvgNpjZ9gnO7P5rkzl1hhTG5OtIoDOwhbe3+7CpkwU/CBdEx4
	flMcToG2J/pqmFGHJv+vXBT4ylQBpkunbkaopiQxzmKNi6enmxNu6Lbn+7Dz3QuI3EBxcUzLsQl
	QobIklwf0gLA3DV2iFJZM+BBWP7cZSGWVTzUr
X-Gm-Gg: ASbGncua43OrhgOvpGdaFwQ94lbWtynLxX7k8fvMYzqY1JB+py9MJgs/VxpNXaO7HJN
	88YkOP/3KMSWy6uDDKZxvKZWv6PB8m3L2xut6E8saPURNyDGbD0s=
X-Google-Smtp-Source: AGHT+IG5bUWJMn934aJFLLbqBw2AOkIQsKQjJQf+FW5w2joFGVMUSmQehttNlWkcrmhhT9aHd4c5YEvXBK36xXQTVQg=
X-Received: by 2002:a05:6512:33cf:b0:542:2a0b:cdd4 with SMTP id
 2adb3069b0e04-5439c287e81mr4094208e87.47.1737372023561; Mon, 20 Jan 2025
 03:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com> <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
 <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
 <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com> <CACGkMEuPXDWHErCCdEUB7+Q0NxsAjpSH9uTvOxzuBvNeyw7_Hg@mail.gmail.com>
In-Reply-To: <CACGkMEuPXDWHErCCdEUB7+Q0NxsAjpSH9uTvOxzuBvNeyw7_Hg@mail.gmail.com>
From: Willem de Bruijn <willemb@google.com>
Date: Mon, 20 Jan 2025 12:19:46 +0100
X-Gm-Features: AbW1kvafrr-kRH1qQ-nNk15dryD6rNi5eAueO9Om8WJCSgPSnlELq-Vuki0tXiI
Message-ID: <CA+FuTSec1z7-8nNNc1ZXkzekDrFHPnvYKFf8PNZg89VuwhoWSw@mail.gmail.com>
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 1:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jan 17, 2025 at 6:35=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayn=
ix.com> wrote:
> >
> > On 2025/01/17 18:23, Willem de Bruijn wrote:
> > > Akihiko Odaki wrote:
> > >> tun and tap implements the same vnet-related features so reuse the c=
ode.
> > >>
> > >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > >> ---
> > >>   drivers/net/Kconfig    |   1 +
> > >>   drivers/net/Makefile   |   6 +-
> > >>   drivers/net/tap.c      | 152 +++++--------------------------------=
------------
> > >>   drivers/net/tun_vnet.c |   5 ++
> > >>   4 files changed, 24 insertions(+), 140 deletions(-)
> > >>
> > >> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > >> index 1fd5acdc73c6..c420418473fc 100644
> > >> --- a/drivers/net/Kconfig
> > >> +++ b/drivers/net/Kconfig
> > >> @@ -395,6 +395,7 @@ config TUN
> > >>      tristate "Universal TUN/TAP device driver support"
> > >>      depends on INET
> > >>      select CRC32
> > >> +    select TAP
> > >>      help
> > >>        TUN/TAP provides packet reception and transmission for user s=
pace
> > >>        programs.  It can be viewed as a simple Point-to-Point or Eth=
ernet
> > >> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> > >> index bb8eb3053772..2275309a97ee 100644
> > >> --- a/drivers/net/Makefile
> > >> +++ b/drivers/net/Makefile
> > >> @@ -29,9 +29,9 @@ obj-y +=3D mdio/
> > >>   obj-y +=3D pcs/
> > >>   obj-$(CONFIG_RIONET) +=3D rionet.o
> > >>   obj-$(CONFIG_NET_TEAM) +=3D team/
> > >> -obj-$(CONFIG_TUN) +=3D tun-drv.o
> > >> -tun-drv-y :=3D tun.o tun_vnet.o
> > >> -obj-$(CONFIG_TAP) +=3D tap.o
> > >> +obj-$(CONFIG_TUN) +=3D tun.o
> > >
> > > Is reversing the previous changes to tun.ko intentional?
> > >
> > > Perhaps the previous approach with a new CONFIG_TUN_VNET is preferabl=
e
> > > over this. In particular over making TUN select TAP, a new dependency=
.
> >
> > Jason, you also commented about CONFIG_TUN_VNET for the previous
> > version. Do you prefer the old approach, or the new one? (Or if you hav=
e
> > another idea, please tell me.)
>
> Ideally, if we can make TUN select TAP that would be better. But there
> are some subtle differences in the multi queue implementation. We will
> end up with some useless code for TUN unless we can unify the multi
> queue logic. It might not be worth it to change the TUN's multi queue
> logic so having a new file seems to be better.

+1 on deduplicating further. But this series is complex enough. Let's not
expand that.

The latest approach with a separate .o file may have some performance
cost by converting likely inlined code into real function calls.
Another option is to move it all into tun_vnet.h. That also resolves
the Makefile issues.
