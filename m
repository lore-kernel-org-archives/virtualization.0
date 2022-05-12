Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BE2C433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 17:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A326400D8;
	Thu, 12 May 2022 17:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UIZG-YN9TZON; Thu, 12 May 2022 17:10:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 21E1C400F2;
	Thu, 12 May 2022 17:10:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6648C0032;
	Thu, 12 May 2022 17:10:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECA64C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCDC841737
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1SOk9dKwUbCO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:10:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7063F416C3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:10:55 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id i27so11496253ejd.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=loonHWmCtVeGx4aWVVUzPzapZ1t+QIqGsKXmCgmw6z8=;
 b=WD5qjD3n7PQ6Q1+OHYaSBYIXZyE3MSnd14hOsae1gMnqzXVow2TJFjREwN777Ig52q
 V4qfULfCcQ86ni9aAhSi7LjMQHCPkFJi+glv65R1S+sQR6oFUNEhVyq5JADGgBm6h1kT
 2hznSR7F9VZ12haH7nWz1Ev8hTm8abuX+I6D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=loonHWmCtVeGx4aWVVUzPzapZ1t+QIqGsKXmCgmw6z8=;
 b=l/KNLaQlPddbNfHA5fGOnCW3N4Ljl7DKXyVSVzhgESPHKZF9C8FpR33NA0rEFvKp2y
 M9YQ8Jfc40nWbg7aThBnM5kixaR3qEqIsZxdSioKctP1h2Se7ooVTJzkbNdhzEr62n/z
 6hXeO9/QbQ3nPDma7SkTiObr8c9UfwqXdv9Z3Cpt8dodqD7KJ8BmU7/anWOrHgNqMqZh
 BceWH3oHC7zct1wTq5Uht6fDgu4gTFZKn3Xq1J4VDON6Reej8nl1AoG2SDXud1RjB4zg
 rfN3OVjBE40D+lij/CWIr9Z21yQgMiNskjXm+G+zW1lllgpQNexTxBoCbgJXXubOPuNV
 Y8gA==
X-Gm-Message-State: AOAM532Jaz8gGUqP0qQh+ii8GAb5HURUfGSqa3uGx79GM+44eDW+WlXT
 5DTd/qD5L9HiLk5BFMRl71XqCqqiGkGnqaEgMQV6FA==
X-Google-Smtp-Source: ABdhPJwKd+KUD8BKisSjoeA8VGpsJ/bcOUyqAuJt1v0qUuu92y8liBAr5Q9w/6K4WmD/6MYcEAp4cA==
X-Received: by 2002:a17:907:d28:b0:6f4:6375:5245 with SMTP id
 gn40-20020a1709070d2800b006f463755245mr856698ejc.12.1652375453170; 
 Thu, 12 May 2022 10:10:53 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com.
 [209.85.221.54]) by smtp.gmail.com with ESMTPSA id
 h12-20020a05640250cc00b0042617ba63d5sm2901075edb.95.2022.05.12.10.10.51
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 10:10:51 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id j25so7145668wrc.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 10:10:51 -0700 (PDT)
X-Received: by 2002:a05:6000:2c2:b0:20c:7329:7c10 with SMTP id
 o2-20020a05600002c200b0020c73297c10mr557896wry.193.1652375451235; Thu, 12 May
 2022 10:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <87czgk8jjo.fsf@mpe.ellerman.id.au>
 <CAHk-=wj9zKJGA_6SJOMPiQEoYke6cKX-FV3X_5zNXOcFJX1kOQ@mail.gmail.com>
 <87mtfm7uag.fsf@mpe.ellerman.id.au>
In-Reply-To: <87mtfm7uag.fsf@mpe.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 May 2022 10:10:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnYGY=10sRDzXCC2bmappjBTRNNbr8owvGLEW-xuV7Vw@mail.gmail.com>
Message-ID: <CAHk-=wgnYGY=10sRDzXCC2bmappjBTRNNbr8owvGLEW-xuV7Vw@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: last minute fixup
To: Michael Ellerman <mpe@ellerman.id.au>
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

On Thu, May 12, 2022 at 6:30 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Links to other random places don't serve that function.

What "function"?

This is my argument. Those Link: things need to have a *reason*.

Saying "they are a change ID" is not a reason. That's just a random
word-salad. You need to have an active reason that you can explain,
not just say "look, I want to add a message ID to every commit".

Here's the thing. There's a difference between "data" and "information".

We should add information to the commits, not random data.

And most definitely not just random data that can be trivially
auto-generated after-the-fact.

                Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
