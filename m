Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC46C3DA79
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 21:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A963401EA;
	Thu, 29 Dec 2022 21:29:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A963401EA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AKEoxau/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MWR0GeP5t_AW; Thu, 29 Dec 2022 21:29:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DA46B401EC;
	Thu, 29 Dec 2022 21:29:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA46B401EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96FBEC0033;
	Thu, 29 Dec 2022 21:29:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1274C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 21:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C353940111
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 21:29:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C353940111
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=AKEoxau/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vgn0ndpVKPDI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 21:29:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB41B400F8
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB41B400F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 21:29:11 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3B918B8188B;
 Thu, 29 Dec 2022 21:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE229C433EF;
 Thu, 29 Dec 2022 21:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672349347;
 bh=MA66UgPU0vXtg/el5fDMiTVLg83gEnoRtkZ0Oh0wJ8Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=AKEoxau/F8wbcYwEwrkjx1A7QoxDekHYjIfH7IjUh7G+yaGZAGd4/BGinvYX0/CVc
 93YkPx6OjF0x4et6nCbj7q87FgPw3gAH8umGMr9F2ByIC//jBorhGe95tPJ2nQ0bXa
 cRQ5s9rbA8a820fnQjwsvXuf1HeKyvmgF7se6A/e2PNk5ozHlIilKO+5s+dLP+IDtQ
 TeTQNu2U96euYMjFIQ6pUoK32nYjSdSKCxl2U+Rkl7trQuiY/K6cPY5TcJFzOqaWQF
 wVSq5S02JxD41TWwB9gBGx9B681sN4T20IcN8qWtHf79MAp2AEx8c3hOYDMtDel4eR
 9hU/LOg9Q7OCQ==
Date: Thu, 29 Dec 2022 15:29:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [RESEND PATCH 1/3] Add SolidRun vendor id
Message-ID: <20221229212906.GA631104@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJs=3_AJnj9udpJ1LRtC+9qvo5Fw-=FjvZRqZkHCaQSEP-FyYg@mail.gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Thu, Dec 29, 2022 at 11:06:02PM +0200, Alvaro Karsz wrote:
> > On Mon, Dec 19, 2022 at 10:35:09AM +0200, Alvaro Karsz wrote:
> > > The vendor id is used in 2 differrent source files,
> > > the SNET vdpa driver and pci quirks.
> >
> > s/id/ID/                   # both in subject and commit log
> > s/differrent/different/
> > s/vdpa/vDPA/               # seems to be the conventional style
> > s/pci/PCI/
> >
> > Make the commit log say what this patch does.
> >
> > > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> >
> > With the above and the sorting fix below:
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > > ---
> > >  include/linux/pci_ids.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > index b362d90eb9b..33bbe3160b4 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -3115,4 +3115,6 @@
> > >
> > >  #define PCI_VENDOR_ID_NCUBE          0x10ff
> > >
> > > +#define PCI_VENDOR_ID_SOLIDRUN               0xd063
> >
> > Move this to the right spot so the file is sorted by vendor ID.
> > PCI_VENDOR_ID_NCUBE, PCI_VENDOR_ID_OCZ, and PCI_VENDOR_ID_XEN got
> > added in the wrong place.
> >
> > >  #endif /* _LINUX_PCI_IDS_H */
> > > --
> 
> Thanks for your comments.
> 
> The patch was taken by another maintainer (CCed)
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=afc9dcfb846bf35aa7afb160d5370ab5c75e7a70
> 
> So, Michael and Bjorn,
> Do you want me to create a new version, or fix it in a follow up patch?
> 
> BTW, the same is true for the next patch in the series, New PCI quirk
> for SolidRun SNET DPU
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=136dd8d8f3a0ac19f75a875e9b27b83d365a5be3

I don't know how Michael runs his tree, so it's up to him, but "New
PCI quirk for SolidRun SNET DPU." is completely different from all the
history and not very informative, so if it were via my tree I would
definitely update both.

Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
