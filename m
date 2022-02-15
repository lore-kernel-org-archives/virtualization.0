Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928C1C433EF
	for <virtualization@archiver.kernel.org>; Tue, 15 Feb 2022 11:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AFB582F19;
	Tue, 15 Feb 2022 11:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06oeF9qTcykA; Tue, 15 Feb 2022 11:42:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2B9DE82EB6;
	Tue, 15 Feb 2022 11:42:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1233C0011;
	Tue, 15 Feb 2022 11:42:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0503DC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 11:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01CF660BAE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 11:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vNjgaXrBgs3s
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 11:42:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57F2060E94
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 11:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644925353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjnbuWeKFhqOoYjM7TShoqpYbBMxPZgJhbxy0whFK08=;
 b=AkxPJD/hOC1orf8ZuU0KbtVeh6fhKMslkhixRr4oKRaijNRu8o7IoaRloTHMahghlnthPN
 a4yTKNSetfGr/FcvtetIzcU34yRuhROuf7N8qe1M2ktj5CL8bqbseaevfNLODpTQObmAUG
 n2v1QpEmzy0ye3WXNhpMHyaPZ7wi7eg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-k-N68IwVPrypPTQ5nzop5w-1; Tue, 15 Feb 2022 06:42:28 -0500
X-MC-Unique: k-N68IwVPrypPTQ5nzop5w-1
Received: by mail-wm1-f71.google.com with SMTP id
 l9-20020a05600c1d0900b0037be9e5f7e8so1967226wms.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 03:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=PjnbuWeKFhqOoYjM7TShoqpYbBMxPZgJhbxy0whFK08=;
 b=J95Jpn7PWMZaIRQAIbDkQYtaUHn46IGxTQVCoEo1b6bZsurbzSsmV47CCu/VwaKOkv
 PhmBbWPcDjIjwu4P2kIFdBTzhZa3F0YIW4YE3MbVWLCBDHfoe9c5N32BCMU43mYwKi+I
 EzVuqmFiO5lL/LcAGYkVK/rH+0B1ceL9vT0nJ1s37VXIckUKvaSuXy6v3u/RTiDcHK35
 275cEAnJw2tvmrFVW7bB9n8rqqJEKkRSWZNmvXFj5a0mh60FQEteCOG7PyREzmAyjWyB
 cgv8QJMlvz80BeMBSCapf57G7GmtGClHuy7vDR29w84028YDchU0lNfdocz0+U1l7h1V
 m6Gw==
X-Gm-Message-State: AOAM531o0mHrZ7AUAO/5oTCFHZWuq9ggaQ/qW5C71QHYCqwJaz7MDSVp
 dR1uSf6UnMlCCrXGJkgal4VH6M1Zbpl0Zvd+C1w+v0qrcNGA9/bQtZpRWmFbcWuzAEuP9tvX/DU
 vCP9auKpfPU7zDZT3A9gTZW+ohM0oRuc10i1aagnolA==
X-Received: by 2002:a7b:ca56:0:b0:37c:321e:9947 with SMTP id
 m22-20020a7bca56000000b0037c321e9947mr2752182wml.14.1644925347642; 
 Tue, 15 Feb 2022 03:42:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoBwAwhuNEUS135wctuAV6IRl4SdvK7l5cFBUZJc6WBHpZGx/EhPB4rfRNzOYOBK5c9+C7kA==
X-Received: by 2002:a7b:ca56:0:b0:37c:321e:9947 with SMTP id
 m22-20020a7bca56000000b0037c321e9947mr2752161wml.14.1644925347419; 
 Tue, 15 Feb 2022 03:42:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:3700:9260:2fb2:742d:da3e?
 (p200300cbc70e370092602fb2742dda3e.dip0.t-ipconnect.de.
 [2003:cb:c70e:3700:9260:2fb2:742d:da3e])
 by smtp.gmail.com with ESMTPSA id j10sm9472254wmq.20.2022.02.15.03.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 03:42:27 -0800 (PST)
Message-ID: <e85b6271-5510-959b-efdc-7ba318f114bc@redhat.com>
Date: Tue, 15 Feb 2022 12:42:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
To: Kameron Lutes <kalutes@google.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org
References: <20220214195908.4070138-1-kalutes@google.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] Virtio-balloon: add user space API for sizing
In-Reply-To: <20220214195908.4070138-1-kalutes@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Charles William Dick <cwd@google.com>,
 Suleiman Souhlal <suleiman@chromium.org>,
 David Stevens <stevensd@chromium.org>
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

On 14.02.22 20:59, Kameron Lutes wrote:
> This new linux API will allow user space applications to directly
> control the size of the virtio-balloon. This is useful in
> situations where the guest must quickly respond to drastically
> increased memory pressure and cannot wait for the host to adjust
> the balloon's size.
> 
> Under the current wording of the Virtio spec, guest driven
> behavior such as this is permitted:
> 
> VIRTIO Version 1.1 Section 5.5.6
> "The device is driven either by the receipt of a configuration
> change notification, or by changing guest memory needs, such as
> performing memory compaction or responding to out of memory
> conditions."

Not quite. num_pages is determined by the hypervisor only and the guest
is not expected to change it, and if it does, it's ignored.

5.5.6 does not indicate at all that the guest may change it or that it
would have any effect. num_pages is examined only, actual is updated by
the driver.

5.5.6.1 documents what's allowed, e.g.,

  The driver SHOULD supply pages to the balloon when num_pages is
  greater than the actual number of pages in the balloon.

  The driver MAY use pages from the balloon when num_pages is less than
  the actual number of pages in the balloon.

and special handling for VIRTIO_BALLOON_F_DEFLATE_ON_OOM.

Especially, we have

  The driver MUST update actual after changing the number of pages in
  the balloon.

  The driver MAY update actual once after multiple inflate and deflate
  operations.

That's also why QEMU never syncs back the num_pages value from the guest
when writing the config.


Current spec does not allow for what you propose.


> 
> The intended use case for this API is one where the host
> communicates a deflation limit to the guest. The guest may then
> choose to respond to memory pressure by deflating its balloon down
> to the guest's allowable limit.

It would be good to have a full proposal and a proper spec update. I'd
assume you'd want separate values for soft vs. hard num_values -- if
that's what we really want.

BUT

There seems to be recent interest in handling memory pressure in a
better way (although how to really detect "serious memory pressure" vs
"ordinary reclaim" in Linux is still to be figured out). There is
already a discussion going on how that could happen. Adding random user
space toggles might not be the best idea. We might want a single
mechanism to achieve that.

https://lists.oasis-open.org/archives/virtio-comment/202201/msg00139.html

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
