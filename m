Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68846C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:46:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E0760FC0
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05E0760FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2DF1400DB;
	Wed, 27 Oct 2021 20:46:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i8nMIVbRbCr1; Wed, 27 Oct 2021 20:46:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B340400F5;
	Wed, 27 Oct 2021 20:46:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCC60C0019;
	Wed, 27 Oct 2021 20:46:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94AA7C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9049B81D65
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:46:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pEkCkZXXe7iv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:46:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9FDE81C20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:46:43 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id b1so339024pfm.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sJa1X8Nq9O3Y4Jpn6QiA74FKvcIV+C24z8IRQUjGGE0=;
 b=TxZcat++g2F8swI/guncdG9/17Z/6RCDj0O4DaP3V2lEJrBjGy6sZkL1oaiVAPUX7i
 ibRs8fV27ZpLTrAbifA8zRst6y+Kk83j+VEjhNI+Vbneg5PK76uFu3Pt51HYTeEaMMd/
 OOX5Fw0eevNVN84NzUSIfUo21BQoeHWua4n8iiMA5hViXFqIkNINp7tTwt6Va0lJxObQ
 XbAdy+YG2LtzHKedjvpvUxc4S7WGprooI9+nPgi9DghDQrCCLYP8qAZgeT7medHBfAJw
 WFVgaDdPI0CXvVHu3YcuEB3ai43LJghhdT9dLcGlj4W6soszGfdT20P58PyL1vt7VaVP
 hqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sJa1X8Nq9O3Y4Jpn6QiA74FKvcIV+C24z8IRQUjGGE0=;
 b=KZEv0Zwsp6eu6Xe/p2NyKde4FoINs6Fguhg/IvKtbGAB5IWnRzX3B0YKcosOqCF0OY
 WqDhlzBsjzJuOaDOzKzB7TOBkOm9PP4uINx2bAmcfue8y1xxl2Bbc+HsA/mq3U0rBaEq
 xv8S3B1T/gEfZ8VzzeSnwHQ/g77xLx7PWEIk+owAmn+y8PRetr8ivGnpZz6ADEHEslBH
 loMhlrypXCuf7qHM+oxO8RLew4FAWK7J3lOC00oosvNfaS6MGPnpS/0GycUbnH/+1KaP
 Kx9mo2bMpWb5gLCKTHZevFpB13Dxg8jBKfUEKAYHpHcfjdeS4eI5jouclCjculPeO42e
 tfgQ==
X-Gm-Message-State: AOAM532ry/Y5boplV1PGCMSafFizLEO9/7loS7DRlgmr8lYR23k0mNMI
 XjaBG+h8UWavaROoqWQTBNlCpovYjsKekWuxSSYxoA==
X-Google-Smtp-Source: ABdhPJzuYcyzIFqC2QDapdBCh3wTfdWUrlublr2aq9P2i1Emub6ylFDIqTcshjHDL5pSUpWP0gXhlJZ+k6Puz+OdoJE=
X-Received: by 2002:a05:6a00:1348:b0:47c:e8f1:69a3 with SMTP id
 k8-20020a056a00134800b0047ce8f169a3mr433025pfu.86.1635367603066; Wed, 27 Oct
 2021 13:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
In-Reply-To: <20211018044054.1779424-1-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 13:46:31 -0700
Message-ID: <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
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

[ add sfr ]

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Dan,
>
> this series cleans up and simplifies the association between DAX and block
> devices in preparation of allowing to mount file systems directly on DAX
> devices without a detour through block devices.

So I notice that this is based on linux-next while libnvdimm-for-next
is based on v5.15-rc4. Since I'm not Andrew I went ahead and rebased
these onto v5.15-rc4, tested that, and then merged with linux-next to
resolve the conflicts and tested again.

My merge resolution is here [1]. Christoph, please have a look. The
rebase and the merge result are both passing my test and I'm now going
to review the individual patches. However, while I do that and collect
acks from DM and EROFS folks, I want to give Stephen a heads up that
this is coming. Primarily I want to see if someone sees a better
strategy to merge this, please let me know, but if not I plan to walk
Stephen and Linus through the resolution.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=c3894cf6eb8f


>
> Diffstat:
>  drivers/dax/Kconfig          |    4
>  drivers/dax/bus.c            |    2
>  drivers/dax/super.c          |  220 +++++--------------------------------------
>  drivers/md/dm-linear.c       |   51 +++------
>  drivers/md/dm-log-writes.c   |   44 +++-----
>  drivers/md/dm-stripe.c       |   65 +++---------
>  drivers/md/dm-table.c        |   22 ++--
>  drivers/md/dm-writecache.c   |    2
>  drivers/md/dm.c              |   29 -----
>  drivers/md/dm.h              |    4
>  drivers/nvdimm/Kconfig       |    2
>  drivers/nvdimm/pmem.c        |    9 -
>  drivers/s390/block/Kconfig   |    2
>  drivers/s390/block/dcssblk.c |   12 +-
>  fs/dax.c                     |   13 ++
>  fs/erofs/super.c             |   11 +-
>  fs/ext2/super.c              |    6 -
>  fs/ext4/super.c              |    9 +
>  fs/fuse/Kconfig              |    2
>  fs/fuse/virtio_fs.c          |    2
>  fs/xfs/xfs_super.c           |   54 +++++-----
>  include/linux/dax.h          |   30 ++---
>  22 files changed, 185 insertions(+), 410 deletions(-)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
