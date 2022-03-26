Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8F9C433EF
	for <virtualization@archiver.kernel.org>; Sat, 26 Mar 2022 00:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 314B5842D4;
	Sat, 26 Mar 2022 00:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ouj1KPt0nWC3; Sat, 26 Mar 2022 00:36:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE8A7842D2;
	Sat, 26 Mar 2022 00:36:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B45D2C002C;
	Sat, 26 Mar 2022 00:36:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0A53C0012
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Mar 2022 00:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCD2740154
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Mar 2022 00:36:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ycwi2hB9DVrf
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Mar 2022 00:36:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C784240103
 for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Mar 2022 00:36:47 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id h7so15961150lfl.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 17:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lcshdobGzILllMY3zNpnZ3Ex5ohCbZSLroaY3F9W/JA=;
 b=dTex8E2DlnTcTjb24xecx3Rs17SSDlOTb2q2dyGoe4UMrbGwJxoqMFipPFX1dMVeta
 WXHrs1YXfFuOjUXiXABz7YSdikeLsyKoFKm9th2ytRWjAyczdZsos502VTEaIp/Z+TxG
 Bge3mQs/tQgKvKYn5r8VcKJQjSjngfGK4Akfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lcshdobGzILllMY3zNpnZ3Ex5ohCbZSLroaY3F9W/JA=;
 b=s+zPSr4SfY1lBf0Qo0a8uIjRevA3iHiNP12PbnX9SikxLoJmOYH2UOfXV46JFZBz/f
 wzFMUN9KBW75eSeul0uQcCHepOYmcfTSPmg/pzm7ZWskCQGT0X21fPVWMl8rPzBp1JA9
 mmmG0p0mJbKUPQa9EERlrnFgF6T1yr8wPBJYxp9tVcwHAQyV1rZ1StghQBsuiDPsLOCe
 ouOSeXVsU9HTqPWorHmBD+Cvjp1iZ5jHpmk5tw1dUabCRze/MnPEWlgAvRXE6YPJ5LhJ
 6EPN6Zz8/dmp3fftFNbZd89Fn7+JIOH0ekc8Ndk8Xt7dD/Q1ziQXN6cMpIBleRzC96XF
 QtNg==
X-Gm-Message-State: AOAM5315g/9eRx1WNf/zSZ2hOn9sOTDf+Qagp4UB6UR2d+CwgxRG4kGt
 cmkUHErPyFeJaQWWaBYee8A+Pjet9KOueSdC7pyHAA==
X-Google-Smtp-Source: ABdhPJwuZ8DPC3CISv99rMPGVsqR9JUZPJnnjuUxQV/AuJnm72PXgOh2u7UsEdjnU+pwopRPIY6mtQ==
X-Received: by 2002:a05:6512:3d22:b0:44a:378e:d289 with SMTP id
 d34-20020a0565123d2200b0044a378ed289mr10344147lfv.369.1648255005187; 
 Fri, 25 Mar 2022 17:36:45 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172]) by smtp.gmail.com with ESMTPSA id
 a25-20020a19ca19000000b0044a145eb35bsm866467lfg.35.2022.03.25.17.36.43
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Mar 2022 17:36:44 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id g24so12278808lja.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 17:36:43 -0700 (PDT)
X-Received: by 2002:a2e:a5c4:0:b0:249:9ec3:f2b with SMTP id
 n4-20020a2ea5c4000000b002499ec30f2bmr10061179ljp.358.1648255003631; Fri, 25
 Mar 2022 17:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220325172036.3f8f619e@gandalf.local.home>
In-Reply-To: <20220325172036.3f8f619e@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Mar 2022 17:36:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTL=vz2PC7=dFZVrT=9nuBtZ21j_qT8e=yHvVuXvhCdg@mail.gmail.com>
Message-ID: <CAHk-=wjTL=vz2PC7=dFZVrT=9nuBtZ21j_qT8e=yHvVuXvhCdg@mail.gmail.com>
Subject: Re: [PATCH] virtio: Workaround fix for hard hang on guest using fifos
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 virtualization@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>
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

On Fri, Mar 25, 2022 at 2:20 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> With the updates to change the size being passed in the splice from
> page_size to pipe_size, this never finished (it would copy around a meg or
> so). And stopped. When I killed the agent-fifo task on the guest, the guest
> hung hard.

Without knowing (or really caring) at all how virtqueue works, this
sounds very much like the classic pipe deadlock where two processes
communicate over a pair of pipes, sending each other commands, and
replying to each other with status updates.

And you absolutely cannot do that if one side can possibly want to up
fill the whole pipe.

Deadlock:

 - process A is trying to send data to process B (on 'pipe_A'), and
blocks because the pipe is full

 - process B is reads the data and everything is fine, and A gets to continue

 - but then process B sends some stratus update the other way (on
'pipe_B' - you can't use the same pipe for bidirectional, it's why you
use a pair of pipes or a socketpair) and waits for the result.

 - now A and B are both waiting for each other - A is waiting for B to
empty the big bunch of data it's sending, and B is waiting for the
result for the (small) command it sent.

and neither makes any progress.

You can find several mentions of these kinds of problems by just
googling for "bidirectional pipe deadlock" or similar.

The solution is invariably to either

 (a) make sure that nobody writes even remotely close to enough data
to fill a pipe before reading the other pipe (you can still fill up a
pipe, but at least somebody is always going to succeed and make
progress and do the read to make progress).

 (b) make sure everybody who writes to a pipe will use nonblocking IO
(and is willing to do reads in between to satisfy the other end).

That first case is basically what one of the PIPE_BUF guarantees is
all about (the other one is the atomicity it guarantees, ie you can
write a "command packet" and be guaranteed that readers will see it
without data mixed in from other writes).

I have no idea what your client/agent does and how it interacts with
the virtio pipes, but it really _sounds_ like a very similar issue,
where it used to work (because PIPE_BUF) and now no longer does
(because pipe filled).

And that virtio_console __send_control_msg() pattern very much sounds
like a "send data and wait for ACK" behavior of "process B".

              Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
