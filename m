Return-Path: <SRS0=Jt+z=NQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83D3C4338F
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 07:23:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744E56128A
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 07:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 744E56128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A722400D9;
	Wed, 25 Aug 2021 07:23:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9fRmoGMNtv2G; Wed, 25 Aug 2021 07:23:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D4816402BE;
	Wed, 25 Aug 2021 07:23:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A693FC0010;
	Wed, 25 Aug 2021 07:23:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBE06C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 07:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97600402BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 07:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mJarizxzaiLF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 07:23:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8D4D400D9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 07:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629876188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7E5N/nJlshM9hA3zETY6iInStLkJCq/cd1o1HlWKF9Y=;
 b=S6tnvbqu2AXWj12KVXDo5SjvVOm96LSH51j9s/yycG024Woerfd8Jx8IoK7XvpxtVkW6mA
 94ItA75Vpa9khCVSlZqJD4F/LPunNHbKWx1AVQpFamgkinBWFsbDcURD+z00pz3y4Icv1L
 zJrapxvw6lwUesMKhSpWaysrtbzSxI8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-2AwlSTV8PgW9CWpHmPvKhA-1; Wed, 25 Aug 2021 03:23:05 -0400
X-MC-Unique: 2AwlSTV8PgW9CWpHmPvKhA-1
Received: by mail-wr1-f71.google.com with SMTP id
 a13-20020adfed0d000000b00156fd70137aso6215166wro.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 00:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7E5N/nJlshM9hA3zETY6iInStLkJCq/cd1o1HlWKF9Y=;
 b=Va3UemUQ5//MD5t13AvkWip3DPpY32OabHCrDI7al1hMGFrzASjT0mt1Fy6YR02rKF
 y8qPWirUuGICwAuamFGoe0lVF7X9LJSJf/rFQlDfSI3XhyOhTqeOjTGQav49/kCX96Xs
 4u9jieHXR5C87dNPHulDWuNX4rrcaqdaKnyJdsW9Q5UA6b2CIJmPrpHuAdDq3mJPofzg
 uT4iJeP9FZIU3OsusDXqiEA36O4mVP0SuaUfrStqvndTy9wwGSX4mLLTbvHLxjZlj17k
 BhPz5Hyo6vxBPPYCjQNVfZ17YDKcWuGupixTHuhH1aTteI6b1fQvBtDGFofMTCfeh80d
 700Q==
X-Gm-Message-State: AOAM53204+Vz77ZaiM+aTVVx7hibVhz9t0H+BVaxwsY/hjkm/HGdz6uN
 BiqknpHNBnB2/8WNNUggnvVVA9ZQpWxzBDMFzEFGwa1k8gMd6EhSj2SrHUO5P7wJHGu/ff6i5Xt
 81l4MSxo+2iod69IIOd7lr3vkq6KnF8K2CvftZEIKWw==
X-Received: by 2002:adf:f403:: with SMTP id g3mr12011601wro.206.1629876184610; 
 Wed, 25 Aug 2021 00:23:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG4aiiyDZwx8VQJaBBxxomNtCUbza9LZ3DxHopkCg74ZqORlsPbhVeFhE2GgmrA26R7Jy9CA==
X-Received: by 2002:adf:f403:: with SMTP id g3mr12011586wro.206.1629876184402; 
 Wed, 25 Aug 2021 00:23:04 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
 by smtp.gmail.com with ESMTPSA id v1sm19763706wrt.93.2021.08.25.00.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Aug 2021 00:23:03 -0700 (PDT)
To: Dan Williams <dan.j.williams@intel.com>
References: <20210816142505.28359-1-david@redhat.com>
 <20210816142505.28359-2-david@redhat.com>
 <CAPcyv4jfPSanWFNopzShtGiMDjwRuaci2n6hF3FCxsm1cG-ydg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] /dev/mem: disallow access to explicitly excluded
 system RAM regions
Message-ID: <bece6d48-57a3-e7d3-9b26-7faccfbcc7a8@redhat.com>
Date: Wed, 25 Aug 2021 09:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jfPSanWFNopzShtGiMDjwRuaci2n6hF3FCxsm1cG-ydg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
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

On 25.08.21 02:58, Dan Williams wrote:
> On Mon, Aug 16, 2021 at 7:25 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> virtio-mem dynamically exposes memory inside a device memory region as
>> system RAM to Linux, coordinating with the hypervisor which parts are
>> actually "plugged" and consequently usable/accessible. On the one hand, the
>> virtio-mem driver adds/removes whole memory blocks, creating/removing busy
>> IORESOURCE_SYSTEM_RAM resources, on the other hand, it logically (un)plugs
>> memory inside added memory blocks, dynamically either exposing them to
>> the buddy or hiding them from the buddy and marking them PG_offline.
>>
>> virtio-mem wants to make sure that in a sane environment, nobody
>> "accidentially" accesses unplugged memory inside the device managed
>> region. After /proc/kcore has been sanitized and /dev/kmem has been
>> removed, /dev/mem is the remaining interface that still allows uncontrolled
>> access to the device-managed region of virtio-mem devices from user
>> space.
>>
>> There is no known sane use case for mapping virtio-mem device memory
>> via /dev/mem while virtio-mem driver concurrently (un)plugs memory inside
>> that region. So once the driver was loaded and detected the device
>> along the device-managed region, we just want to disallow any access via
>> /dev/mem to it.
>>
>> Let's add the basic infrastructure to exclude some physical memory
>> regions completely from /dev/mem access, on any architecture and under
>> any system configuration (independent of CONFIG_STRICT_DEVMEM and
>> independent of "iomem=").
> 
> I'm certainly on team "/dev/mem considered harmful", but this approach
> feels awkward. It feels wrong for being non-committal about whether
> CONFIG_STRICT_DEVMEM is in wide enough use that the safety can be
> turned on all the time, and the configuration option dropped, or there
> are users clinging onto /dev/mem where they expect to be able to build
> a debug kernel to turn all of these restrictions off, even the
> virtio-mem ones. This splits the difference and says some /dev/mem
> accesses are always disallowed for "reasons", but I could say the same
> thing about pmem, there's no sane reason to allow /dev/mem which has
> no idea about the responsibilities of properly touching pmem to get
> access to it.

For virtio-mem, there is no use case *and* access could be harmful; I 
don't even want to allow if for debugging purposes. If you want to 
inspect virtio-mem device memory content, use /proc/kcore, which 
performs proper synchronized access checks. Modifying random virtio-mem 
memory via /dev/mem in a debug kernel will not be possible: if you 
really have to play with fire, use kdb or better don't load the 
virtio-mem driver during boot, such that the kernel won't even be making 
use of device memory.

I don't want people disabling CONFIG_STRICT_DEVMEM, or booting with 
"iomem=relaxed", and "accidentally" accessing any of virtio-mem memory 
via /dev/mem, while it gets concurrently plugged/unplugged by the 
virtio-mem driver. Not even for debugging purposes.

We disallow mapping to some other regions independent of 
CONFIG_STRICT_DEVMEM already, so the idea to ignore CONFIG_STRICT_DEVMEM 
is not completely new:

"Note that with PAT support enabled, even in this case there are 
restrictions on /dev/mem use due to the cache aliasing requirements."

Maybe you even want to do something similar with PMEM now that there is 
infrastructure for it and just avoid having to deal with revoking 
/dev/mem mappings later.


I think there are weird debugging/educational setups [1] that still 
require CONFIG_STRICT_DEVMEM=n even with iomem=relaxed. Take a look at 
lib/devmem_is_allowed.c:devmem_is_allowed(), it disallows any access to 
(what's currently added as) System RAM. It might just do what people 
want when dealing with system RAM that doesn't suddenly vanish , so I 
don't ultimately see why we should remove CONFIG_STRICT_DEVMEM=n.

[1] https://bakhi.github.io/devmem/

Thanks!

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
