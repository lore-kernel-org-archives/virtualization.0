Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB6DC433F5
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 16:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4B2E140AB9;
	Wed, 18 May 2022 16:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XOFIGL8gmGM0; Wed, 18 May 2022 16:39:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D00C8405AE;
	Wed, 18 May 2022 16:39:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9459AC0032;
	Wed, 18 May 2022 16:39:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4B09C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 16:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB9BF41BE2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 16:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4xX8IUiKF44U
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 16:39:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25FAA41BC4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 16:39:26 +0000 (UTC)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mlejs-1nRcf02ULa-00iiTF for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:39:24 +0200
Received: by mail-yb1-f181.google.com with SMTP id x2so4322077ybi.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 09:39:24 -0700 (PDT)
X-Gm-Message-State: AOAM5303kLfk3R/Vl2pxG42xfjRpPqmUoltrCuP9dq493bG3UR2/T+4v
 b/k1ZzKLpWZFT+tTDqUvpGL7/AoX1Pz/nX6Y50c=
X-Google-Smtp-Source: ABdhPJzgO+qZWLWCVNG0zigCWvcyaAMnm3eGdOmvWgnrUQyVgjytOzSGXEWpAN07OlHuwbLMC0znLO5cjVzishwdUG8=
X-Received: by 2002:a25:cfd7:0:b0:64d:9526:1ed4 with SMTP id
 f206-20020a25cfd7000000b0064d95261ed4mr487184ybg.106.1652891963222; Wed, 18
 May 2022 09:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
 <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
 <56e8c32d-6771-7179-005f-26ca58555659@gmail.com>
In-Reply-To: <56e8c32d-6771-7179-005f-26ca58555659@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 May 2022 17:39:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1YhkEZ8gcbXHEa5Bwx-4VVRJO8SUHf8=RNWRsc2Yo-+A@mail.gmail.com>
Message-ID: <CAK8P3a1YhkEZ8gcbXHEa5Bwx-4VVRJO8SUHf8=RNWRsc2Yo-+A@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To: Oleksandr <olekstysh@gmail.com>
X-Provags-ID: V03:K1:iV9XKRsKtEM5soCWDl3Vb3wQRo09aLbxV+x2kd8K//zo+m3vYLv
 4LoYa8Nmr2Zp89KLt+B4aFLTShbxUUpC0UE83dcrSaKnsSfJ+/AeLBBqm6cm8LzCGlbPquZ
 +9CoNUphk39/fm0rubgcyozxNtavJSDJepz8On1ovBJ1lAlrNlVhpPupX6Y9CmNenIhFWw8
 0c4uB84CSaxp6VfG4I5JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:riZsd0p/l84=:PUuNSaubkhcdKj1q+i6+q7
 lJDx+3zuL+JLruqTIXNqvJRtlpfIq0mMI6bwvmGh4JFfQPUAQ4c8rSlvGfvwZXVTQcLiWePPi
 1HMetrjaCcQf/uBmaX0/tmUQ6aYvaUVSZS2aBioASPmhdFDIsh1FnPmjPVuF5+SK9MigGtH8U
 fFsivvMvm6G1xYVmHhOVuIsNqq3Lb0CpJPJFg4yDmuShUZmZ9xfnHkn73UIhOU1HEbl+zrYSz
 b/7NiGhKFtUXUMu3qxywNkx5Mj3C+YVHN2ZDmkWd5JBJJnM0vBaV+15b+V/At1zfvB3Ly+Stj
 xH+ULK/sJGWxwN6gU2Ti79YBXirIpYOYdppuk6bs7IG7q8OQiBGFFcdNzf63OG7/sqqNwmOdn
 Q5ToPKphK9NEGWpcEJ5Sa21ydjBKDE7fe0FSWfY6FEPAay+tAS/XCB6BPrCwWgGTxEBUA+Ru6
 eCqEEZQYPlZqUrs2e22WMmVvVEWTXSjX+oUk9n2VcCDoYB41elnjnvyopryM81cxYbi8/Amvm
 YeHTXmHqDFuAFMqrNCcLhLaGqU9xtz4p21Q9RvyTLNZAP5soMb5jF/Nlw6c6xbXFv/H0mKSnF
 EHwlN02/9cqEbuTNz1zBfKkLLp7jWRyvnzoH9ZIKHg0LOAOZfSdd9hvzkAxptV9tSRpeGQkg6
 BY1yIsW0J2r4tusibkeauk03G/a7aVXKexwBYf6ArUNnhQu5vwyturcNdk+3SRvDhTTIUJIJY
 RTFS+dFj69SSAy/hmKYfy2oC4fCtdm/13d5avA==
Cc: Juergen Gross <jgross@suse.com>, DTML <devicetree@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Wed, May 18, 2022 at 5:06 PM Oleksandr <olekstysh@gmail.com> wrote:
> On 18.05.22 17:32, Arnd Bergmann wrote:
> > On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko <olekstysh@gmail.com> wrote:
>
> >   This would mean having a device
> > node for the grant-table mechanism that can be referred to using the 'iommus'
> > phandle property, with the domid as an additional argument.
>
> I assume, you are speaking about something like the following?
>
>
> xen_dummy_iommu {
>     compatible = "xen,dummy-iommu";
>     #iommu-cells = <1>;
> };
>
> virtio@3000 {
>     compatible = "virtio,mmio";
>     reg = <0x3000 0x100>;
>     interrupts = <41>;
>
>     /* The device is located in Xen domain with ID 1 */
>     iommus = <&xen_dummy_iommu 1>;
> };

Right, that's that's the idea, except I would not call it a 'dummy'.
From the perspective of the DT, this behaves just like an IOMMU,
even if the exact mechanism is different from most hardware IOMMU
implementations.

> > It does not quite fit the model that Linux currently uses for iommus,
> > as that has an allocator for dma_addr_t space
>
> yes (# 3/7 adds grant-table based allocator)
>
>
> > , but it would think it's
> > conceptually close enough that it makes sense for the binding.
>
> Interesting idea. I am wondering, do we need an extra actions for this
> to work in Linux guest (dummy IOMMU driver, etc)?

It depends on how closely the guest implementation can be made to
resemble a normal iommu. If you do allocate dma_addr_t addresses,
it may actually be close enough that you can just turn the grant-table
code into a normal iommu driver and change nothing else.

        Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
