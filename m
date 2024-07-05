Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95516C6AE
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720193409; cv=none; b=PNbbN77JT2FiF0BE5xfvKtV49lnW1I6vZzlq8gTOhp3jNm32tsN/ZSq4TgfXePfzOKWah5N2WjCWEDkVYUfMXeJSEf+MhRRGGV6yKQgCxSA2JQ9PXWy8R0U7WcNB2it+jBxHIR9SpU1zqKpFOkCAgOFw5ES1rPzCn9gw0dHorsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720193409; c=relaxed/simple;
	bh=yEgkAHLT9xLT/kpLsE5GeojmOuuYLdB0Rj2xt8hrjNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EA8kY9MIHR7K3+ZpEOJt+mMeF6+zO7tJhl8nSNh244xXUGxMf26/O9hyi8XdI+Q5qt4sMlXD5oEzfy3Zxba8GoF4CxU4roZuAP4hUb+KkAddBNEqZWoF6D91/8d5VpWgR7aXwy31pZ6sX1vwV8hfWtusfaDozbtuWyIFy7V34oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9T84yNm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9T84yNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720193407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74RpSZvpnxQTfE/ido1/Stn3pY4Si/dshmNfWAA5MUE=;
	b=P9T84yNmh/TIfYhs+I+bX3rUxAkWWLcsT48X8eyjymVsuslbsXiX45cvgLo5CM4ey4++jr
	RaNi2lzQfTQe2UVw+n+2YnACY51qqUR3h3ktMwTf88US6EwR9T5PHazbHdPpIXYF85EVO0
	nCPq1lDiIT4jUrt2W40FKOraLseEv44=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-TyIRavoENYSL2Ic0vJxK5w-1; Fri, 05 Jul 2024 11:30:05 -0400
X-MC-Unique: TyIRavoENYSL2Ic0vJxK5w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4263fff5eaeso12963575e9.0
        for <virtualization@lists.linux.dev>; Fri, 05 Jul 2024 08:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720193404; x=1720798204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74RpSZvpnxQTfE/ido1/Stn3pY4Si/dshmNfWAA5MUE=;
        b=oA8tJQGPmSzO+8XoiViPbp6SLLnxHQTaSS56jJ9mz1haxtecRPkxs7mErTMpt+EqLz
         gKVRXGD6jnlFK09IqCn4nz/Mj1sWS2IpvPpfd56PhgNFr13ksF2S6z/HtBei+R8ydGsk
         V7Hl/E1xMYmPRNJrgkaRy/GTuOKtjRC0/LHAQPfxgVHrfZjVL5qfJD1bN5LTjwKh6py9
         7ypbzoV3JaXieeVNpQ/kyuNksz/qjzJMZaieWy8+FOyUXnaLqeCQR9oijDR9UMdTRKgz
         yxJsJF3ju8O9ESixF5WHd8QIiUW0uAHwYjbbazf2CKahwlkm6YARfn7wewbwfE8BwnnX
         joEA==
X-Forwarded-Encrypted: i=1; AJvYcCViFqKVbEWjADNjp3yxexG7pxyrePBHhjT0htIqEdeygTKxHeGMnCsOX/mZN5TkA61zj3GtmTQPxvMZDoNjEl+fXOBLl5Lzr6SM/D8kIKU=
X-Gm-Message-State: AOJu0YzPpPbex12cRqrJywfyy14iXlBEkYIakhCInVFMZnY+Ty5OJECk
	PbezjQBNJ471HJPtc7Augd49Xu//A5Q5hb9iV+6G4GZFHWucTdpQXOSjx0F4WpWnIBxg5DgFo+Z
	HbHYLDCKDrmh4tfDJbqI6y8ulBSmernozFJi0almimLAwldXuCuKgOgnMzbhtdNRK
X-Received: by 2002:a05:600c:1382:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42651dcf78amr13275305e9.18.1720193404492;
        Fri, 05 Jul 2024 08:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkVrboDczs0dPxo4wunbHpnYmaIVmXlNE6+0TzmZu7gg/JiVCnHif8sPUpik4uc7u+5wZ2JA==
X-Received: by 2002:a05:600c:1382:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42651dcf78amr13274985e9.18.1720193403888;
        Fri, 05 Jul 2024 08:30:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca492sm67562515e9.34.2024.07.05.08.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:30:03 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:29:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
	hare@suse.de, kbusch@kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 0/5] Validate logical block size in blk_validate_limits()
Message-ID: <20240705112922-mutt-send-email-mst@kernel.org>
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240705115127.3417539-1-john.g.garry@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2024 at 11:51:22AM +0000, John Garry wrote:
> This series adds validation of the logical block size in
> blk_validate_limits().
> 
> Some drivers had already been validating this themselves. As such, we can
> mostly drop that driver validation.
> 
> nbd is problematic, as we cannot only change to just stop calling
> blk_validate_limits(). This is because the LBS is updated in a 2-stage
> process:
> a. update block size in the driver and validate
> b. update queue limits
> 
> So if we stop validating the limits in a., there is a user-visible change
> in behaviour (as we stop rejecting invalid limits from the NBD_SET_BLKSIZE
> ioctl). So I left that untouched.
> 
> This topic was originally mentioned in [0] and then again in [1] by
> Keith.
> 
> I have also included a related virtio_blk change to deal with
> blk_size config fallback.
> 
> [0] https://lore.kernel.org/linux-block/10b3e3fe-6ad5-4e0e-b822-f51656c976ee@oracle.com/
> [1] https://lore.kernel.org/linux-block/Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com/

virtio bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I assume this everything will go in gother with block patches?


> John Garry (5):
>   virtio_blk: Fix default logical block size fallback
>   block: Validate logical block size in blk_validate_limits()
>   null_blk: Don't bother validating blocksize
>   virtio_blk: Don't bother validating blocksize
>   loop: Don't bother validating blocksize
> 
>  block/blk-settings.c          |  2 ++
>  drivers/block/loop.c          | 12 +-----------
>  drivers/block/null_blk/main.c |  3 ---
>  drivers/block/virtio_blk.c    | 31 +++++++++++--------------------
>  include/linux/blkdev.h        |  1 +
>  5 files changed, 15 insertions(+), 34 deletions(-)
> 
> -- 
> 2.31.1

