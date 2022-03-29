Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FBAC433F5
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 22:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A172A41942;
	Tue, 29 Mar 2022 22:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I8kXGCNoouuY; Tue, 29 Mar 2022 22:05:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E477240224;
	Tue, 29 Mar 2022 22:04:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C19A9C002C;
	Tue, 29 Mar 2022 22:04:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0143C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 22:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA19640245
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 22:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VLeOZf3OO5V4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 22:04:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9C0640224
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 22:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648591496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBLVNEPOUf5WmMPDsR6Y4RldMomDgegBLpjKSzD4JRA=;
 b=JLHV1TI5dOZ/MWOs/vk6MHKAZPjdI113aN/CSiVGSWI22mHerM5KOmTJXt1six4jHUHo7e
 tkYXCcq5z+JfczSZNnnbBaYqBeIG9L8z/2UF42U94ujbSaBbUVJz5VOMJwUBce17+i/2fT
 +kCs+PyPekonz0VaIvarXcQq0GgIT2g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-2WNn7TBfPDq9gAWSLcjHYA-1; Tue, 29 Mar 2022 18:04:55 -0400
X-MC-Unique: 2WNn7TBfPDq9gAWSLcjHYA-1
Received: by mail-wr1-f71.google.com with SMTP id
 i27-20020adfa51b000000b00205c997f177so1318451wrb.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 15:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IBLVNEPOUf5WmMPDsR6Y4RldMomDgegBLpjKSzD4JRA=;
 b=d+zCSmKiIZmrCjZOI3dVU0Iwo2giPcnk4rJigG3dJyGWgxwCoQ0OJFfSpVNVompfx2
 WH8jzi4wohaR5q1FgDPyv+rIZ44cYHl19WsHX2ZRi4jW/lkHNd7LDp/mtl//oJd5XVkm
 zAmQiYFICknvLlwFG1THDjn+Wymg5QsmRgJAEGLdXXpma1j889g9+X5CQAAUoc64Rf2J
 ee1QjVQj4Z8jY2GBF5USB4ebPxrnO/7Ei/xbteu9qa70j9kO6I8Pvp+Ub7tJIyR0DYgk
 kAmBu3ZVnhIRhr58rHa/P4zerIiyX9TxkhSh2intVQBq6+hQ7Dztpr7ti0dRLeb4s/yS
 GQjQ==
X-Gm-Message-State: AOAM532TvJky7O+16tOhym4ljx+yaYDjNm06TwpX0wLmOBeJeYzIIVcW
 CZKxDv4OAciGIt4cdrzvGao4L5iihPh9bH5DHcqPm0frff92vRljqf3hSHfQ6sq/qr7n8GLUQ5G
 CS8HastOqkONiHxjmfOv6P/054kHRkOQUXBuPJy0Uog==
X-Received: by 2002:a05:6000:1848:b0:204:e90:cb55 with SMTP id
 c8-20020a056000184800b002040e90cb55mr33430807wri.58.1648591493928; 
 Tue, 29 Mar 2022 15:04:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZklsWDLtlBufF6gMqI6XIA4yF+Av43mfXR6BICacO/J+twKmWzR7EUSvOK/qjb3IJxAX0yw==
X-Received: by 2002:a05:6000:1848:b0:204:e90:cb55 with SMTP id
 c8-20020a056000184800b002040e90cb55mr33430788wri.58.1648591493646; 
 Tue, 29 Mar 2022 15:04:53 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0038ca3500494sm5309811wmq.27.2022.03.29.15.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 15:04:53 -0700 (PDT)
Date: Tue, 29 Mar 2022 18:04:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re:
Message-ID: <20220329175426-mutt-send-email-mst@kernel.org>
References: <20220325050947-mutt-send-email-mst@kernel.org>
 <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org>
 <87fsn1f96e.ffs@tglx>
 <20220329100859-mutt-send-email-mst@kernel.org>
 <87v8vweie2.ffs@tglx>
MIME-Version: 1.0
In-Reply-To: <87v8vweie2.ffs@tglx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Keir Fraser <keirf@google.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Mar 29, 2022 at 08:13:57PM +0200, Thomas Gleixner wrote:
> On Tue, Mar 29 2022 at 10:37, Michael S. Tsirkin wrote:
> > On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> > We are trying to fix the driver since at the moment it does not
> > have the dev->ok flag at all.
> >
> > And I suspect virtio is not alone in that.
> > So it would have been nice if there was a standard flag
> > replacing the driver-specific dev->ok above, and ideally
> > would also handle the case of an interrupt triggering
> > too early by deferring the interrupt until the flag is set.
> >
> > And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
> > enable_irq instead of dev->ok = true, except
> > - it doesn't work with affinity managed IRQs
> > - it does not work with shared IRQs
> >
> > So using dev->ok as you propose above seems better at this point.
> 
> Unless there is a big enough amount of drivers which could make use of a
> generic mechanism for that.
> 
> >> If any driver does this in the wrong order, then the driver is
> >> broken.
> > 
> > I agree, however:
> > $ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
> > 113
> > $ git grep -l request_irq drivers/net/|wc -l
> > 397
> >
> > I suspect there are more drivers which in theory need the
> > synchronize_irq dance but in practice do not execute it.
> 
> That really depends on when the driver requests the interrupt, when
> it actually enables the interrupt in the device itself

This last point does not matter since we are talking about protecting
against buggy/malicious devices. They can inject the interrupt anyway
even if driver did not configure it.

> and how the
> interrupt service routine works.
> 
> So just doing that grep dance does not tell much. You really have to do
> a case by case analysis.
> 
> Thanks,
> 
>         tglx


I agree. In fact, at least for network the standard approach is to
request interrupts in the open call, virtio net is unusual
in doing it in probe. We should consider changing that.
Jason?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
