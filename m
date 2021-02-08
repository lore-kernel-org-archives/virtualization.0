Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4218AC433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 15:47:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBEF064E60
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 15:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEF064E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6880086FFD;
	Mon,  8 Feb 2021 15:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D30coq8p4FoJ; Mon,  8 Feb 2021 15:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F34FE86887;
	Mon,  8 Feb 2021 15:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3884C0174;
	Mon,  8 Feb 2021 15:47:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27EDDC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 15:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0F2E98691A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 15:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rNLoNIhsQpiw
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 15:47:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7328B86919
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 15:47:36 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id y11so14597576otq.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=3llYK6EyDFfA8kZNSs7OOJWlhZ6s/Qb8HKdqwTedgO8=;
 b=ESFfJiaCFL4eY4q4WvyNRsh85mck1lW9jTsqET8Sww67i70I3ikh0tET7wS72CAelm
 wflntjM+If6R9YjZ9kKO1hFBjTpcvlpt2LVHiOxwQOg+uSedpp+JneKk87dtR2yk2sca
 KoKVvKqmUrsYlyZ8Q5dcwZVMMd6U6hv6xEvIAFq+aY/lQCUXL1vepaZIR9tsKIa1xEvI
 IyJIPTD0CnjcBWUOjDYMZdbjeiWRBSWpsGHQtcTrVjB215kYrl8BNZ/vqQycG+EgGm8u
 uHaGpzyll1gfnRH2i6iPU7tdQg59cjlcEK5IxiUPmJsl/jfd1FhhxMuYA8fkwVG5xoks
 nwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3llYK6EyDFfA8kZNSs7OOJWlhZ6s/Qb8HKdqwTedgO8=;
 b=C/NEcvxiLQfdJibG5TWswNc36Fvfw9VidDg00msxU/K9bkcbgF+0flLnSb4sK4MmUt
 EXF8JbnH2UNnKt7eIR5nIaW5cFzZ8bDY+7N11w2ZsUISUme70nQm2g+YfJjIHidtnTeK
 m0Kxdfz8YGXgSe95XC958TxmwmDwqtsHczWdT0kaz7Iy596aNiPfsjfLG/EYgodBCpab
 UWg2nJFE7HWiDbn9pyemEYOpsa+xe/s0JLjbQXeiFm/0GDRrUQ43kgf7uhc/IDhaJTm5
 x28ftQuxtEta12hR/kzrkwn3A0PpE03NXJPiKhzDaf1x0ov2wMUTppnhHzPtY9tmQR3+
 XhuA==
X-Gm-Message-State: AOAM532gGmX36ZsJIvHKmmg9PuLa7aFycnIDRjyQbbZNg4PSgs5ts10o
 VJP66Avc8a9gXBl/XeFiqXw=
X-Google-Smtp-Source: ABdhPJy2GUhGzsWbeFPXb0qDuygljGJyPkEu5FAA1xJ95adlTJe/TOS9MSdXg50puyxW9sEzjdlLkQ==
X-Received: by 2002:a05:6830:4b1:: with SMTP id
 l17mr12544140otd.119.1612799255732; 
 Mon, 08 Feb 2021 07:47:35 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.33])
 by smtp.googlemail.com with ESMTPSA id j68sm3712233otc.6.2021.02.08.07.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 07:47:34 -0800 (PST)
Subject: Re: [PATCH iproute2-next v4 1/5] Add kernel headers
To: Parav Pandit <parav@nvidia.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 stephen@networkplumber.org, mst@redhat.com, jasowang@redhat.com
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210205181029.365461-1-parav@nvidia.com>
 <20210205181029.365461-2-parav@nvidia.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <e3aaccc1-4a73-9438-2b76-e73cefc3383f@gmail.com>
Date: Mon, 8 Feb 2021 08:47:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205181029.365461-2-parav@nvidia.com>
Content-Language: en-US
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

On 2/5/21 11:10 AM, Parav Pandit wrote:
> diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
> new file mode 100644
> index 00000000..66a41e4e
> --- /dev/null
> +++ b/vdpa/include/uapi/linux/vdpa.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * vdpa device management interface
> + * Copyright (c) 2020 Mellanox Technologies Ltd. All rights reserved.
> + */
> +
> +#ifndef _UAPI_LINUX_VDPA_H_
> +#define _UAPI_LINUX_VDPA_H_
> +

you should grab this header after a 'make headers_install' which cleans
up the _UAPI prefix.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
