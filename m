Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C9AC4332F
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 11:52:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E8D61056
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 11:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0E8D61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DBAA40301;
	Tue, 14 Sep 2021 11:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CCq_Z16uGmoq; Tue, 14 Sep 2021 11:52:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 376564032D;
	Tue, 14 Sep 2021 11:52:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2698C0011;
	Tue, 14 Sep 2021 11:52:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C675C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06B03400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:52:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 62R74gVmK0TV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:52:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92C0C400DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631620340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qBY2XNwXX1MA9VLSXKiCQE1n4LcmSBqUdBbPiBpddUA=;
 b=HfZ/XgMhjIa8+zSl/oevZasKQs1OcW4rpNysMpLGvT39tT5hpJfvV5pYUvfdND0W9DA229
 BUi8ZkkDynu4IVCUMpM6VCpOXPor6SpGk6cOCNXazL3qwmDSqgAnKZaQYdCziMkDXZDkWn
 rm8Car2i2ISfbwfeOe90uhUTnfKJR6Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-yFYxOJv3MW-z8NLcXnCG8A-1; Tue, 14 Sep 2021 07:52:19 -0400
X-MC-Unique: yFYxOJv3MW-z8NLcXnCG8A-1
Received: by mail-wr1-f69.google.com with SMTP id
 m1-20020a056000180100b0015e1ec30ac3so576292wrh.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 04:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qBY2XNwXX1MA9VLSXKiCQE1n4LcmSBqUdBbPiBpddUA=;
 b=Byj9bMMaxrJoseWmIizpGExFdndiO6tGb5Zi3YNdGpjKPg0PgGsH/xCfzUCVqTvo9Q
 fJ2LhTKBbx4CVtyn7jgiF5c1cYu9DyvnOwq+Q3Hs0ahfy5YdyOjXQGXSjYQZHQBtvayT
 dGGB2GnvqourelwT4Bz/SVCKnd/s105NYnkEFDL5aYIn+kj/1vObQhniHFTi4SFBSHJ+
 7NXq5xqlU2I9kkfIqhKQ4gDzmMg7KpsfS7Hpw/FRBOgJhwGUVrnWKow+f/svfvqi8xGp
 caW3XBsW3GGW6skNUadAf4JqBhIo9G2SXP+0HF0CrqFxq14aZAAoAoTZMC2I4AAqLJRS
 p3gA==
X-Gm-Message-State: AOAM531JoNWGhMiLdrCBWp1Aa6IADunIQUFtNFS8FGhVVGJzZNMqUkVP
 0Xbji03fnpaer+BqVeJ9+GsBNBklFug2e56jGuheGqSg6lAgk6bBS1fzG89EBz8y4+IwxLMTTob
 BdwGGFBIHU4uJwLlS6gIdSkqFZ5qwnXKvRiH4wjW7kw==
X-Received: by 2002:a05:600c:a05:: with SMTP id
 z5mr1723609wmp.73.1631620338108; 
 Tue, 14 Sep 2021 04:52:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiYlZHtMLRjzoVegHvs1Jq46SZ36SDV0xzz4EafT+Ga/oyoJS+AncArM4zwCppyvnbWFnkYg==
X-Received: by 2002:a05:600c:a05:: with SMTP id
 z5mr1723592wmp.73.1631620337926; 
 Tue, 14 Sep 2021 04:52:17 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
 by smtp.gmail.com with ESMTPSA id l21sm922488wmh.31.2021.09.14.04.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 04:52:17 -0700 (PDT)
Date: Tue, 14 Sep 2021 07:52:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 3/3] virtio-mem: disallow mapping virtio-mem memory
 via /dev/mem
Message-ID: <20210914075046-mutt-send-email-mst@kernel.org>
References: <20210902160919.25683-1-david@redhat.com>
 <20210902160919.25683-4-david@redhat.com>
 <20210903025630-mutt-send-email-mst@kernel.org>
 <e5344ed1-6aaf-9e0a-a32d-f7cf69fe5a34@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e5344ed1-6aaf-9e0a-a32d-f7cf69fe5a34@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
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

On Tue, Sep 14, 2021 at 11:45:25AM +0200, David Hildenbrand wrote:
> On 03.09.21 09:02, Michael S. Tsirkin wrote:
> > On Thu, Sep 02, 2021 at 06:09:19PM +0200, David Hildenbrand wrote:
> > > We don't want user space to be able to map virtio-mem device memory
> > > directly (e.g., via /dev/mem) in order to have guarantees that in a sane
> > > setup we'll never accidentially access unplugged memory within the
> > > device-managed region of a virtio-mem device, just as required by the
> > > virtio-spec.
> > > 
> > > As soon as the virtio-mem driver is loaded, the device region is visible
> > > in /proc/iomem via the parent device region. From that point on user space
> > > is aware of the device region and we want to disallow mapping anything
> > > inside that region (where we will dynamically (un)plug memory) until
> > > the driver has been unloaded cleanly and e.g., another driver might take
> > > over.
> > > 
> > > By creating our parent IORESOURCE_SYSTEM_RAM resource with
> > > IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
> > > device region until the driver was unloaded cleanly and removed the
> > > parent region. This will work even though only some memory blocks are
> > > actually currently added to Linux and appear as busy in the resource tree.
> > > 
> > > So access to the region from user space is only possible
> > > a) if we don't load the virtio-mem driver.
> > > b) after unloading the virtio-mem driver cleanly.
> > > 
> > > Don't build virtio-mem if access to /dev/mem cannot be restricticted --
> > > if we have CONFIG_DEVMEM=y but CONFIG_STRICT_DEVMEM is not set.
> > > 
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > 
> > > ---
> > >   drivers/virtio/Kconfig      | 1 +
> > >   drivers/virtio/virtio_mem.c | 4 +++-
> > >   2 files changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > index ce1b3f6ec325..ff80cd03f1d1 100644
> > > --- a/drivers/virtio/Kconfig
> > > +++ b/drivers/virtio/Kconfig
> > > @@ -101,6 +101,7 @@ config VIRTIO_MEM
> > >   	depends on MEMORY_HOTPLUG_SPARSE
> > >   	depends on MEMORY_HOTREMOVE
> > >   	depends on CONTIG_ALLOC
> > > +	depends on !DEVMEM || STRICT_DEVMEM
> > >   	help
> > >   	 This driver provides access to virtio-mem paravirtualized memory
> > >   	 devices, allowing to hotplug and hotunplug memory.
> > 
> > It would be nicer if there was a symbol in the MEMORY_ namespace
> > we can depend on exported by mm and depending on !DEVMEM ||
> > STRICT_DEVMEM.
> > 
> > E.g.
> > 
> > config MEMORY_EXCLUSIVE
> >          def_bool y
> >          depends on !DEVMEM || STRICT_DEVMEM
> > 
> > and then in virtio
> > 	depends on MEMORY_EXCLUSIVE
> > 
> > 
> 
> Yes, but I'm not able to come up with an expressive name. MEMORY_EXCLUSIVE
> can be highly misleading ...


I mean ... it enables IORESOURCE_EXCLUSIVE ... but ok ...
MEMORY_EXCLUSIVE_KERNEL_MAP ?

> 
> > the virtio change itself is ok though:
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Thanks!
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
