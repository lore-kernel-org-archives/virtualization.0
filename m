Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDC5C433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 09:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBFA961089;
	Wed, 11 May 2022 09:13:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RmIftbP6bfNB; Wed, 11 May 2022 09:13:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9109460BE4;
	Wed, 11 May 2022 09:13:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E43DC0032;
	Wed, 11 May 2022 09:13:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B730C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C28982A53
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOYfGDryctvq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:13:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A0A6829F2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652260392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CApB4fCuR2UMK3BwvDisU285t77/lsZs+p+hWazswkg=;
 b=Qt5Brd+6XFVzoaP1eyYZWhdf5iv/Q/Z63vYdkaJg5738NThwOETumfhWqkB9h4eL3/Yzv3
 ebILihLmXauZJLyrjk2aUbq1UxFolFFR6GJ1aS5q99tfsA/e3nSjq0q19JWoEJGPLnLgaG
 ucYMu7tifJEhVOGil+tegoa5X1Km/kc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-w86mAJb8NkywTkN4SXEPWg-1; Wed, 11 May 2022 05:13:09 -0400
X-MC-Unique: w86mAJb8NkywTkN4SXEPWg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAF33866DF4;
 Wed, 11 May 2022 09:13:08 +0000 (UTC)
Received: from localhost (unknown [10.39.193.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23FE41461258;
 Wed, 11 May 2022 09:13:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <CACGkMEtPk9P4KhJ5wTOLj9CZoKDx9-X_5uLRVBag692x4s9SrA@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org>
 <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
 <87r150bi0d.fsf@redhat.com>
 <CACGkMEtPk9P4KhJ5wTOLj9CZoKDx9-X_5uLRVBag692x4s9SrA@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Wed, 11 May 2022 11:13:06 +0200
Message-ID: <87lev8bffh.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Cindy Lu <lulu@redhat.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Wed, May 11, 2022 at 4:17 PM Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
>>
>> > On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >>
>> >> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
>> >> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>> >> >                       vcdev->err = -EIO;
>> >> >       }
>> >> >       virtio_ccw_check_activity(vcdev, activity);
>> >> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
>> >> >       for_each_set_bit(i, indicators(vcdev),
>> >> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>> >> >               /* The bit clear must happen before the vring kick. */
>> >>
>> >> Cornelia sent a lockdep trace on this.
>> >>
>> >> Basically I think this gets the irqsave/restore logic wrong.
>> >> It attempts to disable irqs in the handler (which is an interrupt
>> >> anyway).
>> >
>> > The reason I use irqsave/restore is that it can be called from process
>> > context (if I was not wrong), e.g from io_subchannel_quiesce().
>>
>> io_subchannel_quiesce() should disable interrupts, though? Otherwise, it
>> would be a bug.
>
> Right, it was protected by a spin_lock_irq(), but I can see other
> cdev->handler() in e.g device_fsm.c, the irq status is not obvious, do
> they have the same assumption which IRQ is disabled?

Yes, that should be the case for any invocations via the fsm as well.

It's been some time since I've worked on that part of the code, though,
so let's cc: the s390 cio maintainers so that they can speak up if I'm
wrong.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
