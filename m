Return-Path: <SRS0=Oc7+=FT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B100AC4361B
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 02:46:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5B1207A2
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 02:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5B1207A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A16FD86E44;
	Tue, 15 Dec 2020 02:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0cLWYtmijUZ9; Tue, 15 Dec 2020 02:46:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B9E6F86E04;
	Tue, 15 Dec 2020 02:46:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF48C0893;
	Tue, 15 Dec 2020 02:46:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 942E2C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 02:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 817A62041A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 02:46:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JS4QheU4qHFo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 02:46:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com
 [209.85.222.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 6CAFB20402
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 02:46:26 +0000 (UTC)
Received: by mail-ua1-f66.google.com with SMTP id w7so6202950uap.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 18:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JKDYfoD2YveWyRLE9FVGDqnZc519d7up4wSVOM0VYXg=;
 b=CQaYpmBp1+FbfgAFIpMsWhFEG6LO7xp6fdAXIlzWr0hQQz5Lw3US2gEfT7IHIj1ot4
 UJnQC7vHNHhfcR6z1bLLKlRjbnLuAKCOqWk0jYVdiXlagIX4hXjVhQMCcTRoGKX8r6eC
 NNtn6kVtCGPHWTQT+sb7ZyFXjNfvNoXyJorIZmxiak5w1Xg6bwLQbsIeJ991DIjHtWLV
 2mPs8VS9l3A6Z+vQeQyJdnF8kP43vWQB4R0/sFArpRDY/so4yX6iAjX2SnXLkhoNkT2l
 Xrkoasnv6EsYEFnHN59d9gq0cdw9WHQA/Q/SM+SqinXK5UGjbOGb1njBde02B37ZzPZ9
 g6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JKDYfoD2YveWyRLE9FVGDqnZc519d7up4wSVOM0VYXg=;
 b=ERFad/s5kaOEX2WFIdqbym/ycMLWLlyJHHWcP896CtYpJehSJ05riwCTvkcyOsdiKu
 zng+KtCyKK3AXQdDhK+Anbds5kqJbyyq0ZKca1+5Rs08dwmxZlICwuaDQN85poHh5/vO
 11AlMybsc5IGtE6SMNWmo/I1sJ1kG3shV+naYZvXQkXLpFOzqFGdZ++ePxxFhUL2L2AO
 hBvasxTJNjeQ0o1bf+TAzSUp9ZL90VaOE9OOqzpd5ik8OJ8Oa0JplzBKG39zvmBF9+W+
 ehKc9fpYzBsaCf7R7+EKcekcnBJFxd0Vfi4QlXlPU3TkLL7dsOgmMhjw/1F75xGW3vRa
 QZ2A==
X-Gm-Message-State: AOAM53036AigmB5n0Pe/DSJ3k4OKDE037NwTiJXCY0JNsAL+srHBdCoB
 phq/XvCHsM5+GUYTrSAOF1gISlqAivs=
X-Google-Smtp-Source: ABdhPJwMHXo4T17Jxm5NRXEh8vVtWS9L+RtbHZ9vcIBDFBMMgtL+Em9ghEnt9Z8DsYLfMqZBvcPUwg==
X-Received: by 2002:ab0:3806:: with SMTP id x6mr13809362uav.58.1608000384615; 
 Mon, 14 Dec 2020 18:46:24 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com.
 [209.85.221.174])
 by smtp.gmail.com with ESMTPSA id b16sm2671284vkp.2.2020.12.14.18.46.22
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Dec 2020 18:46:23 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id m67so2019173vkg.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 18:46:22 -0800 (PST)
X-Received: by 2002:a1f:1446:: with SMTP id 67mr11022573vku.24.1608000382303; 
 Mon, 14 Dec 2020 18:46:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608024547.git.wangyunjian@huawei.com>
 <5e2ecf3d0f07b864d307b9f0425b7b7fe8bf4d2c.1608024547.git.wangyunjian@huawei.com>
In-Reply-To: <5e2ecf3d0f07b864d307b9f0425b7b7fe8bf4d2c.1608024547.git.wangyunjian@huawei.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 14 Dec 2020 21:45:45 -0500
X-Gmail-Original-Message-ID: <CA+FuTSeH-+p_7i9UdEy0UL2y2EoprO4sE-BYNe2Vt8ThxaCLcA@mail.gmail.com>
Message-ID: <CA+FuTSeH-+p_7i9UdEy0UL2y2EoprO4sE-BYNe2Vt8ThxaCLcA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] vhost_net: fix ubuf refcount incorrectly when
 sendmsg fails
To: wangyunjian <wangyunjian@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 virtualization@lists.linux-foundation.org, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

On Mon, Dec 14, 2020 at 8:59 PM wangyunjian <wangyunjian@huawei.com> wrote:
>
> From: Yunjian Wang <wangyunjian@huawei.com>
>
> Currently the vhost_zerocopy_callback() maybe be called to decrease
> the refcount when sendmsg fails in tun. The error handling in vhost
> handle_tx_zerocopy() will try to decrease the same refcount again.
> This is wrong. To fix this issue, we only call vhost_net_ubuf_put()
> when vq->heads[nvq->desc].len == VHOST_DMA_IN_PROGRESS.
>
> Fixes: 4477138fa0ae ("tun: properly test for IFF_UP")
> Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Patch looks good to me. Thanks.

But I think the right Fixes tag would be

Fixes: 0690899b4d45 ("tun: experimental zero copy tx support")
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
