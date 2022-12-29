Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8692DC3DA79
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 19:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28C8C400FB;
	Thu, 29 Dec 2022 19:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28C8C400FB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b1x/I3gA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k3L_mcbB7UTF; Thu, 29 Dec 2022 19:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 764E24033C;
	Thu, 29 Dec 2022 19:55:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 764E24033C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 512F5C0033;
	Thu, 29 Dec 2022 19:55:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22E3DC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 19:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1C8A81453
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 19:55:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1C8A81453
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=b1x/I3gA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rxl4ZN1OhvrU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 19:55:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 262A181452
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 262A181452
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 19:55:57 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2E5A5B818F0;
 Thu, 29 Dec 2022 19:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A9CC433EF;
 Thu, 29 Dec 2022 19:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672343752;
 bh=kvC8RAtSg5C1f3gFzc3B2kQUNgKJtVYCg8q6q7Uu6l0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=b1x/I3gAYHpQWVJY4xix2AdZz8v4DzkgnTANPmYSv+VFrg62XfP2y3Zx73NA1afFu
 1njH6e8Owb+VJzX7f/f0qHlLa8nCIIXM/v6qHa2b0xyQQ2hUhGI02m+ggdTdM7bowa
 OckNmH2tCvxeJySiY9DTzq3xcf3ReDTxEq1ueUNrKMcAnlPr1fsxCbntON8TKboRui
 uTlhUGlgWb1s3jWfiOIFQLh583OFuIBUtOQ6VitMMVdX11tHZi4TfHoIeWdo51z5BN
 p5mgtAWsNGoJxxNt3BrDWpAEkyp2xWzBu/gG59PfAyiEJ8wR3PQED8tZHU1dYYYf0w
 36XSzy5OFKE3Q==
Date: Thu, 29 Dec 2022 13:55:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [RESEND PATCH 1/3] Add SolidRun vendor id
Message-ID: <20221229195551.GA626165@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221219083511.73205-2-alvaro.karsz@solid-run.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Hi Alvaro,

On Mon, Dec 19, 2022 at 10:35:09AM +0200, Alvaro Karsz wrote:
> The vendor id is used in 2 differrent source files,
> the SNET vdpa driver and pci quirks.

s/id/ID/                   # both in subject and commit log
s/differrent/different/
s/vdpa/vDPA/               # seems to be the conventional style
s/pci/PCI/

Make the commit log say what this patch does.

> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

With the above and the sorting fix below:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b..33bbe3160b4 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3115,4 +3115,6 @@
>  
>  #define PCI_VENDOR_ID_NCUBE		0x10ff
>  
> +#define PCI_VENDOR_ID_SOLIDRUN		0xd063

Move this to the right spot so the file is sorted by vendor ID.
PCI_VENDOR_ID_NCUBE, PCI_VENDOR_ID_OCZ, and PCI_VENDOR_ID_XEN got
added in the wrong place.

>  #endif /* _LINUX_PCI_IDS_H */
> -- 
> 2.32.0
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
