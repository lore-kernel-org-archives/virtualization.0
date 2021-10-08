Return-Path: <SRS0=03hR=O4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3498C433FE
	for <virtualization@archiver.kernel.org>; Fri,  8 Oct 2021 08:21:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD81610CE
	for <virtualization@archiver.kernel.org>; Fri,  8 Oct 2021 08:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CD81610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 235D260898;
	Fri,  8 Oct 2021 08:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IF4Sxgp9yjpY; Fri,  8 Oct 2021 08:21:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9D5F460891;
	Fri,  8 Oct 2021 08:21:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75C5EC000F;
	Fri,  8 Oct 2021 08:21:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 986C9C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 08:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7752E406FF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 08:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T0B-CzGFnZoF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 08:21:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B108406FD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 08:21:13 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id v4so9604056vsg.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 08 Oct 2021 01:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZIU2hEBrWy04O/6quAlEqQ6iWBtsadQriVwbmeAJBtA=;
 b=SQaLUjSOb+fBnWVBvpBrVed4DuRGxas50pRvF8KbyT3BqkXitxnyml/ONhpjG3M942
 RqqjodysYjUUYmksdopN9g3ZOQqhKhHeMxzE19hgQHGd7kC8anuDl+hYVL2EZMcSvQ91
 OESCASC2fTLSbbRpqJJGlXJImDm34P/G/7s6dAeO0NF+OKTAmPmxnE3HMMGjRUUQFR3w
 1mIKmnELR7OoXyRPJ70iQ4oS+QsKXoCvPagSHVD1f4PqDo9dnyP4fqmHI+wUlP3AC5ro
 CvsEf4CGfv+z7IxaK8oUzEtGgPo3QbhwHpNXDjnOsyuzqfUNvgoYH/CaOg2eWFviRkRh
 20tA==
X-Gm-Message-State: AOAM5330ugaBff1QWaUuYS9NUgnS+qWR6EHjqmPCsCN0txrZ2uQo5jbG
 pUEYdql77Ph+eKzFoifpBdA8+xeBZ6pwjPnb/ss=
X-Google-Smtp-Source: ABdhPJzDL/QWKRtPp3CyYzPJ8qtOafqR2yCXNGdBjWTg61pglR75eGfmgCJFvJ6P1GLFYI22DeMthm9Y3I8Y+9/A4qY=
X-Received: by 2002:a67:d111:: with SMTP id u17mr8113141vsi.37.1633681272542; 
 Fri, 08 Oct 2021 01:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211007214448.6282-1-michael.christie@oracle.com>
 <20211007214448.6282-3-michael.christie@oracle.com>
In-Reply-To: <20211007214448.6282-3-michael.christie@oracle.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Oct 2021 10:21:01 +0200
Message-ID: <CAMuHMdXy1-jCSTNw8A7ZyvNja5P31kXp=uV2cN-CHrKaaQgCag@mail.gmail.com>
Subject: Re: [PATCH V4 2/8] fork: move PF_IO_WORKER's kernel frame setup to
 new flag
To: Mike Christie <michael.christie@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, hdanton@sina.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, vverma@digitalocean.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

On Thu, Oct 7, 2021 at 11:45 PM Mike Christie
<michael.christie@oracle.com> wrote:
> The vhost worker threads need the same frame setup as io_uring's worker
> threads, but handle signals differently and do not need the same
> scheduling behavior. This patch separate's the frame setup parts of
> PF_IO_WORKER into a new PF flag PF_USER_WORKER.
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
