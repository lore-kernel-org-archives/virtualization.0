Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FE6C4742C
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 07:01:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65D120786
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 07:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXqPgs8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65D120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 103D520C92;
	Thu,  5 Nov 2020 07:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0a2Ag0v0qU0N; Thu,  5 Nov 2020 07:00:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1E6AB20361;
	Thu,  5 Nov 2020 07:00:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EED06C088B;
	Thu,  5 Nov 2020 07:00:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68C81C0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4CC2785579
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UxQc_jw123dW
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:00:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D210C85572
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:00:57 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id x13so667699pfa.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Nov 2020 23:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=In22z4zSRFjmN0f9ZWT4tSWe/e4QLia1xEowLwJnVsw=;
 b=MXqPgs8+6JTdO/hUoDQw5oReQIcGnaaVfUbxHiTj/WNMBS0cf3z4ohV+gF45hY58w/
 aoFliyd9R/tnYceFsDd1i5ZqyVInBUwnOTkO0iGVPUyoNe059GQEoAK6RMQUzn3dMo1l
 n9M7VKH4+IyCkaIL+7QBE2LQmvswOpQQnMjujNrQlvxsPx87Z28CxZPz+egzh8LAELS1
 S+F/AqaP302QLGtQjTyL4M7IxF1We073NibdHPAzDHgpmmJILhf1mJaq6BnvAlrSjSh2
 LzOl1rH84hlkjcyzBvUXH9e57VW746Fzr1Vd5+qP9c9nk8Gtt7KQOSjZhfNjGgPBap4m
 fuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=In22z4zSRFjmN0f9ZWT4tSWe/e4QLia1xEowLwJnVsw=;
 b=az0ErELFf3pWyJe7A4MoKUFyYKItU5SNBiPN9leu9VSyM+g5HJlB4y4xWDUbhXoVNB
 ooNcUNOivM1k4KQ4wPLaA/Jpo8MJDizl0PAFovHDGauHKH+yaShKLvUkkStmTeEw+AUO
 VnOiJTIPozm+JBzainUYwR7FXBI7AKkjqXrykMBq9Pnbv4xTbztLlsXfQKhtzkd98V/N
 82V4Uuef+VGFQyi6ythetmw0eIknwFWuwOSGb+//pFKX0dsHOiOm4wouun+kAjHyYpHf
 h6cMBU/JPbP0sdPbgFBaV4OrkPrjZ3aHHC2MWYVX5WWGcdI5w2+X8vlU80Tdsf9/1YSG
 dODw==
X-Gm-Message-State: AOAM533txL1pMkScCsw21nK51xBSbsIpqA+LlSXmxyVT5xH7ux98w1Uu
 c8qZgLHKWutCUgG5gO9Rcxc=
X-Google-Smtp-Source: ABdhPJxccwbMNiHKtX8PlDU2gsnrWVHgRU2ASpOcGh5rnfj0CZusDbR0R9TyZJHcK06SvgZWWBZTOw==
X-Received: by 2002:a65:4b84:: with SMTP id t4mr1159089pgq.138.1604559657437; 
 Wed, 04 Nov 2020 23:00:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
 by smtp.gmail.com with ESMTPSA id c11sm814474pjn.26.2020.11.04.23.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 23:00:56 -0800 (PST)
Date: Thu, 5 Nov 2020 16:00:54 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: use kvmalloc for large allocations
Message-ID: <20201105070054.GD128655@google.com>
References: <20201105014744.1662226-1-senozhatsky@chromium.org>
 <20201105065233.3td3zuyfmbypjtvq@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105065233.3td3zuyfmbypjtvq@sirius.home.kraxel.org>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Suleiman Souhlal <suleiman@google.com>
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

Hi,

On (20/11/05 07:52), Gerd Hoffmann wrote:
> > -	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
> > -			      GFP_KERNEL);
> > +	*ents = kvmalloc_array(*nents,
> > +			       sizeof(struct virtio_gpu_mem_entry),
> > +			       GFP_KERNEL);
> 
> Shouldn't that be balanced with a kvfree() elsewhere?

I think it already is. ents pointer is assigned to vbuf->data_buf,
and free_vbuf() already uses kvfree(vbuf->data_buf) to free it.

	-ss
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
