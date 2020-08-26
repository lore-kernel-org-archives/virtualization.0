Return-Path: <SRS0=/kjp=CE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636EC433E3
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 18:23:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CBF20737
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 18:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="rrACsr3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CBF20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 74435203C4;
	Wed, 26 Aug 2020 18:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJL-4zjvnXhn; Wed, 26 Aug 2020 18:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3D0C02037B;
	Wed, 26 Aug 2020 18:23:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11BD6C0891;
	Wed, 26 Aug 2020 18:23:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E0DFC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 18:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3A284863F1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 18:23:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x1YJVxUiuT04
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 18:23:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AB135864A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 18:23:39 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id v6so3118868iow.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iYoq01qIbGPauST5RfEEhLR3G1zLYNWZoPlBmyH0nwc=;
 b=rrACsr3CvBASDErVlhyy5K/fvnE8tuvuh2uL4jiaUL3ZGIxyyW4t874WgsTFTUoygE
 0nd8dw2k6j5xfynBZ5BbH95ghQWO1tmk7qS4QlhhS+UpQrW6VIixR6b9/tabHPbrZ1TA
 woRwMlA1QVHyLaxTiI+ivqIC95ZJuDOtfQTTRjgK/HRRPkZA+BKnnG+a/1BKvKYfczZW
 giax0/bYLHTK1M0qOlsm4qENxTU2Bh4hQC+PjQEIdvsBdLlLAs06s5gOU5WsPK3RNiVa
 O8bil5tUrtg/+lUTAs1DLmtjKaPjTtBsrUkUk5J3gV7xeMNwjOueDK9lEWOPdwyFfjWL
 4fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iYoq01qIbGPauST5RfEEhLR3G1zLYNWZoPlBmyH0nwc=;
 b=IO8qBxvWJZKBz+F6Q93/IbgM8fNKwsfyEzhIG/KYUmzWAHKbw+poWeuUKOABpyXR+k
 R3aZfLoiEPFJxEIBvZIfU8poR3VVGg7/8/9smz4fulHPgsdO5MhTfTrFjLcbrCOW3zg+
 Mdyrg8gmpCEDS17O6ieObTBb6yKXAxThXLGe92YJFl4rGd+9A5TEZRXIdK9gHZ9WuJeF
 fKCgDNUY241ZcNh/L741vTq7UdQ78ubuNLM8yo3p0UZs0gtMfMKu2yKaVxVnQM/D+CsL
 zwvu/fgHtbwX0nYnmdB0MMIhbKcJYjXc9DGNb5noTeqRD9zvVVmK/v94mb0IgbaqBGky
 iABg==
X-Gm-Message-State: AOAM530vtfH9SBNmylhhXX8H80dOiFgMviaGk5b4kmEvMTfsOVgJBMeG
 IJL3HYe+yrc6K1YLYJ4iKpB4xxaOrkQYbrk/AdB9sQ==
X-Google-Smtp-Source: ABdhPJwFN6cBCs9PM+s7XTIce9XLWKWdjPF/GBPpGUznZWktGx6heltYKpGLa4ads24y20InNb1vg24deYZIDTRb1/0=
X-Received: by 2002:a05:6638:258a:: with SMTP id
 s10mr16082808jat.101.1598466218702; 
 Wed, 26 Aug 2020 11:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <03caf286-09e8-a072-8d3a-b6bcca991516@arm.com>
In-Reply-To: <03caf286-09e8-a072-8d3a-b6bcca991516@arm.com>
From: Tom Murphy <murphyt7@tcd.ie>
Date: Wed, 26 Aug 2020 14:23:26 -0400
Message-ID: <CALQxJuttUa0=Z0dQrgxAE=+w-UeE5XPW3b3BBzujtJ3aw5J8LQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
To: Robin Murphy <robin.murphy@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Julien Grall <julien.grall@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>, linux-mediatek@lists.infradead.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Kukjin Kim <kgene@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============1067908751915894178=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1067908751915894178==
Content-Type: multipart/alternative; boundary="00000000000026d76505adcbeb74"

--00000000000026d76505adcbeb74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That would be great!

On Wed., Aug. 26, 2020, 2:14 p.m. Robin Murphy, <robin.murphy@arm.com>
wrote:

> Hi Tom,
>
> On 2019-12-21 15:03, Tom Murphy wrote:
> > This patchset converts the intel iommu driver to the dma-iommu api.
> >
> > While converting the driver I exposed a bug in the intel i915 driver
> which causes a huge amount of artifacts on the screen of my laptop. You c=
an
> see a picture of it here:
> >
> https://github.com/pippy360/kernelPatches/blob/master/IMG_20191219_225922=
.jpg
> >
> > This issue is most likely in the i915 driver and is most likely caused
> by the driver not respecting the return value of the dma_map_ops::map_sg
> function. You can see the driver ignoring the return value here:
> >
> https://github.com/torvalds/linux/blob/7e0165b2f1a912a06e381e91f0f4e495f4=
ac3736/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c#L51
> >
> > Previously this didn=E2=80=99t cause issues because the intel map_sg al=
ways
> returned the same number of elements as the input scatter gather list but
> with the change to this dma-iommu api this is no longer the case. I wasn=
=E2=80=99t
> able to track the bug down to a specific line of code unfortunately.
> >
> > Could someone from the intel team look at this?
> >
> >
> > I have been testing on a lenovo x1 carbon 5th generation. Let me know i=
f
> there=E2=80=99s any more information you need.
> >
> > To allow my patch set to be tested I have added a patch (patch 8/8) in
> this series to disable combining sg segments in the dma-iommu api which
> fixes the bug but it doesn't fix the actual problem.
> >
> > As part of this patch series I copied the intel bounce buffer code to
> the dma-iommu path. The addition of the bounce buffer code took me by
> surprise. I did most of my development on this patch series before the
> bounce buffer code was added and my reimplementation in the dma-iommu pat=
h
> is very rushed and not properly tested but I=E2=80=99m running out of tim=
e to work
> on this patch set.
> >
> > On top of that I also didn=E2=80=99t port over the intel tracing code f=
rom this
> commit:
> >
> https://github.com/torvalds/linux/commit/3b53034c268d550d9e8522e613a14ab5=
3b8840d8#diff-6b3e7c4993f05e76331e463ab1fc87e1
> > So all the work in that commit is now wasted. The code will need to be
> removed and reimplemented in the dma-iommu path. I would like to take the
> time to do this but I really don=E2=80=99t have the time at the moment an=
d I want
> to get these changes out before the iommu code changes any more.
>
> Further to what we just discussed at LPC, I've realised that tracepoints
> are actually something I could do with *right now* for debugging my Arm
> DMA ops series, so if I'm going to hack something up anyway I may as
> well take responsibility for polishing it into a proper patch as well :)
>
> Robin.
>
> >
> > Tom Murphy (8):
> >    iommu/vt-d: clean up 32bit si_domain assignment
> >    iommu/vt-d: Use default dma_direct_* mapping functions for direct
> >      mapped devices
> >    iommu/vt-d: Remove IOVA handling code from non-dma_ops path
> >    iommu: Handle freelists when using deferred flushing in iommu driver=
s
> >    iommu: Add iommu_dma_free_cpu_cached_iovas function
> >    iommu: allow the dma-iommu api to use bounce buffers
> >    iommu/vt-d: Convert intel iommu driver to the iommu ops
> >    DO NOT MERGE: iommu: disable list appending in dma-iommu
> >
> >   drivers/iommu/Kconfig           |   1 +
> >   drivers/iommu/amd_iommu.c       |  14 +-
> >   drivers/iommu/arm-smmu-v3.c     |   3 +-
> >   drivers/iommu/arm-smmu.c        |   3 +-
> >   drivers/iommu/dma-iommu.c       | 183 +++++--
> >   drivers/iommu/exynos-iommu.c    |   3 +-
> >   drivers/iommu/intel-iommu.c     | 936 ++++---------------------------=
-
> >   drivers/iommu/iommu.c           |  39 +-
> >   drivers/iommu/ipmmu-vmsa.c      |   3 +-
> >   drivers/iommu/msm_iommu.c       |   3 +-
> >   drivers/iommu/mtk_iommu.c       |   3 +-
> >   drivers/iommu/mtk_iommu_v1.c    |   3 +-
> >   drivers/iommu/omap-iommu.c      |   3 +-
> >   drivers/iommu/qcom_iommu.c      |   3 +-
> >   drivers/iommu/rockchip-iommu.c  |   3 +-
> >   drivers/iommu/s390-iommu.c      |   3 +-
> >   drivers/iommu/tegra-gart.c      |   3 +-
> >   drivers/iommu/tegra-smmu.c      |   3 +-
> >   drivers/iommu/virtio-iommu.c    |   3 +-
> >   drivers/vfio/vfio_iommu_type1.c |   2 +-
> >   include/linux/dma-iommu.h       |   3 +
> >   include/linux/intel-iommu.h     |   1 -
> >   include/linux/iommu.h           |  32 +-
> >   23 files changed, 345 insertions(+), 908 deletions(-)
> >
>

--00000000000026d76505adcbeb74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">That would be great!</div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed., Aug. 26, 2020, 2:14 p.m. Rob=
in Murphy, &lt;<a href=3D"mailto:robin.murphy@arm.com">robin.murphy@arm.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Tom,<br>
<br>
On 2019-12-21 15:03, Tom Murphy wrote:<br>
&gt; This patchset converts the intel iommu driver to the dma-iommu api.<br=
>
&gt; <br>
&gt; While converting the driver I exposed a bug in the intel i915 driver w=
hich causes a huge amount of artifacts on the screen of my laptop. You can =
see a picture of it here:<br>
&gt; <a href=3D"https://github.com/pippy360/kernelPatches/blob/master/IMG_2=
0191219_225922.jpg" rel=3D"noreferrer noreferrer" target=3D"_blank">https:/=
/github.com/pippy360/kernelPatches/blob/master/IMG_20191219_225922.jpg</a><=
br>
&gt; <br>
&gt; This issue is most likely in the i915 driver and is most likely caused=
 by the driver not respecting the return value of the dma_map_ops::map_sg f=
unction. You can see the driver ignoring the return value here:<br>
&gt; <a href=3D"https://github.com/torvalds/linux/blob/7e0165b2f1a912a06e38=
1e91f0f4e495f4ac3736/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c#L51" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://github.com/torvalds/linux=
/blob/7e0165b2f1a912a06e381e91f0f4e495f4ac3736/drivers/gpu/drm/i915/gem/i91=
5_gem_dmabuf.c#L51</a><br>
&gt; <br>
&gt; Previously this didn=E2=80=99t cause issues because the intel map_sg a=
lways returned the same number of elements as the input scatter gather list=
 but with the change to this dma-iommu api this is no longer the case. I wa=
sn=E2=80=99t able to track the bug down to a specific line of code unfortun=
ately.<br>
&gt; <br>
&gt; Could someone from the intel team look at this?<br>
&gt; <br>
&gt; <br>
&gt; I have been testing on a lenovo x1 carbon 5th generation. Let me know =
if there=E2=80=99s any more information you need.<br>
&gt; <br>
&gt; To allow my patch set to be tested I have added a patch (patch 8/8) in=
 this series to disable combining sg segments in the dma-iommu api which fi=
xes the bug but it doesn&#39;t fix the actual problem.<br>
&gt; <br>
&gt; As part of this patch series I copied the intel bounce buffer code to =
the dma-iommu path. The addition of the bounce buffer code took me by surpr=
ise. I did most of my development on this patch series before the bounce bu=
ffer code was added and my reimplementation in the dma-iommu path is very r=
ushed and not properly tested but I=E2=80=99m running out of time to work o=
n this patch set.<br>
&gt; <br>
&gt; On top of that I also didn=E2=80=99t port over the intel tracing code =
from this commit:<br>
&gt; <a href=3D"https://github.com/torvalds/linux/commit/3b53034c268d550d9e=
8522e613a14ab53b8840d8#diff-6b3e7c4993f05e76331e463ab1fc87e1" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">https://github.com/torvalds/linux/commit=
/3b53034c268d550d9e8522e613a14ab53b8840d8#diff-6b3e7c4993f05e76331e463ab1fc=
87e1</a><br>
&gt; So all the work in that commit is now wasted. The code will need to be=
 removed and reimplemented in the dma-iommu path. I would like to take the =
time to do this but I really don=E2=80=99t have the time at the moment and =
I want to get these changes out before the iommu code changes any more.<br>
<br>
Further to what we just discussed at LPC, I&#39;ve realised that tracepoint=
s <br>
are actually something I could do with *right now* for debugging my Arm <br=
>
DMA ops series, so if I&#39;m going to hack something up anyway I may as <b=
r>
well take responsibility for polishing it into a proper patch as well :)<br=
>
<br>
Robin.<br>
<br>
&gt; <br>
&gt; Tom Murphy (8):<br>
&gt;=C2=A0 =C2=A0 iommu/vt-d: clean up 32bit si_domain assignment<br>
&gt;=C2=A0 =C2=A0 iommu/vt-d: Use default dma_direct_* mapping functions fo=
r direct<br>
&gt;=C2=A0 =C2=A0 =C2=A0 mapped devices<br>
&gt;=C2=A0 =C2=A0 iommu/vt-d: Remove IOVA handling code from non-dma_ops pa=
th<br>
&gt;=C2=A0 =C2=A0 iommu: Handle freelists when using deferred flushing in i=
ommu drivers<br>
&gt;=C2=A0 =C2=A0 iommu: Add iommu_dma_free_cpu_cached_iovas function<br>
&gt;=C2=A0 =C2=A0 iommu: allow the dma-iommu api to use bounce buffers<br>
&gt;=C2=A0 =C2=A0 iommu/vt-d: Convert intel iommu driver to the iommu ops<b=
r>
&gt;=C2=A0 =C2=A0 DO NOT MERGE: iommu: disable list appending in dma-iommu<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0drivers/iommu/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0drivers/iommu/amd_iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 14 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/arm-smmu-v3.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A03 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/arm-smmu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A03 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/dma-iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 183 =
+++++--<br>
&gt;=C2=A0 =C2=A0drivers/iommu/exynos-iommu.c=C2=A0 =C2=A0 |=C2=A0 =C2=A03 =
+-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/intel-iommu.c=C2=A0 =C2=A0 =C2=A0| 936 ++++-=
---------------------------<br>
&gt;=C2=A0 =C2=A0drivers/iommu/iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 39 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/ipmmu-vmsa.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/msm_iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A03 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/mtk_iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A03 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/mtk_iommu_v1.c=C2=A0 =C2=A0 |=C2=A0 =C2=A03 =
+-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/omap-iommu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/qcom_iommu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/rockchip-iommu.c=C2=A0 |=C2=A0 =C2=A03 +-<br=
>
&gt;=C2=A0 =C2=A0drivers/iommu/s390-iommu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/tegra-gart.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/tegra-smmu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +-<br>
&gt;=C2=A0 =C2=A0drivers/iommu/virtio-iommu.c=C2=A0 =C2=A0 |=C2=A0 =C2=A03 =
+-<br>
&gt;=C2=A0 =C2=A0drivers/vfio/vfio_iommu_type1.c |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0include/linux/dma-iommu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0include/linux/intel-iommu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 -<br>
&gt;=C2=A0 =C2=A0include/linux/iommu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 32 +-<br>
&gt;=C2=A0 =C2=A023 files changed, 345 insertions(+), 908 deletions(-)<br>
&gt; <br>
</blockquote></div>

--00000000000026d76505adcbeb74--

--===============1067908751915894178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1067908751915894178==--
