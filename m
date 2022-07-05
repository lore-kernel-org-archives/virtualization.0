Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FA4C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 21:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03DE940ABC;
	Tue,  5 Jul 2022 21:39:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03DE940ABC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=C94wUsjH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xsQAHpsjTK9P; Tue,  5 Jul 2022 21:39:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D365E400A8;
	Tue,  5 Jul 2022 21:39:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D365E400A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93673C0032;
	Tue,  5 Jul 2022 21:39:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE61EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 21:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FE7D81D4F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 21:39:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FE7D81D4F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=C94wUsjH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id amjnpzwka7_l
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 21:39:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D97581B99
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D97581B99
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 21:39:44 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id m184so7799959wme.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jul 2022 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uVq3SS5z0OOLu4Dz+fgC14BcaabN+0EvMUub15/aayE=;
 b=C94wUsjHGErDEFfla43eG5MzlsxSHvDnvrDe/Xrq4j16p0QUv7EPUUdY8qfT32N8PO
 AkNo/0UsK88y1OWqCBOYj46lR/3MdEhmM+drGL8ytyaLNB5DkDjEP00OCpzW+m2wAelp
 TCjJ7vUiUbhEC8mlleJNOTcqUVGV/ivrW9GKS7hh9oDIOodvDUlUbW4gWh8hHeIPGFRb
 GmN849Dm7RTsKEWdgUCm5Wtd0phCicceWYfNP3NI0E3rA+EjSvilom+GgarNgzMePkLI
 YUu9amjiRtd4qbZYzhVluqdxKr3YKYOQtRIAdp1MD6idcW/oD9wi9ffHBAtQrXAenSTI
 kDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uVq3SS5z0OOLu4Dz+fgC14BcaabN+0EvMUub15/aayE=;
 b=nnLaRAXtL6lqsxQDMc+4+0HiCicL6O00rK4On1rPpC9ZbXQZBkMS3YngzsfGQm7o43
 6763AjkTh/GmtzLqCElPcbITmYFge8pi1Ak4jNqcDQ54frChvuQV8I0NxPF8y6vTuod4
 o75tuFOKd5D6VUZpiQFHQEna3Ni9RSuCOzmny8y8UjUYllnUYI+DiTyhlqhcgfHKolFv
 eMe33G4aoFFs74nXwfM7DCAoJpWw0t73XiA1sN5JqL/3uYxL2n2S2GUUy3gY/jhHXr6I
 LS1CD2qLAvv7Sxw2h+50HvTdEhVgGiQjP1rxPR0EUKgjgCZ+sXPAMBHRibpEx+bujxWE
 npHA==
X-Gm-Message-State: AJIora+tZmLKgHT/Yxu+3O9n0K7tO/QqHnINUtUC9x+ghgVYvp3lgtUd
 XB0KIX0SXAQZNomHK6lgXhOJly5Rfrkra7bS8Mc=
X-Google-Smtp-Source: AGRyM1t4PnuQ4FyRFI1FjuAnfXAuz8RC8AR6+hfD0f99JNKIvcxLDBodEWidId40zCkDUWQDdpcm5SB+uKOKRjrDWac=
X-Received: by 2002:a05:600c:3ac3:b0:3a0:45b6:7efb with SMTP id
 d3-20020a05600c3ac300b003a045b67efbmr40084996wms.183.1657057182563; Tue, 05
 Jul 2022 14:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com>
 <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
 <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
 <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
 <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
In-Reply-To: <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 5 Jul 2022 14:39:54 -0700
Message-ID: <CAF6AEGtE+3AbaJnSZ07VY0xMOJMNz6BSQ+mPKmPYLi_Z-CLAig@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] drm/virtio: Improve DMA API usage for shmem BOs
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@linux.ie>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, Robin Murphy <robin.murphy@arm.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
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

On Tue, Jul 5, 2022 at 10:02 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 7/5/22 18:45, Gerd Hoffmann wrote:
> >   Hi,
> >
> >>> Also note that pci is not the only virtio transport we have.
> >>
> >> The VirtIO indeed has other transports, but only PCI is really supported
> >> in case of the VirtIO-GPU in kernel and in Qemu/crosvm, AFAICT. Hence
> >> only the PCI transport was tested.
> >
> > qemu -M microvm \
> >   -global virtio-mmio.force-legacy=false \
> >   -device virtio-gpu-device
> >
> > Gives you a functional virtio-gpu device on virtio-mmio.
> >
> > aarch64 virt machines support both pci and mmio too.
> > s390x has virtio-gpu-ccw ...
>
> Gerd, thank you very much! It's was indeed unclear to me how to test the
> MMIO GPU, but yours variant with microvm works! I was looking for trying
> aarch64 in the past, but it also was unclear how to do it since there is
> no DT support for the VirtIO-GPU, AFAICS.

just a drive-by note, IME on aarch64 kernels, at least with crosvm,
virtgpu is also a pci device.. the non-pci things in the guest kernel
use dt, but devices on discoverable busses like pci don't need dt
nodes (which is true also in the non-vm case)

BR,
-R


> I booted kernel with this patchset applied and everything is okay, Xorg
> works.
>
>  [drm] Initialized virtio_gpu 0.1.0 0 for LNRO0005:01 on minor 0
>  virtio-mmio LNRO0005:01: [drm] drm_plane_enable_fb_damage_clips() not
> called
>  virtio-mmio LNRO0005:01: [drm] fb0: virtio_gpudrmfb frame buffer device
>
> There is no virgl support because it's a virtio-gpu-device and not
> virtio-gpu-device-gl that is PCI-only in Qemu. Hence everything seems good.
>
> I'd appreciate if you could give s390x a test.. I never touched s390x
> and it will probably take some extra effort to get into it.
>
> --
> Best regards,
> Dmitry
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
