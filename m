Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CF4C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 12:09:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5417D60F43
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 12:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5417D60F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 12367403CF;
	Tue, 21 Sep 2021 12:09:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iNzA__zoM1RC; Tue, 21 Sep 2021 12:09:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2266D402DC;
	Tue, 21 Sep 2021 12:09:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDCFEC0011;
	Tue, 21 Sep 2021 12:09:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 305D1C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 12:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11AAB4037C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 12:09:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PWh53_0G7-pR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 12:09:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33BA54017F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632226159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uHvbv5slu5+j53B9OEnLfe2TjeQRn+fomR71sUrsq60=;
 b=ERcHmBcWPIKOm82/cOZeW31AQbxzgTseL2IxKBHP98tFkDBnj0x6H4If2hcr8q1OLkMZNF
 qniZrdQqgL70jb6QJ9pHHLY6r2112jcLE8H+SBVahpMLkgjCp7OIhXQeAb6ixWubAukSW5
 ICTE32ArmXUn7OIhMyYty6NQnvKbAzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-uQX_74s2P16wtECi_TQcbA-1; Tue, 21 Sep 2021 08:09:18 -0400
X-MC-Unique: uQX_74s2P16wtECi_TQcbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B313101AFA9;
 Tue, 21 Sep 2021 12:09:17 +0000 (UTC)
Received: from localhost (unknown [10.39.194.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DD181972D;
 Tue, 21 Sep 2021 12:09:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] virtio/s390: fix vritio-ccw device teardown
In-Reply-To: <20210921052548.4eea231f.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210915215742.1793314-1-pasic@linux.ibm.com>
 <87pmt8hp5o.fsf@redhat.com> <20210916151835.4ab512b2.pasic@linux.ibm.com>
 <87mtobh9xn.fsf@redhat.com> <20210920003935.1369f9fe.pasic@linux.ibm.com>
 <88b514a4416cf72cda53a31ad2e15c13586350e4.camel@linux.ibm.com>
 <878rzrh86c.fsf@redhat.com> <20210921052548.4eea231f.pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Tue, 21 Sep 2021 14:09:14 +0200
Message-ID: <87r1dif7v9.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 bfu@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, kvm@vger.kernel.org,
 Michael Mueller <mimu@linux.ibm.com>
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

On Tue, Sep 21 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 20 Sep 2021 12:07:23 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Mon, Sep 20 2021, Vineeth Vijayan <vneethv@linux.ibm.com> wrote:
>> 
>> > On Mon, 2021-09-20 at 00:39 +0200, Halil Pasic wrote:  
>> >> On Fri, 17 Sep 2021 10:40:20 +0200
>> >> Cornelia Huck <cohuck@redhat.com> wrote:
>> >>   
>> > ...snip...  
>> >> > > 
>> >> > > Thanks, if I find time for it, I will try to understand this
>> >> > > better and
>> >> > > come back with my findings.
>> >> > >    
>> >> > > > > * Can virtio_ccw_remove() get called while !cdev->online and 
>> >> > > > >   virtio_ccw_online() is running on a different cpu? If yes,
>> >> > > > > what would
>> >> > > > >   happen then?      
>> >> > > > 
>> >> > > > All of the remove/online/... etc. callbacks are invoked via the
>> >> > > > ccw bus
>> >> > > > code. We have to trust that it gets it correct :) (Or have the
>> >> > > > common
>> >> > > > I/O layer maintainers double-check it.)
>> >> > > >     
>> >> > > 
>> >> > > Vineeth, what is your take on this? Are the struct ccw_driver
>> >> > > virtio_ccw_remove and the virtio_ccw_online callbacks mutually
>> >> > > exclusive. Please notice that we may initiate the onlining by
>> >> > > calling ccw_device_set_online() from a workqueue.
>> >> > > 
>> >> > > @Conny: I'm not sure what is your definition of 'it gets it
>> >> > > correct'...
>> >> > > I doubt CIO can make things 100% foolproof in this area.    
>> >> > 
>> >> > Not 100% foolproof, but "don't online a device that is in the
>> >> > progress
>> >> > of going away" seems pretty basic to me.
>> >> >   
>> >> 
>> >> I hope Vineeth will chime in on this.  
>> > Considering the online/offline processing, 
>> > The ccw_device_set_offline function or the online/offline is handled
>> > inside device_lock. Also, the online_store function takes care of
>> > avoiding multiple online/offline processing. 
>> >
>> > Now, when we consider the unconditional remove of the device,
>> > I am not familiar with the virtio_ccw driver. My assumptions are based
>> > on how CIO/dasd drivers works. If i understand correctly, the dasd
>> > driver sets different flags to make sure that a device_open is getting
>> > prevented while the the device is in progress of offline-ing.   
>> 
>> Hm, if we are invoking the online/offline callbacks under the device
>> lock already, 
>
> I believe we have a misunderstanding here. I believe that Vineeth is
> trying to tell us, that online_store_handle_offline() and
> online_store_handle_offline() are called under the a device lock of
> the ccw device. Right, Vineeth?
>
> Conny, I believe, by online/offline callbacks, you mean
> virtio_ccw_online() and virtio_ccw_offline(), right?

Whatever the common I/O layer invokes.

>
> But the thing is that virtio_ccw_online() may get called (and is
> typically called, AFAICT) with no locks held via:
> virtio_ccw_probe() --> async_schedule(virtio_ccw_auto_online, cdev)
> -*-> virtio_ccw_auto_online(cdev) --> ccw_device_set_online(cdev) -->
> virtio_ccw_online()

That's the common I/O layer in there again?

>
> Furthermore after a closer look, I believe because we don't take
> a reference to the cdev in probe, we may get virtio_ccw_auto_online()
> called with an invalid pointer (the pointer is guaranteed to be valid
> in probe, but because of async we have no guarantee that it will be
> called in the context of probe).
>
> Shouldn't we take a reference to the cdev in probe? BTW what is the
> reason for the async?

I don't know.

>
>
>> how would that affect the remove callback?
>
> I believe dev->bus->remove(dev) is called by 
> bus_remove_device() with the device lock held. I.e. I believe that means
> that virtio_ccw_remove() is called with the ccw devices device lock
> held. Vineeth can you confirm that?
>
>
> The thing is, both virtio_ccw_remove() and virtio_ccw_offline() are
> very similar, with the notable exception that offline assumes we are
> online() at the moment, while remove() does the same only if it
> decides based on vcdev && cdev->online that we are online.
>
>
>> Shouldn't they
>> be serialized under the device lock already? I think we are fine.
>
> AFAICT virtio_ccw_remove() and virtio_ccw_offline() are serialized
> against each other under the device lock. And also against
> virtio_ccw_online() iff it was initiated via the sysfs, and not via
> the auto-online mechanism.
>
> Thus I don't think we are fine at the moment.

I don't understand this, sorry.

>
>> 
>> For dasd, I think they also need to deal with the block device
>> lifetimes. For virtio-ccw, we are basically a transport that does not
>> know about devices further down the chain (that are associated with the
>> virtio device, whose lifetime is tied to online/offline processing.) I'd
>> presume that the serialization above would be enough.
>> 
>
> I don't know about dasd that much. For the reasons stated above, I don't
> think the serialization we have right now is entirely sufficient.

I'm not sure it makes sense to discuss this further right now, I feel I
currently can't really provide any meaningful contribution.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
