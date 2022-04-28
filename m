Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27616C433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 06:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C491060899;
	Thu, 28 Apr 2022 06:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DSvEZFPQuMd9; Thu, 28 Apr 2022 06:02:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6229D60615;
	Thu, 28 Apr 2022 06:02:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34E8CC0032;
	Thu, 28 Apr 2022 06:02:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C29FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1014C81361
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rOTRwT3yy81E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:02:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A01081359
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651125750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/5SY8yHPHy/pd09osroiZ4JJ60QVRx9AaMSzsMSnZg0=;
 b=YLqZvTXVj1fKf1Tc9Nvn033ohtPdvok2HAWHg3BfIt7EAV/bJuP5inY51k5DpBZQBAFHyS
 TWdYu5naVBXosCBU1ZnSNZ7Nmq4qcHQdQQCI687q9XGNGD+VmlNONtN0+q3TTjrNdrLmw3
 VGrnG8UvzQEwp5//QDWUyeHWLmJ1R3w=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-_a9NPezpNjyZtyDSaoq0Qw-1; Thu, 28 Apr 2022 02:02:29 -0400
X-MC-Unique: _a9NPezpNjyZtyDSaoq0Qw-1
Received: by mail-lj1-f198.google.com with SMTP id
 u19-20020a2e8553000000b0024f222a942aso1451324ljj.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 23:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/5SY8yHPHy/pd09osroiZ4JJ60QVRx9AaMSzsMSnZg0=;
 b=eUG+7j5nThOmcLQTc2KlhusIrqSnjQSsi2uJ0+NeCb/wf3t1ksebOkLOUzewjAd14y
 pFolUSaIb6fNwSdNZw7U5/tE83eIxqJTS+fmWQN+rsC3orINdk3RUw0YLO3BIWPXjmD+
 G2SDjD5iKuRWSAHiwlStYaBHCkvaeLKNAndghcO0kQOMEX2bEAc7GOivfAJwnvfXX6LK
 rlryGJ3Vn5tdFes0gdm4Cp7xagxVLVOncNjeo+S8No4u8Tx+riLol5qOb/5V2G1tZBzT
 iyHAJr2XHdJg0c42vO3zcK7d5p/VTVaS3YBX3XRMBrxOsBwKTgUS1S5rdNTUEpO2fkWq
 vBdQ==
X-Gm-Message-State: AOAM533kVu+QLLFkUfUl5MrNlVAr1DyjHpt3z1WTyYD6w46g/KZbexCo
 Gd1iWz2GZcBdKe6kK4Cv1LvJaAeiqSB5ED5M63M2Csfg7UFOJoqamSAj4rO6PL+CwcVC/bmZVVu
 Mmf3fuHEWulQp2KSuusxSD1onlPc1Y6uU0llLPKh2n7S+I4VCWHrXbLH/1w==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr22536223lfa.210.1651125748103; 
 Wed, 27 Apr 2022 23:02:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp2288/pYYhrDOFWzIzoQhfpAS0zeFfu2hhkegIQPrVXhgtyHbnKjeiooiOiAvB8lDIDAJm5uK4StybvuAgbo=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr22536206lfa.210.1651125747905; Wed, 27
 Apr 2022 23:02:27 -0700 (PDT)
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
In-Reply-To: <20220428015318-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Apr 2022 14:02:16 +0800
Message-ID: <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
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

On Thu, Apr 28, 2022 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 28, 2022 at 01:51:59PM +0800, Jason Wang wrote:
> > On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> > > > > But my guess is that rwlock + some testing for the legacy indicator case
> > > > > just to double check if there is a heavy regression despite of our
> > > > > expectations to see none should do the trick.
> > > >
> > > > I suggest this, rwlock (for not airq) seems better than spinlock, but
> > > > at worst case it will cause cache line bouncing. But I wonder if it's
> > > > noticeable (anyhow it has been used for airq).
> > > >
> > > > Thanks
> > >
> > > Which existing rwlock does airq use right now? Can we take it to sync?
> >
> > It's the rwlock in airq_info, it has already been used in this patch.
> >
> >                 write_lock(&info->lock);
> >                 write_unlock(&info->lock);
> >
> > But the problem is, it looks to me there could be a case that airq is
> > not used, (virtio_ccw_int_hander()). That's why the patch use a
> > spinlock, it could be optimized with using a rwlock as well.
> >
> > Thanks
>
> Ah, right. So let's take that on the legacy path too and Halil promises
> to test to make sure performance isn't impacted too badly?

I think what you meant is using a dedicated rwlock instead of trying
to reuse one of the airq_info locks.

If this is true, it should be fine.

Thanks

>
> > >
> > > --
> > > MST
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
