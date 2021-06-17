Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E8AC2B9F4
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 11:47:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169F261410
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 11:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169F261410
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4382415D3;
	Thu, 17 Jun 2021 11:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oiEDzif8QClx; Thu, 17 Jun 2021 11:47:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 00495415D6;
	Thu, 17 Jun 2021 11:47:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4862C000E;
	Thu, 17 Jun 2021 11:47:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D89D0C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 11:47:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE6FB4057B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 11:47:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f0VF6wArkkC0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 11:47:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DBB2400D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 11:47:53 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id v13so2782101ple.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QasMKCIaT47MEF+OQcq8zCDU70HNznQ46OZY6zak3V8=;
 b=YjZuzJ+NWs/14eFKW5mhz42xgNpTsEoV8oZ4cGMsIt9+TzUz1kdmMAfO7xXHgkQq0g
 Ia52JM8iI2whXeKXN/2K6F02pd30D8emps0Jz+/nxWU8zMyroF/HKtyZs5qCYlzNmEFJ
 m1yVj/8f0dsS3m91UPPLrJbA2NkmqZvlrMmaw9lNTbI7VTp9n0jNRu9BOOijGr2AEU18
 UDj8Jdz3wNufxBoaVID02yn3JU9Jx6JugUxGJy8fvS3DFGr1i+L/IPXOWIzR9TlnRoRh
 9r23X01QaTcw9X0haydqFp7C96joqt3lzre2lMeS5hILGfLAh249oeK4Yi6TA9AHtQlQ
 VIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QasMKCIaT47MEF+OQcq8zCDU70HNznQ46OZY6zak3V8=;
 b=ryVJLZMEesemSxQL6rtwdQfB5RSsPbwVVQ3BAX5aDEIBKOf/PRkbvt3clIk5mxgIbv
 K2+4VLX0Gl3dT5JIjzsTKyEApeJ7h0patLfoZUS8yfB+pp/lYYjI9sypvka6jwdY8WNi
 bglc6MUzpJDzcZPFMZfNGBlrch8D5xvWDsDgyuZSIcYgSlz0Fr36oQJ3DV0FtJDwr4rm
 BFBmBjyMwls5ctNytW9U9wsv+XHCCARLUgZ397hyOz81OLQUyiF/M2KIbw9UV/l/+Ver
 WpdHjU2dxpk47WW0VUq+4F41+wThnS8WrFduaHy4ZffUI3tR9vW1i6mjVkwHbDL/Olta
 t2jw==
X-Gm-Message-State: AOAM532FsZSnSC8BrTTZEZYpactk0jZ/69YC7aW7j5UzDRHB1WDTAwVO
 ny1PFVoGnIhJpQNVGZGKKJbjnQ==
X-Google-Smtp-Source: ABdhPJxIrIzZcQtKYc+FRL5bxfc04IWWpEdqgixoIsZEOGYOtWJ6eX9RHjce0kFNtrQQQX1ZD1W97A==
X-Received: by 2002:a17:90a:6b42:: with SMTP id
 x2mr5108905pjl.16.1623930472719; 
 Thu, 17 Jun 2021 04:47:52 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id u23sm6288551pgk.38.2021.06.17.04.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jun 2021 04:47:51 -0700 (PDT)
Date: Thu, 17 Jun 2021 17:17:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20210617114749.uueu2v63duepfunb@vireshk-i7>
References: <20210616114934.n3grzuh6c64wlaj6@vireshk-i7>
 <5cffb354-0d00-5ace-260d-61ac0c4c7491@metux.net>
 <20210617035901.kfzps6kg2emthjf4@vireshk-i7>
 <116f8135-4ddf-e8fc-6838-94093702ec3d@metux.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <116f8135-4ddf-e8fc-6838-94093702ec3d@metux.net>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Anton Vorontsov <anton@enomsg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Kees Cook <keescook@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Tony Luck <tony.luck@intel.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Colin Cross <ccross@android.com>,
 linux-riscv <linux-riscv@lists.infradead.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 17-06-21, 11:54, Enrico Weigelt, metux IT consult wrote:
> Actually, I am subscribed in the list. We already had debates on it,
> including on your postings (but also other things).

Right.

> And the ascii
> version of the spec actually landed on the list last year, we had
> discussions about it there.

I tried to search for it earlier, but never found anything on virtio
list.  Maybe I missed it then.

> I've just had the problem that my patches didn't go through, which is
> very strange, since I actually am on the list and other mails of mine
> went through all the time. I'm now suspecting it's triggered by some
> subtle difference between my regular mail clients and git send-email.
> 
> > Since you started this all and still want to do it, I will take my
> > patches back and let you finish with what you started. I will help
> > review them.
> 
> Thank you very much.
> 
> Please don't me wrong, I really don't wanna any kind of power play, just
> wanna get an technically good solution. If there had been any mis-
> understandings at that point, I'm officially saying sorry here.

Its okay, we are both trying to make things better here :)

> Let's be friends.
> 
> You mentioned you've been missing with my spec. Please come foreward and
> tell us what exactly you're missing and what your use cases are.

I have sent a detailed review of your spec patch, lets do it there
point by point :)

> Note that I've intentionally left off certain "more sophisticated"
> functionality we find on *some* gpio controllers, eg. per-line irq
> masking, pinmux settings for several reasons, e.g.:
> 
> * those are only implemented by some hardware
> * often implemented in or at least need to be coordinated with other
>   pieces of hw (e.g. in SoCs, pinmux is usually done in a separate
>   device)
> * it shall be possible to support even the most simple devices and
>   have the more sophisticated things totally optional. minium
>   requirements for silicon implementations should be the lowest possible
>   (IOW: minimal number of logic gates)
> 
> >> You sound like a politician that tries to push an hidden agenda,
> >> made by some secret interest group in the back room, against the
> >> people - like "resistance is futile".
> >
> > :)
> 
> Perhaps I've been a bit overreacting at that point. But: this is really
> that kind of talking we hear from politicians and corporate leaders
> since many years, whenever they wanna push something through that we the
> people don't want. Politicians use that as a social engineering tool for
> demotivating any resistance. Over heare in Germany this even had become
> a meme, and folks from CCC made a radio show about and named by that
> (the German word is "alternativlos" - in english: without any
> alternative). No idea about other countries, maybe it's a cultural
> issue, but over here, those kind of talking had become a red light.
> 
> Of course, I never intended to accuse you of being one of these people.
> Sorry if there's been misunderstanding.

It sounded strange yesterday to be honest, but I have gone past it
already :)
 
> Let's get back to your implementation: you've mentioned you're routing
> raw virtio traffic into userland, to some other process (outside VMMs
> like qemu) - how exactly are you doing that ?
> 
> That could be interesting for completely different scenarios. For
> example, I'm currently exploring how to get VirGL running between separate
> processes running under the same kernel instance (fow now we
> only have the driver side inside VM and the device outside it), means
> driver and device are running as separate processes.
> 
> The primary use case are containers that shall have really GPU generic
> drivers, not knowing anything about the actual hardware on the host.
> Currently, container workloads wanting to use a GPU need to have special
> drivers for exactly the HW the host happens to have. This makes generic,
> portable container images a tuff problem.
> 
> I haven't digged deeply into the matter, but some virtio-tap transport
> could be an relatively easy (probably not the most efficient) way to
> solve this problem. In that scanario it would like this:
> 
> * we have a "virgl server" (could be some X or wayland application, or
>   completely own compositor) opens up the device-end of an "virtio-tap"
>   transport and attaches its virtio-gpio device emulation on it.
> * "virtio-tap" now creates a driver-end, kernel probes an virtio-gpu
>   instance on this (also leading to a new DRI device)
> * container runtime picks the new DRI device and maps it into the
>   container(s)
>   [ yet open question, whether one DRI device for many containers
>     is enough ]
> * container application sees that virtio-gpu DRI device and speaks to
>   it (mesa->virgl backend)
> * the "virgl-server" receives buffers and commands from via virtio and
>   sends them to the host's GL or Gallium API.
> 
> Once we're already there, we might think whether it could make sense
> putting virtio routing into kvm itself, instead of letting qemu catch
> page faults and virtual irqs. Yet have to see whether that's a good
> idea, but I can imagine some performance improvements here.

We (at Linaro) work on software enablement normally and not end
products (rarely that happen though), like framework level work in the
kernel which can later be used by everyone to build their drivers on.

There are many companies like Qualcomm, ST Micro, etc, who want to use
Virtio in general for Automotive or other applications / solution. The
purpose of Project Stratos [1], an initiative of Linaro, is working
towards developing hypervisor agnostic Virtio interfaces and
standards. The end products and applications will be worked on by the
members directly and we need to add basic minimum support, with all
the generally required APIs or interfaces.

-- 
viresh

[1] https://linaro.atlassian.net/wiki/spaces/STR/overview
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
