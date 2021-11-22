Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB94C433F5
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 09:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A8E380F32;
	Mon, 22 Nov 2021 09:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTa62KFfmD3w; Mon, 22 Nov 2021 09:38:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 464B480D63;
	Mon, 22 Nov 2021 09:38:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 172E6C001E;
	Mon, 22 Nov 2021 09:38:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F985C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 004B480F29
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XqCokfkX-FDN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:37:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51CCB80D63
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637573875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bIlk+ihBReA4luef3l9FK2apG4r8ckQxVs4q15V5P4E=;
 b=CcV7+I1m6xqKJ9s5WTAW8rREz0dalTWbqrrDlN7w8ZlsU+v/FRkI8Iglj6jVeec1iuSQV6
 0JuEXCVEjHBUYHVeCND3vIzoTBMAVxbwq0Xxd9lHeIglA3tcKt4UfoAhskrSQpqD4cG9s0
 F+1FZ+gG0aemjg09Ps36Fmse9BlFy4M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-432-UkQ864IKM9WPoV-q-g3qmQ-1; Mon, 22 Nov 2021 04:37:54 -0500
X-MC-Unique: UkQ864IKM9WPoV-q-g3qmQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 bg20-20020a05600c3c9400b0033a9300b44bso3380644wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 01:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bIlk+ihBReA4luef3l9FK2apG4r8ckQxVs4q15V5P4E=;
 b=4Sz9iZ458MD7ARlDnOCth6rXrviIFkiy4n1sUgp6aG6g8bcuyzxQ3+Z+DFMclAfW0u
 32V2vh3+4PnhlAm5MHrJrPeqmJBM1/7Q32PfD5bggWJggWqLcKUv/6BwoFgHqE1z75a/
 NtPifR/HIOHI6WAENXaN2Sibj0jnPTkJzC3XZ0JIOJ/M6QrUqZk1JRZRMyOVLQzVfkD/
 sMUwQUeGKeLfE4GatF4qPzR7mRIM/8Ye8BCwzUHMroqF3NJ4mon4Fv5Kam3snVZAECeH
 IhF/Iiyv8XK6fA0AxvFPmQdCSyaCgNpEFZ2t18DCdBk8gKYkRLaz0qMgdH3SZVBvQLr8
 OdPQ==
X-Gm-Message-State: AOAM532Y4Akri3/MUMFMbuELrR0fefo7A6uYGiQJgwHx8NYjJaYlAT1V
 fwKmlgz+o1vpA5hwerVqKDgB43SWN+35y0Z1l/HJJPiVctyeF3W6b8aktC6LBD5qxg4oMPcAeIa
 oKi4SPHqUmVk/Vr8lth+zPjNtZiumwxeRDy3zIKS2Pw==
X-Received: by 2002:a5d:6dc3:: with SMTP id d3mr36126801wrz.159.1637573873433; 
 Mon, 22 Nov 2021 01:37:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxBO0fMZmz4vU5DDAWrAXgOEEtOabqFm5qkQuvtfLHepd8zMa6raRS+mZ6nm92m3RkPKn+JQ==
X-Received: by 2002:a5d:6dc3:: with SMTP id d3mr36126776wrz.159.1637573873232; 
 Mon, 22 Nov 2021 01:37:53 -0800 (PST)
Received: from redhat.com ([2.55.128.84])
 by smtp.gmail.com with ESMTPSA id j11sm8373660wrt.3.2021.11.22.01.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 01:37:52 -0800 (PST)
Date: Mon, 22 Nov 2021 04:37:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH 6/6] vhost_net: use RCU callbacks instead of
 synchronize_rcu()
Message-ID: <20211122043620-mutt-send-email-mst@kernel.org>
References: <20211115153003.9140-1-arbn@yandex-team.com>
 <20211115153003.9140-6-arbn@yandex-team.com>
 <CACGkMEumax9RFVNgWLv5GyoeQAmwo-UgAq=DrUd4yLxPAUUqBw@mail.gmail.com>
 <b163233f-090f-baaf-4460-37978cab4d55@yandex-team.com>
MIME-Version: 1.0
In-Reply-To: <b163233f-090f-baaf-4460-37978cab4d55@yandex-team.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
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

On Fri, Nov 19, 2021 at 02:32:05PM +0300, Andrey Ryabinin wrote:
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
> thread context or not. If it can run after vhost thread stopped, than the race you
> describe seems possible and the fix in commit b0c057ca7e83 ("vhost: fix a theoretical race in device cleanup")
> wasn't complete. I would fix it by calling synchronize_rcu() after vhost_net_flush()
> and before vhost_dev_cleanup().
> 
> As for the performance problem, it can be solved by replacing synchronize_rcu() with synchronize_rcu_expedited().

expedited causes a stop of IPIs though, so it's problematic to
do it upon a userspace syscall.

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
> This means that the callback can't run after kthread_stop() in vhost_dev_cleanup() and no synchronize_rcu() needed.
> 
> I'm not confident that my quite limited testing cover all possible vhost_zerocopy_callback() callstacks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
