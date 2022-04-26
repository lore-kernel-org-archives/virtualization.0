Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E05FC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 03:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0A4181490;
	Tue, 26 Apr 2022 03:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UTsvg_Rkt3PK; Tue, 26 Apr 2022 03:38:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 23C248146E;
	Tue, 26 Apr 2022 03:38:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBEE0C0032;
	Tue, 26 Apr 2022 03:38:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9F4EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C166D4037C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P5su08Jh3qRo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:38:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 700124013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650944297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WIQnceDnTPqWEyvR+jRAACxbLqJerOV/+jqpfvLm6RA=;
 b=caWjln6YG+Pdg/NypLSf0nPPb1j11ljalWxVt/yunMEk8ysLh1RrRqSijD0vcf4N22nUXT
 M1msj/bGldO281CTUYeKaG7DfB571aUaU4ZGMAJZZBL2PiyfOQkeutqcJaK5DCqQkPyp9G
 1FDYS+3GFhcaHrovUroJumQJLedVTBk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-HDnit9GMN-2mfSVO3Ap6fg-1; Mon, 25 Apr 2022 23:38:06 -0400
X-MC-Unique: HDnit9GMN-2mfSVO3Ap6fg-1
Received: by mail-wr1-f70.google.com with SMTP id
 t15-20020adfdc0f000000b001ef93643476so3965723wri.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 20:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WIQnceDnTPqWEyvR+jRAACxbLqJerOV/+jqpfvLm6RA=;
 b=VfIqP+JAeTZhV9qU9Y2ZGPBACr1aRwqzPhoFMgoJYPFg+MuP0ccmYkxik3zofz4rlI
 W8v5iVC8jpavB956RDl18GV4ph6KqHs0RYRwpRSoGGezmAXh1aepColDnfSLsS7EQx9v
 2Dvh6Z48YFAPk5u/8wakZIiCkeVGNz9/NqEM4r+LABlaGl+llzoiEUl/diBEgGsMIIqZ
 ZrQ/nt9r/y6lb+qZkEfhHZsdP8YUATQesFH1KofVz5FBPpSpLvc0MMbHiO9QTLyCcsj3
 uPBC90YR3nlTkFahO0SGsQC7+TXW+7T705lLAGz/8sOn5d/FS+CuMunOSrqm52G43x5h
 CYFA==
X-Gm-Message-State: AOAM530vB+vITT0HWuctvbsUaKQu64XXFkD2g1GcJ7BT5PU4HrovusR9
 /IJGsB62dhjQXC/hxzH5QOg7vbvxP3Qc0sV7qMWOhDsjB/pqaVboPSA0jPtYZA8SktQsINbRaDi
 xhy1xFiphwuvhYgUropmigjf+Wwi13ftf0Hb4z0x8Og==
X-Received: by 2002:a5d:6102:0:b0:20a:db89:724f with SMTP id
 v2-20020a5d6102000000b0020adb89724fmr6294046wrt.59.1650944285457; 
 Mon, 25 Apr 2022 20:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDl85Otu4KZcKjc/hiNLN0xYTp11xKMZiuuo8GOT13qx2bgBE3K0mDwMLh4XIvvLqvOuFVPA==
X-Received: by 2002:a5d:6102:0:b0:20a:db89:724f with SMTP id
 v2-20020a5d6102000000b0020adb89724fmr6294031wrt.59.1650944285222; 
 Mon, 25 Apr 2022 20:38:05 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 p3-20020a5d59a3000000b0020a83f00487sm14093629wrr.9.2022.04.25.20.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 20:38:04 -0700 (PDT)
Date: Mon, 25 Apr 2022 23:38:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425233604-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220425233434-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 tglx@linutronix.de
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

On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> > On Mon, 25 Apr 2022 09:59:55 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >   
> > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:  
> > > > >> This patch tries to implement the synchronize_cbs() for ccw. For the
> > > > >> vring_interrupt() that is called via virtio_airq_handler(), the
> > > > >> synchronization is simply done via the airq_info's lock. For the
> > > > >> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > > > >> device spinlock for irq is introduced ans used in the synchronization
> > > > >> method.
> > > > >> 
> > > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > >> Cc: Marc Zyngier <maz@kernel.org>
> > > > >> Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > >> Cc: Cornelia Huck <cohuck@redhat.com>
> > > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> > > > >
> > > > >
> > > > > This is the only one that is giving me pause. Halil, Cornelia,
> > > > > should we be concerned about the performance impact here?
> > > > > Any chance it can be tested?  
> > > > 
> > > > We can have a bunch of devices using the same airq structure, and the
> > > > sync cb creates a choke point, same as registering/unregistering.  
> > > 
> > > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
> > 
> > I'm not sure I understand the question.
> > 
> > I do think we can have multiple CPUs that are executing some portion of
> > virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> > 
> > On the other hand we could also end up serializing synchronize_cbs()
> > calls for different devices if they happen to use the same airq_info. But
> > this probably was not your question
> 
> 
> I am less concerned about  synchronize_cbs being slow and more about
> the slowdown in interrupt processing itself.
> 
> > > this patch serializes them on a spinlock.
> > >
> > 
> > Those could then pile up on the newly introduced spinlock.
> > 
> > Regards,
> > Halil
> 
> Hmm yea ... not good.

Is there any other way to synchronize with all callbacks?

> -- 
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
