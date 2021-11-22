Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B842C433F5
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 07:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23B3240209;
	Mon, 22 Nov 2021 07:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Za5nBbiH77jC; Mon, 22 Nov 2021 07:42:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5B2AE401F2;
	Mon, 22 Nov 2021 07:42:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2220AC002E;
	Mon, 22 Nov 2021 07:42:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1139BC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 07:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCE2640154
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 07:42:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NwDzwEsyBzAi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 07:42:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F41F400F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 07:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637566972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/XAbxjcnQGWVtvkYaQ80Gfqu/bCr+6feL1euVa+EhEk=;
 b=AF4uww3W7L+nvbS61pmtsldAJ7xR8JZPL2r10m6b4oWw03GAzt/B5nnC/AV4Zs/4W6gAJi
 DPhXQiiFiNKOYsNGSHWhhaQGu14DjzNS9gcrVII9yc70DA07f+d1wNUgw9fSUXXkhsyUNc
 GSBTz9U2L8wCq89DUv/pHi9mY9Rh3PE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-qfEk5jwnNZGTwv74L5BFRw-1; Mon, 22 Nov 2021 02:42:49 -0500
X-MC-Unique: qfEk5jwnNZGTwv74L5BFRw-1
Received: by mail-ed1-f72.google.com with SMTP id
 n11-20020aa7c68b000000b003e7d68e9874so13986996edq.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 23:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/XAbxjcnQGWVtvkYaQ80Gfqu/bCr+6feL1euVa+EhEk=;
 b=tMBqeLWpkqjZLjHqRBsYqsUlXjNFAGYOIosScw9ZT6bewIipkPQhSGod9JaIW69RjJ
 cOUcy02/0SWDYXoHKyTk1ItuLtRBLG9HeOMH9hEOgBrHCJWmDaKv0i4yjY5gFBblLPx/
 Gj3AZzuMejmL74/2ya9ELzkZzGd0Sd+hUhVzzzMgtwJr3XTkoaW4DNgsyaMRDFSEpUW6
 6Fv3uscwUFjuXl83SDnIUWkYXzdJrymAzT+z1kVEH+zL+/W8AinQVF+qaOFIi2Vhx9Hx
 Nitqjfz26zCm2wudz57SJ9/Hyg/GyfNYUxbbOYVbk4eGBEzUp+jfr9gfp7tyXmvIN/Gy
 XgGQ==
X-Gm-Message-State: AOAM530tNh0HhTtp8IiI2YsQlxM+d8izIodUSNUxgNJHmNyiTZQyW3EA
 rV/4YcL7R7K2X6cSl33zjwEE7plaNo5vuMsgLjA8XEsYa/enX9sO4c6RS4DTFYaOFxWV6Ru45/O
 o9iC84nIa9v9CdheA95wmaSTGTW9Nx5uhY/nxV9fCGw==
X-Received: by 2002:a17:906:ad89:: with SMTP id
 la9mr37000370ejb.178.1637566968364; 
 Sun, 21 Nov 2021 23:42:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTJqGs1B8o8V6KFilAJwvYHxoBKa2JlfENlQuYYQh/xLzQNbXGuOX/XyoPnu/ayfDrCqXk+g==
X-Received: by 2002:a17:906:ad89:: with SMTP id
 la9mr37000350ejb.178.1637566968195; 
 Sun, 21 Nov 2021 23:42:48 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id w24sm3273814ejk.0.2021.11.21.23.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Nov 2021 23:42:47 -0800 (PST)
Date: Mon, 22 Nov 2021 08:42:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211122074245.d75nqk5quyaopfpt@steredhat>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, Nov 22, 2021 at 11:51:09AM +0800, Jason Wang wrote:
>On Fri, Nov 19, 2021 at 11:10 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>> On Wed, 27 Oct 2021 10:21:04 +0800
>> Jason Wang <jasowang@redhat.com> wrote:
>>
>> > This patch validate the used buffer length provided by the device
>> > before trying to use it. This is done by record the in buffer length
>> > in a new field in desc_state structure during virtqueue_add(), then we
>> > can fail the virtqueue_get_buf() when we find the device is trying to
>> > give us a used buffer length which is greater than the in buffer
>> > length.
>> >
>> > Since some drivers have already done the validation by themselves,
>> > this patch tries to makes the core validation optional. For the driver
>> > that doesn't want the validation, it can set the
>> > suppress_used_validation to be true (which could be overridden by
>> > force_used_validation module parameter). To be more efficient, a
>> > dedicate array is used for storing the validate used length, this
>> > helps to eliminate the cache stress if validation is done by the
>> > driver.
>> >
>> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>>
>> Hi Jason!
>>
>> Our CI has detected, that virtio-vsock became unusable with this
>> patch on s390x. I didn't test on x86 yet. The guest kernel says
>> something like:
>> vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0
>>
>> Did you, or anybody else, see something like this on platforms other that
>> s390x?
>
>Adding Stefan and Stefano.
>
>I think it should be a common issue, looking at

Yep, I confirm the same behaviour on x86_64. On Friday evening I had the 
same failure while testing latest QEMU and Linux kernel.

>vhost_vsock_handle_tx_kick(), it did:
>
>len += sizeof(pkt->hdr);
>vhost_add_used(vq, head, len);
>
>which looks like a violation of the spec since it's TX.
>
>>
>> I had a quick look at this code, and I speculate that it probably
>> uncovers a pre-existig bug, rather than introducing a new one.
>
>I agree.
>
>>
>> If somebody is already working on this please reach out to me.
>

My plan was to debug and test it today, so let me know if you need some 
help.

>AFAIK, no. I think the plan is to fix both the device and drive side
>(but I'm not sure we need a new feature for this if we stick to the
>validation).
>

Yes, maybe we need a new feature, since I believe there has been this 
problem since the beginning.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
