Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEACC6FA86
	for <virtualization@archiver.kernel.org>; Mon,  5 Sep 2022 07:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D59BF81388;
	Mon,  5 Sep 2022 07:49:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D59BF81388
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMbzmB5r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id llKR3yPeMbFt; Mon,  5 Sep 2022 07:49:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 781BA8135C;
	Mon,  5 Sep 2022 07:49:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 781BA8135C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5896FC0032;
	Mon,  5 Sep 2022 07:49:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FD71C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 07:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15D3860B9A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 07:49:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15D3860B9A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMbzmB5r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bwYZK_OlYyan
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 07:49:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EF5F600C4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EF5F600C4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662364187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SMj8mXrJ0Q/Mmrlyt4DK6FLz8HLyNr19Sl/fz3gGSnk=;
 b=aMbzmB5r778G6ejio2iLhMXGiAFDEX6GRtKtXzvvVlzf+hphKQSRfIQuhVhDs/E99dbZ2+
 y+dVpJLre4/eS8mkGVbGkSZprG8m9dfj/3iO2xjI2QtxV1Og89KJahxMXXa6BhrSuwRbWZ
 k61XrL7/uZd1Z+7zvdVrdJ3+BiRCz1M=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-261-geToMK-rN9qZsmJmL0GRdA-1; Mon, 05 Sep 2022 03:49:44 -0400
X-MC-Unique: geToMK-rN9qZsmJmL0GRdA-1
Received: by mail-ua1-f71.google.com with SMTP id
 k48-20020ab01633000000b003af70af1b2aso15834uae.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Sep 2022 00:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=SMj8mXrJ0Q/Mmrlyt4DK6FLz8HLyNr19Sl/fz3gGSnk=;
 b=eVtLKAo10zFDMnND8FeIkUel5oqCgm1+4IB2kJlu0pwozABK9yTAyr8u/r7674iC+/
 gOHtTaZ12557ij7UW5gEphM9MH++iqlq1OXR0g8UzVlwvGw8bXFe15bjMkCD1qfpZjWU
 6LCU1d5sTE1djnjfqylQeG1xdYmz8bMLUwjJ6bw94LTcC/VAR6DBQlFKow4alYI1KQfQ
 uCAima+fTiejQzfh+APTfMwt9tClIsVwBzhWl2EIFSnkvFUGvYEsfy8gQyIuoDZKAUi/
 5E3zanRe99gV2ZuFPAaZ0x78fiDPNG3+bdluFG5reMFXlu+sYkPPS2JbtV+cn9POf93A
 CGSg==
X-Gm-Message-State: ACgBeo39gWDRTTSzInQ8BvPwZde0SWVitEiM/L4+61AKvltAm3i/0x7e
 cs2OpGiUfHXvBSmxSzePOaOuCa2bG8AIpE2NCUrPqp+zeWKmdCIzoExZwsjLljcW4Qd3E/ZqLY3
 GNfyy0WIOCZuxHUALr2V7pcxmfL+8lnmFr9V56p8BUzTblxKCroQlZqovhQ==
X-Received: by 2002:ab0:1473:0:b0:396:d89d:3a87 with SMTP id
 c48-20020ab01473000000b00396d89d3a87mr14112636uae.73.1662364183860; 
 Mon, 05 Sep 2022 00:49:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ri0CX6EFp7VbOu8dXi4Lj61EowOLZEkc0m0LHhlVZdChmPQxGb8nAeVrQg+nUqe/tT1QyJocHziPlwgCF6Xg=
X-Received: by 2002:ab0:1473:0:b0:396:d89d:3a87 with SMTP id
 c48-20020ab01473000000b00396d89d3a87mr14112626uae.73.1662364183662; Mon, 05
 Sep 2022 00:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220905031405-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Sep 2022 15:49:32 +0800
Message-ID: <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command waiting
 loop
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
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

On Mon, Sep 5, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> > Adding cond_resched() to the command waiting loop for a better
> > co-operation with the scheduler. This allows to give CPU a breath to
> > run other task(workqueue) instead of busy looping when preemption is
> > not allowed.
> >
> > What's more important. This is a must for some vDPA parent to work
> > since control virtqueue is emulated via a workqueue for those parents.
> >
> > Fixes: bda324fd037a ("vdpasim: control virtqueue support")
>
> That's a weird commit to fix. so it fixes the simulator?

Yes, since the simulator is using a workqueue to handle control virtueue.

>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index ece00b84e3a7..169368365d6a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2000,8 +2000,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> >        * into the hypervisor, so the request should be handled immediately.
> >        */
> >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -            !virtqueue_is_broken(vi->cvq))
> > +            !virtqueue_is_broken(vi->cvq)) {
> > +             cond_resched();
> >               cpu_relax();
> > +     }
>
> with cond_resched do we still need cpu_relax?

I think so, it's possible that cond_sched() just doesn't trigger scheduling.

Thanks

>
> >       return vi->ctrl->status == VIRTIO_NET_OK;
> >  }
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
