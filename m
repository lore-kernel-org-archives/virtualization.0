Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58712C43219
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 03:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2F2540493;
	Wed, 24 Nov 2021 03:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sx0ikJxvnT7J; Wed, 24 Nov 2021 03:52:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 474CC40488;
	Wed, 24 Nov 2021 03:52:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E5C5C002E;
	Wed, 24 Nov 2021 03:52:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B4ABC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A26880E0A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:52:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7UeoMCXlBamw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:52:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C623F80DFE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:52:22 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 gf14-20020a17090ac7ce00b001a7a2a0b5c3so3882040pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 19:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6zOlc/LjY/38MNl2fNjkOvdM3xFlyfeXQW77bsVPs7U=;
 b=lAK1cPsbcZgDOnzv+wRyX5hFeuNtWn74alyzSOfh2WTiCK6b1Gd9bfDzl0+LSFYqBx
 NFA78tBSHfT8IWLc76OROAypo1vlQiiVSp+deqPBmSErFfOP18cWXFbnZCxI9VIMHHuR
 rkB6XFn/xh99StS9siD+gMovD+TGGHheUMxQDm6Fs4TRxLl6LVPgdXFahdYzrs2kgHk1
 2vtAqiLmzKNsso+noEF/MbJXbTSUoUVvNEOcLZD7XraD8UxaJOkOnpqbEwEn6rei4bjJ
 t5MvTN9s/WuPOzLWfQKYxVJtbNdZgfs/23Dfq3WeRbXM/0WgTMF9HeylQ/9xSVmw3Fc5
 g5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6zOlc/LjY/38MNl2fNjkOvdM3xFlyfeXQW77bsVPs7U=;
 b=KKjnqZQ1M5/KXvj+0mR3odFo7khBY4lLZ4m+nyiahf4HW18w/s2dw1QLFxok0Nzm5l
 M481OJPpKN/eSCkJY4mr5jLy4EioCEz+VJwv3rA6t2RaBzM3JgNV88OuBekNLYHrRAuc
 CgmkbBZMvOY5i8twIVx68/xXWwd8tqhhbZoQwyhsoWOqJYjpZeySABC7fduPs+Wh0vGJ
 2tI4Mg9RawF06nOBGAOb8fsZttZAjX1qNcG/f5jfHbx7RcESTYfZqO34DI5+30InoDRk
 p8+60U3SOqP/LOnP1DWiQ9Xc6Uw/8Ua4l+w+muosk5LpIHXkPAvYK5EbVQlkkj0/CM+q
 4gQw==
X-Gm-Message-State: AOAM532khNioiwbXERxwBaPtpaIssMeXKoncoQFrIKd+GjmJdf8G7efx
 dqiSUoPJQwaNz83MnRdd85mMBVZkPKtrT0g6UUDk5A==
X-Google-Smtp-Source: ABdhPJymXNtj/xuoHYk/qKEwmz57TlRY6ykmrutCD2G8CDlG536bSV07F4JpqasRcpvkUcp5iE8OReW1Fq5UwnxXf/0=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id
 kb10mr10703847pjb.8.1637725942362; 
 Tue, 23 Nov 2021 19:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-30-hch@lst.de>
In-Reply-To: <20211109083309.584081-30-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 19:52:11 -0800
Message-ID: <CAPcyv4gNH1ex_6+pHmpv_pWGV8H8KomzWFtfMvtntNe++x8OBA@mail.gmail.com>
Subject: Re: [PATCH 29/29] fsdax: don't require CONFIG_BLOCK
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
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

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The file system DAX code now does not require the block code.  So allow
> building a kernel with fuse DAX but not block layer.

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
