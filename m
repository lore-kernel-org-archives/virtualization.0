Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE41C433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 08:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C606C40222;
	Wed, 11 May 2022 08:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id trDJi7cVeq0l; Wed, 11 May 2022 08:44:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5C0154011F;
	Wed, 11 May 2022 08:44:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22FB8C0032;
	Wed, 11 May 2022 08:44:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E78B8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E40CE40135
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QeoJB_XjUi9c
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:44:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15C024011F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652258668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6XAsQFnhrZpWvc7RJwu2raTQ/L5Wv/W+iz3iayoq1a0=;
 b=bOI0r00DtbBESn/S3NLJa/JzWDvctXresKjKmR1Bu2bPCejHpSaj+kT7/vMJoi3ey9BKs0
 R0hhKTQUowqJSevZaRtOmUF+J8qtb0+wxz3ccvLOtCxnG+NqJHtOdaxPjoMHK9bImGebqe
 1k4zKbArXh12k1EISGK9zYzN7SLiUxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-NMVowrerMIai6WqcNK0bPA-1; Wed, 11 May 2022 04:44:27 -0400
X-MC-Unique: NMVowrerMIai6WqcNK0bPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2059801210;
 Wed, 11 May 2022 08:44:26 +0000 (UTC)
Received: from localhost (unknown [10.39.193.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9827AD9;
 Wed, 11 May 2022 08:44:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
In-Reply-To: <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-9-jasowang@redhat.com>
 <20220510072833-mutt-send-email-mst@kernel.org>
 <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Wed, 11 May 2022 10:44:14 +0200
Message-ID: <87o804bgrl.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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

> On Tue, May 10, 2022 at 7:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:
>> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> > index d8a2340f928e..23f1694cdbd5 100644
>> > --- a/include/linux/virtio_config.h
>> > +++ b/include/linux/virtio_config.h
>> > @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
>> >       unsigned status = dev->config->get_status(dev);
>> >
>> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>> > +
>> > +     /*
>> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
>> > +      * will see the driver specific setup if it sees vq->broken
>> > +      * as false.
>> > +      */
>> > +     virtio_synchronize_cbs(dev);
>>
>> since you mention vq->broken above, maybe add
>>         "set vq->broken to false"
>
> Ok.
>
>>
>> > +     __virtio_unbreak_device(dev);
>> > +     /*
>> > +      * The transport is expected ensure the visibility of
>>
>> to ensure
>
> Will fix.
>
>>
>> > +      * vq->broken
>>
>> let's add: "visibility by vq callbacks"
>
> Sure.
>
>>
>> > before setting VIRTIO_CONFIG_S_DRIVER_OK.
>> > +      */
>>
>>
>> Can I see some analysis of existing transports showing
>> this is actually the case for them?
>
> Yes.
>
>> And maybe add a comment near set_status to document the
>> requirement.
>
> For PCI and MMIO, we can quote the memory-barriers.txt or explain that
> wmb() is not needed before the MMIO writel().
> For CCW, it looks not obvious, it looks to me the IO was submitted via
> __ssch() which has an inline assembly.  Cornelia and Hali, could you
> help me to understand if and how did virtio_ccw_set_status() can
> ensure the visibility of the previous driver setup and vq->broken
> here?

I'm not sure I completely understand the question here, but let me try:

virtio_ccw_set_status() uses a channel command to set the status, with
the interesting stuff done inside ccw_io_helper(). That function
- takes the subchannel lock, disabling interrupts
- does the ssch; this instruction will fail if there's already another
  I/O in progress, or an interrupt is pending for the subchannel; on
  success, it is guaranteed that we'll get an interrupt eventually
- unlock the subchannel, and wait for the interupt handler to eventually
  process the interrupt, so I guess it should see the vq->broken value?

If the I/O fails, virtio_ccw_set_status() will revert its internal
status to the old value.


>
> Thanks
>
>>
>> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>> >  }

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
