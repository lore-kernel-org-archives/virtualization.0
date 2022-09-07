Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E51ECAAD3
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 07:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16DC581757;
	Wed,  7 Sep 2022 07:07:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16DC581757
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e3D1tHrz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o7CPpIJwAlwO; Wed,  7 Sep 2022 07:07:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5F25D81756;
	Wed,  7 Sep 2022 07:07:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F25D81756
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD9EC0033;
	Wed,  7 Sep 2022 07:07:28 +0000 (UTC)
Received: from smtp4.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe79:d16b])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94996C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A65740246
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:07:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A65740246
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e3D1tHrz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dawrj-qP5aaV
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:07:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FFF040235
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FFF040235
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662534444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/+HSxg5tcrvz/CJsTFm78OgI3pQS+e1F1DHw+MtS9w=;
 b=e3D1tHrzogqMR04hatD+VWTJm8wJtzU3PjQGV9hQjF6DCfAXxSVWQFAW1Da7SeQAanlHm4
 7C3YpaA4GamqLWT0OFEWdGb8oozqnFqbh37sOi33CVx+WdCxNSWRBja/spy7+FmZi0BB5Y
 xKGaN0KqGHRxYBwoFbhe9LYWCHetiBg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-281-0aCd6NqENSaVP46LmgSNxA-1; Wed, 07 Sep 2022 03:07:23 -0400
X-MC-Unique: 0aCd6NqENSaVP46LmgSNxA-1
Received: by mail-wr1-f71.google.com with SMTP id
 v15-20020adf8b4f000000b002285ec61b3aso2744444wra.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 00:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date;
 bh=z/+HSxg5tcrvz/CJsTFm78OgI3pQS+e1F1DHw+MtS9w=;
 b=HRfZNm7GLIxv/73N2G163hgTk5dgg0o/IQzlq7FNrhFyDKUKXcHWas3bL56k5YStEY
 iSTjaZ9I0YLXZqEzevAcRVjDdjbfGP3PneOqbNjCxkKFB1eZMakEeS8J0asddi5PEAb+
 DPwQiqjfBF4mmBowDhl9hQoacRhz13gNJN6Xj1MM2bcKLD0KSNpNF+nwNmjcmDds6HQ7
 YmHm7Joz1DmagLp/lEiZJ8c3BXPffGjC44Mtz11OIAuUcyatFUYEpj9AQednPAt3rdwC
 EDQ53RSzHz6XXSlNlEZ2LiVl8LGyquALomhy4GLc6fvDww5qd6bvm+euK+1kbYy5Dxbq
 u+bw==
X-Gm-Message-State: ACgBeo1SfuNVF+Thy/b2LXLAWLngtLIAHZQR7edfgWxg6qUwnUt1AFQd
 A/dYX4D/9nkmnky2YuYolx9I03ElvRKeCRIuNNq/9JlZY7ph/baIR/mqdNXKmGYcD7ZxcfwYYnf
 8R8k5LD/qWP7IIi2ns34+NkKh3iCQKILS1hIQCpUY+g==
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id
 e14-20020a056000178e00b00220635feb13mr1090936wrg.634.1662534442058; 
 Wed, 07 Sep 2022 00:07:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR49NwluFNkfmL/l1sDW03NqaJvOQWjUhRUW2teBAjXK1WwZOvJMJQqIMKJkY8eq21o01mwfig==
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id
 e14-20020a056000178e00b00220635feb13mr1090919wrg.634.1662534441847; 
 Wed, 07 Sep 2022 00:07:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-72.dyn.eolo.it.
 [146.241.112.72]) by smtp.gmail.com with ESMTPSA id
 ay19-20020a05600c1e1300b003a50924f1c0sm18241872wmb.18.2022.09.07.00.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 00:07:21 -0700 (PDT)
Message-ID: <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Date: Wed, 07 Sep 2022 09:07:20 +0200
In-Reply-To: <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
 <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
 <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
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

On Wed, 2022-09-07 at 10:09 +0800, Jason Wang wrote:
> On Tue, Sep 6, 2022 at 6:56 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > 
> > On Mon, 2022-09-05 at 15:49 +0800, Jason Wang wrote:
> > > On Mon, Sep 5, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > 
> > > > On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> > > > > Adding cond_resched() to the command waiting loop for a better
> > > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > > run other task(workqueue) instead of busy looping when preemption is
> > > > > not allowed.
> > > > > 
> > > > > What's more important. This is a must for some vDPA parent to work
> > > > > since control virtqueue is emulated via a workqueue for those parents.
> > > > > 
> > > > > Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> > > > 
> > > > That's a weird commit to fix. so it fixes the simulator?
> > > 
> > > Yes, since the simulator is using a workqueue to handle control virtueue.
> > 
> > Uhmm... touching a driver for a simulator's sake looks a little weird.
> 
> Simulator is not the only one that is using a workqueue (but should be
> the first).
> 
> I can see  that the mlx5 vDPA driver is using a workqueue as well (see
> mlx5_vdpa_kick_vq()).
> 
> And in the case of VDUSE, it needs to wait for the response from the
> userspace, this means cond_resched() is probably a must for the case
> like UP.
> 
> > 
> > Additionally, if the bug is vdpasim, I think it's better to try to
> > solve it there, if possible.
> > 
> > Looking at vdpasim_net_work() and vdpasim_blk_work() it looks like
> > neither needs a process context, so perhaps you could rework it to run
> > the work_fn() directly from vdpasim_kick_vq(), at least for the control
> > virtqueue?
> 
> It's possible (but require some rework on the simulator core). But
> considering we have other similar use cases, it looks better to solve
> it in the virtio-net driver.

I see.

> Additionally, this may have better behaviour when using for the buggy
> hardware (e.g the control virtqueue takes too long to respond). We may
> consider switching to use interrupt/sleep in the future (but not
> suitable for -net).

Agreed. Possibly a timeout could be useful, too.

Cheers,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
