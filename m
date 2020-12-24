Return-Path: <SRS0=rM6z=F4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F003C433DB
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 02:40:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA8922571
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 02:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA8922571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F98385792;
	Thu, 24 Dec 2020 02:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B69YvucBXemc; Thu, 24 Dec 2020 02:40:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2206985742;
	Thu, 24 Dec 2020 02:40:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 043C9C1787;
	Thu, 24 Dec 2020 02:40:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87BDEC0893
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6EEAD85775
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:40:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id exwsdvltuIK3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:39:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 06D1C85742
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:39:59 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id j22so1627123eja.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 18:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NjG06L3A2y7EyOAPA8qQEkMYP0fOIFXomd5VJhGvonw=;
 b=lbD06MwxnMTBKm9UFkUyMaagYzhQ04v/L3QpVGK1v5pFcVLlx5paigmmmNGxgXAtPQ
 LI6jvLtwaGR3BQFrgr/blcDNVCbqEip4x8Xi1NQXDLFPZHkeqTqb3o9O/3Bd1nL9qXxV
 Mq6z2RpsHwX+B/eA3m0he+uaX6CyPTXpVL1564accO79rZ9EjQk7728fznCwVbWZ8P6u
 hb2MNeO3f/O0iK9TdJxP4p5x7NiFGLBhMbunyHNGulN/ZD2KJIWzD+AjD5qRDqIbXnfr
 FKFKJuiI89NCu5somS7XlnSKf2Hoi124gMW0kaUJ6NdtTznaO7XqMhNWz7+dl5ia6fvA
 X6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NjG06L3A2y7EyOAPA8qQEkMYP0fOIFXomd5VJhGvonw=;
 b=HoqOFvXn2izmmr8kukDOq5MIAl8LGjsWpRUa5I/wicKBMhbY07e9xSvfwpaOTVl3dZ
 Nag9c9aZvV28I1W2YoeuMYoDg5I7UgDhEVdXEhoiZ983BufDN1TfoH+bbSTtCHF6i30t
 totG6BACEK6KHEevsr4pW8H/9V4e58TyWsZ532R4j8Iayw808Df0Yl9T/9lBU7zEzskb
 vMvfkpnvzUSRCMDmdIs3sVx2dl62OWkZLgT1qy0xculfyYSjw46ucBnHmvhcZ0WfG6/v
 SUGOFvf1L7egsqLoTBURQP1tly/rVO7pH56C+Ex1Z7Y8gFrUl6cjtdcODkQxQcG4ynH+
 m/nw==
X-Gm-Message-State: AOAM530ECVasT4n0WeD4gA7RPoSUgSuKUQiu1tTd7377w/HA1SXRTl+N
 rCcFUsOh654e1QkKNFF80l6cUMkxCKLGjoNZuUc=
X-Google-Smtp-Source: ABdhPJySF3Jr0hQHF20L2EcoroCWMiycgS8JXpi950PizcC7YnvQxEG+bFtjg+na3OtA/0t/ZiN4OnN6RrDgUpQNb+Y=
X-Received: by 2002:a17:906:8255:: with SMTP id
 f21mr26071925ejx.265.1608777597515; 
 Wed, 23 Dec 2020 18:39:57 -0800 (PST)
MIME-Version: 1.0
References: <1608776746-4040-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1608776746-4040-1-git-send-email-wangyunjian@huawei.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 23 Dec 2020 21:39:19 -0500
Message-ID: <CAF=yD-J88Pvo+jseUQviy1+uvtH+CwkOwirDyV1EjN=J_93xsw@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] vhost_net: fix tx queue stuck when sendmsg
 fails
To: wangyunjian <wangyunjian@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

On Wed, Dec 23, 2020 at 9:25 PM wangyunjian <wangyunjian@huawei.com> wrote:
>
> From: Yunjian Wang <wangyunjian@huawei.com>
>
> Currently the driver doesn't drop a packet which can't be sent by tun
> (e.g bad packet). In this case, the driver will always process the
> same packet lead to the tx queue stuck.
>
> To fix this issue:
> 1. in the case of persistent failure (e.g bad packet), the driver
> can skip this descriptor by ignoring the error.
> 2. in the case of transient failure (e.g -EAGAIN and -ENOMEM), the
> driver schedules the worker to try again.
>
> Fixes: 3a4d5c94e959 ("vhost_net: a kernel-level virtio server")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
