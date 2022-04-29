Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56946C433EF
	for <virtualization@archiver.kernel.org>; Fri, 29 Apr 2022 02:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE43583F56;
	Fri, 29 Apr 2022 02:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bDdDM_XJmBbg; Fri, 29 Apr 2022 02:02:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7936683EBF;
	Fri, 29 Apr 2022 02:02:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22CB9C0032;
	Fri, 29 Apr 2022 02:02:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A74DDC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 99E1741BE5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:02:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mi5Vk6HC_rKN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:02:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E853441BD1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651197744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dvj9G0/4wUIqSyOJTfvrlWtHyKpXimLlrMN8i333+hY=;
 b=FkqDfv6nxNUruYkIkTxUa85nGrHVJenHN1o9mLBpn3LIaNKIoVhdbVtKzzGVwn7JkBVtdq
 VPaXUVuG+9JhUpXfktwFpjZcQ9nkhs28NFRDifzYZsFNsk6RcvWObPSdCRT1xxCIwW5RGO
 suaFqzhpBnHWyD5wrS0R0rDDNa1SVEM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-LTR7-1RbOX2PMwZQKMq-4g-1; Thu, 28 Apr 2022 22:02:22 -0400
X-MC-Unique: LTR7-1RbOX2PMwZQKMq-4g-1
Received: by mail-lf1-f69.google.com with SMTP id
 v13-20020a056512096d00b004487e1503d0so2707362lft.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 19:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dvj9G0/4wUIqSyOJTfvrlWtHyKpXimLlrMN8i333+hY=;
 b=Uva53Dlm4gGdLE1GC99DXS0QkTeEC+NEJQlQvWUqTnaXQ+tmpEyH674EbkNSRjda50
 0cihC2lZSJfUszz4aUDzS2T4X4i0YuCJ/KZsb1Rg1J4CsvlB6nPTYIVOY6IDVbSeyWrr
 4/Vk2verRtwigstXwey9xI4oOwS+GdtyYsg6rAFHqcgZ8ctA3TUP16cnXB263pz015Kq
 5x5DJcren32ykANP6np10Y7Exz8NnjMYBREzbVjXpzA0kt592PUtA8OUnXG+PO8IaElD
 xU4kQPype3QABAr8DRiL/bnG/nI4UYv+m/K9ifKnlY2IoL1fwmM4S+5BttEA+PUQXDXt
 IXRg==
X-Gm-Message-State: AOAM533uE/3AZTrhamovh6Dd9A7L11wpj2xXbgwX5d/elXDHLS6bohay
 Pi7ESmthR/bwKW8zekMhuvFVYwfbaWfBIyEXyiCIdpFdDtd8k8X1vUa3vOOcZ1/RTSf1AEA9lqn
 fIvFhN9L7CcJGCLHc30gO4LkHMnVLrlO2cxEk3mEOaopGJMIM+ESUHLLJIg==
X-Received: by 2002:a05:6512:1526:b0:471:44fa:c367 with SMTP id
 bq38-20020a056512152600b0047144fac367mr25928153lfb.376.1651197741181; 
 Thu, 28 Apr 2022 19:02:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRwhr5Cr2fURlu5+J1sQU4pjDclODzlVYVdEfWUhon2IrguY2W6JlRc8rJ3htPCEJZ1xLuCNvxsMLxtCZHwxg=
X-Received: by 2002:a05:6512:1526:b0:471:44fa:c367 with SMTP id
 bq38-20020a056512152600b0047144fac367mr25928142lfb.376.1651197740985; Thu, 28
 Apr 2022 19:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com> <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com> <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
 <20220428012156-mutt-send-email-mst@kernel.org>
 <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
 <20220428015318-mutt-send-email-mst@kernel.org>
 <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
 <87zgk5lkme.fsf@redhat.com>
In-Reply-To: <87zgk5lkme.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Apr 2022 10:02:09 +0800
Message-ID: <CACGkMEtAXGdWKTSh90DH-=0YHhoSFxR43jwA8eROHqxUxdrVYQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On Thu, Apr 28, 2022 at 3:42 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Thu, Apr 28 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Thu, Apr 28, 2022 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Thu, Apr 28, 2022 at 01:51:59PM +0800, Jason Wang wrote:
> >> > On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > >
> >> > > On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> >> > > > > But my guess is that rwlock + some testing for the legacy indicator case
> >> > > > > just to double check if there is a heavy regression despite of our
> >> > > > > expectations to see none should do the trick.
> >> > > >
> >> > > > I suggest this, rwlock (for not airq) seems better than spinlock, but
> >> > > > at worst case it will cause cache line bouncing. But I wonder if it's
> >> > > > noticeable (anyhow it has been used for airq).
> >> > > >
> >> > > > Thanks
> >> > >
> >> > > Which existing rwlock does airq use right now? Can we take it to sync?
> >> >
> >> > It's the rwlock in airq_info, it has already been used in this patch.
> >> >
> >> >                 write_lock(&info->lock);
> >> >                 write_unlock(&info->lock);
> >> >
> >> > But the problem is, it looks to me there could be a case that airq is
> >> > not used, (virtio_ccw_int_hander()). That's why the patch use a
> >> > spinlock, it could be optimized with using a rwlock as well.
> >> >
> >> > Thanks
> >>
> >> Ah, right. So let's take that on the legacy path too and Halil promises
> >> to test to make sure performance isn't impacted too badly?
> >
> > I think what you meant is using a dedicated rwlock instead of trying
> > to reuse one of the airq_info locks.
> >
> > If this is true, it should be fine.
>
> FWIW, that approach makes sense to me as well.
>

Good to know that. Let me post a new version.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
