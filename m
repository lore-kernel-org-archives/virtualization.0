Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F185C433DF
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:09:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044F02231B
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmUP3qEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044F02231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6EC71875DF;
	Mon, 19 Oct 2020 15:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3En20wpdZCDF; Mon, 19 Oct 2020 15:09:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B362A875C4;
	Mon, 19 Oct 2020 15:09:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A204AC0052;
	Mon, 19 Oct 2020 15:09:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B114C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 650978681D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:09:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2D7UrLB6pbia
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:09:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E2CE78680F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603120141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Quj0p/pFwEfJeGG4Twcf2zA6haX4tZXg4zcm/JGZqU=;
 b=gmUP3qEOUDF4Tk1IBGrkn0nJU8wBhTmZy0NEsafxwdpoCd9xAz4hDlgYTou6doVytcEVFu
 a0dsMAtChpVz+rc7kILKT19kX+cdeTSb9CrIauRI0E9MctHbDJ5KOHcaglsawOvJikXhzK
 yb+mZoSKj9NmeJEvgANXF+Wnqu98ovM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-kmCoxwzdMHyf4D8Zd0xMDg-1; Mon, 19 Oct 2020 11:08:59 -0400
X-MC-Unique: kmCoxwzdMHyf4D8Zd0xMDg-1
Received: by mail-wm1-f70.google.com with SMTP id g71so60483wmg.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 08:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3Quj0p/pFwEfJeGG4Twcf2zA6haX4tZXg4zcm/JGZqU=;
 b=bZYZ1Cd8fLJdeNTjgPGkQCo4TLiIIT6kZEAPGs7muG7dxnf75XE1Y8EDlzPob9n9/6
 XhtHzDQO41HkIciT6/zL7TjyJcPUeEaq2wTcVLhZ9dodJ7HG+8KZOI9jQTcbHUF8bu03
 DWZ490GnEBQWD/0/jDRSPH/MoEy5z0ryHA2vvpMrztJhx/Elj8P8hX5pMVtjI30WO4Ci
 TRfXAatn1yl093RnqpFFleglzAycaWPL0bpR7phoDzWB0yAowTn1bPb+GvVdYMvRn+zb
 Mp7nJMScBxxUzM0iiuuQbCMJ++cH+t/qo8o0uFGuTfpsmivDnm3bka+n1a1etlKZmTTE
 /0bA==
X-Gm-Message-State: AOAM533uM4JtFrX2m7J6as6AZsZ5sMpauczDvlB4NNUbe12MKqfXZBEg
 WHC/HVakFmUi/S39jeWN5tZ/wnQp3+ZMvjuDtC3HIvrtcwJalDf0mgClmd8eJRDnlQAV4u5H0Pl
 G6JvzfRFFaVuFBSwmpvm1YzeYGQpi+PYr4lsKNMCXaA==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr20058754wrn.35.1603120138562; 
 Mon, 19 Oct 2020 08:08:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsCVgyeKRoQU6Fj0S1z8nRkIR3+g7FcgqFJ58jP3zzzgmCjy8qRBBanwGkffcJmZ3YMi9feQ==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr20058721wrn.35.1603120138315; 
 Mon, 19 Oct 2020 08:08:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id j101sm52479wrj.9.2020.10.19.08.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:08:56 -0700 (PDT)
Date: Mon, 19 Oct 2020 11:08:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC 2/4] vduse: Introduce VDUSE - vDPA Device in Userspace
Message-ID: <20201019110740-mutt-send-email-mst@kernel.org>
References: <20201019145623.671-1-xieyongji@bytedance.com>
 <20201019145623.671-3-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20201019145623.671-3-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
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

On Mon, Oct 19, 2020 at 10:56:21PM +0800, Xie Yongji wrote:
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> new file mode 100644
> index 000000000000..855d2116b3a6
> --- /dev/null
> +++ b/include/uapi/linux/vduse.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _UAPI_VDUSE_H_
> +#define _UAPI_VDUSE_H_
> +
> +#include <linux/types.h>
> +
> +#define VDUSE_CONFIG_DATA_LEN	8
> +
> +enum vduse_req_type {
> +	VDUSE_SET_VQ_STATE,
> +	VDUSE_SET_FEATURES,
> +	VDUSE_GET_FEATURES,
> +	VDUSE_SET_STATUS,
> +	VDUSE_GET_STATUS,
> +	VDUSE_SET_CONFIG,
> +	VDUSE_GET_CONFIG,
> +};
> +
> +struct vduse_vq_state {
> +	__u32 index;
> +	__u32 num;
> +	__u64 desc_addr;
> +	__u64 driver_addr;
> +	__u64 device_addr;
> +	__u8 ready;
> +};
> +
> +struct vduse_dev_config_data {
> +	__u32 offset;
> +	__u32 len;
> +	__u8 data[VDUSE_CONFIG_DATA_LEN];
> +};
> +
> +struct vduse_dev_request {
> +	__u32 type;
> +	__u32 unique;
> +	__u32 flags;
> +	__u32 size;
> +	union {
> +		struct vduse_vq_state vq_state;
> +		struct vduse_dev_config_data config;
> +		__u64 features;
> +		__u8 status;
> +	};
> +};
> +
> +struct vduse_dev_response {
> +	__u32 unique;
> +	__s32 result;
> +	union {
> +		struct vduse_dev_config_data config;
> +		__u64 features;
> +		__u8 status;
> +	};
> +};
> +
> +/* ioctl */
> +
> +struct vduse_dev_config {
> +	__u32 id;
> +	__u32 vendor_id;
> +	__u32 device_id;
> +	__u64 iova_size;
> +	__u16 vq_num;
> +	__u16 vq_size_max;
> +	__u32 vq_align;
> +};
> +
> +struct vduse_vq_eventfd {
> +	__u32 index;
> +	__u32 fd;
> +};
> +
> +#define VDUSE_BASE	'V'
> +
> +#define VDUSE_CREATE_DEV	_IOW(VDUSE_BASE, 0x01, struct vduse_dev_config)
> +#define VDUSE_GET_DEV		_IO(VDUSE_BASE, 0x02)
> +#define VDUSE_DESTROY_DEV	_IO(VDUSE_BASE, 0x03)
> +
> +#define VDUSE_DEV_START		_IO(VDUSE_BASE, 0x04)
> +#define VDUSE_DEV_STOP		_IO(VDUSE_BASE, 0x05)
> +#define VDUSE_VQ_SETUP_KICKFD	_IOW(VDUSE_BASE, 0x06, struct vduse_vq_eventfd)
> +#define VDUSE_VQ_SETUP_IRQFD	_IOW(VDUSE_BASE, 0x07, struct vduse_vq_eventfd)
> +
> +#endif /* _UAPI_VDUSE_H_ */


Could we see some documentation about the user interface of this module please?

> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
