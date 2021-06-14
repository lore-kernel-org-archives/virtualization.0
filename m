Return-Path: <SRS0=07LM=LI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB07C48BE6
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 09:52:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8A761357
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 09:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8A761357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7800181B9D;
	Mon, 14 Jun 2021 09:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TC22LHz8xnpG; Mon, 14 Jun 2021 09:52:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D995081AA7;
	Mon, 14 Jun 2021 09:52:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7E3AC000D;
	Mon, 14 Jun 2021 09:52:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C2B2C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 475A14046F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gT2uWHdo-SPX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:52:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 585AA40459
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:52:24 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 x21-20020a17090aa395b029016e25313bfcso9810364pjp.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tyrwULaDA/8yLqlpZdEOiGOlczFmIcq5jIHr0JXrByc=;
 b=igPrVeoHcTmiAINqhls6RiJIDB5nLDcSwdZ3KpExZuE8yIUZMRE1RVmBm+B0fXRIyB
 6ew0i/Ft0rDT+XS5FZf4NnMvWhY8OhRlIhSSvjrha4+p9GtHzdWDfp/C9QLrdWDJsxmX
 qxp4xFgElsZTEkQTGWYkHbx6zEz7RFqykq/1SlcX5WQ9RjPmy16hpDvvmEmmv0A3GcL6
 HLSCp5yL4L6wJ82932X6X9djic9QkAGXl4cCM25kjm+J1bMx1Q53X9ivtme2uTZv8kKI
 Wgc+c7O5qFXbU1v8N5gb7swqmNalHRSEHxyDVGXgnzJPySQT21tPHhCi6QkTzJn/52ZU
 shVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tyrwULaDA/8yLqlpZdEOiGOlczFmIcq5jIHr0JXrByc=;
 b=dU75Rjha5mOBuwoUuIP7FlOJ6bBv+XAU8ySzRSJWuC5hVMX0Bcl7ZWhdc7VQVLdXkE
 CzwWzH0Hw0slBEQiB5l0J6J7rDUzl2g2UcXV2nWFdPbX5RLdM9iTIGdt5VD13me9P1bE
 66AwwWGEMRRKQSgDU2r797/iNHC3I6YMFGwrXrXolQMkWx5OVp01H6Xpt1/4vQ2BSmFF
 4kH7hGPTDDZvSs0X/SQH7zAZMG/TkB5L4aeItA2Jp3Vmdx8PzIu1Tw6ZE0OLJDTSUFYR
 LzT2GY/FYPGqSeuoUlq9DJnUj0Erqk4hKKCToQjAiCzI2SZSFuOYfqVRtkiRtp0wDyHb
 r7Sw==
X-Gm-Message-State: AOAM531Quf/3+WA8uSuN/1YLEUEL8N2qmvxFDnAbz5HeSHmP6NFIMM8V
 2Qfy2R4DYNlS69G3aglCZnNTzg==
X-Google-Smtp-Source: ABdhPJzrnSMBDHqHbJTk9n5Gre9pL7dGgqKtzvv6r3635rG525QZ1LkuwmofSJGB7i19czbV3jBH/Q==
X-Received: by 2002:a17:90a:2d8e:: with SMTP id
 p14mr17631924pjd.131.1623664343718; 
 Mon, 14 Jun 2021 02:52:23 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id v1sm12224241pfi.194.2021.06.14.02.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jun 2021 02:52:23 -0700 (PDT)
Date: Mon, 14 Jun 2021 15:22:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210614095221.7qngyzhbxbckolpj@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
 <0478822f-9d10-deb8-86ae-3b4ac3bb0c6c@metux.net>
 <CAHp75Vf0+bCnnD3wtkrPvFbr2k3A0r3eWNp87PyksiC7euaqdw@mail.gmail.com>
 <d127bb4c-722d-536b-c89f-4c40cbaa6479@metux.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d127bb4c-722d-536b-c89f-4c40cbaa6479@metux.net>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 stratos-dev@op-lists.linaro.org, "Enrico Weigelt,
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

On 14-06-21, 11:17, Enrico Weigelt, metux IT consult wrote:
> On 14.06.21 10:12, Andy Shevchenko wrote:
> 
> > That's why we have a thing called standard. And AFAIU virtio API/ABIs
> > should be officially registered and standardized.
> 
> Absolutely.
> 
> I've submitted my spec to virtio folks last nov, but this wasn't in form
> of patch against their tex-based documentation yet (just ascii text),
> thus laying around in the pipeline.
> 
> (meanwhile the actual implementation is running in the field for over
> 6 month now)
> 
> Viresh picked it up, but made something totally different out of it.
> I wonder why he didn't consult me first.

Here I asked you on 26th of May, if you would be fine if I take it
forward as you didn't do anything with it formally in the last 5-6
months (Yes I know you were busy with other stuff).

https://lore.kernel.org/linux-doc/20210526033206.5v362hdywb55msve@vireshk-i7/

You chose not to reply.

I did the same before picking up the kernel code. You chose not to
reply.

I am not inclined to do offlist discussions as they aren't fruitful
eventually, and it is better to do these discussions over open lists,
so others can chime in as well.

> All that needed to be done was
> translated the ascii documentation into tex and rephrase a bit in order
> to match the formal terminology and structure used in virtio specs.

Not really. There were things lagging, which are normally caught in
reviews and fixed/updated. But that never happened in this case. You
only sent the specs once to virtio list, that too as an attachment and
it never made it to the virtio guys there (as the list doesn't take
attachments).

https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg06946.html

> This makes me very unhappy.

I know you have solutions running in products which depend on the
layout of the config structure or request/responses, based on your
original write-up, but unless something is merged in open source code
or specification, it is going to get changed, normally because of
reviews.

And you will be required to change things based on reviews, you just
can't say that I have products running the code and so I won't change
it. That is why people say, Upstream first. So you don't get into this
mess. Yes, this is tough and that's the way it is.

You keep saying that I have changed the original specification too
much, which is incorrect, I tried to point out earlier what all is
changed and why.

https://lore.kernel.org/linux-gpio/CAKohpokxSoSVtAJkL-T_OOoS8dW-gYG1Gs5=_DwebvJETE48Xw@mail.gmail.com/

You chose not to reply to that.

Lemme say this again. This is a generic protocol we are trying to
define here. It needs to take everyone's view into account and their
use cases. We are required here to collaborate. A solution thought to
be good enough for one person or use-case, isn't going to fly.

The changes I did to it are required to make it useful for the generic
solution for a protocol.

I am sure there would be shortcomings, like the one identified by
Jean-Philippe Brucker, where he asked to add offset of the gpios-name
thing. He made a sensible suggestion, which I am required to
incorporate. I just can't reply to him and say I won't change it
because I have already designed my product based on this.

Lets try to improve the code and specification here and make it work
for both of us by giving very specific feedback on wherever you think
the protocol or code is not efficient or correct. Being unhappy isn't
going make anything better.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
