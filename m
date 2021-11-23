Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82063C433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 21:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0F13400BF;
	Tue, 23 Nov 2021 21:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uAwv0Hk9xlRu; Tue, 23 Nov 2021 21:22:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 263CC40374;
	Tue, 23 Nov 2021 21:22:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01EF0C002E;
	Tue, 23 Nov 2021 21:22:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EB4FC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 21:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 790BF40221
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 21:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j3Tz4R7NHvPS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 21:22:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50D0C401F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 21:22:24 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id n26so567155pff.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 13:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bLSToY/Rn4QaplrUteOdrUS7Uug3uZWr/TlOz9Y1nF0=;
 b=b/hUI3hQLxDR2Xk9r7lQxFzBrg/2/5tGZW+JSVwNYrq8dmNWS3P9ynBIU8RZmfFHUI
 Xgm0552sZFP2+qPF3soghwDd7XxX6FGNBFe395T6bvF+N1dr29Lop15wmWK8lt8m87yV
 9vAVuWAMC6kkIO1VclhYl3oilFONamQuNci0i1jGGdKo0v4NlKYSPdpcWln2MSBf1py8
 eotcm4rw3pNPGNJSmy6HW2en9pvx0GUA8KH3ho166JTJ5FG5ph7IQpvk6v1nkInbqZW5
 YGsf77VgzBkZO6x5IA8KcT5QTl5SnWc54c+GTeaTywwpW3otwTRaZbbIpfY5ylF9vOkP
 iFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bLSToY/Rn4QaplrUteOdrUS7Uug3uZWr/TlOz9Y1nF0=;
 b=mA3TfHHZfOFJrPYOi2QtUTaAxKAtacWqMVTTsnXpd0YhS5EWuruLnHlO1rjEfOoSRM
 hOTfO5umMwe03MeLIgAfVt/7eEl69dPMq4B90TYwu+TIj4/oG/i/r/vUMwNuV8B2Cn9B
 osIifR9NBg+X0bdVKy85qHdvEMHAIe5rCsbLzuR4ohW1OYGNLG82om/YlkJLqKQot0nX
 YrbFtThcQhQ35CQR4Wg8PuIXESwfqACwsvPSWiey1oXHLmKN6zamDrhX5gsLFQ52W7DV
 mp+rnfFnZ4a9CGEGMy0TkcSRP0SSB60xyBQRObCRUGqQsUVHcir5qGfRnhGd0VaM6mo9
 4ffQ==
X-Gm-Message-State: AOAM533Rf0bgsroJ5SREmQVVCcBSjCf9h4Pol0dPJGnuP1glRRd1vVLR
 Bn7mV1j2osObEAdNbIn4hVFZnpB+H23CX+Ri1znRZQ==
X-Google-Smtp-Source: ABdhPJynvi8g71RwjaWWgFjo9LaoTAJgYi1+7huNhjnlJVCNZL4JsPbOJLOogDISiszVaR5xm5B316tq/pqSlm2ohsA=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr476612pfu.61.1637702544283; Tue, 23 Nov
 2021 13:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-18-hch@lst.de>
In-Reply-To: <20211109083309.584081-18-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 13:22:13 -0800
Message-ID: <CAPcyv4imPgBEbhDCQpDwCQUTxOQy=RT9ZkAueBQdPKXOLNmrAQ@mail.gmail.com>
Subject: Re: [PATCH 17/29] fsdax: factor out a dax_memzero helper
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
> Factor out a helper for the "manual" zeroing of a DAX range to clean
> up dax_iomap_zero a lot.
>

Small / optional fixup below:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index d7a923d152240..dc9ebeff850ab 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1121,34 +1121,36 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  }
>  #endif /* CONFIG_FS_DAX_PMD */
>
> +static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
> +               unsigned int offset, size_t size)
> +{
> +       void *kaddr;
> +       long rc;
> +
> +       rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> +       if (rc >= 0) {

Technically this should be "> 0" because dax_direct_access() returns
nr_available_pages @pgoff, but this isn't broken because
dax_direct_access() converts the "zero pages available" case into
-ERANGE.

> +               memset(kaddr + offset, 0, size);
> +               dax_flush(dax_dev, kaddr + offset, size);
> +       }
> +       return rc;
> +}
> +
>  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  {
>         pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
>         long rc, id;
> -       void *kaddr;
> -       bool page_aligned = false;
>         unsigned offset = offset_in_page(pos);
>         unsigned size = min_t(u64, PAGE_SIZE - offset, length);
>
> -       if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
> -               page_aligned = true;
> -
>         id = dax_read_lock();
> -
> -       if (page_aligned)
> +       if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
>                 rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
>         else
> -               rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
> -       if (rc < 0) {
> -               dax_read_unlock(id);
> -               return rc;
> -       }
> -
> -       if (!page_aligned) {
> -               memset(kaddr + offset, 0, size);
> -               dax_flush(iomap->dax_dev, kaddr + offset, size);
> -       }
> +               rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
>         dax_read_unlock(id);
> +
> +       if (rc < 0)
> +               return rc;
>         return size;
>  }
>
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
