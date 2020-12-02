Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4139EC64E8A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 11:21:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3C9206E0
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 11:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3C9206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E94B38792F;
	Wed,  2 Dec 2020 11:21:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2XfKDkc28emL; Wed,  2 Dec 2020 11:21:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 55CDA87839;
	Wed,  2 Dec 2020 11:21:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35134C0859;
	Wed,  2 Dec 2020 11:21:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61F6EC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 11:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 49BE48792B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 11:21:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Ec2-pobSY20
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 11:21:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 81F5687839
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 11:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606908095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tWFGgSupy/SUledxw6vTNMTFDlvVB4tfXcEiiE/bKy4=;
 b=HPywrElrs6AEfnNKCHcRjRe/KPiw66lCvYoPhzRN36Po7EhKqQXYnCmTURwPBcF0TuSaiF
 GPPX9Niy8eyOSkoPoTK+zMtgUrEsnMhnC+erP08nPDZ7H08lQmZzRs0KTdYYOYqiPgJA9q
 qk4hz6JMUZ/2gkcq7i6+pbv2IAmLbgU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-u2Dk6hBLP8Sc2D1izqxj3g-1; Wed, 02 Dec 2020 06:21:34 -0500
X-MC-Unique: u2Dk6hBLP8Sc2D1izqxj3g-1
Received: by mail-wm1-f70.google.com with SMTP id q17so3264141wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Dec 2020 03:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tWFGgSupy/SUledxw6vTNMTFDlvVB4tfXcEiiE/bKy4=;
 b=NR/a6NJf6K7tulr3+ycQ40UzchxWBkj4vZCgVwZx7YS5vw3adsmtq4L9huPWrAvpsG
 r6tkWtOiNVuNKOQeDFlxqvL/hvgs95wLkMRZ5OOjQGGJlraa9v7Ga4HRjoPL0QRBSctZ
 KqW9pP2r9JBt6N5EbHq/Dmy5esMBUYlr+eX5WfOvCp48gNCCKWgGOWHztrQWcpGJYMEA
 EGJEL3HXzndDvU65cPzdvw7SNudEqlf0WfoCWttT6XTkjoO3w88L3+doILTPz5DNrShC
 68Chys/3DW/KMxX5soIQhtnvW1OO8B8K22q7MU8pJa8SIv28tLgMoW/kYSl+0IzIEBuh
 L/Vg==
X-Gm-Message-State: AOAM53041Wet2trRFMevBs1QsOSXLzNYaxlKo0Hi85MOcQa5UNabfBk5
 HtrDav19XMy0URd3cvefiHEDNQnYtU6+wAAb+S+fgpq1buF8h08BNwpRWNyARRTKL93qLR++Ho5
 OPVreAxKWWPlNsxfvWwE3JoUtEN3iNhOD7Wyk7Uv2cQ==
X-Received: by 2002:a5d:634b:: with SMTP id b11mr2911843wrw.97.1606908092962; 
 Wed, 02 Dec 2020 03:21:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1fsWF2Z7gQLSZxuX2FtoXMrXiM5VaYGLyrMtNuIcm5lD7L7yq4NnqVWesShsXHBORlb/pRA==
X-Received: by 2002:a5d:634b:: with SMTP id b11mr2911827wrw.97.1606908092807; 
 Wed, 02 Dec 2020 03:21:32 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id v1sm1623707wrr.48.2020.12.02.03.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 03:21:32 -0800 (PST)
Date: Wed, 2 Dec 2020 06:21:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: Re: [PATCH 2/2] uapi: virtio_ids: add missing device type IDs from
 OASIS spec
Message-ID: <20201202062046-mutt-send-email-mst@kernel.org>
References: <20201202111931.31953-1-info@metux.net>
 <20201202111931.31953-2-info@metux.net>
MIME-Version: 1.0
In-Reply-To: <20201202111931.31953-2-info@metux.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tony.luck@intel.com, keescook@chromium.org, anton@enomsg.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 ccross@android.com
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

On Wed, Dec 02, 2020 at 12:19:31PM +0100, Enrico Weigelt, metux IT consult wrote:
> The OASIS virtio spec (1.1) defines several IDs that aren't reflected
> in the header yet. Fixing this by adding the missing IDs, even though
> they're not yet used by the kernel yet.


double yet ;)

> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  include/uapi/linux/virtio_ids.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 3cb55e5277a1..bc1c0621f5ed 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -34,15 +34,21 @@
>  #define VIRTIO_ID_CONSOLE		3 /* virtio console */
>  #define VIRTIO_ID_RNG			4 /* virtio rng */
>  #define VIRTIO_ID_BALLOON		5 /* virtio balloon */
> +#define VIRTIO_ID_IOMEM			6 /* virtio ioMemory */
>  #define VIRTIO_ID_RPMSG			7 /* virtio remote processor messaging */
>  #define VIRTIO_ID_SCSI			8 /* virtio scsi */
>  #define VIRTIO_ID_9P			9 /* 9p virtio console */
> +#define VIRTIO_ID_MAC80211_WLAN		10 /* virtio WLAN MAC */
>  #define VIRTIO_ID_RPROC_SERIAL		11 /* virtio remoteproc serial link */
>  #define VIRTIO_ID_CAIF			12 /* Virtio caif */
> +#define VIRTIO_ID_MEMORY_BALLOON	13 /* virtio memory balloon */
>  #define VIRTIO_ID_GPU			16 /* virtio GPU */
> +#define VIRTIO_ID_CLOCK			17 /* virtio clock/timer */
>  #define VIRTIO_ID_INPUT			18 /* virtio input */
>  #define VIRTIO_ID_VSOCK			19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO		20 /* virtio crypto */
> +#define VIRTIO_ID_SIGNAL_DIST		21 /* virtio signal distribution device */
> +#define VIRTIO_ID_PSTORE		22 /* virtio pstore device */
>  #define VIRTIO_ID_IOMMU			23 /* virtio IOMMU */
>  #define VIRTIO_ID_MEM			24 /* virtio mem */
>  #define VIRTIO_ID_FS			26 /* virtio filesystem */
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
