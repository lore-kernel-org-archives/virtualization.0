Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD94C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 10:09:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D70E61077
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 10:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D70E61077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E641A4076A;
	Wed, 13 Oct 2021 10:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2TmdNKQYH3Mv; Wed, 13 Oct 2021 10:09:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4C01B40755;
	Wed, 13 Oct 2021 10:09:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20572C000F;
	Wed, 13 Oct 2021 10:09:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 605F5C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3667280E4E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:09:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xNvd1r2ppCX7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:09:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77FF480E4C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634119750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+H2CcqHQa3aHsMSE5edugMU+61s5pxwJjosotJGK2ew=;
 b=b9vNQPGdEUh7h8/NeWcZhitH0hQbKQ+3/LzZtzVSAqQSqoM1kB7FDO2N65rGH/23sd9qki
 iKqcVz7BoGgYouWP19vFHKHjrNjwovk9oiH806H+CnoU3l7TeORa1hf4zwmdPKabv8DmQl
 MXHf3FmTJkMixUCPXFtn3qoqGALjA0s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-Bbsj7GczPQSHKWjMdqNwrA-1; Wed, 13 Oct 2021 06:09:08 -0400
X-MC-Unique: Bbsj7GczPQSHKWjMdqNwrA-1
Received: by mail-wr1-f70.google.com with SMTP id
 d13-20020adf9b8d000000b00160a94c235aso1592959wrc.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+H2CcqHQa3aHsMSE5edugMU+61s5pxwJjosotJGK2ew=;
 b=Vj5kMBndwEDzBvlSZc8ufpLMyfTz5GrAiEcguFDchsOWPf29y0e3KGGTvi4q215MGr
 xCWc3sjzNVl0YSmUmGUE0kTkxEY7v+X0P3IjAwXZixK1iMlCs8xYsa/APiDK1owvdhLr
 1oxXFHYrekgcJ0VvQ3UAD0OLkFk5Z1i4mEB79JA3NhQoPwEGylep1GDOZRRXM+IHGnJW
 o6yoeCf2zLIR1ZV48IrroQ2FNaPSDj/v+4eDREXQvpHEB3dzd7BmdKwxdeX9oPzjpQ8+
 UHr19xwfYJiey0j00wyaJU1dqLPU2TguiHj4hVmULaxfVqxBI8PRG5Li4Oxbnc+9Tjd/
 WSXw==
X-Gm-Message-State: AOAM533RyLwcXvRhg3ULjN0f/LOPT5f0ARKKxp3C4hmy7jn8TGqaFBNa
 vb/Z5opXoQ39sSx9QANgAGAYIw+EE92/BA+m6byG0BWm+l9LAm7Y6ZjH+vX8rWs+w+o4gSrRAu2
 ukwYK7Wz/f1fMYRUnfjW4UDutFOQGdwG0DyTV5vf3gQ==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr11952925wmc.87.1634119747523; 
 Wed, 13 Oct 2021 03:09:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAG6+SiB0W+JEraq7KKny4L51lvdAdz9tBqTVTomwWEDTigwLRxfDFPNdqwRmIp2zegjsS7Q==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr11952906wmc.87.1634119747323; 
 Wed, 13 Oct 2021 03:09:07 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id i24sm4502602wml.26.2021.10.13.03.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 03:09:06 -0700 (PDT)
Date: Wed, 13 Oct 2021 06:09:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 02/12] virtio: add doc for validate() method
Message-ID: <20211013060808-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211012065227.9953-3-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, david.kaplan@amd.com,
 virtualization@lists.linux-foundation.org
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

On Tue, Oct 12, 2021 at 02:52:17PM +0800, Jason Wang wrote:
> This patch adds doc for validate() method.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

And maybe document __virtio_clear_bit : it says
"for use by transports" and now it's also legal in the
validate callback.

> ---
>  include/linux/virtio.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 41edbc01ffa4..0cd8685aeba4 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -152,6 +152,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
>   * @feature_table_size: number of entries in the feature table array.
>   * @feature_table_legacy: same as feature_table but when working in legacy mode.
>   * @feature_table_size_legacy: number of entries in feature table legacy array.
> + * @validate: optional function to do early checks
>   * @probe: the function to call when a device is found.  Returns 0 or -errno.
>   * @scan: optional function to call after successful probe; intended
>   *    for virtio-scsi to invoke a scan.
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
