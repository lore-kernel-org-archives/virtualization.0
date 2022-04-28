Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EBFC433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 06:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE6C94150F;
	Thu, 28 Apr 2022 06:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VX_qojIHs2lE; Thu, 28 Apr 2022 06:17:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 283C241503;
	Thu, 28 Apr 2022 06:17:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED49AC0039;
	Thu, 28 Apr 2022 06:17:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2A5FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BAD8760A6D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:17:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wUbhBiOnbchF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1709360899
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651126648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qQhGtA47NR84b2kaV85amh4Sebyf9NryuvTIfdPeXpA=;
 b=K5bDmTSnZ2E7/XoLjkYPUmvrHp26LDs6R9AhgQLl0RtKnWBF//b8TvJL1CH3tGjIk0AVZD
 Rms3e2W+f2nbyz3lVCHlreXSVaK1nqxDfmdwPk93XrFq2CD2JU5uvvoVVSNgT60M17MlQa
 tmFJlTjqHN7Godo9EYWpQLmg2mu6XyM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-ItK19JjiO9-ykMJfbrvn8A-1; Thu, 28 Apr 2022 02:17:26 -0400
X-MC-Unique: ItK19JjiO9-ykMJfbrvn8A-1
Received: by mail-wm1-f69.google.com with SMTP id
 az19-20020a05600c601300b003914ac8efb8so1124042wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 23:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qQhGtA47NR84b2kaV85amh4Sebyf9NryuvTIfdPeXpA=;
 b=Ce9nrlRnY6py4v1vFZYNXEnKodRdQVJvU8mCS9Dbx15RI1Cg259XbAYVHJz/pBdGHy
 D49Cy9XsanlH0yLxOu37qydVkuLWKkI5Xhb75DE09aQtIY0FJd7EORV38TsHZRH5Tzjr
 cqf0KT+bE5bLNyIiePBcau/2zUL+NJ47gvyj6PWdJ7Ah9kwAsVQzaNpZmP5OYyh5Z8wC
 b2YElMinGa39y2hHmyqgv9AC7ZMZBDol8ykhrctlvBZ7S+ln9IchHWzCN8Lu50MyfJze
 vdzN+YKjehHOk4WlMDz9sZPyjHLbyRqpPCnHG6tok3M0NenL/MIaZv06fXfasd13LXiK
 QSiw==
X-Gm-Message-State: AOAM532F48GCu4XpE+RoAi2gjjnmUwI9nLnczhYeDe9rNbQBaGk1+BmM
 T4frnGGTyPRBbtP8kX20ViXD529w0a94vgbbNOoemuuE27KVgJEDWy3LjR8PRtqSBN/hJNb6vuf
 8mYtdE4x9V2AIo1XfMt55vBomPnLGZMXCCwDjgISamQ==
X-Received: by 2002:a05:600c:1d9b:b0:393:ffc8:a09b with SMTP id
 p27-20020a05600c1d9b00b00393ffc8a09bmr6976972wms.40.1651126645655; 
 Wed, 27 Apr 2022 23:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySt1PmpZpkFkGjb2r3Cu8qgqSGEsGjgTv5m05qjUwHnRW5foby32blg2uMdYADJxt6WCMk5A==
X-Received: by 2002:a05:600c:1d9b:b0:393:ffc8:a09b with SMTP id
 p27-20020a05600c1d9b00b00393ffc8a09bmr6976935wms.40.1651126645390; 
 Wed, 27 Apr 2022 23:17:25 -0700 (PDT)
Received: from redhat.com ([2.53.18.16]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d6482000000b0020a96536fcdsm16391780wri.57.2022.04.27.23.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 23:17:24 -0700 (PDT)
Date: Thu, 28 Apr 2022 02:17:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220428021658-mutt-send-email-mst@kernel.org>
References: <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com>
 <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
 <20220428012156-mutt-send-email-mst@kernel.org>
 <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
 <20220428015318-mutt-send-email-mst@kernel.org>
 <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Thu, Apr 28, 2022 at 02:02:16PM +0800, Jason Wang wrote:
> On Thu, Apr 28, 2022 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 01:51:59PM +0800, Jason Wang wrote:
> > > On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> > > > > > But my guess is that rwlock + some testing for the legacy indicator case
> > > > > > just to double check if there is a heavy regression despite of our
> > > > > > expectations to see none should do the trick.
> > > > >
> > > > > I suggest this, rwlock (for not airq) seems better than spinlock, but
> > > > > at worst case it will cause cache line bouncing. But I wonder if it's
> > > > > noticeable (anyhow it has been used for airq).
> > > > >
> > > > > Thanks
> > > >
> > > > Which existing rwlock does airq use right now? Can we take it to sync?
> > >
> > > It's the rwlock in airq_info, it has already been used in this patch.
> > >
> > >                 write_lock(&info->lock);
> > >                 write_unlock(&info->lock);
> > >
> > > But the problem is, it looks to me there could be a case that airq is
> > > not used, (virtio_ccw_int_hander()). That's why the patch use a
> > > spinlock, it could be optimized with using a rwlock as well.
> > >
> > > Thanks
> >
> > Ah, right. So let's take that on the legacy path too and Halil promises
> > to test to make sure performance isn't impacted too badly?
> 
> I think what you meant is using a dedicated rwlock instead of trying
> to reuse one of the airq_info locks.
> 
> If this is true, it should be fine.
> 
> Thanks

yes

> >
> > > >
> > > > --
> > > > MST
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
