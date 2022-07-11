Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352C3C43334
	for <virtualization@archiver.kernel.org>; Mon, 11 Jul 2022 22:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 878B6421F1;
	Mon, 11 Jul 2022 22:00:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 878B6421F1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Kq4gksMd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qSrJxxNkQshe; Mon, 11 Jul 2022 22:00:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A4DDD4182F;
	Mon, 11 Jul 2022 22:00:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4DDD4182F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6829EC0033;
	Mon, 11 Jul 2022 22:00:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17052C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jul 2022 22:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDD1C42188
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jul 2022 22:00:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EDD1C42188
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUC8melKtM0P
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jul 2022 22:00:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4A5A4182F
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4A5A4182F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jul 2022 22:00:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A4F7260DBD;
 Mon, 11 Jul 2022 22:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90C6C34115;
 Mon, 11 Jul 2022 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657576838;
 bh=h/r4YLHCKzq8XvfrWvxzIuHzi4CzsULHgZCszQBiYqU=;
 h=Date:From:To:Subject:In-Reply-To:From;
 b=Kq4gksMdnH/AjpfKcTEB/jtGsSAFjU83CCusGHFpxo2GS4Ma2aBhWAbCvfJwTGz6V
 7Fr8AKmveibUls8s2a+VXHcdQnWqqD/OrcNgXzGrCu7Ony24qEJlv5v4OYI970H0UF
 upWhEr1MczbOjsFMPyiS5Vn+ycxyUBWlUod9xG8Cjs09mrCr+SCI/OJmBCESP9sM6C
 Do4SeQTUfnaaPq76DLJr5eTI6AbIvRldQFWCfUi43DWhOPnVPhnhUgJSbmd6s8FblA
 B6UtEsUnCxz7RmDJmz6nQz74vfIBpYA/ijthTsjYNmNHWkdCp7ZPteoEcM30bJmLdD
 wONjNV5IWlutA==
Date: Mon, 11 Jul 2022 17:00:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, ecree.xilinx@gmail.com,
 linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next v2 0/2] sfc: Add EF100 BAR config support
Message-ID: <20220711220036.GA692083@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yswn7p+OWODbT7AR@gmail.com>
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

On Mon, Jul 11, 2022 at 02:38:54PM +0100, Martin Habets wrote:
> On Thu, Jul 07, 2022 at 10:55:00AM -0500, Bjorn Helgaas wrote:
> > On Thu, Jul 07, 2022 at 02:07:07PM +0100, Martin Habets wrote:
> > > The EF100 NICs allow for different register layouts of a PCI memory BAR.
> > > This series provides the framework to switch this layout at runtime.
> > > 
> > > Subsequent patch series will use this to add support for vDPA.
> > 
> > Normally drivers rely on the PCI Vendor and Device ID to learn the
> > number of BARs and their layouts.  I guess this series implies that
> > doesn't work on this device?  And the user needs to manually specify
> > what kind of device this is?
> 
> When a new PCI device is added (like a VF) it always starts of with
> the register layout for an EF100 network device. This is hardcoded,
> i.e. it cannot be customised.
> The layout can be changed after bootup, and only after the sfc driver has
> bound to the device.
> The PCI Vendor and Device ID do not change when the layout is changed.
> 
> For vDPA specifically we return the Xilinx PCI Vendor and our device ID
> to the vDPA framework via struct vdpa_config_opts.
> 
> > I'm confused about how this is supposed to work.  What if the driver
> > is built-in and claims a device before the user can specify the
> > register layout?
> 
> The bar_config file will only exist once the sfc driver has bound to
> the device. So in fact we count on that driver getting loaded.
> When a new value is written to bar_config it is the sfc driver that
> instructs the NIC to change the register layout.
>
> > What if the user specifies the wrong layout and the
> > driver writes to the wrong registers?
> 
> We have specific hardware and driver requirements for this sort of
> situation. For example, the register layouts must have some common
> registers (to ensure some compatibility).

Obviously we have to deal with the hardware as it exists, but it seems
like a hardware design problem that you can change the register
layout but the change is not detectable via those common registers.  

Anyway, it seems weird to me, but doesn't affect the PCI core and I
won't stand in your way ;)

> A layout that is too different will require a separate device ID.
> A driver that writes to the wrong register is a bug.
> 
> Maybe the name "bar_config" is causing most of the confusion here.
> Internally we also talk about "function profiles" or "personalities",
> but we thought such a name would be too vague.
> 
> Martin
> 
> > > ---
> > > 
> > > Martin Habets (2):
> > >       sfc: Add EF100 BAR config support
> > >       sfc: Implement change of BAR configuration
> > > 
> > > 
> > >  drivers/net/ethernet/sfc/ef100_nic.c |   80 ++++++++++++++++++++++++++++++++++
> > >  drivers/net/ethernet/sfc/ef100_nic.h |    6 +++
> > >  2 files changed, 86 insertions(+)
> > > 
> > > --
> > > Martin Habets <habetsm.xilinx@gmail.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
