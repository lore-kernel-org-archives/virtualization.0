Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E96C433FE
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 02:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B48C5400A6;
	Wed, 24 Nov 2021 02:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SrsR8Sg-Wm8I; Wed, 24 Nov 2021 02:52:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 43EDB40125;
	Wed, 24 Nov 2021 02:52:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EABE4C001E;
	Wed, 24 Nov 2021 02:52:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08412C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4EBF60AA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5e5a_4tDAhxq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:52:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63D5860AAD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:52:29 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id b13so667128plg.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HOfci/mx3akOO+4HmSZ2UPdC5Rli9mLX/eg9lyyjZ30=;
 b=Y7XkrixbrNlS8hQi6+YjpK4PZmxcaZt8IqYEL0x+AbApMNhFV77CzxIm1fpzZJvqGy
 z6D/gHDQ4xlWEfbCz9zV/Nr2rYvjyAJ/qcfvABnWEzU5q3sPzeWrzFiGiQQVw5TF5P/Q
 vGI8iomC/tTJLNOXXKE+qcAeV4HDU/nIHSo9sub+NaaMXbz5ALE5SX90GBKyPNNwTUeM
 U8Wl8gNSrdkT3Uzd5sOv409e3dENQvzi+2J3G8FjskgqDuk0PglVJ0u6ajEy8rV/j0R2
 Kp+xFLo9F8v5ClK8M1g/uaLLpJP0HiqMIi5yPKOPokQDDyomwLUF2ZncL/aMKydNlkDc
 qMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HOfci/mx3akOO+4HmSZ2UPdC5Rli9mLX/eg9lyyjZ30=;
 b=O5ZV64HLjlX93ehrj7F67T9w63zDZwMbCSiCrx5BD1OaxEnLAwPyRYA2PWF8Y7Y3Po
 4QE3kB2sZnxcAU+s/94kJJtRpW7Q9gCrrrROoooz3RQKPU6xTxkEVtyzxF0okPoJ38Qc
 ynZYe7q6MAw70usVT87g6Vs3eI4yHG3mKmmwryI8l3Am3mv0eg4HKGFmGjfqIjX21d4X
 Lojg549eLccp3LLRVQBswgHO2oyAPvPBcnK0Jh08o04FCWFs9CnAZhj7s7FbnjfhREpu
 r17pvs0Lja12QdUfGBtpM0D7yhVT4P4NJLQ2WMAd059n2mMp8I/z1H3vUNpYul7x5LgU
 pBAQ==
X-Gm-Message-State: AOAM533/r9O8O1NHzqDMFLefIWLwLV6TIyPhjtUtAX2piVjWiN44vDIZ
 HKonIwVk8qSlHimdN1LRT9LHWWErGPHqYZIoZ67VWw==
X-Google-Smtp-Source: ABdhPJwYJBk3MOCLfOjDzIFwcn3St8lk3aeiUUUrOONNeXpKHHsZfcNKcAaGYukH/G67vklAJOZt7FEQ2h9y1bfGO+A=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id
 kb10mr10191254pjb.8.1637722343903; 
 Tue, 23 Nov 2021 18:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-25-hch@lst.de>
In-Reply-To: <20211109083309.584081-25-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 18:52:13 -0800
Message-ID: <CAPcyv4iRUDaT4rrLYhGrJB-zt9B-bGGoVW3wYoUnePRxx58Fdw@mail.gmail.com>
Subject: Re: [PATCH 24/29] xfs: use xfs_direct_write_iomap_ops for DAX zeroing
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
> While the buffered write iomap ops do work due to the fact that zeroing
> never allocates blocks, the DAX zeroing should use the direct ops just
> like actual DAX I/O.
>

I always wondered about this, change looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 8cef3b68cba78..704292c6ce0c7 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1324,7 +1324,7 @@ xfs_zero_range(
>
>         if (IS_DAX(inode))
>                 return dax_zero_range(inode, pos, len, did_zero,
> -                                     &xfs_buffered_write_iomap_ops);
> +                                     &xfs_direct_write_iomap_ops);
>         return iomap_zero_range(inode, pos, len, did_zero,
>                                 &xfs_buffered_write_iomap_ops);
>  }
> @@ -1339,7 +1339,7 @@ xfs_truncate_page(
>
>         if (IS_DAX(inode))
>                 return dax_truncate_page(inode, pos, did_zero,
> -                                       &xfs_buffered_write_iomap_ops);
> +                                       &xfs_direct_write_iomap_ops);
>         return iomap_truncate_page(inode, pos, did_zero,
>                                    &xfs_buffered_write_iomap_ops);
>  }
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
