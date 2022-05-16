Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF19BC433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 14:25:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60C0041839;
	Mon, 16 May 2022 14:25:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id egPvGcqCZnWC; Mon, 16 May 2022 14:25:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B003B41803;
	Mon, 16 May 2022 14:25:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FC78C0032;
	Mon, 16 May 2022 14:25:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3127C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 14:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9826F41826
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 14:25:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NxHkn4N3aWoZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 14:25:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62F6B41803
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652711111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NRq6KGsNxCSeCY6JCFk9olYgNVlaBKaEOFZvjnnTK1U=;
 b=Zs07bvkr6d1cey5X0cG4UR0YoB9S6AH767r5O2XQM1CjTLUO3CFPhpRJCThePnU2KCVVz2
 h+D7ufD3lWUj078qKycu92e+V0QE1E2xZUqwbEgGV8IofVz/43woFuHcI7UTVsWi/XU3bD
 FeyoGWAXFrGwzvnThf7Eye3CMYolbWc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-bxJOxkTSN3-KriAORZzCiA-1; Mon, 16 May 2022 10:25:09 -0400
X-MC-Unique: bxJOxkTSN3-KriAORZzCiA-1
Received: by mail-ed1-f69.google.com with SMTP id
 f20-20020a50d554000000b0042abba35e60so787317edj.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 07:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NRq6KGsNxCSeCY6JCFk9olYgNVlaBKaEOFZvjnnTK1U=;
 b=rPLgeHFVuv8h8b03VluECon9WTk0m91GEwvYVGsIJuEkq8UWfe+ksuloBbMh7SkoXH
 PgXEz+3h/pdN+2kE5cnBe6EAtZkdixRkYyYObArQ2WzNRyQmTu3AhX+xRhIfmvq9ztnz
 BZD8o5/ESCXMHPsgNHXrLhT0L/jjTIt6KEfYmBL4ekgZnXP19L6d6YooYEo+H1eN6eTv
 NLQJt71SbZ1HtZP5uVMRGK9h/5e4gWRmEhKQsCoSzCZ5iHvRiSyu6Nw89lyjk6ePORCK
 2MJg+7hoB2YYUbMNyzlV983Pm0pdq5+l9JpL25POtusYi+jCbS6/sbjyyEjw8TASlOHU
 Kp5Q==
X-Gm-Message-State: AOAM531j5j2QdCZtzzY9O56Q3kBMDjRhQ0+7pryd+shVKRSoJEGKfdhp
 0rw11nuj1fZlcGqeH5456nOK0iEEgkGFpA5aod7PQezmGfKrSS06C1zoODLwuWqKZcz02+ScNVj
 hAippXjhz7qcOk5rPJbtlNViu6gPsokjgix6V84pRaQ==
X-Received: by 2002:a17:906:99c4:b0:6f4:56d2:4bbd with SMTP id
 s4-20020a17090699c400b006f456d24bbdmr15954525ejn.754.1652711108646; 
 Mon, 16 May 2022 07:25:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye6mqKhXV1EBhqjD51FQ3FfI+pLSVF1VgsllzZALr294dHvcZwWeRpUm7YaMfxxw1HWuVGpg==
X-Received: by 2002:a17:906:99c4:b0:6f4:56d2:4bbd with SMTP id
 s4-20020a17090699c400b006f456d24bbdmr15954503ejn.754.1652711108454; 
 Mon, 16 May 2022 07:25:08 -0700 (PDT)
Received: from redhat.com ([2.55.141.66]) by smtp.gmail.com with ESMTPSA id
 gz21-20020a170907a05500b006f4512e7bc8sm3773846ejc.60.2022.05.16.07.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 07:25:07 -0700 (PDT)
Date: Mon, 16 May 2022 10:25:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
Message-ID: <20220516102425-mutt-send-email-mst@kernel.org>
References: <20220507071954.14455-1-jasowang@redhat.com>
 <875ymd3fd1.fsf@redhat.com>
 <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
 <20220511160147.46cbf2fb.pasic@linux.ibm.com>
 <CACGkMEtaN6tZrwp3rsxu4Hn1Rev2P06X3BaR4X1cqDxnRdPCKg@mail.gmail.com>
 <20220516132006.29d28fbe.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220516132006.29d28fbe.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Mon, May 16, 2022 at 01:20:06PM +0200, Halil Pasic wrote:
> On Thu, 12 May 2022 11:31:08 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > > > It looks to me we need to use write_lock_irq()/write_unlock_irq() to
> > > > do the synchronization.
> > > >
> > > > And we probably need to keep the
> > > > read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
> > > > virtio_ccw_int_handler() to be called from process context (e.g from
> > > > the io_subchannel_quiesce()).
> > > >  
> > >
> > > Sounds correct.  
> > 
> > As Cornelia and Vineeth pointed out, all the paths the vring_interrupt
> > is called with irq disabled.
> > 
> > So I will use spin_lock()/spin_unlock() in the next version.
> 
> Can we do some sort of an assertion that if the kernel is built with
> the corresponding debug features will make sure this assumption holds
> (and warn if it does not)? That assertion would also document the fact.

Lockdep will do this automatically if you get it wrong, just like it
did here.

> If an assertion is not possible, I think we should at least place a
> strategic comment that documents our assumption.

That can't hurt.

> Regards,
> Halil
> 
> > 
> > Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
