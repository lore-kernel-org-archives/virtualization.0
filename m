Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC17CC47082
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 21:22:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBE66128B
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 21:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBE66128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FEE2606BB;
	Wed, 26 May 2021 21:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kevGQpnRdYCZ; Wed, 26 May 2021 21:22:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id C23BF60590;
	Wed, 26 May 2021 21:22:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95E9DC000D;
	Wed, 26 May 2021 21:22:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F89AC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 21:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51C6040591
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 21:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qcqrAY1ji6jj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 21:22:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 546ED4057B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 21:22:50 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id h16so3229280edr.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7bWUzz3mXf4ng9N21e9bEjKKU0Rq54acZv1GkQ/xcY0=;
 b=QfikG8wrkmC0m3tXTYmZxodBn7Xg0IuuRN5Yz3uWBPt5XyG519/kEF/cjtKsVu/DFb
 742PzlhLYjmMM/bR+ePUG+ZTOFghKJ6xJ0RwXste9wLuIVJwVI3mhrv/z8q8e3sjkBji
 rJV76aXN2p6COObuBp/p54lbINi2h51pKqhPZBRdDMMFtSP1GKYMgwWFuyVBMaAFdt4c
 5wZpGepxAhDtKDr2DvOanz0U9WZ47xdlGyxAbvOlmY43TzDCEcl8CaGYf4DU32f54T4h
 l6vEZbyLAkOqiAu2AmXR/oaQ5x7lbtCuNFF0sZ9e8xvMHo5lmvUiDOumNNLZor0DU78J
 SfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7bWUzz3mXf4ng9N21e9bEjKKU0Rq54acZv1GkQ/xcY0=;
 b=NX8OFWcCxTiIqe1lEI0Ko1bfrSL4XoUsU9Rhyx9VMhCwydqayP6BLmMgcg77ykL5Kq
 msVt7qvhwMhV+9S/HqgF2ZZlvs6eHmwZBSyMfhC/irmEkhBVxXF0D4Ia61M4YcCjywjH
 rytg3rcPeNPyy2YepCKE7D5fnfGq8AbOYRMcGfsJc9Jt/u1L70JBIIO48hD5Epr6hTRt
 VES/oWxQsjyo36x2dJJXN5b84jgUF8dmU4FRMiH5Xu3E8aDtC8CTnZXlVBbjKqAQwO4P
 aJAySkqh+1Ql14BbjrX7JjBx4UIV6lrpgOardQSb7gOE7xw+wHa/zYTIVnBgIXmkwWoA
 zy2g==
X-Gm-Message-State: AOAM530COgQbfqe+/kupRlie7bJkfKWYuPiHxZeYQtR2T2j5hhyuVtpS
 akX9ppnWnz0TE9e8bo7KCYSDTwlZ051WOw==
X-Google-Smtp-Source: ABdhPJywlO+h/Teoi8dNM5dEDNs+BelyMVU10Lf4WHQjbun441tosZL72DpoJ1DcnJlNxXGiml3g1Q==
X-Received: by 2002:a05:6402:2686:: with SMTP id
 w6mr252424edd.80.1622064167973; 
 Wed, 26 May 2021 14:22:47 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53])
 by smtp.gmail.com with ESMTPSA id y9sm39399edc.46.2021.05.26.14.22.46
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 14:22:47 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id t206so1540069wmf.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 14:22:46 -0700 (PDT)
X-Received: by 2002:a05:600c:2209:: with SMTP id
 z9mr337264wml.120.1622064166487; 
 Wed, 26 May 2021 14:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-5-mst@redhat.com>
 <18b47c22-8c8a-7699-ffaf-ccfdcbf39d37@gmail.com>
In-Reply-To: <18b47c22-8c8a-7699-ffaf-ccfdcbf39d37@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 26 May 2021 17:22:08 -0400
X-Gmail-Original-Message-ID: <CA+FuTSetvnwCzyuFkypkXgYycsMe1B3brW93upmg+KjGsgD-gA@mail.gmail.com>
Message-ID: <CA+FuTSetvnwCzyuFkypkXgYycsMe1B3brW93upmg+KjGsgD-gA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] virtio_net: disable cb aggressively
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
 David Miller <davem@davemloft.net>
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

On Wed, May 26, 2021 at 11:15 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 5/26/21 10:24 AM, Michael S. Tsirkin wrote:
> > There are currently two cases where we poll TX vq not in response to a
> > callback: start xmit and rx napi.  We currently do this with callbacks
> > enabled which can cause extra interrupts from the card.  Used not to be
> > a big issue as we run with interrupts disabled but that is no longer the
> > case, and in some cases the rate of spurious interrupts is so high
> > linux detects this and actually kills the interrupt.

Temporarily disabling interrupts during free_old_xmit_skbs in
virtnet_poll_cleantx might reduce the spurious interrupt rate by
avoiding an additional Tx interrupt from being scheduled during
virtnet_poll_cleantx.

It probably does not address all spurious interrupts, as
virtnet_poll_cleantx might also run in between the scheduling of the
Tx interrupt and the call to virtnet_poll_tx, right? The Tx and Rx
interrupts racing.

If I can reproduce the report, I can also test how much this helps in practice.

> > Fix up by disabling the callbacks before polling the tx vq.
>
>
> It is not clear why we want to poll TX completions from ndo_start_xmit() in napi mode ?

Yes, we can simply exclude that. The original napi-tx patch did not
make that change, but not for any strong reason.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
