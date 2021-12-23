Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A87FC433EF
	for <virtualization@archiver.kernel.org>; Thu, 23 Dec 2021 17:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F02FA8131C;
	Thu, 23 Dec 2021 17:26:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L1eb5bA-vW4F; Thu, 23 Dec 2021 17:26:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAD48812E6;
	Thu, 23 Dec 2021 17:26:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F34CC002F;
	Thu, 23 Dec 2021 17:26:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D943C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 17:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E8C34162A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 17:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id swdBTXSjJLxn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 17:26:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98B9041624
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 17:26:37 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id bm14so24058073edb.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 09:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s6ewMJ2Z+IzcgF6xIUMHr0fBNib7MLyFPwMExIntXDQ=;
 b=Nh/JZnZIQKCHcPVE2zpqDRAQAn0zb++R5dsUx6CD9Px4tIKzLNH7ltOy99r46sform
 XbYcxDbgfY9qMeDQTvAylVkdl84hTQIpccqjy/whmUbb0NTpxCu88QbVwqlRJXpX5Jhg
 1p8NIZQrFDAHm6FTOXtluShv4LkDp+sGEoVI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s6ewMJ2Z+IzcgF6xIUMHr0fBNib7MLyFPwMExIntXDQ=;
 b=7M3MzO/UotR2gH01L/PjgNjiyDH4pZP8GQMEO43hijkXoHpTH5u1afj1MBtidRbFkS
 VYG1ZeY0Lt3ynbj9zm5kJz1OJOojpLsf7hSoWS8dUloxQaCnmK3ExXNoVs4Ef7WcorZ+
 3Jjl1s9ScMX6dw/hu+dxxqYjaYXzB2tYqwtF5QzC/vc2MUWZnxXd0g3VlYU9o19hCpMg
 TEJeBjDhuaT5C3gOETvdFL0L8f6RXopMGviVtelAoYhveyr8LfXpdsnKaKMLYrtXCUTq
 5MaH3ifbDif2rLyKvKccaxOfZR0S05W+vv/+cmz9qqUt9X+RM54sOLE/tz0QhSaoBgYd
 JU9g==
X-Gm-Message-State: AOAM533RaeqbI362AV9UkXEMjOrsMZoju5M1HBV4vMVjpThDTJoAEo9I
 ELdobWmBxqfoyJzbeCuwU+XhdEXtErBNyfUfsTA2GQ==
X-Google-Smtp-Source: ABdhPJxHF1NtJtVO8OjHl5iqfV3pUnVTR0g3or3SVsWKrrujEH5+4kdvjcLCAr8Iek0ZPfR1lLC6wg==
X-Received: by 2002:a05:6402:2547:: with SMTP id
 l7mr2862261edb.301.1640280395622; 
 Thu, 23 Dec 2021 09:26:35 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48])
 by smtp.gmail.com with ESMTPSA id go39sm1924959ejc.77.2021.12.23.09.26.35
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Dec 2021 09:26:35 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id y22so24137648edq.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 09:26:35 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id
 b18mr2336024wrx.193.1640280042472; 
 Thu, 23 Dec 2021 09:20:42 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-9-ebiederm@xmission.com>
 <YcNsG0Lp94V13whH@archlinux-ax161>
 <87zgoswkym.fsf@email.froward.int.ebiederm.org>
 <YcNyjxac3wlKPywk@archlinux-ax161>
 <87pmpow7ga.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
 <87o858uh80.fsf@email.froward.int.ebiederm.org>
 <87a6grvqy8.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87a6grvqy8.fsf_-_@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Dec 2021 09:20:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmsosJkXoN+arC6eUdayq42pTZzr1j0rG3=RsPBgqujA@mail.gmail.com>
Message-ID: <CAHk-=whmsosJkXoN+arC6eUdayq42pTZzr1j0rG3=RsPBgqujA@mail.gmail.com>
Subject: Re: [PATCH] kthread: Generalize pf_io_worker so it can point to
 struct kthread
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Kyle Huey <me@kylehuey.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 virtualization@lists.linux-foundation.org, Alexey Gladkov <legion@kernel.org>,
 Christian Brauner <christian.brauner@ubuntu.com>
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

On Wed, Dec 22, 2021 at 9:19 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Instead of continuing to use the set_child_tid field of task_struct
> generalize the pf_io_worker field of task_struct and use it to hold
> the kthread pointer.

Well that patch certainly looks like a nice cleanup to me. Thanks.

                Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
