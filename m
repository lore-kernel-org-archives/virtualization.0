Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B56DC433F5
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 01:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B292040482;
	Thu, 19 May 2022 01:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gb8cKyTRJN-R; Thu, 19 May 2022 01:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 28C2A4015A;
	Thu, 19 May 2022 01:06:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F274EC0032;
	Thu, 19 May 2022 01:06:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04308C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 01:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E05DB41CC1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 01:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lqtxsRJlQGuh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 01:06:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DC3641CBF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 01:06:20 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CE889B82282;
 Thu, 19 May 2022 01:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E4CC385A9;
 Thu, 19 May 2022 01:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652922377;
 bh=A37qzO27clIicOaYiKS+7XcGNtBlcRdGs+YWygQldiE=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Q1ISrQZMlC7dfffXYF2LojSw8XRR0txL3DlfV3ijVpuPFCDh/xpWfJ6Q9YNmLQ8cB
 bOt31zuut1LXYk2EWEiMTcHWteKBs6YYiWit2LsoIf1ChT8OWizPh11zvSCt3h37rc
 o/Zs0vZAQkDgCAEoOZ9RU4XzqV7CBeMeQ6OS1tE2Oi/v4jdEyFVa8wks8VP3oomCZx
 b3JPlpEn7bEAT2UTulT4f/+xXkBIvh/Q+V0XBeZyUUqfLjcVLHaJtry+VANv/zARhy
 63U8oicDVdlxmPS2FMniCnbbVrlisTOVkpnnupLhVku1I/gS1D9ONwetqJkxsjSPI7
 O+hR72zkswG9A==
Date: Wed, 18 May 2022 18:06:14 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Oleksandr <olekstysh@gmail.com>
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,
 dev-domid property description for xen-grant DMA ops
In-Reply-To: <460a746c-6b61-214b-4653-44a1430e314d@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205181802310.1905099@ubuntu-linux-20-04-desktop>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
 <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
 <56e8c32d-6771-7179-005f-26ca58555659@gmail.com>
 <CAK8P3a1YhkEZ8gcbXHEa5Bwx-4VVRJO8SUHf8=RNWRsc2Yo-+A@mail.gmail.com>
 <460a746c-6b61-214b-4653-44a1430e314d@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-845912708-1652922160=:1905099"
Content-ID: <alpine.DEB.2.22.394.2205181802530.1905099@ubuntu-linux-20-04-desktop>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-845912708-1652922160=:1905099
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2205181802531.1905099@ubuntu-linux-20-04-desktop>

On Thu, 19 May 2022, Oleksandr wrote:
> > On Wed, May 18, 2022 at 5:06 PM Oleksandr <olekstysh@gmail.com> wrote:
> > > On 18.05.22 17:32, Arnd Bergmann wrote:
> > > > On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko
> > > > <olekstysh@gmail.com> wrote:
> > > >    This would mean having a device
> > > > node for the grant-table mechanism that can be referred to using the
> > > > 'iommus'
> > > > phandle property, with the domid as an additional argument.
> > > I assume, you are speaking about something like the following?
> > > 
> > > 
> > > xen_dummy_iommu {
> > >      compatible = "xen,dummy-iommu";
> > >      #iommu-cells = <1>;
> > > };
> > > 
> > > virtio@3000 {
> > >      compatible = "virtio,mmio";
> > >      reg = <0x3000 0x100>;
> > >      interrupts = <41>;
> > > 
> > >      /* The device is located in Xen domain with ID 1 */
> > >      iommus = <&xen_dummy_iommu 1>;
> > > };
> > Right, that's that's the idea,
> 
> thank you for the confirmation
> 
> 
> 
> >   except I would not call it a 'dummy'.
> >  From the perspective of the DT, this behaves just like an IOMMU,
> > even if the exact mechanism is different from most hardware IOMMU
> > implementations.
> 
> well, agree
> 
> 
> > 
> > > > It does not quite fit the model that Linux currently uses for iommus,
> > > > as that has an allocator for dma_addr_t space
> > > yes (# 3/7 adds grant-table based allocator)
> > > 
> > > 
> > > > , but it would think it's
> > > > conceptually close enough that it makes sense for the binding.
> > > Interesting idea. I am wondering, do we need an extra actions for this
> > > to work in Linux guest (dummy IOMMU driver, etc)?
> > It depends on how closely the guest implementation can be made to
> > resemble a normal iommu. If you do allocate dma_addr_t addresses,
> > it may actually be close enough that you can just turn the grant-table
> > code into a normal iommu driver and change nothing else.
> 
> Unfortunately, I failed to find a way how use grant references at the
> iommu_ops level (I mean to fully pretend that we are an IOMMU driver). I am
> not too familiar with that, so what is written below might be wrong or at
> least not precise.
> 
> The normal IOMMU driver in Linux doesn’t allocate DMA addresses by itself, it
> just maps (IOVA-PA) what was requested to be mapped by the upper layer. The
> DMA address allocation is done by the upper layer (DMA-IOMMU which is the glue
> layer between DMA API and IOMMU API allocates IOVA for PA?). But, all what we
> need here is just to allocate our specific grant-table based DMA addresses
> (DMA address = grant reference + offset in the page), so let’s say we need an
> entity to take a physical address as parameter and return a DMA address (what
> actually commit #3/7 is doing), and that’s all. So working at the dma_ops
> layer we get exactly what we need, with the minimal changes to guest
> infrastructure. In our case the Xen itself acts as an IOMMU.
> 
> Assuming that we want to reuse the IOMMU infrastructure somehow for our needs.
> I think, in that case we will likely need to introduce a new specific IOVA
> allocator (alongside with a generic one) to be hooked up by the DMA-IOMMU
> layer if we run on top of Xen. But, even having the specific IOVA allocator to
> return what we indeed need (DMA address = grant reference + offset in the
> page) we will still need the specific minimal required IOMMU driver to be
> present in the system anyway in order to track the mappings(?) and do nothing
> with them, returning a success (this specific IOMMU driver should have all
> mandatory callbacks implemented).
> 
> I completely agree, it would be really nice to reuse generic IOMMU bindings
> rather than introducing Xen specific property if what we are trying to
> implement in current patch series fits in the usage of "iommus" in Linux
> more-less. But, if we will have to add more complexity/more components to the
> code for the sake of reusing device tree binding, this raises a question
> whether that’s worthwhile.
> 
> Or I really missed something?

I think Arnd was primarily suggesting to reuse the IOMMU Device Tree
bindings, not necessarily the IOMMU drivers framework in Linux (although
that would be an added bonus.)

I know from previous discussions with you that making the grant table
fit in the existing IOMMU drivers model is difficult, but just reusing
the Device Tree bindings seems feasible?
--8323329-845912708-1652922160=:1905099
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323329-845912708-1652922160=:1905099--
