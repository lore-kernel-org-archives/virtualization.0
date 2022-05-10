Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEFEC433EF
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 23:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 599A041872;
	Tue, 10 May 2022 23:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sKcoAetsSqC4; Tue, 10 May 2022 23:51:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A9F9541731;
	Tue, 10 May 2022 23:51:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 865F2C0039;
	Tue, 10 May 2022 23:51:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3CC3C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 23:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAB6040232
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 23:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tQ7x1cHv8Wgy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 23:51:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1AE3400CB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 23:51:06 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id dk23so811589ejb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 16:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s7uQP88rm2fFVrAVhakdMnaytPLChwV+spwEqxpvxKE=;
 b=Wvb2Yr5ntSMikIY6rsVTXCZINVsgnvf5OHdXaS5WophjI51WFvB8FsxEaYv1RdGkSy
 ORGLa02GFQN4jWiwyp35UkGxqCVY8hbh1eV9xU7ToJNJzjVWjhEYOqjgamybrHXG8cWb
 TwhAiglLuZCkojR6K6YA46HDyLB6G+PqIX51A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s7uQP88rm2fFVrAVhakdMnaytPLChwV+spwEqxpvxKE=;
 b=izSwwTujZIeqv4s4XX3qOXeT2y5FnqmB535ShA1aWhW03XfsQLdXxBbmj6EpduDN6x
 GwrYwWt9/AW5KA25MlR541IDHxQrzFMcYG9rw8uNv1+SdgYuIUfpIC9RSv/neD3Vuk4a
 Bwee1FgNLyFmf4n1EPxOO9jhFnIePJL+P/EIXG2+bU8lQEzKX81ouKlQiv2MrdlZXPhn
 aA+OSRtydrn4CfRUOQABazP1zWxt7qITWLhH2TpxNmt3qhlk4huieQcoKcchuEX2PeBF
 REPP0NcL1xQo1uIyVsM5rd7wDKVqHdnyF5eskta5ZRIb2sJGCb/xyLFbJx1EymtbEg0U
 2Y2g==
X-Gm-Message-State: AOAM5336AKep0g4GkLg8wcejdb/Qk54QoGMEdq6gfo4oXcPADVCvCjkA
 pl04rsYEWWBqBg6O/+Pu4N/uJeLNwa++G1Qzo8H9+g==
X-Google-Smtp-Source: ABdhPJyHOOI8BmlHICJMeGcvn/Uyoyd7DBQOLn6k0zNMz4tcZUea43XefzqcmJ3xrdbDqRvY86rnnA==
X-Received: by 2002:a17:907:2ce5:b0:6f5:64f4:91d8 with SMTP id
 hz5-20020a1709072ce500b006f564f491d8mr19443588ejc.675.1652226664622; 
 Tue, 10 May 2022 16:51:04 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com.
 [209.85.128.41]) by smtp.gmail.com with ESMTPSA id
 k9-20020a056402048900b0042617ba6399sm270207edv.35.2022.05.10.16.51.03
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 16:51:04 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id
 n6-20020a05600c3b8600b0039492b44ce7so281039wms.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 16:51:03 -0700 (PDT)
X-Received: by 2002:a1c:4c06:0:b0:394:65c4:bd03 with SMTP id
 z6-20020a1c4c06000000b0039465c4bd03mr2167400wmf.8.1652226663399; Tue, 10 May
 2022 16:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <YnrxTMVRtDnGA/EK@dev-arch.thelio-3990X>
In-Reply-To: <YnrxTMVRtDnGA/EK@dev-arch.thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 May 2022 16:50:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAk3NEJ2PHtb0jXzCUOGytiHLq=rzjkFKfpiuH-SROgA@mail.gmail.com>
Message-ID: <CAHk-=wgAk3NEJ2PHtb0jXzCUOGytiHLq=rzjkFKfpiuH-SROgA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: last minute fixup
To: Nathan Chancellor <nathan@kernel.org>
Cc: KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, mie@igel.co.jp,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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

On Tue, May 10, 2022 at 4:12 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> For what it's worth, as someone who is frequently tracking down and
> reporting issues, a link to the mailing list post in the commit message
> makes it much easier to get these reports into the right hands, as the
> original posting is going to have all relevant parties in one location
> and it will usually have all the context necessary to triage the
> problem.

Honestly, I think such a thing would be trivial to automate with
something like just a patch-id lookup, rather than a "Link:".

And such a lookup model ("where was this patch posted") would work for
<i>any</i> patch (and often also find previous unmodified versions of
it when it has been posted multiple times).

I suspect that most of the building blocks of such automation
effectively already exists, since I think the lore infrastructure
already integrates with patchwork, and patchwork already has a "look
up by patch id".

Wouldn't it be cool if you had some webby interface to just go from
commit SHA1 to patch ID to a lore.kernel.org lookup of where said
patch was done?

Of course, I personally tend to just search by the commit contents
instead, which works just about as well. If the first line of the
commit isn't very unique, add a "f:author" to the search.

IOW, I really don't find much value in the "Link to original
submission", because that thing is *already* trivial to find, and the
lore search is actually better in many ways (it also tends to find
people *reporting* that commit, which is often what you really want -
the reason you're doing the search is that there's something going on
with it).

My argument here really is that "find where this commit was posted" is

 (a) not generally the most interesting thing

 (b) doesn't even need that "Link:" line.

but what *is* interesting, and where the "Link:" line is very useful,
is finding where the original problem that *caused* that patch to be
posted in the first place.

Yes, obviously you can find that original problem by searching too if
the commit message has enough other information.

For example, if there is an oops quoted in the commit message, I have
personally searched for parts of that kind of information to find the
original report and discussion.

So that whole "searching is often an option" is true for pretty much
_any_ Link:, but I think that for the whole "original submission" it's
so mindless and can be automated that it really doesn't add much real
value at all.

                Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
