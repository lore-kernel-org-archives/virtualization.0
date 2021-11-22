Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09BFC433EF
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 08:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57A31607FA;
	Mon, 22 Nov 2021 08:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEwXYFWkIC1O; Mon, 22 Nov 2021 08:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1440D607EE;
	Mon, 22 Nov 2021 08:08:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1525C001E;
	Mon, 22 Nov 2021 08:08:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F989C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 08:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F37D607F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 08:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HPDP4r0AJU-X
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 08:08:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CFBB607EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 08:08:18 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id t13so34737788uad.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 00:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pCwPVxjiiXjhwUGSnDBz+stSxiYomGO7y/AFBYehvbs=;
 b=y6Yax3yc2sydsPSf+2PmL2a2YBMnuXA8eV0UlQMzUcka0yScHXkiPDo0TI4azYqPPe
 x8JbmX7bA66uEnPl/DjFFtS4AoFvsuQb24k5USoJ04FBze5NDS9ZfL/f1Qw7iNek/s89
 J7tX98qSp02OHMJKGhu6OapkJMFgQc4Ct/1lzmrbT4Y0LVbWkTsXpeaBXm6owh9pNMix
 NvL+It0D7ReXDi3N0v97FpAwYHeulFURiyaymGrgRAq/hw1oVB7bNS55qYoVSqP+0Q3o
 GntYfINNr3D+l/B3/UFsTWZVFCG+WiGuLrmHqMyulNQY40xGsnfk/QeD/mcAVRLRXV/C
 nM1w==
X-Gm-Message-State: AOAM531ltHIT4HRzx+vpY1RMouw0UWdH/THuSe5KiB+m4DZgRSDKk3pO
 l2wRSDWGOtCh0NskcmkbABXiuh0WBJHHSQ==
X-Google-Smtp-Source: ABdhPJyhGXcYl1YZ5DKGIITaSYRzCZsyFdFvhkv8dtutQVgBTLJASwbwvEZrpdenRvSyM9niwec6BQ==
X-Received: by 2002:a05:6102:a46:: with SMTP id
 i6mr128125030vss.19.1637568497234; 
 Mon, 22 Nov 2021 00:08:17 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com.
 [209.85.222.41])
 by smtp.gmail.com with ESMTPSA id q26sm4498641vsp.23.2021.11.22.00.08.16
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:08:16 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id j14so24993853uan.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 00:08:16 -0800 (PST)
X-Received: by 2002:a05:6102:e82:: with SMTP id
 l2mr127366434vst.37.1637568496222; 
 Mon, 22 Nov 2021 00:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20211121174930.6690-1-michael.christie@oracle.com>
 <20211121174930.6690-3-michael.christie@oracle.com>
In-Reply-To: <20211121174930.6690-3-michael.christie@oracle.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Nov 2021 09:08:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNiuFdwXgj3kvKybm0Jb2g9N-2FgaB0U0LnQQ88y72aA@mail.gmail.com>
Message-ID: <CAMuHMdUNiuFdwXgj3kvKybm0Jb2g9N-2FgaB0U0LnQQ88y72aA@mail.gmail.com>
Subject: Re: [PATCH V5 02/10] fork/vm: Move common PF_IO_WORKER behavior to
 new flag
To: Mike Christie <michael.christie@oracle.com>
Cc: axboe@kernel.dk, hdanton@sina.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, vverma@digitalocean.com, stefanha@redhat.com,
 christian.brauner@ubuntu.com
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

On Sun, Nov 21, 2021 at 6:49 PM Mike Christie
<michael.christie@oracle.com> wrote:
> This adds a new flag, PF_USER_WORKER, that's used for behavior common to
> to both PF_IO_WORKER and users like vhost which will use the new
> kernel_worker helpers that will use the flag and are added later in this
> patchset.
>
> The common behavior PF_USER_WORKER covers is the initial frame and fpu
> setup and the vm reclaim handling.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

>  arch/m68k/kernel/process.c       | 2 +-

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
