Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0259C433FE
	for <virtualization@archiver.kernel.org>; Wed, 19 Oct 2022 10:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 380BC81317;
	Wed, 19 Oct 2022 10:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 380BC81317
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BIopzC1/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NCiQMzAgq06F; Wed, 19 Oct 2022 10:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 688E28132C;
	Wed, 19 Oct 2022 10:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 688E28132C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39AC1C0033;
	Wed, 19 Oct 2022 10:53:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A7F6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 10:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2214B60608
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 10:53:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2214B60608
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=BIopzC1/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gsq3BCedtZY3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 10:53:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E965660C17
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E965660C17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 10:53:51 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id a6so21636274ljq.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 03:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SLJhYMtLXgKI7Y17ZUIiMFD3J1dSMKzi0bGsbw5e7go=;
 b=BIopzC1/zEhmwdduNBVA6swDAiJ/PaY8ch4dJ2rG5XuPIEphc4HpFIwENy/oXgcF77
 g26f5vpGaEszcK++cCcUTKXnXewQJhMolM/QKzyYXNbX9xSmjD/h8CuNjZnIiz7Pow8u
 9oViyTjYtEDviMMGlKH85v/Ws+BdAJzTCaIXgEvN2cQC8OYtO73LOuvgzZLgMf+F+rIG
 mtckB/MCVPgD2rV3KUTEV82YQSZME3UNkpjhzr5nvBMLdEHKNnoKLk44gbindiuqP3++
 9IOegW4jhF+LV2Vq5vqvc4+NLv43nVgJjixrVLu9Nl+mWgLbiiG+y5EemQvr99KzMTYQ
 tpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SLJhYMtLXgKI7Y17ZUIiMFD3J1dSMKzi0bGsbw5e7go=;
 b=wCjkqLGl6C5BDrZh3DknN+PNFpJ0wni/1DFeZ2bhZ3XRi1s6he9Ue1x3mhg3/jFdZ9
 3ZImIWgM0tjmEhJnd/C+FRFJUzlAFINZrbiXbnyevFcV2HNuDSCF7FtRvmutnLMoLDeD
 EWqsnQR8cd1YpLPBXQIYy2tTvUXtuZdoqfRfxBv+rJxDv2oLDWhQgJemZx3h/kbcjxv4
 xoudff9mylGh9F9dJsv14eQZZwYxg5WzqWF/Qi8T7SvS4B2359JcfV2c9aWSm85N2SAj
 YSTfceLisVZlK4MND4dCWGgvtVuOMXiEhA/WEmIdvtXK/ntprqrIhzLM8hbkytL4hpIF
 LHDQ==
X-Gm-Message-State: ACrzQf2rCzGvNkAb/9VxPNrl+O7EAB62A+SiNCuMjSn9fvT7M1AKNFcC
 ozRUE9Ym2n9eS6cWkksL/SvaGbj9/qAe+cpF3I4=
X-Google-Smtp-Source: AMsMyM56LTTzTKGc4F++LzICGIh8ple7Tae6Xn81CIYsoHyoaHlCwHgx+9D2SKe1qtnypzSnzS56crQyLn1GyeQTpJg=
X-Received: by 2002:a05:651c:194c:b0:26f:ec78:6172 with SMTP id
 bs12-20020a05651c194c00b0026fec786172mr2697844ljb.479.1666176829774; Wed, 19
 Oct 2022 03:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
In-Reply-To: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Wed, 19 Oct 2022 13:53:38 +0300
Message-ID: <CALYGNiONv3au6hbAva60jWurwkU5ancWo-o2v7tpSzwguqzD9g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] Make balloon drivers' memory changes known to
 the rest of the kernel
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc: Juergen Gross <jgross@suse.com>, Wei Liu <wei.liu@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, kernel test robot <lkp@intel.com>,
 pv-drivers@vmware.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nadav Amit <namit@vmware.com>, xen-devel@lists.xenproject.org,
 kernel@openvz.org, Haiyang Zhang <haiyangz@microsoft.com>
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
Content-Type: multipart/mixed; boundary="===============5090453877032760494=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5090453877032760494==
Content-Type: multipart/alternative; boundary="00000000000012626105eb6106d0"

--00000000000012626105eb6106d0
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Oct 2022 at 12:57, Alexander Atanasov <
alexander.atanasov@virtuozzo.com> wrote:

> Currently balloon drivers (Virtio,XEN, HyperV, VMWare, ...)
> inflate and deflate the guest memory size but there is no
> way to know how much the memory size is changed by them.
>
> Make it possible for the drivers to report the values to mm core.
>
> Display reported InflatedTotal and InflatedFree in /proc/meminfo
> and print these values on OOM and sysrq from show_mem().
>
> The two values are the result of the two modes the drivers work
> with using adjust_managed_page_count or without.
>
> In earlier versions, there was a notifier for these changes
> but after discussion - it is better to implement it in separate
> patch series. Since it came out as larger work than initially expected.
>
> Amount of inflated memory can be used:
>  - totalram_pages() users working with drivers not using
>     adjust_managed_page_count
>  - si_meminfo(..) users can improve calculations
>  - by userspace software that monitors memory pressure
>

Sorry, I see no reason for that series.
Balloon inflation adjusts totalram_pages. That's enough.

There is no reason to know the amount of non-existent ballooned memory
inside.
Management software which works outside should care about that.

For debugging you could get current balloon size from /proc/vmstat
(balloon_inflate - balloon_deflate).
Also (I guess) /proc/kpageflags has a bit for that.

Anyway it's easy to monitor balloon inflation by seeing changes of total
memory size.


>
> Alexander Atanasov (8):
>   mm: Make a place for a common balloon code
>   mm: Enable balloon drivers to report inflated memory
>   mm: Display inflated memory to users
>   mm: Display inflated memory in logs
>   drivers: virtio: balloon - report inflated memory
>   drivers: vmware: balloon - report inflated memory
>   drivers: hyperv: balloon - report inflated memory
>   documentation: create a document about how balloon drivers operate
>
>  Documentation/filesystems/proc.rst            |   6 +
>  Documentation/mm/balloon.rst                  | 138 ++++++++++++++++++
>  MAINTAINERS                                   |   4 +-
>  arch/powerpc/platforms/pseries/cmm.c          |   2 +-
>  drivers/hv/hv_balloon.c                       |  12 ++
>  drivers/misc/vmw_balloon.c                    |   3 +-
>  drivers/virtio/virtio_balloon.c               |   7 +-
>  fs/proc/meminfo.c                             |  10 ++
>  .../linux/{balloon_compaction.h => balloon.h} |  18 ++-
>  lib/show_mem.c                                |   8 +
>  mm/Makefile                                   |   2 +-
>  mm/{balloon_compaction.c => balloon.c}        |  19 ++-
>  mm/migrate.c                                  |   1 -
>  mm/vmscan.c                                   |   1 -
>  14 files changed, 213 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/mm/balloon.rst
>  rename include/linux/{balloon_compaction.h => balloon.h} (91%)
>  rename mm/{balloon_compaction.c => balloon.c} (94%)
>
> v4->v5:
>  - removed notifier
>  - added documentation
>  - vmware update after op is done , outside of the mutex
> v3->v4:
>  - add support in hyperV and vmware balloon drivers
>  - display balloon memory in show_mem so it is logged on OOM and on sysrq
> v2->v3:
>  - added missed EXPORT_SYMBOLS
> Reported-by: kernel test robot <lkp@intel.com>
>  - instead of balloon_common.h just use balloon.h (yes, naming is hard)
>  - cleaned up balloon.h - remove from files that do not use it and
>    remove externs from function declarations
> v1->v2:
>  - reworked from simple /proc/meminfo addition
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: pv-drivers@vmware.com
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Cc: xen-devel@lists.xenproject.org
>
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> --
> 2.31.1
>
>

--00000000000012626105eb6106d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, 19 Oct 2022 at 12:57, Alexander A=
tanasov &lt;<a href=3D"mailto:alexander.atanasov@virtuozzo.com">alexander.a=
tanasov@virtuozzo.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Currently balloon drivers (=
Virtio,XEN, HyperV, VMWare, ...)<br>
inflate and deflate the guest memory size but there is no<br>
way to know how much the memory size is changed by them.<br>
<br>
Make it possible for the drivers to report the values to mm core.<br>
<br>
Display reported InflatedTotal and InflatedFree in /proc/meminfo<br>
and print these values on OOM and sysrq from show_mem().<br>
<br>
The two values are the result of the two modes the drivers work<br>
with using adjust_managed_page_count or without.<br>
<br>
In earlier versions, there was a notifier for these changes<br>
but after discussion - it is better to implement it in separate<br>
patch series. Since it came out as larger work than initially expected.<br>
<br>
Amount of inflated memory can be used:<br>
=C2=A0- totalram_pages() users working with drivers not using<br>
=C2=A0 =C2=A0 adjust_managed_page_count<br>
=C2=A0- si_meminfo(..) users can improve calculations<br>
=C2=A0- by userspace software that monitors memory pressure<br></blockquote=
><div><br></div><div>Sorry, I see no reason for that series.</div><div>Ball=
oon inflation adjusts totalram_pages. That&#39;s enough.</div><div><br></di=
v><div>There is no reason to know the amount of non-existent ballooned memo=
ry inside.<br></div><div>Management software which works outside should car=
e about that.</div><div><br></div><div>For debugging you could get current=
=C2=A0balloon=C2=A0size from /proc/vmstat (balloon_inflate -=C2=A0balloon_d=
eflate).</div><div>Also (I guess) /proc/kpageflags has a bit for that.</div=
><div><br></div><div>Anyway it&#39;s easy to monitor balloon=C2=A0inflation=
 by seeing changes of total memory size.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
Alexander Atanasov (8):<br>
=C2=A0 mm: Make a place for a common balloon code<br>
=C2=A0 mm: Enable balloon drivers to report inflated memory<br>
=C2=A0 mm: Display inflated memory to users<br>
=C2=A0 mm: Display inflated memory in logs<br>
=C2=A0 drivers: virtio: balloon - report inflated memory<br>
=C2=A0 drivers: vmware: balloon - report inflated memory<br>
=C2=A0 drivers: hyperv: balloon - report inflated memory<br>
=C2=A0 documentation: create a document about how balloon drivers operate<b=
r>
<br>
=C2=A0Documentation/filesystems/proc.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A06 +<br>
=C2=A0Documentation/mm/balloon.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 138 ++++++++++++++++++<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A04 +-<br>
=C2=A0arch/powerpc/platforms/pseries/cmm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/hv/hv_balloon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12 ++<br>
=C2=A0drivers/misc/vmw_balloon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0drivers/virtio/virtio_balloon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +-<br>
=C2=A0fs/proc/meminfo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 ++<br>
=C2=A0.../linux/{balloon_compaction.h =3D&gt; balloon.h} |=C2=A0 18 ++-<br>
=C2=A0lib/show_mem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 +<=
br>
=C2=A0mm/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A02 +-<br>
=C2=A0mm/{balloon_compaction.c =3D&gt; balloon.c}=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 19 ++-<br>
=C2=A0mm/migrate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A01 -<br>
=C2=A0mm/vmscan.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A01 -<br>
=C2=A014 files changed, 213 insertions(+), 18 deletions(-)<br>
=C2=A0create mode 100644 Documentation/mm/balloon.rst<br>
=C2=A0rename include/linux/{balloon_compaction.h =3D&gt; balloon.h} (91%)<b=
r>
=C2=A0rename mm/{balloon_compaction.c =3D&gt; balloon.c} (94%)<br>
<br>
v4-&gt;v5:<br>
=C2=A0- removed notifier<br>
=C2=A0- added documentation<br>
=C2=A0- vmware update after op is done , outside of the mutex<br>
v3-&gt;v4:<br>
=C2=A0- add support in hyperV and vmware balloon drivers<br>
=C2=A0- display balloon memory in show_mem so it is logged on OOM and on sy=
srq<br>
v2-&gt;v3:<br>
=C2=A0- added missed EXPORT_SYMBOLS<br>
Reported-by: kernel test robot &lt;<a href=3D"mailto:lkp@intel.com" target=
=3D"_blank">lkp@intel.com</a>&gt;<br>
=C2=A0- instead of balloon_common.h just use balloon.h (yes, naming is hard=
)<br>
=C2=A0- cleaned up balloon.h - remove from files that do not use it and<br>
=C2=A0 =C2=A0remove externs from function declarations<br>
v1-&gt;v2:<br>
=C2=A0- reworked from simple /proc/meminfo addition<br>
<br>
Cc: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_bla=
nk">mst@redhat.com</a>&gt;<br>
Cc: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_bl=
ank">david@redhat.com</a>&gt;<br>
Cc: Wei Liu &lt;<a href=3D"mailto:wei.liu@kernel.org" target=3D"_blank">wei=
.liu@kernel.org</a>&gt;<br>
Cc: Nadav Amit &lt;<a href=3D"mailto:namit@vmware.com" target=3D"_blank">na=
mit@vmware.com</a>&gt;<br>
Cc: <a href=3D"mailto:pv-drivers@vmware.com" target=3D"_blank">pv-drivers@v=
mware.com</a><br>
Cc: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank"=
>jasowang@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:virtualization@lists.linux-foundation.org" target=3D"=
_blank">virtualization@lists.linux-foundation.org</a><br>
Cc: &quot;K. Y. Srinivasan&quot; &lt;<a href=3D"mailto:kys@microsoft.com" t=
arget=3D"_blank">kys@microsoft.com</a>&gt;<br>
Cc: Haiyang Zhang &lt;<a href=3D"mailto:haiyangz@microsoft.com" target=3D"_=
blank">haiyangz@microsoft.com</a>&gt;<br>
Cc: Stephen Hemminger &lt;<a href=3D"mailto:sthemmin@microsoft.com" target=
=3D"_blank">sthemmin@microsoft.com</a>&gt;<br>
Cc: Dexuan Cui &lt;<a href=3D"mailto:decui@microsoft.com" target=3D"_blank"=
>decui@microsoft.com</a>&gt;<br>
Cc: <a href=3D"mailto:linux-hyperv@vger.kernel.org" target=3D"_blank">linux=
-hyperv@vger.kernel.org</a><br>
Cc: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" target=3D"_blank">=
jgross@suse.com</a>&gt;<br>
Cc: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kernel.org" target=
=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
Cc: Oleksandr Tyshchenko &lt;<a href=3D"mailto:oleksandr_tyshchenko@epam.co=
m" target=3D"_blank">oleksandr_tyshchenko@epam.com</a>&gt;<br>
Cc: <a href=3D"mailto:xen-devel@lists.xenproject.org" target=3D"_blank">xen=
-devel@lists.xenproject.org</a><br>
<br>
base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780<br>
-- <br>
2.31.1<br>
<br>
</blockquote></div></div>

--00000000000012626105eb6106d0--

--===============5090453877032760494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5090453877032760494==--
