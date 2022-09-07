Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CCCECAAD5
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 02:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6D604048F;
	Wed,  7 Sep 2022 02:10:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6D604048F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIDHPwwu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id htv9Qiop7M_m; Wed,  7 Sep 2022 02:10:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1E151403C1;
	Wed,  7 Sep 2022 02:10:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E151403C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E86C5C0032;
	Wed,  7 Sep 2022 02:10:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAC0BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 02:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 906744048F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 02:10:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 906744048F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MGRgOwU8OHYN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 02:10:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28747403C1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28747403C1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662516605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vx8aKJ5u7qXrqUODw8TKz6yxmbl8ogDCyc6Iz97sTBo=;
 b=jIDHPwwuFWs9FlXC4CUBLt3zV4QENyBu5RVe1hW02HF+J1ajjiIUFwwGZ/PuqwbDfbZ0f0
 yaLX5GLEighLiauiajHVQPoHawd4MYf1ts95cVM0S0OVa+YGYoj0ve8MAo53fzUSUS9IQP
 t0BheVBf9QPD6ggIdhK4xRbZbIEB0G0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-slpG_TnVP3mCFnb3b-9-eg-1; Tue, 06 Sep 2022 22:10:03 -0400
X-MC-Unique: slpG_TnVP3mCFnb3b-9-eg-1
Received: by mail-ua1-f70.google.com with SMTP id
 g28-20020ab016dc000000b0039efee2e95aso2427062uaf.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 19:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=Vx8aKJ5u7qXrqUODw8TKz6yxmbl8ogDCyc6Iz97sTBo=;
 b=h2rKG6imuSegT9/kwLyf8q4M/zO913nvm0sgA1OcbBmPXrKUMbt199zvHrcFLB/Hpn
 3OAXLhJJAqR1NHNw0Lpc/zS1t05CEcYAol36dvnv6QlalQpWXfry9KNhXjqNMVe+EXRv
 CFS+J65p3YqvsG4HXaJiS8ZicJScRB5UGHVq/7qEM5w5CvxkhpeCrgGm5EUnbueQVKCd
 1njvSERPmkBOMlnhmiId4pS/lnCg8BYbAzho1jy4HWC0VlL28LyGIHLYMQBJj+T+aaLS
 /dpEqPXD6iCYYF+caIAG8v6kChfnp7O5IoIPU5VX/EUpvgOYdwlQsAw6fKnasp+FRP76
 f06w==
X-Gm-Message-State: ACgBeo2mYfPvJK2YkdQJYsh9RA+/2wIEcxue0lfid5tpKv4EDLZRFwpb
 6ohCQqcFxaBTGgbtAq5nBp0OKX7tV8+A3D36VvUxCAnkDVZa0Lgez7WiSAndqXiip/wmQc098pj
 kAdl/qbieEYrHZ1HgRQOmMay033X40BaPKrQErz50TmTnIahKrdkc4kbHyw==
X-Received: by 2002:a1f:ac83:0:b0:388:9d97:b5a9 with SMTP id
 v125-20020a1fac83000000b003889d97b5a9mr372675vke.22.1662516603346; 
 Tue, 06 Sep 2022 19:10:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6DWYAnQkaJlZ6pRhxUd2HGBY/TKQ5iRWCjE1i2eaVKcuP5Gfc+HkgyEEINqKrc6CvdYuEg6AAdXDtCql9/8Vk=
X-Received: by 2002:a1f:ac83:0:b0:388:9d97:b5a9 with SMTP id
 v125-20020a1fac83000000b003889d97b5a9mr372663vke.22.1662516603081; Tue, 06
 Sep 2022 19:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
 <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
In-Reply-To: <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Sep 2022 10:09:52 +0800
Message-ID: <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command waiting
 loop
To: Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Gautam Dawar <gautam.dawar@xilinx.com>, davem <davem@davemloft.net>
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

On Tue, Sep 6, 2022 at 6:56 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Mon, 2022-09-05 at 15:49 +0800, Jason Wang wrote:
> > On Mon, Sep 5, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> > > > Adding cond_resched() to the command waiting loop for a better
> > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > run other task(workqueue) instead of busy looping when preemption is
> > > > not allowed.
> > > >
> > > > What's more important. This is a must for some vDPA parent to work
> > > > since control virtqueue is emulated via a workqueue for those parents.
> > > >
> > > > Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> > >
> > > That's a weird commit to fix. so it fixes the simulator?
> >
> > Yes, since the simulator is using a workqueue to handle control virtueue.
>
> Uhmm... touching a driver for a simulator's sake looks a little weird.

Simulator is not the only one that is using a workqueue (but should be
the first).

I can see  that the mlx5 vDPA driver is using a workqueue as well (see
mlx5_vdpa_kick_vq()).

And in the case of VDUSE, it needs to wait for the response from the
userspace, this means cond_resched() is probably a must for the case
like UP.

>
> Additionally, if the bug is vdpasim, I think it's better to try to
> solve it there, if possible.
>
> Looking at vdpasim_net_work() and vdpasim_blk_work() it looks like
> neither needs a process context, so perhaps you could rework it to run
> the work_fn() directly from vdpasim_kick_vq(), at least for the control
> virtqueue?

It's possible (but require some rework on the simulator core). But
considering we have other similar use cases, it looks better to solve
it in the virtio-net driver.

Additionally, this may have better behaviour when using for the buggy
hardware (e.g the control virtqueue takes too long to respond). We may
consider switching to use interrupt/sleep in the future (but not
suitable for -net).

Thanks

>
> Thanks!
>
> Paolo
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
