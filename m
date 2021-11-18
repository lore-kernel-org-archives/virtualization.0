Return-Path: <SRS0=Mnfs=QF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4825C433F5
	for <virtualization@archiver.kernel.org>; Thu, 18 Nov 2021 11:17:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597B161AD2
	for <virtualization@archiver.kernel.org>; Thu, 18 Nov 2021 11:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 597B161AD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22EC0814B4;
	Thu, 18 Nov 2021 11:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WTUU2eLG6psN; Thu, 18 Nov 2021 11:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9489781066;
	Thu, 18 Nov 2021 11:17:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F443C001E;
	Thu, 18 Nov 2021 11:17:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 240D9C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Nov 2021 11:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E19040367
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Nov 2021 11:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N8Nln4mWO3z1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Nov 2021 11:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA80740366
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Nov 2021 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637234223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KT6c1tJXluW5btxlZn/cO0YpWcPPW+F/zKrmnhCsxh0=;
 b=RWiw8w+f5/r6PfWAucoc5bqoicM3qeFGdBfaDGw5hXmWXRh+Fm018d02caUH8CD0bSWH3+
 Loj5BtAaTLZeCyPqsLxMYaALrth6rSbl95FV67BusCwn1b+u6goCE6ZBSw4W+NsCXBbdID
 8D+TB5hmCW8lZ0NJz9X3ncGUDbAk9vM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-w8U3DdE8ODGykh87MB57yg-1; Thu, 18 Nov 2021 06:17:02 -0500
X-MC-Unique: w8U3DdE8ODGykh87MB57yg-1
Received: by mail-wr1-f71.google.com with SMTP id
 u4-20020a5d4684000000b0017c8c1de97dso986519wrq.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Nov 2021 03:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=KT6c1tJXluW5btxlZn/cO0YpWcPPW+F/zKrmnhCsxh0=;
 b=PMtHYxGPq1Ekvv8LmK0Hf/B8iawt7OQNa6D806ffgSyzCgXEnHZWiCinYpRmDstJwp
 kwWljtw6rR2qqFBdUspFl718JKzHN98B6kp9ntJrN/c8dXpspkKivlhVz5i7m6T6Tr1m
 BV2QPDVYvkvjy6VV8GLmtxeQO4G9eEKvyhsuPNz31hQQ8gI9nWF/b9pmV/WGTS3x+3+Y
 /vmMr36HVG/IMQRUbzKDihc0zGY1EDbAMFlHseYq2Oeb398nBH7o7TEksCa2X5geZTpe
 kPSVHCYP9q5wrHmcVMuFACVocolpBx5WJM7emQMoe1uFcppioVyE7Qn+6SepHQ1ejwub
 4pjg==
X-Gm-Message-State: AOAM5300GNh12nx3yCnhrSM9IngjMEUT4oHpsWHWX1jO/INv/UIimYy5
 GmPtjqHAtXTZm9C+WNPG6foP/THDf/qNNO9UYQHxGRorhtklBiWyo+24yZoRnT+ApvIjFSDmb1g
 23vodAHSoZDPKhHSZwJEgcjtkWQwTzy1/iI+j1bLM7g==
X-Received: by 2002:a5d:65c7:: with SMTP id e7mr29801983wrw.319.1637234221492; 
 Thu, 18 Nov 2021 03:17:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwihzicgomqh1ZJevPG4aRp5RwGlQcjHwAz55lTvvqMBxsEw1So37gpL3p1ZSiwnhdgrIzWAA==
X-Received: by 2002:a5d:65c7:: with SMTP id e7mr29801956wrw.319.1637234221312; 
 Thu, 18 Nov 2021 03:17:01 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62b7.dip0.t-ipconnect.de. [91.12.98.183])
 by smtp.gmail.com with ESMTPSA id
 g198sm2969144wme.23.2021.11.18.03.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Nov 2021 03:17:00 -0800 (PST)
Message-ID: <290e140c-abc1-76b8-e036-5b550b8b99c4@redhat.com>
Date: Thu, 18 Nov 2021 12:17:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] virtio_balloon: add param to skip adjusting pages
To: David Stevens <stevensd@chromium.org>,
 virtualization@lists.linux-foundation.org
References: <20211118091130.3817665-1-stevensd@google.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211118091130.3817665-1-stevensd@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

On 18.11.21 10:11, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>

Hi David,

> 
> Add a module parameters to virtio_balloon to allow specifying whether or
> not the driver should call adjust_managed_page_count. If the parameter
> is set, it overrides the default behavior inferred from the deflate on
> OOM flag. This allows the balloon to operate without changing the amount
> of memory visible to userspace via /proc/meminfo or sysinfo, even on a
> system that cannot set the default on OOM flag.
> 
> The motivation for this patch is to allow userspace to more accurately
> take advantage of virtio_balloon's cooperative memory control on a
> system without the ability to use deflate on OOM. As it stands,
> userspace has no way to know how much memory may be available on such a
> system, which makes tasks such as sizing caches impossible.

But that user space also has no idea "when" that memory will become
available, it could be never. This problem is similar to memory hotplug,
where we don't know "when" more memory might get hotplugged.

With deflate-on-OOM this behavior makes sense, because the guest can use
that memory whenever it wants -- it's actually available as soon as we
need it.

> 
> When deflate on OOM is not enabled, the current behavior of the
> virtio_balloon more or less resembles hotplugging individual pages, at
> least from an accounting perspective. This is basically hardcoding the
> requirement that totalram_pages must be available to the guest
> immediately, regardless of what the host does. While that is a valid
> policy, on Linux (which supports memory overcommit) with virtio_balloon
> (which is designed to facilitate overcommit in the host), it is not the
> only possible policy.
> 
> The param added by this patch allows the guest to operate under the
> assumption that pages in the virtio_balloon will generally be made
> available when needed. This assumption may not always hold, but when it
> is violated, the guest will just fall back to the normal mechanisms for
> dealing with overcommitted memory.
> 
> Independent of what policy the guest wants, the virtio_balloon device
> does not consider pages in the balloon as contributing to the guest's
> total amount of memory if deflate on OOM is not enabled. Ensure that the
> reported stats are consistent with this by adjusting totalram if a
> guest without deflate on OOM is skipping the calls to
> adjust_managed_page_count.

What about simply exposing the number of inflated balloon pages
("logically offline pages") e.g., via /proc/meminfo to user space? It's
then up to smart user space trying to be smart about memory that's not
available right now and might never become available eventually in the
future -- but still that user space wants to optimize for some eventuality.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
