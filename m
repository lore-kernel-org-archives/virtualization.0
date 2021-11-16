Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD8C433F5
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 05:01:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CE161BF5
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 05:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33CE161BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D561F401BA;
	Tue, 16 Nov 2021 05:01:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8xpevbG8sUd; Tue, 16 Nov 2021 05:01:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2560E40100;
	Tue, 16 Nov 2021 05:01:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E26C1C001E;
	Tue, 16 Nov 2021 05:01:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFC86C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 05:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DE0D607C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 05:01:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B9ru5w_r0Apc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 05:01:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEC5A60775
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 05:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637038864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NZbJVFSsiYxk6JEYO0Xpu55G92qAXMwmH+tm+8XpReU=;
 b=AxtLH/8vHIUJ3uoKaIj3dRD5pDN39ed/qKFYiIYwBVAb3cUlr4n8NreW15bHlprCVzZHuU
 CljWU1dPEkKsUSVmS/DxwZVIAsJXXETChTwCMlHmY7DUhMce5bMEUmaX7Qc6tKt1BJcTh9
 Sju7aCV3M/1JLuBnh/rnWbAfJa/jZ2c=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-EU_LTA7VMKuzgvX3iapFHQ-1; Tue, 16 Nov 2021 00:01:02 -0500
X-MC-Unique: EU_LTA7VMKuzgvX3iapFHQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 x7-20020a056512130700b003fd1a7424a8so7716997lfu.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 21:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NZbJVFSsiYxk6JEYO0Xpu55G92qAXMwmH+tm+8XpReU=;
 b=SguQMdPr3+QanGjztFyiOMxOvY/9FBm/lt3L6yv2BljYYIEooOBV82meEfKeMMhdr6
 0fvrQKNfcr6kU2Ff7ZHj3IgnTA5TdltCrqCtyItSlyWQ4oKO7VMA4jGYsFxQjSEoOu7M
 oEU5ls4PhXxuu7s+w+KF/rx4JjIzAhIkICus527al/uaDPwGeikal/DvTFlI3yd4rD93
 Yxjwg1qLPwfCsVqcNA7HT7KbYzWv+IhS69dkQZPpsleh+18Ly6zxePfSz4lSsDZKUM+5
 aE8hTlQ9smksHk7ofqehn8qvh6cD85f9tIv2B8GcmcII4wUZlq1Xp2cwoXIEjaeZapJa
 /4/Q==
X-Gm-Message-State: AOAM531xIwdG6JDp5bLj7Rmncqkp6nyAYDeF45OVXr2uUfMgiqGqhuXN
 POXDOya8/HkF3Md1tv9mX9CiOUgwrFuksAuWD8iNOuZ//t7ae5DEYbrKC9mMEL7Cck1YePPUy5w
 MJBq9/DHsujQaVxvyb8yzBFg1aLkVKrkNVirufgQGsh4I2pZll+LVCxzOlg==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr3980753lfi.498.1637038861041; 
 Mon, 15 Nov 2021 21:01:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmwi8ZBJDwkdhthf+6U7z0+K409Zl2U1G1z4cKoLh4WJGn9JeAOqnszcmQh+p5V5nQXwNj+ySZvlSCNDXcV2U=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr3980732lfi.498.1637038860836; 
 Mon, 15 Nov 2021 21:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20211115153003.9140-1-arbn@yandex-team.com>
 <20211115153003.9140-6-arbn@yandex-team.com>
In-Reply-To: <20211115153003.9140-6-arbn@yandex-team.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Nov 2021 13:00:50 +0800
Message-ID: <CACGkMEumax9RFVNgWLv5GyoeQAmwo-UgAq=DrUd4yLxPAUUqBw@mail.gmail.com>
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

On Mon, Nov 15, 2021 at 11:32 PM Andrey Ryabinin <arbn@yandex-team.com> wrote:
>
> Currently vhost_net_release() uses synchronize_rcu() to synchronize
> freeing with vhost_zerocopy_callback(). However synchronize_rcu()
> is quite costly operation. It take more than 10 seconds
> to shutdown qemu launched with couple net devices like this:
>         -netdev tap,id=tap0,..,vhost=on,queues=80
> because we end up calling synchronize_rcu() netdev_count*queues times.
>
> Free vhost net structures in rcu callback instead of using
> synchronize_rcu() to fix the problem.

I admit the release code is somehow hard to understand. But I wonder
if the following case can still happen with this:

CPU 0 (vhost_dev_cleanup)   CPU1
(vhost_net_zerocopy_callback()->vhost_work_queue())
                                                if (!dev->worker)
dev->worker = NULL

wake_up_process(dev->worker)

If this is true. It seems the fix is to move RCU synchronization stuff
in vhost_net_ubuf_put_and_wait()?

Thanks

>
> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
> ---
>  drivers/vhost/net.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 97a209d6a527..0699d30e83d5 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -132,6 +132,7 @@ struct vhost_net {
>         struct vhost_dev dev;
>         struct vhost_net_virtqueue vqs[VHOST_NET_VQ_MAX];
>         struct vhost_poll poll[VHOST_NET_VQ_MAX];
> +       struct rcu_head rcu;
>         /* Number of TX recently submitted.
>          * Protected by tx vq lock. */
>         unsigned tx_packets;
> @@ -1389,6 +1390,18 @@ static void vhost_net_flush(struct vhost_net *n)
>         }
>  }
>
> +static void vhost_net_free(struct rcu_head *rcu_head)
> +{
> +       struct vhost_net *n = container_of(rcu_head, struct vhost_net, rcu);
> +
> +       kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
> +       kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
> +       kfree(n->dev.vqs);
> +       if (n->page_frag.page)
> +               __page_frag_cache_drain(n->page_frag.page, n->refcnt_bias);
> +       kvfree(n);
> +}
> +
>  static int vhost_net_release(struct inode *inode, struct file *f)
>  {
>         struct vhost_net *n = f->private_data;
> @@ -1404,15 +1417,8 @@ static int vhost_net_release(struct inode *inode, struct file *f)
>                 sockfd_put(tx_sock);
>         if (rx_sock)
>                 sockfd_put(rx_sock);
> -       /* Make sure no callbacks are outstanding */
> -       synchronize_rcu();
>
> -       kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
> -       kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
> -       kfree(n->dev.vqs);
> -       if (n->page_frag.page)
> -               __page_frag_cache_drain(n->page_frag.page, n->refcnt_bias);
> -       kvfree(n);
> +       call_rcu(&n->rcu, vhost_net_free);
>         return 0;
>  }
>
> --
> 2.32.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
