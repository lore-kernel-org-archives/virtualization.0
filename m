Return-Path: <SRS0=qgkY=OM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440AC433F5
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 12:32:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7483C60F9D
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 12:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7483C60F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C542400FA;
	Wed, 22 Sep 2021 12:32:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aa2F7SgTlAeL; Wed, 22 Sep 2021 12:32:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A95FE40139;
	Wed, 22 Sep 2021 12:32:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B52AC0011;
	Wed, 22 Sep 2021 12:32:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 839A4C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71A0582470
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CH5-eHfnWcZi
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:32:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96F1082437
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:32:50 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id z202so1089058vkd.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 05:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R/nhv1c3kfB+8GUpcbKdwWWl/t1iJqUbmVf63u/XqWY=;
 b=L6IbNmJEL3b8eLYS6rS0Cc4qvK7/uS+nEqGL8sqGxA/19kXdET4uQu7Xit2ANE3NRZ
 w0JBS9PW7s5qOsMEKMf9y3g5prhIGzjISGaWpMnez3c7mSQyVA7f1ue3CY+xUWQdKo1g
 K6cSFqmmpaytNUcy0niIXGP6Y5nLDcK0r+T0VgjgEoyToew8pDWffztKa+wfUwOHtbP+
 z1YcCc72YvxIjaXSzTWsJZ73vreEsoO9m8k0WSK1oplog0Q+B8PEbs8lsaOlz9rx1OE1
 2X+q22THH4/nOGZ0uaKmAjYe45WTXkTL/UOiKgGBJDJSjVIfCbForHgNp16G3hDI+f/V
 366w==
X-Gm-Message-State: AOAM5324Q7NM184Xz3GkqAeAZk1isaVTJVQ8QI0zH4JFiEH4AUlzdKCB
 PFPEbI7IMmKtA6+ajgKedPzBf2iEF9EEh3FNWNQ=
X-Google-Smtp-Source: ABdhPJxth2FYG46f0S5OWGAuSsEkUNQOSjbi8d7mL7ridoO4xhKND97RZqrl1VQPIyKGRp4zN7o8NWtJxjo0/BMvl6c=
X-Received: by 2002:a1f:5e14:: with SMTP id s20mr23127866vkb.7.1632313969468; 
 Wed, 22 Sep 2021 05:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210921215218.89844-1-michael.christie@oracle.com>
 <20210921215218.89844-4-michael.christie@oracle.com>
In-Reply-To: <20210921215218.89844-4-michael.christie@oracle.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Sep 2021 14:32:37 +0200
Message-ID: <CAMuHMdXhtq-6vcU_1qYfT_ChPGsnhLAA_yZwPz7ERJgxJERK7Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/9] fork: move PF_IO_WORKER's kernel frame setup to
 new flag
To: Mike Christie <michael.christie@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, hdanton@sina.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Stefan Hajnoczi <stefanha@redhat.com>,
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

Hi Mike,

On Tue, Sep 21, 2021 at 11:55 PM Mike Christie
<michael.christie@oracle.com> wrote:
> The vhost worker threads need the same frame setup as io_uring's worker
> threads, but handle signals differently and do not need the same
> scheduling behavior. This patch separate's the frame setup parts of
> PF_IO_WORKER into a kernel_clone_args flag, KERN_WORKER_USER.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Thanks for your patch!

> --- a/arch/m68k/kernel/process.c
> +++ b/arch/m68k/kernel/process.c
> @@ -157,7 +157,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>          */
>         p->thread.fs = get_fs().seg;
>
> -       if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +       if (unlikely(p->flags & (PF_KTHREAD) ||
> +                    worker_flags & KERN_WORKER_USER)) {

I guess it wouldn't hurt to add parentheses to improve
readability:

    if (unlikely((p->flags & (PF_KTHREAD)) ||
                 (worker_flags & KERN_WORKER_USER))) {

>                 /* kernel thread */
>                 memset(frame, 0, sizeof(struct fork_frame));
>                 frame->regs.sr = PS_S;

With the above fixed, for m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
