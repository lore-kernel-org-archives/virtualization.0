Return-Path: <SRS0=Jt+z=NQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D9C4338F
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 17:07:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E06561076
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 17:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E06561076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2357740512;
	Wed, 25 Aug 2021 17:07:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P2tYqBViSw9Q; Wed, 25 Aug 2021 17:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9BA8D40611;
	Wed, 25 Aug 2021 17:07:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E601C001A;
	Wed, 25 Aug 2021 17:07:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16EDEC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 17:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBB9D401BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 17:07:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iy0JT15KXBNc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 17:07:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6F9140105
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 17:07:44 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id 18so270130pfh.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9UW6pSpJ4FLqQ4wBMuO+kq8Bqfp9+2FRMMWJSAkncAI=;
 b=I9y2FdMrrmYyf94isIAJ1/5++twpxEF/rRiEBCII1BWzsHJnYRoj4J7VE0NAm3JrRd
 HZYC/xbPm39a37i+d8l6sLgmTRhu5G5LlK1sPZII33IlQRyvuu6GS1Has8ou6QawOcwp
 rDofaFIRlOHM8MxbvIgoV84p1SC8mN/fFj6OcEhcnECQBx404gZNxvVSuGolzSCYHHna
 34LC/7CRu0SYTVFQmimM8xjMTOJ9K4mqNBCk+k7Xua5TUH0k3mWEcv5Km/r003ZRf2GP
 GlBoPGiXMeNGfSQBDSEPlj1yTudVNpllYYqGkEfTQvpsy/sLQpzuYaDRdgxkZrHtGBz5
 omoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9UW6pSpJ4FLqQ4wBMuO+kq8Bqfp9+2FRMMWJSAkncAI=;
 b=Kt4htyaQ9HNxTNGixnZ0QB/gDYnjgMxIKm49T3McTAKRddnyE3zTXoSKWvTGXEucHy
 rxvBVCmxGXewfqwaSSDDeJAMN61btbh8oA5IDgPM1qLj5Bv/qmrDoQVZ54ip47UOJdbQ
 184V6CaW5Mifej40OdrzdOKTOSuUcMmJJtjAG4I17ZzInfURazhxV9iHOaTMUraq54E8
 bY3qDIu/NFCB5tVvmCx7weYxq5mC9V5wV8bOpRvIBYl3VMh3YNQjbHFrjG/OwtJ1+fQW
 CMNrx4/czSnAixaKrIZjrFlLju6brlncbkpJVr1u7dpzDA9cdOS2WmnlLweSzVPnSgnG
 1WCw==
X-Gm-Message-State: AOAM530rKtV36OVE+EgU7qDEbpcOIogiyzqwE3Op/zaqcYZK4dBJ10eh
 /uvO64z6K43K5A86tRp6ctwRxsHWiifGlMH4PUi7fw==
X-Google-Smtp-Source: ABdhPJwpAUb3DagTRG4rQPoXjjmsHuDpGOzTn60ItEUkm1r3QamAN4U8gPHCNvLoVfY+hbSdObCYXuRqad33dVsk3Wg=
X-Received: by 2002:a65:6642:: with SMTP id z2mr30617563pgv.240.1629911263764; 
 Wed, 25 Aug 2021 10:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210816142505.28359-1-david@redhat.com>
 <20210816142505.28359-2-david@redhat.com>
 <CAPcyv4jfPSanWFNopzShtGiMDjwRuaci2n6hF3FCxsm1cG-ydg@mail.gmail.com>
 <bece6d48-57a3-e7d3-9b26-7faccfbcc7a8@redhat.com>
In-Reply-To: <bece6d48-57a3-e7d3-9b26-7faccfbcc7a8@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 25 Aug 2021 10:07:33 -0700
Message-ID: <CAPcyv4h9ikp3fSaAc132DV=zrG-OJJ9-6ct8KZ3XhMZ-jbAR=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] /dev/mem: disallow access to explicitly excluded
 system RAM regions
To: David Hildenbrand <david@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Aug 25, 2021 at 12:23 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 25.08.21 02:58, Dan Williams wrote:
> > On Mon, Aug 16, 2021 at 7:25 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> virtio-mem dynamically exposes memory inside a device memory region as
> >> system RAM to Linux, coordinating with the hypervisor which parts are
> >> actually "plugged" and consequently usable/accessible. On the one hand, the
> >> virtio-mem driver adds/removes whole memory blocks, creating/removing busy
> >> IORESOURCE_SYSTEM_RAM resources, on the other hand, it logically (un)plugs
> >> memory inside added memory blocks, dynamically either exposing them to
> >> the buddy or hiding them from the buddy and marking them PG_offline.
> >>
> >> virtio-mem wants to make sure that in a sane environment, nobody
> >> "accidentially" accesses unplugged memory inside the device managed
> >> region. After /proc/kcore has been sanitized and /dev/kmem has been
> >> removed, /dev/mem is the remaining interface that still allows uncontrolled
> >> access to the device-managed region of virtio-mem devices from user
> >> space.
> >>
> >> There is no known sane use case for mapping virtio-mem device memory
> >> via /dev/mem while virtio-mem driver concurrently (un)plugs memory inside
> >> that region. So once the driver was loaded and detected the device
> >> along the device-managed region, we just want to disallow any access via
> >> /dev/mem to it.
> >>
> >> Let's add the basic infrastructure to exclude some physical memory
> >> regions completely from /dev/mem access, on any architecture and under
> >> any system configuration (independent of CONFIG_STRICT_DEVMEM and
> >> independent of "iomem=").
> >
> > I'm certainly on team "/dev/mem considered harmful", but this approach
> > feels awkward. It feels wrong for being non-committal about whether
> > CONFIG_STRICT_DEVMEM is in wide enough use that the safety can be
> > turned on all the time, and the configuration option dropped, or there
> > are users clinging onto /dev/mem where they expect to be able to build
> > a debug kernel to turn all of these restrictions off, even the
> > virtio-mem ones. This splits the difference and says some /dev/mem
> > accesses are always disallowed for "reasons", but I could say the same
> > thing about pmem, there's no sane reason to allow /dev/mem which has
> > no idea about the responsibilities of properly touching pmem to get
> > access to it.
>
> For virtio-mem, there is no use case *and* access could be harmful; I
> don't even want to allow if for debugging purposes. If you want to
> inspect virtio-mem device memory content, use /proc/kcore, which
> performs proper synchronized access checks. Modifying random virtio-mem
> memory via /dev/mem in a debug kernel will not be possible: if you
> really have to play with fire, use kdb or better don't load the
> virtio-mem driver during boot, such that the kernel won't even be making
> use of device memory.
>
> I don't want people disabling CONFIG_STRICT_DEVMEM, or booting with
> "iomem=relaxed", and "accidentally" accessing any of virtio-mem memory
> via /dev/mem, while it gets concurrently plugged/unplugged by the
> virtio-mem driver. Not even for debugging purposes.

That sounds more an argument that all of the existing "kernel is using
this region" cases should become mandatory exclusions. If unloading
the driver removes the exclusion then that's precisely
CONFIG_IO_STRICT_DEVMEM. Why is the virtio-mem driver more special
than any other driver that expects this integrity guarantee?

> We disallow mapping to some other regions independent of
> CONFIG_STRICT_DEVMEM already, so the idea to ignore CONFIG_STRICT_DEVMEM
> is not completely new:
>
> "Note that with PAT support enabled, even in this case there are
> restrictions on /dev/mem use due to the cache aliasing requirements."
>
> Maybe you even want to do something similar with PMEM now that there is
> infrastructure for it and just avoid having to deal with revoking
> /dev/mem mappings later.

That would be like blocking writes to /dev/sda just because a
filesytem might later be mounted on it. If the /dev/mem access is not
actively colliding with other kernel operations what business does the
kernel have saying no?

I'm pushing on this topic because I am also considering an exclusion
on PCI configuration access to the "DOE mailbox" since it can disrupt
the kernel's operation, at the same time, root can go change PCI BARs
to nonsensical values whenever it wants which is also in the category
of "has no use case && could be harmful".

> I think there are weird debugging/educational setups [1] that still
> require CONFIG_STRICT_DEVMEM=n even with iomem=relaxed. Take a look at
> lib/devmem_is_allowed.c:devmem_is_allowed(), it disallows any access to
> (what's currently added as) System RAM. It might just do what people
> want when dealing with system RAM that doesn't suddenly vanish , so I
> don't ultimately see why we should remove CONFIG_STRICT_DEVMEM=n.

Yes, I wanted to tease out more of your rationale on where the line
should be drawn, I think a mostly unfettered /dev/mem mode is here to
stay.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
