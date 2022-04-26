Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8260BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 03:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1835460F5C;
	Tue, 26 Apr 2022 03:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 83qCfkBRf6Qc; Tue, 26 Apr 2022 03:35:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 934B460E2E;
	Tue, 26 Apr 2022 03:35:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67F21C0032;
	Tue, 26 Apr 2022 03:35:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E465C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C2AC8146D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BCVXqn75p2Sm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:35:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C63C38146B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650944144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LOGur+nJHD6EjUHWFTErPA0LCESsEHkIqwkzyPulrMU=;
 b=XZpXwA5mA2Z4ZKdOPox9TECORwK4ba66cnQ/z7n38VkQiJ3LB42ZYdw53qKnHb2OYNTL2i
 tx/+vWQn4vRVdGd2heDjq+eTeWwrjetnmtp9SvC55Bv2bC1Ya/DDxvTwtb0CKwdYDhUceG
 KnGnf9nu6JQYjb+N7y6cIbmUZ/nkxuk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-xECHjLFyM5S3bFIa54IOAQ-1; Mon, 25 Apr 2022 23:35:43 -0400
X-MC-Unique: xECHjLFyM5S3bFIa54IOAQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 c62-20020a1c3541000000b0038ec265155fso584923wma.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 20:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LOGur+nJHD6EjUHWFTErPA0LCESsEHkIqwkzyPulrMU=;
 b=aBEkDpz40xv3WcjVX7CRz9lQ+X/SPJBETxUrlKWYxa5w2FtSYQ5+NVrADTPyZXsV7Z
 bqKbXx09OIPY/08lnSxSECYKQw56AmBDqpS5ZZr5zeBupW/UR6gpjS15FF5MSif6QIsj
 ogkaSVpFgsM2rhQzGOwv7X/LUU/lkG6M+5uwIHuL42NLNEgQ6nuK8LBS4tETuaFTnj4o
 gL1Ey8H46UuIgfuHzzQUVe7qbNTeLsAYaIp/wN/iM7A9gTdEXJ2TZVO0ID3I6n/A4U6R
 Fvs6QtBKavsO7FA4nmjpI010GdUty2BDUftQ8tVO7yzb8AAhUXaBPbuFTfn8+Z5khrpy
 0lzQ==
X-Gm-Message-State: AOAM533tMHu5JydnjoRWIeG0e8nVE+ADWLBuc0JT1qViRj2qPJ5ATbI+
 LfDsdO4wAqibNvTldOauMlejS40VyOp44q4wK9fRswoKvaBFZ1lMf4CBu0xct4dvUndom8R9W/q
 xdxPDE1n2iYcCqXT3EPLiJdghMTS+vSBEapOlYjYaXA==
X-Received: by 2002:a5d:6c6d:0:b0:20a:7614:bf77 with SMTP id
 r13-20020a5d6c6d000000b0020a7614bf77mr16739326wrz.662.1650944141895; 
 Mon, 25 Apr 2022 20:35:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZLhLLaBSBNqef4UimQMgT4T8pjJMB2WmmpL3yCGfLiaW0wOyEqnTow6jGq31l8CkKDMmJvg==
X-Received: by 2002:a5d:6c6d:0:b0:20a:7614:bf77 with SMTP id
 r13-20020a5d6c6d000000b0020a7614bf77mr16739322wrz.662.1650944141728; 
 Mon, 25 Apr 2022 20:35:41 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 l3-20020a05600002a300b0020aad7fd63bsm12013398wry.61.2022.04.25.20.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 20:35:41 -0700 (PDT)
Date: Mon, 25 Apr 2022 23:35:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425233434-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220426042911.544477f9.pasic@linux.ibm.com>
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

On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
> On Mon, 25 Apr 2022 09:59:55 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:  
> > > >> This patch tries to implement the synchronize_cbs() for ccw. For the
> > > >> vring_interrupt() that is called via virtio_airq_handler(), the
> > > >> synchronization is simply done via the airq_info's lock. For the
> > > >> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > > >> device spinlock for irq is introduced ans used in the synchronization
> > > >> method.
> > > >> 
> > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > >> Cc: Marc Zyngier <maz@kernel.org>
> > > >> Cc: Halil Pasic <pasic@linux.ibm.com>
> > > >> Cc: Cornelia Huck <cohuck@redhat.com>
> > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> > > >
> > > >
> > > > This is the only one that is giving me pause. Halil, Cornelia,
> > > > should we be concerned about the performance impact here?
> > > > Any chance it can be tested?  
> > > 
> > > We can have a bunch of devices using the same airq structure, and the
> > > sync cb creates a choke point, same as registering/unregistering.  
> > 
> > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
> 
> I'm not sure I understand the question.
> 
> I do think we can have multiple CPUs that are executing some portion of
> virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> 
> On the other hand we could also end up serializing synchronize_cbs()
> calls for different devices if they happen to use the same airq_info. But
> this probably was not your question


I am less concerned about  synchronize_cbs being slow and more about
the slowdown in interrupt processing itself.

> > this patch serializes them on a spinlock.
> >
> 
> Those could then pile up on the newly introduced spinlock.
> 
> Regards,
> Halil

Hmm yea ... not good.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
