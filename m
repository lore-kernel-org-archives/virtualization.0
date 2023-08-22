Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE47EE4993
	for <virtualization@archiver.kernel.org>; Tue, 22 Aug 2023 14:29:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00CFD81CBA;
	Tue, 22 Aug 2023 14:29:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00CFD81CBA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XcWHrxZh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XoBVXNyDFYMZ; Tue, 22 Aug 2023 14:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 44F8B817FF;
	Tue, 22 Aug 2023 14:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44F8B817FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05261C0039;
	Tue, 22 Aug 2023 14:29:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FE23C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 14:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A8F240199
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 14:29:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A8F240199
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XcWHrxZh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k_VOKEnMYWhb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 14:29:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33E4E4014D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 14:29:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33E4E4014D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692714548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oo0qQMP+EpYcaK0x6LYo/3scrNwDZqWhIrmx2SDwrB8=;
 b=XcWHrxZhB3PhH5bR84/4bgFnntjI9t5dndHAWR+zzPTw+tTbI9QdGZlcRCZbsW5CcE+MbC
 D9Eih6dn0j6KI0qjYBEPCkJAQaodu8uTRr5HY1IMhlGXLnHybzxq+DnnOavjl/9l0DU6Nb
 bObcgh5P1S73oQEOWnZo/RLNpr3vg4E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-tmh1baoiMWy2w8dAY1EBtQ-1; Tue, 22 Aug 2023 10:29:06 -0400
X-MC-Unique: tmh1baoiMWy2w8dAY1EBtQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bcbb224910so27096511fa.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 07:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692714545; x=1693319345;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oo0qQMP+EpYcaK0x6LYo/3scrNwDZqWhIrmx2SDwrB8=;
 b=A2rPqUa3QA8mG++Tcxl6bKIiVO8LhHdGn7DSnxXTyk6yyar6dzM2zijCoKW5zMLV/f
 GxdzXpsy/LqpkFRBu7847ECjqpSGnBULUsYtNYcr7unI5VKMDgVRePEEqcMGMM6LYl5f
 9u+uhM0oV0QkOCUCMr4E4/Hx1Vq5SQTdt0XozHI0bNaOsQQX86701i9l/BIuUvLk+8et
 gZV2wTTFjlseGQx4vFSSVToe18d6v6xGpEZx8xk2M2Y9aLErQbc9E4KZT8D92IK1c+Jh
 7v+QltFd4+TfAT2vl/rKpE5VKfo8DJ/EEaIe6EK7OamXIgyScwtGmuiD2Jui+ffRoBIr
 7BTQ==
X-Gm-Message-State: AOJu0YxsTUoY1FCXrrsiOATRw9Cnf4W4QNtt4XADJ1u7BrXJB9moMvdk
 k5/evJSpfT4b0ZgdtvZcJniEV+cp/jrJ12T0bwro955Dog5UJJJry0YYYOSwhq53BFF5c5xTFMy
 1WZOl7ZwsBYz8K+ve6tBZEK4zUgNffumccRGsRhC8UA==
X-Received: by 2002:a2e:b053:0:b0:2b9:6810:b333 with SMTP id
 d19-20020a2eb053000000b002b96810b333mr6891278ljl.14.1692714544834; 
 Tue, 22 Aug 2023 07:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHbtdV1Z2oYexwVe8mpbyzXTeUz0WQ5wiHT8u+gk/LvXpSBjPcLrFisAk3pJfWzuqTvvZdCw==
X-Received: by 2002:a2e:b053:0:b0:2b9:6810:b333 with SMTP id
 d19-20020a2eb053000000b002b96810b333mr6891263ljl.14.1692714544356; 
 Tue, 22 Aug 2023 07:29:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c?
 (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de.
 [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a05600c11cf00b003fe215e4492sm16116605wmi.4.2023.08.22.07.29.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 07:29:03 -0700 (PDT)
Message-ID: <437ee67b-d3d6-906a-7ee1-d798d3f77643@redhat.com>
Date: Tue, 22 Aug 2023 16:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Daniel Verkamp <dverkamp@chromium.org>
References: <CABVzXAke4LRt4=S4FsFTFf_WPrAhe1dukoLZto6t6R13kgjw0Q@mail.gmail.com>
 <20230822134011.GB727224@fedora>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [virtio-comment] virtio queue numbering and optional queues
In-Reply-To: <20230822134011.GB727224@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Cornelia Huck <cohuck@redhat.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org,
 virtio-comment@lists.oasis-open.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 22.08.23 15:40, Stefan Hajnoczi wrote:
> On Mon, Aug 21, 2023 at 03:18:50PM -0700, Daniel Verkamp wrote:
>> Hello virtio folks,
> 
> Hi Daniel,
> I have CCed those involved in the free page hint and page reporting
> features.
> 
> Stefan
> 
>>
>> I noticed a mismatch between the way the specification defines
>> device-specific virtqueue indexes and the way device and driver
>> implementers have interpreted the specification. As a practical example,
>> consider the traditional memory balloon device [1]. The first two queues
>> (indexes 0 and 1) are available as part of the baseline device, but the
>> rest of the queues are tied to feature bits.
>>
>> Section 5.5.2, "Virtqueues", gives a list that appears to be a mapping from
>> queue index to queue name/function, defining queue index 3 as free_page_vq
>> and index 4 as reporting_vq, and declaring that "free_page_vq only exists
>> if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set" and "reporting_vq only exists if
>> VIRTIO_BALLOON_F_PAGE_REPORTING is set." This wording is a bit vague, but I
>> assume "is set" means "is negotiated" (not just "advertised by the
>> device").

Staring at QEMU: the queues are added when the virtio-balloon device is
*created*. Queues are added based on feature configuration, if they are
part of the device feature set.

That should translate to "is advertised", not "is negotiated".

The queue ordering is as follows:

* inflate queue, baseline device
* deflate queue, baseline device
* driver memory statistics, VIRTIO_BALLOON_F_STATS_VQ
* free page hinting, VIRTIO_BALLOON_F_FREE_PAGE_HINT
* free page reporting, VIRTIO_BALLOON_F_REPORTING

QEMU always supports the first 3, so they use number 0-2. The other two
can be configured for the device.

So the queue indices vary based on actual feature presence.

>> Also presumably "exists" means something like "may only be used
>> by the driver if the feature bit is negotiated" and "should be ignored by
>> the device if the feature bit is not negotiated", although it would be nice
>> to have a proper definition in the spec somewhere.
>>
>> Section 5.5.3, "Feature bits", gives definitions of the feature bits, with
>> similar descriptions of the relationship between the feature bits and
>> virtqueue availability, although the wording is slightly different
>> ("present" rather than "exists"). No dependency between feature bits is
>> defined, so it seems like it should be valid for a device or driver to
>> support or accept one of the higher-numbered features while not supporting
>> a lower-numbered one.

Yes, that's my understanding.

>>
>>
>> Notably, there is no mention of queue index assignments changing based on
>> negotiated features in either of these sections. Hence a reader can only
>> assume that the queue index assignments are fixed (i.e. stats_vq will
>> always be vq index 4 if F_STATS_VQ is negotiated, regardless of any other
>> feature bits).

And that does not seem to be the case. At least QEMU assigns them sequentially,
based on actually configured features for the device.

If I read the kernel code correctly (drivers/virtio/virtio_balloon.c:init_vqs)
it also behaves that way: if the device has a certain feature
"virtio_has_feature", it gets the next index. Otherwise, the next index goes
to another feature:

	/*
	 * Inflateq and deflateq are used unconditionally. The names[]
	 * will be NULL if the related feature is not enabled, which will
	 * cause no allocation for the corresponding virtqueue in find_vqs.
	 */
	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;


	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
	}

	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
	}

	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
		names[VIRTIO_BALLOON_VQ_REPORTING] = "reporting_vq";
		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
	}

	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
			      callbacks, names, NULL);
	if (err)
		return err;

>>
>> Now consider a scenario where VIRTIO_BALLOON_F_STATS_VQ and
>> VIRTIO_BALLOON_F_PAGE_REPORTING are negotiated but
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT is not (perhaps the device supports all of
>> the defined features but the driver only wants to use reporting_vq, not
>> free_page_vq). In this case, what queue index should be used by the driver
>> when enabling reporting_vq? My reading of the specification is that the
>> reporting_vq is always queue index 4, independent of whether
>> VIRTIO_BALLOON_F_STATS_VQ or VIRTIO_BALLOON_F_FREE_PAGE_HINT are
>> negotiated, but this contradicts existing device and driver
>> implementations, which will use queue index 3 (the next one after stats_vq
>> = 2) as reporting_vq in this case.

Then the specification really needs updating :)

>>
>> The qemu virtio-ballon device [2] assigns the next-highest unused queue
>> index when calling virtio_add_queue(), and in the scenario presented above,
>> free_page_vq will not be added since F_STATS_VQ is not negotiated, so
>> reporting_vq will be assigned queue index 3, rather than 4. (Additionally,
>> qemu always adds the stats_vq regardless of negotiated features, but that's
>> irrelevant in this case since we are assuming the STATS_VQ feature is
>> negotiated.)
>>
>> The Linux virtio driver code originally seemed to use the correct (by my
>> reading) indexes, but it was changed to match the layout used by qemu in a
>> 2019 commit ("virtio_pci: use queue idx instead of array idx to set up the
>> vq") [3] - in other words, it will now also expect queue index 3 to be
>> reporting_vq in the scenario laid out above.

Note that at the time of this commit, there was no support for "free page reporting".

         callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
         names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
         callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
         names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
         names[VIRTIO_BALLOON_VQ_STATS] = NULL;
         names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;

         if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
                 names[VIRTIO_BALLOON_VQ_STATS] = "stats";
                 callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
         }

         if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
                 names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
                 callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
         }

And as QEMU always sets VIRTIO_BALLOON_F_STATS_VQ, that one always gets id=2.

Consequently, VIRTIO_BALLOON_F_FREE_PAGE_HINT, if around, gets id=3.

As we didn't support VIRTIO_BALLOON_F_REPORTING, it doesn't matter which id it gets.

But as you note, once we have different implementations and more feature variability,
it's a mess.

A device that implements VIRTIO_BALLOON_F_FREE_PAGE_HINT but not VIRTIO_BALLOON_F_STATS_VQ
might not work correctly with either old or new QEMU.

Maybe it needs to be documented that any device that implements either
VIRTIO_BALLOON_F_FREE_PAGE_HINT or VIRTIO_BALLOON_F_REPORTING *must* also implement
VIRTIO_BALLOON_F_STATS_VQ, so old+new Linux drivers would continue working.

>>
>> I'm not sure how to resolve the mismatch between the specification and
>> actual implementation behavior. The simplest change would probably be to
>> rewrite the specification to drop the explicit queue indexes in section
>> 5.5.2 and add some wording about how queues are numbered based on
>> negotiated feature bits (this would need to be applied to other device

Yes.

>> types that have specified queue indexes as well). However, this would also
>> technically be an incompatible change of the specification. On the other
>> hand, changing the device and driver implementations to match the
>> specification would be even more challenging, since it would be an
>> incompatible change in actual practice, not just a change of the spec to
>> match consensus implementation behavior.

Changing drivers/devices is pretty much impossible.

So we should document the queue assignment better, and maybe the implication
of requiring VIRTIO_BALLOON_F_STATS_VQ when any new features are implemented.

Does that make sense?

>>
>>
>> Perhaps drivers could add a quirk to detect old versions of the qemu device
>> and use the old behavior, while enabling the correct behavior only for
>> other device vendors and newer qemu device revisions, and the qemu device
>> could add an opt-in feature to enable the correct behavior that users would
>> need to enable only when they know they have a sufficiently new driver with
>> the fix.
>>
>>
>> Or maybe there could be a new feature bit that would opt into following the
>> spec-defined queue indexes (VIRTIO_F_VERSION_2?) and some new wording to
>> require devices to use the old behavior when that bit is not negotiated,
>> but that also feels less than ideal to me.
>>
>> Any thoughts on how to proceed with this situation? Is my reading of the
>> specification just wrong?

I think you raised an important point. We should try documenting reality in
the specification.

-- 
Cheers,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
