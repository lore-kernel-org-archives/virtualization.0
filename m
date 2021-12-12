Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66572C433F5
	for <virtualization@archiver.kernel.org>; Sun, 12 Dec 2021 14:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2464241E9C;
	Sun, 12 Dec 2021 14:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1OEmGoXDiDEi; Sun, 12 Dec 2021 14:39:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9AE9C42030;
	Sun, 12 Dec 2021 14:39:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E187C002F;
	Sun, 12 Dec 2021 14:39:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6132C0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A617960D5E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OpZ_CVMuZxJi
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:39:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02B3560C2F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:39:27 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 y14-20020a17090a2b4e00b001a5824f4918so12836046pjc.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 06:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c2zny3Bx2o60PdHAHhyf6q+y4E1Ceap0f1n6TKcneOk=;
 b=AlZ4MjqeDEThHEH1FVUzZvmPycukh+PxUwoNaVX5obBJ1cbGHWrTFXhwDvkeLPtwLI
 NHAB8xNArm8PU3DO00Z4REhsm+1Qob5/1ys9INe5D2L2b/t2UBCbCv2eWNYhhKTCINNS
 Q1t8/d3A1COiZ95VaH5Rk1yRA9uPc1Tw8y+dLInqS/mvz45lXPDFlTg+rjL2gA8569Ct
 GL+IVMJJ/wrJ7C7lHVb1smufdMBPNjTAQrn9bTN7CY+SsdNimDU+ZrBJWQpMBVJ2jVq1
 uXY8Bk9o5/8ZSmZHwswsew7WhsFfZauh8tlr+PdX0FkYdSaEagRCltJHMUxaIZv/WTkL
 iliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c2zny3Bx2o60PdHAHhyf6q+y4E1Ceap0f1n6TKcneOk=;
 b=Z7AwzUpexW1uvGg4ix4sUylvLIU4iwsYMCsI3fjT+MBcmF1e6ILoMBhkKADAP9CDWA
 mjeexRpgWOptdG2wGQFZIlcRp7+Lohe8k04gVueXCAtI11dBbuwkQF6Xrbq4DYH4Yk6e
 kPA055TZInCpSXr0eEwz3tqJpmlgVYAb0BIuflIfMQb3IxyrhJTWlFHjZrzg7rMit0p4
 H681lJTL9/SHAl0sOIM9Qwu6cb5W3fv8ArZ4qE1Jdn4G10/2JlIwmFDcnJf8dPJn2G/z
 kBaXeTo6eB01mB+eiruaTnUScM/q8EruV6Pnfan7ge0CagwuWmeTL2YjeO2w6XIy9yIV
 DnyA==
X-Gm-Message-State: AOAM531tEC+fzkoP1pyxy1xioRqLSqHs0qDnXL96EfvePek+2cUf0Nhp
 HkJKfBphGIayxqGgy8h4wYPO+1aFcsCuLaqIaCvL8Siv5akgGg==
X-Google-Smtp-Source: ABdhPJz2lbfhBkbKpu43+79k6Z3alD86owZO4X5IPgFqiWUlbzwsnwFTD+5Dey+ZqI2i+TrJIWAD/hQxem3DZ5dPHCE=
X-Received: by 2002:a17:90b:1e07:: with SMTP id
 pg7mr37441884pjb.93.1639319967232; 
 Sun, 12 Dec 2021 06:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-5-hch@lst.de>
In-Reply-To: <20211209063828.18944-5-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 12 Dec 2021 06:39:16 -0800
Message-ID: <CAPcyv4gZjkVW0vwNLChXCCBVF8CsSZityzSVmcGAk79-mt9yOw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter
 methods
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Vishal Verma <vishal.l.verma@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 device-mapper development <dm-devel@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Alasdair Kergon <agk@redhat.com>
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

On Wed, Dec 8, 2021 at 10:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> These methods indirect the actual DAX read/write path.  In the end pmem
> uses magic flush and mc safe variants and fuse and dcssblk use plain ones
> while device mapper picks redirects to the underlying device.
>
> Add set_dax_virtual() and set_dax_nomcsafe() APIs for fuse to skip these
> special variants, then use them everywhere as they fall back to the plain
> ones on s390 anyway and remove an indirect call from the read/write path
> as well as a lot of boilerplate code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c           | 36 ++++++++++++++--
>  drivers/md/dm-linear.c        | 20 ---------
>  drivers/md/dm-log-writes.c    | 80 -----------------------------------
>  drivers/md/dm-stripe.c        | 20 ---------
>  drivers/md/dm.c               | 50 ----------------------
>  drivers/nvdimm/pmem.c         | 20 ---------
>  drivers/s390/block/dcssblk.c  | 14 ------
>  fs/dax.c                      |  5 ---
>  fs/fuse/virtio_fs.c           | 19 +--------
>  include/linux/dax.h           |  9 ++--
>  include/linux/device-mapper.h |  4 --
>  11 files changed, 37 insertions(+), 240 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e81d5ee57390f..ff676a07480c8 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -105,6 +105,10 @@ enum dax_device_flags {
>         DAXDEV_WRITE_CACHE,
>         /* flag to check if device supports synchronous flush */
>         DAXDEV_SYNC,
> +       /* do not use uncached operations to write data */
> +       DAXDEV_CACHED,
> +       /* do not use mcsafe operations to read data */
> +       DAXDEV_NOMCSAFE,

Linus did not like the mcsafe name, and this brings it back. Let's
flip the polarity to positively indicate which routine to use, and to
match the 'nofault' style which says "copy and handle faults".

/* do not leave the caches dirty after writes */
DAXDEV_NOCACHE

/* handle CPU fetch exceptions during reads */
DAXDEV_NOMC

...and then flip the use cases around.

Otherwise, nice cleanup. In retrospect I took the feedback to push
this decision to a driver a bit too literally, this is much better.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
