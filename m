Return-Path: <SRS0=2EET=LR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15E3C48BC2
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 15:04:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BD0611C1
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 15:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BD0611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DAD04027A;
	Wed, 23 Jun 2021 15:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WZ-rjXb9AEW8; Wed, 23 Jun 2021 15:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5466C40223;
	Wed, 23 Jun 2021 15:04:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34E4AC001A;
	Wed, 23 Jun 2021 15:04:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7632BC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 15:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63DB5607CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 15:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZeGj5bGBUQgT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 15:04:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28B3E6072C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 15:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624460670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1vDPIzbZl0TimwBy+DU+d8PKQSWK0hkz6MynMrqdOA=;
 b=HkidJllNr1hh0cYQTuwK7BVLLGXss64TTINzxJKqWrckRD2X3OPZPe9nlZIiCa3/AMQMmW
 kIXdnx+5DYe/6jHL/zI/4ICvg9UqSLvGO0HzL5qQqns7IcaFFO5CuZYSiIGiOBxDEEDEyN
 SygFKWfHDY7xWUE2JFMIbT4lWSMyUxc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-h9C3TdGnO2etQZZtwnCRVA-1; Wed, 23 Jun 2021 11:04:28 -0400
X-MC-Unique: h9C3TdGnO2etQZZtwnCRVA-1
Received: by mail-wm1-f72.google.com with SMTP id
 f11-20020a05600c154bb02901e0210617aaso1245437wmg.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 08:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=r1vDPIzbZl0TimwBy+DU+d8PKQSWK0hkz6MynMrqdOA=;
 b=Wf5xpVp8Kse2PkRWypDahUPobTLwSXJFlcwcrFS0kpju4rNf0ZUhuvnBUWf81gWJ5z
 63hjRSOy65+t1iRHLMhP485xjGi/5MN8SH37xW3H0N4jpBxjRmHreRSYDIh3g71xPMj9
 T55dtRUg8sFIaM17Nx7FUb+Cr3sWh5EgsCesKXTPhWdvUMmArCqZihRhCzgkPdI7W/5G
 BBFwuspWO6r9wmC8YeJuimxxDN5wRJ+U77w1P0VfMsPN+pvDY2egIRgsVbFqW7z5UW3/
 QwMhV6hxmYBNgeQiDm42K7zgCVCW8BXz9rjO5DBmOWLy4ZwgHFDQ0T3iLs6RkVjCEIdj
 tOZw==
X-Gm-Message-State: AOAM531zJMecR9r0CqyPpklFhStS/4H46wmCO4iY/m5OQhfwPhcKgIuu
 A9nX3x/gq6tRErYNI3IKeHWEwHbJmxObndEnFfJ6H/Q5GIYLo01QKkxt8/7e8MwF9FhoR2M3bOj
 cMA8YEwISW9CXg9vX9Io0rANR/XtQw0Yvi6X731GOJibmlkqfeoXkkcvXZg==
X-Received: by 2002:adf:ea07:: with SMTP id q7mr525555wrm.153.1624460666825;
 Wed, 23 Jun 2021 08:04:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhcgmxbZhRuC823uGo8VLCFC2D2VZneu8pi7pkIpVpY+xuARqnBBG59LN2sG2BtVd6IJBS3r+Sry0Ma52mhfg=
X-Received: by 2002:adf:ea07:: with SMTP id q7mr525519wrm.153.1624460666562;
 Wed, 23 Jun 2021 08:04:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4e08:0:0:0:0:0 with HTTP; Wed, 23 Jun 2021 08:04:26
 -0700 (PDT)
In-Reply-To: <20210623115839.3524-1-teawater@gmail.com>
References: <20210623115839.3524-1-teawater@gmail.com>
From: David Hildenbrand <david@redhat.com>
Date: Wed, 23 Jun 2021 17:04:26 +0200
Message-ID: <CADFyXm7Ky+S2gq5ht2h_tX9bLsoOSuctCkG==VYAH0uUHGp+QQ@mail.gmail.com>
Subject: Re: [RFC] virtio-mem: Add support of memory_hotplug.memmap_on_memory
To: Hui Zhu <teawater@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dhildenb@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Hui Zhu <teawater@antfin.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4356514542467883154=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4356514542467883154==
Content-Type: multipart/alternative; boundary="000000000000fb7af905c570383a"

--000000000000fb7af905c570383a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, June 23, 2021, Hui Zhu <teawater@gmail.com> wrote:

> From: Hui Zhu <teawater@antfin.com>
>
> We did some virtio-mem resize tests in high memory pressure environment.
> Memory increases slowly and sometimes fails in these tests.
> This is a way to reproduce the issue.
> Start a qemu with a small size of memory (132Mb) and resize the
> virtio-mem to hotplug memory.
> Then will get following error:
> [    8.097461] virtio_mem virtio0: requested size: 0x10000000
> [    8.098038] virtio_mem virtio0: plugging memory: 0x100000000 -
> 0x107ffffff
> [    8.098829] virtio_mem virtio0: adding memory: 0x100000000 -
> 0x107ffffff
> [    8.106298] kworker/0:1: vmemmap alloc failure: order:9,
> mode:0x4cc0(GFP_KERNEL|__GFP_RETRY_MAYFAIL),
> nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
> [    8.107609] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 5.13.0-rc7+
> [    8.108295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [    8.109476] Workqueue: events_freezable virtio_mem_run_wq
> [    8.110039] Call Trace:
> [    8.110305]  dump_stack+0x76/0x94
> [    8.110654]  warn_alloc.cold+0x7b/0xdf
> [    8.111054]  ? __alloc_pages+0x2c2/0x310
> [    8.111462]  vmemmap_alloc_block+0x86/0xdc
> [    8.111891]  vmemmap_populate+0xfc/0x325
> [    8.112309]  __populate_section_memmap+0x38/0x4e
> [    8.112787]  sparse_add_section+0x167/0x244
> [    8.113226]  __add_pages+0xa6/0x130
> [    8.113592]  add_pages+0x12/0x60
> [    8.113934]  add_memory_resource+0x114/0x2d0
> [    8.114377]  add_memory_driver_managed+0x7c/0xc0
> [    8.114852]  virtio_mem_add_memory+0x57/0xe0
> [    8.115304]  virtio_mem_sbm_plug_and_add_mb+0x9a/0x130
> [    8.115833]  virtio_mem_run_wq+0x9d5/0x1100
> I think allocating 2 Mb contiguous memory will be slow and failed
> in some cases, especially in high memory pressure environment.
> This commit try to add support of memory_hotplug.memmap_on_memory to
> handle this issue.
>
> Just let SBM mode support it because memory_hotplug.memmap_on_memory
> need a single memory block.



Hi,

I=E2=80=98m on vacation this and next week. I=E2=80=98ll have a closer look=
 when I=E2=80=98m back.

We also want to have this optimization for BBM, initially when a big block
comprises a single memory block. But we can add that separately later.


>
> Add nr_vmemmap_pages and sbs_vmemmap to struct sbm.
> If memory_hotplug.memmap_on_memory is open, pages number of a memory
> block's internal metadata will be store in nr_vmemmap_pages.
> sbs_vmemmap is the number of vmemmap subblocks per Linux memory block.
> The pages in the vmemmap subblocks should bigger than nr_vmemmap_pages
> because sb_size need to span at least MAX_ORDER_NR_PAGES and
> pageblock_nr_pages pages (virtio_mem_init).
> All the pages in vmemmap subblocks is not going to add to the buddy
> even if the pages that are not used to store the internal metadata
> (struct pages) because they should not work reliably with
> alloc_contig_range().



We most certainly want to handle partially consumed subblocks by metadata
and expose that memory to the buddy. alloc_contig_range() will really only
be sub-optimal on ZONE_NORMAL right now when called on pageblock
granularity; so that=E2=80=99s when we can expect memory unplug to be less
reliable, which is the case either way. ZONE_MOVABLE should be just fine I
think.


>
> When resize virtio-mem, sbs_vmemmap is going to count in
> virtio_mem_sbm_plug_and_add_mb, virtio_mem_sbm_unplug_any_sb_offline
> and virtio_mem_sbm_unplug_any_sb_online.
> Because internal metadata also need the real pages in the host to store
> it.  I think resize virtio-mem size same with the actual memory
> footprint
> on the host is better if we want setup a memory cgroup for QEMU.
>
> I did not add special module_param for this function and did not move
> code
> inside CONFIG_MHP_MEMMAP_ON_MEMORY.
> Do I need add them?


There is a single tunable to enable memmap_on_memory, so that should be
sufficient I think.

Thanks!

--000000000000fb7af905c570383a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, June 23, 2021, Hui Zhu &lt;<a href=3D"mailto:teawater=
@gmail.com">teawater@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">From: Hui Zhu &lt;<a href=3D"mailto:teawater@antfin.com">teawater@antf=
in.com</a>&gt;<br>
<br>
We did some virtio-mem resize tests in high memory pressure environment.<br=
>
Memory increases slowly and sometimes fails in these tests.<br>
This is a way to reproduce the issue.<br>
Start a qemu with a small size of memory (132Mb) and resize the<br>
virtio-mem to hotplug memory.<br>
Then will get following error:<br>
[=C2=A0 =C2=A0 8.097461] virtio_mem virtio0: requested size: 0x10000000<br>
[=C2=A0 =C2=A0 8.098038] virtio_mem virtio0: plugging memory: 0x100000000 -=
<br>
0x107ffffff<br>
[=C2=A0 =C2=A0 8.098829] virtio_mem virtio0: adding memory: 0x100000000 -<b=
r>
0x107ffffff<br>
[=C2=A0 =C2=A0 8.106298] kworker/0:1: vmemmap alloc failure: order:9,<br>
mode:0x4cc0(GFP_KERNEL|__GFP_<wbr>RETRY_MAYFAIL),<br>
nodemask=3D(null),cpuset=3D/,mems_<wbr>allowed=3D0<br>
[=C2=A0 =C2=A0 8.107609] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 5.13.=
0-rc7+<br>
[=C2=A0 =C2=A0 8.108295] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96),<br>
BIOS <a href=3D"http://rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org" target=
=3D"_blank">rel-1.14.0-0-g155821a1990b-<wbr>prebuilt.qemu.org</a> 04/01/201=
4<br>
[=C2=A0 =C2=A0 8.109476] Workqueue: events_freezable virtio_mem_run_wq<br>
[=C2=A0 =C2=A0 8.110039] Call Trace:<br>
[=C2=A0 =C2=A0 8.110305]=C2=A0 dump_stack+0x76/0x94<br>
[=C2=A0 =C2=A0 8.110654]=C2=A0 warn_alloc.cold+0x7b/0xdf<br>
[=C2=A0 =C2=A0 8.111054]=C2=A0 ? __alloc_pages+0x2c2/0x310<br>
[=C2=A0 =C2=A0 8.111462]=C2=A0 vmemmap_alloc_block+0x86/0xdc<br>
[=C2=A0 =C2=A0 8.111891]=C2=A0 vmemmap_populate+0xfc/0x325<br>
[=C2=A0 =C2=A0 8.112309]=C2=A0 __populate_section_memmap+<wbr>0x38/0x4e<br>
[=C2=A0 =C2=A0 8.112787]=C2=A0 sparse_add_section+0x167/0x244<br>
[=C2=A0 =C2=A0 8.113226]=C2=A0 __add_pages+0xa6/0x130<br>
[=C2=A0 =C2=A0 8.113592]=C2=A0 add_pages+0x12/0x60<br>
[=C2=A0 =C2=A0 8.113934]=C2=A0 add_memory_resource+0x114/<wbr>0x2d0<br>
[=C2=A0 =C2=A0 8.114377]=C2=A0 add_memory_driver_managed+<wbr>0x7c/0xc0<br>
[=C2=A0 =C2=A0 8.114852]=C2=A0 virtio_mem_add_memory+0x57/<wbr>0xe0<br>
[=C2=A0 =C2=A0 8.115304]=C2=A0 virtio_mem_sbm_plug_and_add_<wbr>mb+0x9a/0x1=
30<br>
[=C2=A0 =C2=A0 8.115833]=C2=A0 virtio_mem_run_wq+0x9d5/0x1100<br>
I think allocating 2 Mb contiguous memory will be slow and failed<br>
in some cases, especially in high memory pressure environment.<br>
This commit try to add support of memory_hotplug.memmap_on_<wbr>memory to<b=
r>
handle this issue.<br>
<br>
Just let SBM mode support it because memory_hotplug.memmap_on_<wbr>memory<b=
r>
need a single memory block.</blockquote><div><br></div><div><br></div><div>=
<div>Hi,</div><div><br></div><div>I=E2=80=98m on vacation this and next wee=
k. I=E2=80=98ll have a closer look when I=E2=80=98m back.</div></div><div><=
br></div><div>We also want to have this optimization for BBM, initially whe=
n a big block comprises a single memory block. But we can add that separate=
ly later.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Add nr_vmemmap_pages and sbs_vmemmap to struct sbm.<br>
If memory_hotplug.memmap_on_<wbr>memory is open, pages number of a memory<b=
r>
block&#39;s internal metadata will be store in nr_vmemmap_pages.<br>
sbs_vmemmap is the number of vmemmap subblocks per Linux memory block.<br>
The pages in the vmemmap subblocks should bigger than nr_vmemmap_pages<br>
because sb_size need to span at least MAX_ORDER_NR_PAGES and<br>
pageblock_nr_pages pages (virtio_mem_init).<br>
All the pages in vmemmap subblocks is not going to add to the buddy<br>
even if the pages that are not used to store the internal metadata<br>
(struct pages) because they should not work reliably with<br>
alloc_contig_range().</blockquote><div><br></div><div><br></div><div>We mos=
t certainly want to handle partially consumed subblocks by metadata and exp=
ose that memory to the buddy. alloc_contig_range() will really only be sub-=
optimal on ZONE_NORMAL right now when called on pageblock granularity; so t=
hat=E2=80=99s when we can expect memory unplug to be less reliable, which i=
s the case either way. ZONE_MOVABLE should be just fine I think.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
When resize virtio-mem, sbs_vmemmap is going to count in<br>
virtio_mem_sbm_plug_and_add_<wbr>mb, virtio_mem_sbm_unplug_any_sb_<wbr>offl=
ine<br>
and virtio_mem_sbm_unplug_any_sb_<wbr>online.<br>
Because internal metadata also need the real pages in the host to store<br>
it.=C2=A0 I think resize virtio-mem size same with the actual memory<br>
footprint<br>
on the host is better if we want setup a memory cgroup for QEMU.<br>
<br>
I did not add special module_param for this function and did not move<br>
code<br>
inside CONFIG_MHP_MEMMAP_ON_MEMORY.<br>
Do I need add them?</blockquote><div><br></div><div>There is a single tunab=
le to enable memmap_on_memory, so that should be sufficient I think.</div><=
div><br></div><div>Thanks!</div>

--000000000000fb7af905c570383a--


--===============4356514542467883154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4356514542467883154==--

