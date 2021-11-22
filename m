Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4527C433F5
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 02:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5960F40483;
	Mon, 22 Nov 2021 02:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0IUkKclBelVM; Mon, 22 Nov 2021 02:48:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E1E92403E7;
	Mon, 22 Nov 2021 02:48:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C338AC001E;
	Mon, 22 Nov 2021 02:48:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88808C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 02:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62A9040454
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 02:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CdkZbYU3iNeb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 02:48:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F2CC403E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 02:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637549329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bCpHgtK0TLoUoBYAl3rKsWf4v1EviHMP7QNyo8Nuefw=;
 b=eO+1y7hhModGV9J3rCIiD4km7JibIdbZZuGNesyTUYp9O2diAMjY9NNPWCPSJ9zjAtt/zq
 m69MjJaXNRamcy/qs+jqxc7OKpN2L4HvzGIQ3luNRJaURioCf1wjdcBwqNLj1/0+rUhVpa
 0LvMbtdTPZf/y4b17XXwn/Q6Po+AktQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-Ip7p2IUZP9uAh_nRWTb6cQ-1; Sun, 21 Nov 2021 21:48:48 -0500
X-MC-Unique: Ip7p2IUZP9uAh_nRWTb6cQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 c15-20020a05651200cf00b0040524451deeso10936486lfp.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 18:48:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bCpHgtK0TLoUoBYAl3rKsWf4v1EviHMP7QNyo8Nuefw=;
 b=ilik40fSPLOWNxFXGNzkY0dBi2ND310KTktjgkQ8VQ1BX7LMbX83FTzsIlCnuX1jtx
 nnCxZbQM3kY5M3pJCkhS1Vvfee1euoNP3FRWXwd8uK9cl9c35QOQC4ydj01ymsI1OYZV
 uLiTEOcBabxvRCPsR9ZTRElI4/i5I+jeLRATSGQUTHPs0A/TeKYSH0G1XT/9kAvx8gbf
 Rmd006hVcrkNGhmjDuH3XW/lEMweHd5dfWyETeQbz0lJ+l1mL+33r+ikptnOmMG/+bVK
 x8pAp2wHfNqaCpn6VEKZqCQgQod3iiK8AJG9BGkOptakGj7ybncunFO4ncWlXQGP+tn3
 Xihg==
X-Gm-Message-State: AOAM533Q3Ch5VsmFakenkFSAbdLqfZ0y1LjP/B+wsgeygoZZ0b0citU2
 NZM/ZHniIP8DIyZ8wppBacNt3uvZtSsEuymtFQwM1/P6oK9VcdQZP1VN3VC1bZUCkfYwPfLm25w
 jaJBF3tjzLM1ahi65j7yVy3jufleOA1nBlxxRPnTcNT2whsfElQ4T7wI8rg==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr47494888ljw.217.1637549326860; 
 Sun, 21 Nov 2021 18:48:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhMUoYJy/fa5HNf3Y1dZw9n8WaAFEGalW9iZHLhJvk00Yldk6U6avgseBmGbi5f8k7IKQdMCJIgKYGrl1mobY=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr47494851ljw.217.1637549326643; 
 Sun, 21 Nov 2021 18:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20211115153003.9140-1-arbn@yandex-team.com>
 <20211115153003.9140-6-arbn@yandex-team.com>
 <CACGkMEumax9RFVNgWLv5GyoeQAmwo-UgAq=DrUd4yLxPAUUqBw@mail.gmail.com>
 <b163233f-090f-baaf-4460-37978cab4d55@yandex-team.com>
In-Reply-To: <b163233f-090f-baaf-4460-37978cab4d55@yandex-team.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Nov 2021 10:48:35 +0800
Message-ID: <CACGkMEuNhRf8_nhAsJ68J4HFxGJcnjNyA8ZyktNcBhNGfSafmA@mail.gmail.com>
Subject: Re: [PATCH 6/6] vhost_net: use RCU callbacks instead of
 synchronize_rcu()
To: Andrey Ryabinin <arbn@yandex-team.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm <kvm@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Fri, Nov 19, 2021 at 7:31 PM Andrey Ryabinin <arbn@yandex-team.com> wrote:
>
>
>
> On 11/16/21 8:00 AM, Jason Wang wrote:
> > On Mon, Nov 15, 2021 at 11:32 PM Andrey Ryabinin <arbn@yandex-team.com> wrote:
> >>
> >> Currently vhost_net_release() uses synchronize_rcu() to synchronize
> >> freeing with vhost_zerocopy_callback(). However synchronize_rcu()
> >> is quite costly operation. It take more than 10 seconds
> >> to shutdown qemu launched with couple net devices like this:
> >>         -netdev tap,id=tap0,..,vhost=on,queues=80
> >> because we end up calling synchronize_rcu() netdev_count*queues times.
> >>
> >> Free vhost net structures in rcu callback instead of using
> >> synchronize_rcu() to fix the problem.
> >
> > I admit the release code is somehow hard to understand. But I wonder
> > if the following case can still happen with this:
> >
> > CPU 0 (vhost_dev_cleanup)   CPU1
> > (vhost_net_zerocopy_callback()->vhost_work_queue())
> >                                                 if (!dev->worker)
> > dev->worker = NULL
> >
> > wake_up_process(dev->worker)
> >
> > If this is true. It seems the fix is to move RCU synchronization stuff
> > in vhost_net_ubuf_put_and_wait()?
> >
>
> It all depends whether vhost_zerocopy_callback() can be called outside of vhost
> thread context or not.

I think the answer is yes, the callback will be mainly used in the
zerocopy path when the underlayer NIC finishes the DMA of a packet.

> If it can run after vhost thread stopped, than the race you
> describe seems possible and the fix in commit b0c057ca7e83 ("vhost: fix a theoretical race in device cleanup")
> wasn't complete. I would fix it by calling synchronize_rcu() after vhost_net_flush()
> and before vhost_dev_cleanup().
>
> As for the performance problem, it can be solved by replacing synchronize_rcu() with synchronize_rcu_expedited().

Yes, that's another way, but see below.

>
> But now I'm not sure that this race is actually exists and that synchronize_rcu() needed at all.
> I did a bit of testing and I only see callback being called from vhost thread:
>
> vhost-3724  3733 [002]  2701.768731: probe:vhost_zerocopy_callback: (ffffffff81af8c10)
>         ffffffff81af8c11 vhost_zerocopy_callback+0x1 ([kernel.kallsyms])
>         ffffffff81bb34f6 skb_copy_ubufs+0x256 ([kernel.kallsyms])
>         ffffffff81bce621 __netif_receive_skb_core.constprop.0+0xac1 ([kernel.kallsyms])
>         ffffffff81bd062d __netif_receive_skb_one_core+0x3d ([kernel.kallsyms])
>         ffffffff81bd0748 netif_receive_skb+0x38 ([kernel.kallsyms])
>         ffffffff819a2a1e tun_get_user+0xdce ([kernel.kallsyms])
>         ffffffff819a2cf4 tun_sendmsg+0xa4 ([kernel.kallsyms])
>         ffffffff81af9229 handle_tx_zerocopy+0x149 ([kernel.kallsyms])
>         ffffffff81afaf05 handle_tx+0xc5 ([kernel.kallsyms])
>         ffffffff81afce86 vhost_worker+0x76 ([kernel.kallsyms])
>         ffffffff811581e9 kthread+0x169 ([kernel.kallsyms])
>         ffffffff810018cf ret_from_fork+0x1f ([kernel.kallsyms])
>                        0 [unknown] ([unknown])
>

From the call trace you can send packets between two TAP. Since the TX
of TAP is synchronous so we can't see callback to be called out of
vhost thread.

In order to test it, we need 1) enable zerocopy
(experimental_zcopytx=1) and 2) sending the packet to the real NIC
with bridge or macvlan

Zerocopy was disalbed due to a lot of isuses (098eadce3c62 "vhost_net:
disable zerocopy by default"). So if we fix by moving it to
vhost_net_ubuf_put_and_wait(), there won't be a synchronize_rcu() in
the non-zerocopy path which seems to be sufficient. And we can use
synchronize_rcu_expedited() on top if it is really needed.

Thanks

> This means that the callback can't run after kthread_stop() in vhost_dev_cleanup() and no synchronize_rcu() needed.
>
> I'm not confident that my quite limited testing cover all possible vhost_zerocopy_callback() callstacks.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
