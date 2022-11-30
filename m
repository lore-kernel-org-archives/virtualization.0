Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C0EC47089
	for <virtualization@archiver.kernel.org>; Wed, 30 Nov 2022 21:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8FEB81497;
	Wed, 30 Nov 2022 21:24:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8FEB81497
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=qPJmcAzG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FfmVcyZn7THA; Wed, 30 Nov 2022 21:24:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 936D781422;
	Wed, 30 Nov 2022 21:24:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 936D781422
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A2FBC0033;
	Wed, 30 Nov 2022 21:24:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35457C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 21:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01F6E403E5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 21:24:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01F6E403E5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
 header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=qPJmcAzG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Smur26PjK1Ha
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 21:24:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BAEE2400F2
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BAEE2400F2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 21:24:06 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id a9so1914112pld.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 13:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6Lsc5JX1EsfCIVKdUidgufDfSH65QaOowzu3Qg9HsI=;
 b=qPJmcAzGa/f0joAwMeKTF+3HlX8XsIqSiVl3cTzCtxtsmtSe8KH8Va1t6zVvf/Xf/5
 Vnr3i4Sl6hbirRT+fpyt32KCzapXpCDQ7MqiJli7N/RA8YNRWnmi+QbwS46hHmHbnrE/
 LoNrxldZDJexQEPQzOExL9eP7V4b6uuQNtvnhlSNj5yFQkY0KgwXghCnCc9OK9eJIZSF
 JkYC5TqiDFyNirVR/VzKXpJ/W5fQEMrGIKW1r6FpMOtDQO+n62HsEwJ00S7DbeWR7nkF
 MfxYyjSLNvtLYyg/mm8Llomq4Qb+M2aoTYCUmelDImwt+Fj6wdvagx0VADg4TvGAdujx
 8FXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6Lsc5JX1EsfCIVKdUidgufDfSH65QaOowzu3Qg9HsI=;
 b=b8fe7mPI7hmjwWLpW6ZYW1VkT6QuzaJX4dDOkrwk52mZrApZg96wlzK7VHhwDVm6tG
 GSnkjb5jOwzImc7UmCnAALAL8Fbdw0NwetB3T/tDeNT9rf0qcPeuPhTsO0QdB794msh4
 ZJONzblDsY/P0ChCgLDKMK9zjmdgK14K4veKksknfYDJJnuR60rUGgcWc7OKtXYfdDz/
 gh05VlEcmG7h1MM5lpXFVoLCzSRkhMkVtzc+NdWiCBalUwH2ZcZXSMUvUBIybn6xojiz
 EZ75GQIqM4gDeBID/bGV++8VdCBYwL22jl2wNS6in1PPgYDOe0as0sjPONuVtULjslHh
 dmHg==
X-Gm-Message-State: ANoB5plJw3wf/6lj5voZn6mIklT7leZYlvQlBhdNCcdUCr9q4jXRhvLQ
 IB1K8u6c3V6S5jG3Mf2IHhYNdQ==
X-Google-Smtp-Source: AA0mqf5HDMBEtQPCd1mTu/rQ28XjuK7ZuwBNgSuDgb7a8vXqx5pSTF7cDW9Qxo9dvSBps67LvmfAXQ==
X-Received: by 2002:a17:902:ab89:b0:185:3659:1ce9 with SMTP id
 f9-20020a170902ab8900b0018536591ce9mr42143363plr.26.1669843445775; 
 Wed, 30 Nov 2022 13:24:05 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:400::5:ace1])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a17090311cf00b00176b63535adsm1946942plh.260.2022.11.30.13.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Nov 2022 13:24:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: pbonzini@redhat.com, Pankaj Raghav <p.raghav@samsung.com>,
 stefanha@redhat.com
In-Reply-To: <20221130123001.25473-1-p.raghav@samsung.com>
References: =?utf-8?q?=3CCGME20221130123126eucas1p2cd3287ee4e5c03642f1847c50?=
 =?utf-8?q?af0e4f2=40eucas1p2=2Esamsung=2Ecom=3E?=
 <20221130123001.25473-1-p.raghav@samsung.com>
Subject: Re: [PATCH] virtio-blk: replace ida_simple[get|remove] with
 ida_[alloc_range|free]
Message-Id: <166984344282.477505.2826968238507327804.b4-ty@kernel.dk>
Date: Wed, 30 Nov 2022 14:24:02 -0700
MIME-Version: 1.0
X-Mailer: b4 0.11.0-dev-d377f
Cc: Pankaj Raghav <pankydev8@gmail.com>, mst@redhat.com, gost.dev@samsung.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
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

On Wed, 30 Nov 2022 13:30:03 +0100, Pankaj Raghav wrote:
> ida_simple[get|remove] are deprecated, and are just wrappers to
> ida_[alloc_range|free]. Replace ida_simple[get|remove] with their
> corresponding counterparts.
> 
> No functional changes.
> 
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: replace ida_simple[get|remove] with ida_[alloc_range|free]
      commit: 92a34c461719eb4a3f95353bb7b27a3238eb7478

Best regards,
-- 
Jens Axboe


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
