Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B28FC433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 15:59:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A5423433
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 15:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A5423433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF2C586BA1;
	Wed,  9 Dec 2020 15:59:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZTYSlUXIYG3g; Wed,  9 Dec 2020 15:59:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7959286A5C;
	Wed,  9 Dec 2020 15:59:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65221C0893;
	Wed,  9 Dec 2020 15:59:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F242C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 15:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4BA6B204B0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 15:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HVwSBKdPam5i
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 15:59:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id CFBDD2038A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607529539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ic2nkwK79IxKpdpalLsRrJg/MhQzoe7h4ISxUOffPrw=;
 b=LexNIPvhcrQfd9KLxruHiBLIQ05YK0lgHm1RL1c+oQvO5/5eRpUNqIF/8WlxxkUwB6+2SG
 qMX9BQpN1F0NJSCvG28Kg8U+vhWUM8pjBRLgommTKDY+xk3/lCQhWyGz/ZTS86yANjL2im
 X40FTWK/wwgtF4vZsTHC/cUvk6b3hT8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-_4Z3SJ3rPNK3GWROnEXI0w-1; Wed, 09 Dec 2020 10:58:57 -0500
X-MC-Unique: _4Z3SJ3rPNK3GWROnEXI0w-1
Received: by mail-wm1-f71.google.com with SMTP id f12so727371wmf.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Dec 2020 07:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=YEJSbJgiaDtb+7xVfW+bk1IzQ6Qu9Ts+yErRDxVgSNc=;
 b=XKXzi2q7F1i8eX5jF4G3eDljj7sxZqjbsZPk3pf9+uPgBUvvnJe2BBrU81QtwJ0lse
 Svxa6qIkgcUemHICazyehns9opPhMEjf2fhVNzk5sjktcfelAA3cXmLduul0TUfoa23p
 YAwnZusjLRTNmoBC/H6FQoRKhkA2b7XMtaAqelzOqxxHAa7cpg7Br03Wp5PbipHWc9Bu
 eODsMm+M/zQNwb+8dg2binMX3tt3VrRMPVjwP3kU1kIaGmH4/Ns6eiTNQJodE47KEJHP
 ddt6Bb1Lr1F1YTjw/uEpxlPQm/A1ZFKBQ7zWIbFKf9Cua/emcjASLlxDxkLFomjQFCao
 YEvg==
X-Gm-Message-State: AOAM5307TqMyn9x8ky+VdlbYE+o/F3/qhDXUimLkz/8GbVVSzxyqDCb+
 +4dpQa8kPxZA+sid9iYTzNHBzP6GVFHxwOpXrDPW4pXbnu2TBTxHhBBhWspVH+mg2PAsdNICPUS
 Hi7RgP1vBh1VkA7HxCrBkOxS8B2Af88jSvy5d+1rArw==
X-Received: by 2002:adf:92c2:: with SMTP id 60mr3530081wrn.266.1607529536743; 
 Wed, 09 Dec 2020 07:58:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXPiTjoweiFCd8lPhQbRI1pAc1gIvVHQ/dWn2SnAqjW7JdMQnbm3SW51ntkLYMg4+CVwMjSA==
X-Received: by 2002:adf:92c2:: with SMTP id 60mr3530064wrn.266.1607529536555; 
 Wed, 09 Dec 2020 07:58:56 -0800 (PST)
Received: from steredhat (host-79-24-227-66.retail.telecomitalia.it.
 [79.24.227.66])
 by smtp.gmail.com with ESMTPSA id u66sm4556862wmg.2.2020.12.09.07.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 07:58:55 -0800 (PST)
Date: Wed, 9 Dec 2020 16:58:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [RFC PATCH 0/8] vhost: allow userspace to control vq cpu affinity
Message-ID: <20201209155853.rdzh5a5qyhmzj3lq@steredhat>
References: <1607068593-16932-1-git-send-email-michael.christie@oracle.com>
 <20201204160651.7wlselx4jm6k66mb@steredhat>
 <40b22c4a-f9db-1389-aed1-b3d33678cfda@oracle.com>
 <73defee7-2c9b-7a2b-a532-3c297fc56ca6@oracle.com>
MIME-Version: 1.0
In-Reply-To: <73defee7-2c9b-7a2b-a532-3c297fc56ca6@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Mike,
sorry for the delay but there were holidays.

On Fri, Dec 04, 2020 at 11:33:11AM -0600, Mike Christie wrote:
>On 12/4/20 11:10 AM, Mike Christie wrote:
>>On 12/4/20 10:06 AM, Stefano Garzarella wrote:
>>>Hi Mike,
>>>
>>>On Fri, Dec 04, 2020 at 01:56:25AM -0600, Mike Christie wrote:
>>>>These patches were made over mst's vhost branch.
>>>>
>>>>The following patches, made over mst's vhost branch, allow userspace
>>>>to set each vq's cpu affinity. Currently, with cgroups the worker thread
>>>>inherits the affinity settings, but we are at the mercy of the CPU
>>>>scheduler for where the vq's IO will be executed on. This can result in
>>>>the scheduler sometimes hammering a couple queues on the host instead of
>>>>spreading it out like how the guest's app might have intended if it was
>>>>mq aware.
>>>>
>>>>This version of the patches is not what you guys were talking about
>>>>initially like with the interface that was similar to nbd's old
>>>>(3.x kernel days) NBD_DO_IT ioctl where userspace calls down to the
>>>>kernel and we run from that context. These patches instead just
>>>>allow userspace to tell the kernel which CPU a vq should run on.
>>>>We then use the kernel's workqueue code to handle the thread
>>>>management.
>>>
>>>I agree that reusing kernel's workqueue code would be a good strategy.
>>>
>>>One concern is how easy it is to implement an adaptive polling =

>>>strategy using workqueues. From what I've seen, adding some =

>>>polling of both backend and virtqueue helps to eliminate =

>>>interrupts and reduce latency.
>>>
>>Would the polling you need to do be similar to the vhost net poll =

>>code like in vhost_net_busy_poll (different algorithm though)? But, =

>>we want to be able to poll multiple devs/vqs from the same CPU =

>>right? Something like:
>>
>>retry:
>>
>>for each poller on CPU N
>> =C2=A0=C2=A0=C2=A0=C2=A0if poller has work
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver->run work fn
>>
>>if (poll limit hit)
>> =C2=A0=C2=A0=C2=A0=C2=A0return
>>else
>> =C2=A0=C2=A0=C2=A0=C2=A0cpu_relax();
>>goto retry:
>>
>>?

Yeah, something similar. IIUC vhost_net_busy_poll() polls both vring and =

backend (socket).

Maybe we need to limit the work->fn amount of work to avoid starvation.

>>
>>If so, I had an idea for it. Let me send an additional patch on top =

>>of this set.

Sure :-)

>
>Oh yeah, just to make sure I am on the same page for vdpa, because =

>scsi and net work so differnetly.
>
>Were you thinking that you would initially run from
>
>vhost_poll_wakeup -> work->fn
>
>then in the vdpa work->fn you would do the kick_vq still, but then =

>also kick off a group backend/vq poller. This would then poll the =

>vqs/devs that were bound to that CPU from the worker/wq thread.

Yes, this seams reasonable!

>
>So I was thinking you want something similar to network's NAPI. Here =


I don't know NAPI very well, but IIUC the goal is the same: try to avoid =

notifications (IRQs from the device, vm-exit from the guest) doing an =

adaptive polling.

>our work->fn is the hard irq, and then the worker is like their softirq =

>we poll from.
>

I'm a little lost here...

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
