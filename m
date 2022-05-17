Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F6CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 01:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 115FA40535;
	Tue, 17 May 2022 01:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q9iu8JHVc4gH; Tue, 17 May 2022 01:00:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 964EE405C0;
	Tue, 17 May 2022 01:00:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BD1DC0032;
	Tue, 17 May 2022 01:00:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60581C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 01:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55C8A405C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 01:00:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sNTuOB9VSVyV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 01:00:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9375E40535
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652749234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=378j+iYEEH5oqWnq5jjHkAR2MvwkVCfL/9+UoMi9JsE=;
 b=G6vD86Ku2xw9xiZgNRp1IjAjB1MZtBZlyOmkrOAFdrrAXKExmdGj0/lV7FL06uzd2AP7CF
 eizHFjetIr8+razIqKBl24ityif2l74Wtdt0TtmXyM/fFH2lQYZxiCLI2A8BxyOMhq1xM5
 OnzNb8tFsSzPVmfeoymX4oGcc5HIxA0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-bpjYue9XPFKSfTynTuHgYA-1; Mon, 16 May 2022 21:00:32 -0400
X-MC-Unique: bpjYue9XPFKSfTynTuHgYA-1
Received: by mail-lf1-f69.google.com with SMTP id
 a13-20020a19ca0d000000b0047233f64994so7160718lfg.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 18:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=378j+iYEEH5oqWnq5jjHkAR2MvwkVCfL/9+UoMi9JsE=;
 b=JvYKPMDd2clb0SXxH8OEvmWUshHKIY+alYmg14QBSsqwcSFCizCsNLzzk/3QHMXZXI
 OSLBqE1dfW5pDONOx7UigZl1/PJh431LZ5hKBrUbcJBi77P7n/oZBGgLHDMXccen+kHB
 S2QHhsQnl8s7zsyG1vf3smhpFR9NLUzrzHnMnMPIwTczVuwjbZ3Ero1SXEG9Nmd+HOPN
 6mBa1y8U/sBb/wHCpWOYSrerW2BuBXvw/caUQNgXqC1UNT0ddRvOJ3eV6wbe5LzbmQ5Q
 Idf6TwJ668V+mQ3LHPpmBBqtPptS/qSZii1kfQlpgW3O/Qw6qYuLQ+PHLDZypBLQFa8u
 9QkA==
X-Gm-Message-State: AOAM532Nn6hCzPRAw7lIUJVplfm/36BaHDuB82U1eOl4d+P0dzMHT5Da
 wDWSWAicaEol+2NZe0EQORnbuPVAdf2GEKH0KgfUlqvr9lHmRol1EMZ194BJsvxsfBLz5RBCupk
 lO4jOlEXh1WANZ87Ra0WIOFeX8aN5WqAmm86XOZJwpbl6e2GeOmTaZssZ4Q==
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr13082337ljq.315.1652749231445; 
 Mon, 16 May 2022 18:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7EN/VoW/ucILliSKJpfc58p1g0pp+q4S3+BbXjx+b7PAbrtD/pWftV+zCozEdqTw8rhhpoAbfMu18Z4Yuu0o=
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr13082319ljq.315.1652749231249; Mon, 16
 May 2022 18:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <875ymd3fd1.fsf@redhat.com>
 <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
 <20220511160147.46cbf2fb.pasic@linux.ibm.com>
 <CACGkMEtaN6tZrwp3rsxu4Hn1Rev2P06X3BaR4X1cqDxnRdPCKg@mail.gmail.com>
 <20220516132006.29d28fbe.pasic@linux.ibm.com>
 <20220516102425-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220516102425-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 May 2022 09:00:20 +0800
Message-ID: <CACGkMEsgNuZE1hnmOBBrBnSk9iMXw+4NosmytNA-h8XULv0Bdg@mail.gmail.com>
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Mon, May 16, 2022 at 10:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, May 16, 2022 at 01:20:06PM +0200, Halil Pasic wrote:
> > On Thu, 12 May 2022 11:31:08 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> > > > > It looks to me we need to use write_lock_irq()/write_unlock_irq() to
> > > > > do the synchronization.
> > > > >
> > > > > And we probably need to keep the
> > > > > read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
> > > > > virtio_ccw_int_handler() to be called from process context (e.g from
> > > > > the io_subchannel_quiesce()).
> > > > >
> > > >
> > > > Sounds correct.
> > >
> > > As Cornelia and Vineeth pointed out, all the paths the vring_interrupt
> > > is called with irq disabled.
> > >
> > > So I will use spin_lock()/spin_unlock() in the next version.
> >
> > Can we do some sort of an assertion that if the kernel is built with
> > the corresponding debug features will make sure this assumption holds
> > (and warn if it does not)? That assertion would also document the fact.
>
> Lockdep will do this automatically if you get it wrong, just like it
> did here.
>
> > If an assertion is not possible, I think we should at least place a
> > strategic comment that documents our assumption.
>
> That can't hurt.

I will add some comments here.

Thanks

>
> > Regards,
> > Halil
> >
> > >
> > > Thanks
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
