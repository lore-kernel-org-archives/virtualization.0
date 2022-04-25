Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98693C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 08:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3634F40472;
	Mon, 25 Apr 2022 08:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0F4y88qtNBC5; Mon, 25 Apr 2022 08:54:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9850440022;
	Mon, 25 Apr 2022 08:54:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B8DFC0032;
	Mon, 25 Apr 2022 08:54:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1FA5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9164140462
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8xm6I4I_7Wwx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:54:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB10040022
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650876868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7eIeWS47Em435MDdVzeQsQsPcR5jLBoUJYfnOUHKBU=;
 b=NCEBIyCtz0BXarhkbHeIkulVegXl5RakAPEcWMKNn2EiLVrHcBQISfcKiVkfFeX+eHJuJq
 pfY67K0KoJsHjO5X91dI1ImpvZ+3dwHLdugTRi3ncFn5OiZNWnH8/4OxJTN0eCSX+sfgow
 wbL+xSBzKGHU3WDlnVfMXbeUGbcunl4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-OxcRZ2GINRaOhAtSpaFdkw-1; Mon, 25 Apr 2022 04:54:26 -0400
X-MC-Unique: OxcRZ2GINRaOhAtSpaFdkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7999811E7A;
 Mon, 25 Apr 2022 08:54:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EAC51402427;
 Mon, 25 Apr 2022 08:54:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <20220425040512-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Mon, 25 Apr 2022 10:54:24 +0200
Message-ID: <87a6c98rwf.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, eperezma@redhat.com, tglx@linutronix.de
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

On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
>> This patch tries to implement the synchronize_cbs() for ccw. For the
>> vring_interrupt() that is called via virtio_airq_handler(), the
>> synchronization is simply done via the airq_info's lock. For the
>> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
>> device spinlock for irq is introduced ans used in the synchronization
>> method.
>> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> This is the only one that is giving me pause. Halil, Cornelia,
> should we be concerned about the performance impact here?
> Any chance it can be tested?

We can have a bunch of devices using the same airq structure, and the
sync cb creates a choke point, same as registering/unregistering. If
invoking the sync cb is a rare operation (same as (un)registering), it
should not affect interrupt processing for other devices too much, but
it really should be rare.

For testing, you would probably want to use a setup with many devices
that share the same airq area (you can fit a lot of devices if they have
few queues), generate traffic on the queues, and then do something that
triggers the callback (adding/removing a new device in a loop?)

I currently don't have such a setup handy; Halil, would you be able to
test that?

>
>> ---
>>  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>> 
>> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
>> index d35e7a3f7067..c19f07a82d62 100644
>> --- a/drivers/s390/virtio/virtio_ccw.c
>> +++ b/drivers/s390/virtio/virtio_ccw.c
>> @@ -62,6 +62,7 @@ struct virtio_ccw_device {
>>  	unsigned int revision; /* Transport revision */
>>  	wait_queue_head_t wait_q;
>>  	spinlock_t lock;
>> +	spinlock_t irq_lock;
>>  	struct mutex io_lock; /* Serializes I/O requests */
>>  	struct list_head virtqueues;
>>  	bool is_thinint;
>> @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
>>  	return dev_name(&vcdev->cdev->dev);
>>  }
>>  
>> +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
>> +{
>> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>> +	struct airq_info *info = vcdev->airq_info;
>> +
>> +	/*
>> +	 * Synchronize with the vring_interrupt() called by
>> +	 * virtio_ccw_int_handler().
>> +	 */
>> +	spin_lock(&vcdev->irq_lock);
>> +	spin_unlock(&vcdev->irq_lock);
>> +
>> +	if (info) {
>> +		/*
>> +		 * Synchronize with the vring_interrupt() with airq indicator
>> +		 */
>> +		write_lock(&info->lock);
>> +		write_unlock(&info->lock);
>> +	}

I think we can make this an either/or operation (devices will either use
classic interrupts or adapter interrupts)?

>> +}
>> +
>>  static const struct virtio_config_ops virtio_ccw_config_ops = {
>>  	.get_features = virtio_ccw_get_features,
>>  	.finalize_features = virtio_ccw_finalize_features,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
