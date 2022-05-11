Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026A8C433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 08:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B5CD4011F;
	Wed, 11 May 2022 08:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Csm3BfA29I9; Wed, 11 May 2022 08:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E55D404F0;
	Wed, 11 May 2022 08:17:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2985DC0032;
	Wed, 11 May 2022 08:17:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C51AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5563F4160D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o-8dshqerDCK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 038FC41886
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652257048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WhNG2BFNpm3DlKnvpsKok4cmCLeGV6XphB375cBO7U=;
 b=VGRPrHzB9zM1+Gsk9omPkYIV0xG2XTHx5n5kgEPAN+St1ULf8QdMbOLwsuDeuh1l0vsz2h
 aTHwDAvMnH3bD3yJTU58bY9pIQc51aQSfxvj6k/w0VXSY7zvzyBxQFlsgqclUy9C6tQt/M
 emBn3P9eFahkvss5q09OFiU9QC9plLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-naHtCBJcPk6b1wVTF8gDJg-1; Wed, 11 May 2022 04:17:25 -0400
X-MC-Unique: naHtCBJcPk6b1wVTF8gDJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05E3D185A794;
 Wed, 11 May 2022 08:17:25 +0000 (UTC)
Received: from localhost (unknown [10.39.193.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73F97145BF03;
 Wed, 11 May 2022 08:17:24 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org>
 <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Wed, 11 May 2022 10:17:22 +0200
Message-ID: <87r150bi0d.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
>> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>> >                       vcdev->err = -EIO;
>> >       }
>> >       virtio_ccw_check_activity(vcdev, activity);
>> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
>> >       for_each_set_bit(i, indicators(vcdev),
>> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>> >               /* The bit clear must happen before the vring kick. */
>>
>> Cornelia sent a lockdep trace on this.
>>
>> Basically I think this gets the irqsave/restore logic wrong.
>> It attempts to disable irqs in the handler (which is an interrupt
>> anyway).
>
> The reason I use irqsave/restore is that it can be called from process
> context (if I was not wrong), e.g from io_subchannel_quiesce().

io_subchannel_quiesce() should disable interrupts, though? Otherwise, it
would be a bug.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
