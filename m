Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DAAC433EF
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 16:28:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A31A610D2
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 16:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A31A610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3359660604;
	Mon,  1 Nov 2021 16:28:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TYirllTg8P3D; Mon,  1 Nov 2021 16:28:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D7E8F605F7;
	Mon,  1 Nov 2021 16:28:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF1C3C0019;
	Mon,  1 Nov 2021 16:28:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AFCFC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5595B401D3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6VU7ObFpYAn
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:28:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D5F740171
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635784125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSSeiEsgy4ZRAwPPYMh123Zf4LHs8XHr2NNVii6Qq7o=;
 b=H3BL2sO8tZdO7jApOtbVv+jBbGXwXcgS14tJ6qV4WC847WMLA2A9odKqXIEoV64Qb+lu42
 fX6vyNjXEEgw+31uAOiB5L9bHJD/4bTru0BLjQtZP6vtDXs+5eU9DtaDuWp7tfaCQuY9Au
 o51Ww9Fs1nZnMG1Iji8fxElXnQRq89A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-6vFAYT2KMGit_qICbfMZ7Q-1; Mon, 01 Nov 2021 12:28:41 -0400
X-MC-Unique: 6vFAYT2KMGit_qICbfMZ7Q-1
Received: by mail-qk1-f199.google.com with SMTP id
 w2-20020a3794020000b02903b54f40b442so10921439qkd.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 09:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vSSeiEsgy4ZRAwPPYMh123Zf4LHs8XHr2NNVii6Qq7o=;
 b=2SaFpCrRFRS3yhj4o+r7Ch5xIWCgyMTj3NWSUkHzuN6MOv2kbnSXwzDWZUNsnw1MXZ
 MD5FP+HYqVgJS8aEuIn5iqS7RF8ayZQgJA1WVTk9au//c6yhrw03sWFXji8u0HTsOM65
 vwDCdVLIfDv0X0ieZDxPHpr/Rskxo/Eah7estR1N24OvqTtPN5JxHVtdHy0oDDV5fsPy
 5XCUfxsHFJ7G4Z71TYQZLXcH+aIhGc3BgfLJ5O/5WKCxHgHyO+t0JxCHPV4XbB0crPQt
 GFqVlneV3K/c7FYs89jBHj/391P5SX3IosMZXFKdYnSQiKgBEU2MlxLmlLIlcwRVp2O4
 QeZQ==
X-Gm-Message-State: AOAM530gRlGgLl4omy3lU4rN9PFppi33oEGpCBiKTxtdHMGbH8BOwu4D
 GbQsjf51jtCbFD8/r0e2a0AuZqZh01mNpXsJ3kW+Q0uzVbOBJ/p4LgRJRNeTrbKUpUR/bUD/Mjx
 7Xc4JtneTxKAZyecyGD/sI1XzKiWn5yWmlCy1zm/7
X-Received: by 2002:a05:6214:e4a:: with SMTP id
 o10mr29863860qvc.58.1635784120280; 
 Mon, 01 Nov 2021 09:28:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnnToYfIdlwewHO/8stJwOwIrIwZDJizj1Vl7BOinzg8bNzbcfCyJ9R9K4APUV9a9jX59VOw==
X-Received: by 2002:a05:6214:e4a:: with SMTP id
 o10mr29863844qvc.58.1635784120140; 
 Mon, 01 Nov 2021 09:28:40 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id u185sm10250817qkd.48.2021.11.01.09.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 09:28:39 -0700 (PDT)
Date: Mon, 1 Nov 2021 12:28:38 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/11] dax: simplify the dax_device <-> gendisk association
Message-ID: <YYAVtv6kiqVHDjQH@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-4-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20211018044054.1779424-4-hch@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
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

On Mon, Oct 18 2021 at 12:40P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Replace the dax_host_hash with an xarray indexed by the pointer value
> of the gendisk, and require explicitl calls from the block drivers that
> want to associate their gendisk with a dax_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

...

> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 79737aee516b1..a0a4703620650 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1683,6 +1683,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  	bioset_exit(&md->io_bs);
>  
>  	if (md->dax_dev) {
> +		dax_remove_host(md->disk);
>  		kill_dax(md->dax_dev);
>  		put_dax(md->dax_dev);
>  		md->dax_dev = NULL;
> @@ -1784,10 +1785,11 @@ static struct mapped_device *alloc_dev(int minor)
>  	sprintf(md->disk->disk_name, "dm-%d", minor);
>  
>  	if (IS_ENABLED(CONFIG_FS_DAX)) {
> -		md->dax_dev = alloc_dax(md, md->disk->disk_name,
> -					&dm_dax_ops, 0);
> +		md->dax_dev = alloc_dax(md, &dm_dax_ops, 0);
>  		if (IS_ERR(md->dax_dev))
>  			goto bad;
> +		if (dax_add_host(md->dax_dev, md->disk))
> +			goto bad;
>  	}
>  
>  	format_dev_t(md->name, MKDEV(_major, minor));

Acked-by: Mike Snitzer <snitzer@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
