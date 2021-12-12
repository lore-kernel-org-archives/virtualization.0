Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEF9C4332F
	for <virtualization@archiver.kernel.org>; Sun, 12 Dec 2021 14:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 943F384BD7;
	Sun, 12 Dec 2021 14:23:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c-bP8-oRvNP0; Sun, 12 Dec 2021 14:23:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2FB8784B64;
	Sun, 12 Dec 2021 14:23:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A2C5C002F;
	Sun, 12 Dec 2021 14:23:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 626E8C0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 432BA84BA5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:23:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gC440upatS27
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:23:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADA5884B64
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:23:52 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id v19so9439269plo.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 06:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8lwwZWzMg5a3s7lwMASlg5tu9b+fzGmp/D7TMwKxKFc=;
 b=C1VDazYvOsHerGRum3UpDemvC3bLBABNz77cgqTNDNW/AlDRjmxr+knCqOb3lbM8WO
 nCuRMxTi17hjy2mfZFS6DLg1CC+TyYg8zaU2aBeKKFky3Rcsp4/9vOZKTntOjByb+hJ5
 0z6NFJU2SLN62ZWqorLtNFaHccHYM1JZ7Mu2yHUUiPrzmD1llDNRqRtKoHw0vprZZn1C
 nm6MqHIyalByp/KuSOcHH4nPAdw2l3b13tMdWhLdbsNZfg7ms1Wl3ArmPz5baUq43ARi
 V4c990kOWIh9SL0yrCBDZ7oIc/+hdYouELCNB6m6IMhS2kuwbJLs9VZytg0tPw2o9EEM
 7w2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8lwwZWzMg5a3s7lwMASlg5tu9b+fzGmp/D7TMwKxKFc=;
 b=salkwknnOEB69ac6E4854U8KQ7s2cbnfnwucbayu01SqSpV8y+3NqNjspukNltJqHV
 kyNnxXB1S0JjBoB9PcJVHDhcy0Zm9TdZuUFUBEMalCPHOQa9GMg8LzdVeh3ICbdqnMgZ
 ERiPHyNs+Kk5f/DuDbJ1dGzlx1k7uwewChrAGAmVIDToXnsclvHy01izSgS3Y4MDu3SW
 a1awPXkxEbFqvCH1sfYZwgHcPT8+EQkPzsW/vWQC3W540V8gTAYEDUQI+SrR1/3ykJsT
 xzwdDPVDfaCzrUU6fUduqsfJj8zCdataHKBNva7jPuabFyGJJVFhI3ZUD7O3e/HeomRm
 dOeg==
X-Gm-Message-State: AOAM5331Ic/5c7w3XlctygaanooVEF9GM9fRa416dnX/y3N8SIQhFN0l
 RFqcBoSddabLiSwAqW9MWKPlz7X5F1y3yWfxh70Zkw==
X-Google-Smtp-Source: ABdhPJwD+M0MBopqkFuJGa9sgfSVBzZnNozNDZqwXOq1RFaO0zbunOMva9BpA++y2ooxKRxQrM2G01fpVQgDA3WnFR8=
X-Received: by 2002:a17:90b:1e49:: with SMTP id
 pi9mr38028565pjb.220.1639319032132; 
 Sun, 12 Dec 2021 06:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-3-hch@lst.de>
In-Reply-To: <20211209063828.18944-3-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 12 Dec 2021 06:23:41 -0800
Message-ID: <CAPcyv4gZvE69C8wCukFGgFLqzD49U8Wn8X4F9N6RmMFebgyqzg@mail.gmail.com>
Subject: Re: [PATCH 2/5] dax: simplify dax_synchronous and set_dax_synchronous
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
> Remove the pointless wrappers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, not sure why those ever existed.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  drivers/dax/super.c |  8 ++++----
>  include/linux/dax.h | 12 ++----------
>  2 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e7152a6c4cc40..e18155f43a635 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -208,17 +208,17 @@ bool dax_write_cache_enabled(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(dax_write_cache_enabled);
>
> -bool __dax_synchronous(struct dax_device *dax_dev)
> +bool dax_synchronous(struct dax_device *dax_dev)
>  {
>         return test_bit(DAXDEV_SYNC, &dax_dev->flags);
>  }
> -EXPORT_SYMBOL_GPL(__dax_synchronous);
> +EXPORT_SYMBOL_GPL(dax_synchronous);
>
> -void __set_dax_synchronous(struct dax_device *dax_dev)
> +void set_dax_synchronous(struct dax_device *dax_dev)
>  {
>         set_bit(DAXDEV_SYNC, &dax_dev->flags);
>  }
> -EXPORT_SYMBOL_GPL(__set_dax_synchronous);
> +EXPORT_SYMBOL_GPL(set_dax_synchronous);
>
>  bool dax_alive(struct dax_device *dax_dev)
>  {
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 87ae4c9b1d65b..3bd1fdb5d5f4b 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -48,16 +48,8 @@ void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
>  bool dax_write_cache_enabled(struct dax_device *dax_dev);
> -bool __dax_synchronous(struct dax_device *dax_dev);
> -static inline bool dax_synchronous(struct dax_device *dax_dev)
> -{
> -       return  __dax_synchronous(dax_dev);
> -}
> -void __set_dax_synchronous(struct dax_device *dax_dev);
> -static inline void set_dax_synchronous(struct dax_device *dax_dev)
> -{
> -       __set_dax_synchronous(dax_dev);
> -}
> +bool dax_synchronous(struct dax_device *dax_dev);
> +void set_dax_synchronous(struct dax_device *dax_dev);
>  /*
>   * Check if given mapping is supported by the file / underlying device.
>   */
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
