Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD1FC433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 02:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52AC141748;
	Wed, 13 Apr 2022 02:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Savt5xLrv3L; Wed, 13 Apr 2022 02:54:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C0656409F5;
	Wed, 13 Apr 2022 02:54:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83FA2C0033;
	Wed, 13 Apr 2022 02:54:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50D03C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 02:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DBD28138E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 02:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V85JDCJuoL0o
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 02:53:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6758F8138D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 02:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649818438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aypMv+ZPgdsPLn658L1nF7+IyBlpmCG4qqxgdXjWqDg=;
 b=Zjgb7V64raset1JteXXgw72x6fWXGwXsk9G0VO8hLWd8OpHNWN2HjpfOov09eJ+iV+4RS6
 UszvSEQFzKOWj3iR5Tk5RUY7MqxDb76MbkZq4f+RPDUwC9GB8v/akpuERDw8eJdeDVc5SH
 DnPH7u6km0RUDIQ5O/RoIzDRxedkzvY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-vs4EzScOO8ywqvDchK8nYQ-1; Tue, 12 Apr 2022 22:53:56 -0400
X-MC-Unique: vs4EzScOO8ywqvDchK8nYQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 w25-20020a05651234d900b0044023ac3f64so321273lfr.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 19:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aypMv+ZPgdsPLn658L1nF7+IyBlpmCG4qqxgdXjWqDg=;
 b=CQjVRMv3CJl4OsIdGXW0Vj4dO3fe/BESYwpEWgcJzoz8MpBc0XvkIlpB84K+x3iJvq
 QHAfJicgh0vqqMD8CVGFqxJ+LC7NYza7eAv87v1G6wSzay+nQZaKqJqtbJwS2FCUH1Oz
 Icm3AR1U9W8mPdcI8yM+fERSSf7Kgwr+iPljBge1hJKMDbYqvQ2KJ8m0Rg8lOENd+jUP
 nTCQPO+CKulevDVLWBfTt8JLn/Kf8/8jR94xY+U9HCWKm+2ZxGDFCT++5KV0tVQead+P
 oa9P/9LjxbbcLYjNWyPcqy+kyKiSnyg76VWAuxya658OLSTmBxWxr5nIqJzHq2KWpn63
 NrMw==
X-Gm-Message-State: AOAM531delN+TWq9MAUBggUdMbUwSIXJkIAppq9psyzsvuLLXy9QgbgA
 wJxQv77OLf4poqGoEA/ClgVdH0qalOvG+L0dD5ylp2kf7wfBm3cmsul+9X8cznE7+9DgZf9rRFg
 ppUPklEauFbyIIaNjRKNSTBP+Hig5T9izGPmy06Rl9DlaAlDYv7h4S/kw/A==
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr27125051lfh.471.1649818435296; 
 Tue, 12 Apr 2022 19:53:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3EpYX8EMZCFcND8kfaSkNRCake24Uu+62MAReL2MCHl6d5nFXjeR2zS/5extqCEfll6a/nkHj7E7qob8q+wQ=
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr27125029lfh.471.1649818435001; Tue, 12
 Apr 2022 19:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
 <877d7vbspu.fsf@redhat.com> <20220412020145.32e26e5a.pasic@linux.ibm.com>
 <87r1629rio.fsf@redhat.com>
In-Reply-To: <87r1629rio.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Apr 2022 10:53:43 +0800
Message-ID: <CACGkMEuUXAUK-8GnBWgij5TOSN0ct_gmxnDQEcovRmTLK6bv4w@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Apr 13, 2022 at 12:49 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Tue, Apr 12 2022, Halil Pasic <pasic@linux.ibm.com> wrote:
>
> > On Mon, 11 Apr 2022 16:27:41 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
>
> >> My main concern is that we would need to synchronize against a single
> >> interrupt that covers all kinds of I/O interrupts, not just a single
> >> device...
> >>
> >
> > Could we synchronize on struct airq_info's lock member? If we were
> > to grab all of these that might be involved...
>
> Hm, that could possibly narrow the sync down to a subset, which seems
> better. For devices still using classic interrupts, per-device sync
> would be easy.
>
> >
> > AFAIU for the synchronize implementation we need a lock or a set of locks
> > that contain all the possible vring_interrupt() calls with the queuues
> > that belong to the given device as a critical section. That way, one
> > has the acquire's and release's in place so that the vrign_interrupt()
> > either guaranteed to finish before the change of driver_ready is
> > guaranteed to be complete, or it is guaranteed to see the change.
> >
> > In any case, I guess we should first get clear on the first part. I.e.
> > when do we want to allow host->guest notifications.
>
> Also, whether we just care about vring interrupts, or general device
> interrupts (not sure if a config change interrupt may also trigger
> things we do not want to trigger?)

I think only vring interrupts, since the config interrupt hardening is
done via 22b7050a024d7 ("virtio: defer config changed notifications")

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
