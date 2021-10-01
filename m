Return-Path: <SRS0=yNrU=OV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91993C433F5
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 15:18:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC36615A4
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 15:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DC36615A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0726D40415;
	Fri,  1 Oct 2021 15:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lZ3xvePynEYZ; Fri,  1 Oct 2021 15:18:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 633F8403C6;
	Fri,  1 Oct 2021 15:18:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31B21C000F;
	Fri,  1 Oct 2021 15:18:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93F82C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 15:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 82FC8614E9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 15:18:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14OmsPtptSVq
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 15:18:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5800D614E8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 15:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633101531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7C7nph0IhS1Fw7syhYok+wzYniobVwIXFwlQp7ZOwZk=;
 b=WUt+ijyGr/JiAsIwrN4Nboo3VEiLVW/lEmTrYedIIE784vGNcvbO0tBygJl7c2xZkS9m3P
 kMlfwN2Kjtbn+d3o4G1MhvtpwbB9LucEPUgmiVwCz2sEDqvsoLF1xpLZ5i63deNb9dAy89
 K6UpkvLGa5OXTRFlXCqHdi+fpVNKYgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-gwn_3wreOuavPHbos-PwJQ-1; Fri, 01 Oct 2021 11:18:50 -0400
X-MC-Unique: gwn_3wreOuavPHbos-PwJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FD2D81426E;
 Fri,  1 Oct 2021 15:18:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B975660936;
 Fri,  1 Oct 2021 15:18:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211001162213.18d7375e.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com> <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com> <20211001162213.18d7375e.pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Fri, 01 Oct 2021 17:18:46 +0200
Message-ID: <87v92g3h9l.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Xie Yongji <xieyongji@bytedance.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
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

On Fri, Oct 01 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 30 Sep 2021 13:31:04 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Thu, Sep 30 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
>> 
>> > On Thu, 30 Sep 2021 11:28:23 +0200
>> > Cornelia Huck <cohuck@redhat.com> wrote:
>> >  
>> >> On Thu, Sep 30 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
>> >> > @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
>> >> >  		if (device_features & (1ULL << i))
>> >> >  			__virtio_set_bit(dev, i);
>> >> >  
>> >> > +	/* Write back features before validate to know endianness */
>> >> > +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>> >> > +		dev->config->finalize_features(dev);    
>> >> 
>> >> This really looks like a mess :(
>> >> 
>> >> We end up calling ->finalize_features twice: once before ->validate, and
>> >> once after, that time with the complete song and dance. The first time,
>> >> we operate on one feature set; after validation, we operate on another,
>> >> and there might be interdependencies between the two (like a that a bit
>> >> is cleared because of another bit, which would not happen if validate
>> >> had a chance to clear that bit before).  
>> >
>> > Basically the second set is a subset of the first set.  
>> 
>> I don't think that's clear.
>
> Validate can only remove features, or? So I guess after validate
> is a subset of before validate.

I was thinking about (more-or-less hypothetical) interdependencies (see
above). But that's not terribly important.

>
>
>> 
>> >  
>> >> 
>> >> I'm not sure whether that is even a problem in the spec: while the
>> >> driver may read the config before finally accepting features  
>> >
>> > I'm not sure I'm following you. Let me please qoute the specification:
>> > """
>> > 4. Read device feature bits, and write the subset of feature bits
>> > understood by the OS and driver to the device. During this step the driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it. 
>> > 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature bits after this step. 
>> > """
>> > https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-930001  
>> 
>> Yes, exactly, it MAY read before accepting features. How does the device
>> know whether the config space is little-endian or not?
>> 
>
> Well that is what we are talking about. One can try to infer things from
> the spec. This reset dance I called ugly is probably the cleanest,
> because the spec says that re-nego should work.
>
>> >  
>> >> , it does
>> >> not really make sense to do so before a feature bit as basic as
>> >> VERSION_1 which determines the endianness has been negotiated.   
>> >
>> > Are you suggesting that ->verify() should be after
>> > virtio_finalize_features()?  
>> 
>> No, that would defeat the entire purpose of verify. After
>> virtio_finalize_features(), we are done with feature negotiation.
>>
>
> Exactly!

It seems we are in violent agreement :)

>  
>> > Wouldn't
>> > that mean that verify() can't reject feature bits? But that is the whole
>> > point of commit 82e89ea077b9 ("virtio-blk: Add validation for block size
>> > in config space"). Do you think that the commit in question is
>> > conceptually flawed? My understanding of the verify is, that it is supposed
>> > to fence features and feature bits we can't support, e.g. because of
>> > config space things, but I may be wrong.  
>> 
>> No, that commit is not really flawed on its own, I think the whole
>> procedure may be problematic.
>> 
>
> I agree! But that regression really hurts us. Maybe the best band-aid is
> to conditional-compile it (not compile the check if s390).

It's probably most likely to hit on s390 (big-endian, and devices with a
blocksize != 512 in common use); but I'd like to make that band-aid more
generic than "exclude for s390". A hack for honouring VERSION_1 before
negotiation has finished is probably better as a stop-gap before we
manage to figure out how to deal with this properly.

>
>> >
>> > The trouble is, feature bits are not negotiated one by one, but basically all
>> > at once. I suppose, I did the next best thing to first negotiating
>> > VERSION_1.  
>> 
>> We probably need to special-case VERSION_1 to move at least forward;
>> i.e. proceed as if we accepted it when reading the config space.
>> 
>> The problem is that we do not know what the device assumes when we read
>> the config space prior to setting FEATURES_OK. It may assume
>> little-endian if it offered VERSION_1, or it may not. The spec does not
>> really say what happens before feature negotiation has finished.
>> 
> No it does not, but I hope, the implementations we care the most about do
> little endian if VERSION_1 is set but FEATURES_OK is not yet done. A
> transitional device would have to act upon a feature that is set,
> because for legacy there is no FEATURES_OK. Where we can run into
> trouble is minimum required feature set, e.g. mandatory features.

All ugly :(

>
> I will do some testing.
>
>> >
>> >  
>> >> For
>> >> VERSION_1, we can probably go ahead and just assume that we will accept
>> >> it if offered, but what about other (future) bits?  
>> >
>> > I don't quite understand.  
>> 
>> There might be other bits in the future that change how the config space
>> works. We cannot assume that any of those bits will be accepted if
>> offered; i.e. we need a special hack for VERSION_1.
>
> I tend to agree. What I didn't consider in this patch is that, setting
> bits does not only set bits, but may also change the device in a way,
> that clearing the bit would not change it back.
>
>> 
>> >
>> > Anyway, how do you think we should solve this problem?  
>> 
>> This is a mess. For starters, we need to think about if we should do
>> something in the spec, and if yes, what.. Then, we can probably think
>> about how to implement that properly.
>>
>
> I agree.
>
>  
>> As we have an error right now that is basically a regression, we
>> probably need a band-aid to keep going. Not sure if your patch is the
>> right approach, maybe we really need to special-case VERSION_1 (the
>> "assume we accepted it" hack mentioned above.) This will likely fix the
>> reported problem (I assume that is s390x on QEMU); do we know about
>> other VMMs? Any other big-endian architectures?
>
> I didn't quite get it. Would this hack take place in QEMU or in the guest
> kernel?

I'd say we need a hack here so that we assume little-endian config space
if VERSION_1 has been offered; if your patch here works, I assume QEMU
does what we expect (assmuming little-endian as well.) I'm mostly
wondering what happens if you use a different VMM; can we expect it to
work similar to QEMU? Even if it helps for s390, we should double-check
what happens for other architectures.

>
>> 
>> Anyone have any better suggestions?
>> 
>
> There is the conditional compile, as an option but I would not say it is
> better.

Yes, I agree.

Anyone else have an idea? This is a nasty regression; we could revert the
patch, which would remove the symptoms and give us some time, but that
doesn't really feel right, I'd do that only as a last resort.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
