Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CF4C3DA79
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 19:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C63444019D;
	Thu, 29 Dec 2022 19:55:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C63444019D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V2bB3UvZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xd9MbQWgjO-9; Thu, 29 Dec 2022 19:55:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3C21B40111;
	Thu, 29 Dec 2022 19:55:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C21B40111
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D537C0033;
	Thu, 29 Dec 2022 19:55:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3270AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 19:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B5F24033B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 19:55:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B5F24033B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=V2bB3UvZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7EPAIssOk-3x
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 19:55:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCAB6400FB
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCAB6400FB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 19:55:50 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B9A66617E1;
 Thu, 29 Dec 2022 19:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E989EC433EF;
 Thu, 29 Dec 2022 19:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672343749;
 bh=URFFj4jkFc+tFnghQDARsWaYCBYiol/xBKnP7FN6/Q0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=V2bB3UvZN3+azSoguJpMn3xZZjMVTh5Yh79CHkrbGYG0H+bc9p5AR1RZ5mQI66Mxp
 FeD1v9Ky9vQhX0cMURVClvlze8i6GAXkEVKZO9A7ez5ilq7pO7G7WF1IxaCBvtzZSw
 ArIR6Qv3acKKMjXSHUsJG2YqeID+wqcAkgds+PnpU443tLukKsxtwvAtKlU6BIx5Cx
 RMdzn8wld/nqP8mN2lp0cGzgMouHFGRp52ONYAC0c+LBrJlXXFRFafy3hYDATtwpzO
 RaNkU2I6iaVs6E/7QvhXJNTapW7hHwrNB8AVu9VJ1B5jwy2NfR5sKq7DK4di8Y9GUi
 2e88hZ/XOABjw==
Date: Thu, 29 Dec 2022 13:55:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [RESEND PATCH 2/3] New PCI quirk for SolidRun SNET DPU.
Message-ID: <20221229195547.GA625927@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221219083511.73205-3-alvaro.karsz@solid-run.com>
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

Thanks for the patch!

On Mon, Dec 19, 2022 at 10:35:10AM +0200, Alvaro Karsz wrote:
> The DPU advertises FLR, but it may cause the device to hang.
> This only happens with revision 0x1.

Please update the subject line to:

  PCI: Avoid FLR for SolidRun SNET DPU rev 1

This makes the subject meaningful by itself and is similar to previous
quirks:

  5727043c73fd ("PCI: Avoid FLR for AMD Starship USB 3.0")
  0d14f06cd665 ("PCI: Avoid FLR for AMD Matisse HD Audio & USB 3.0")
  f65fd1aa4f98 ("PCI: Avoid FLR for Intel 82579 NICs")

Also, update the commit log so it says what this patch does, instead
of simply describing the current situation.

https://chris.beams.io/posts/git-commit/ is a good reference.

With the above changes,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> ---
>  drivers/pci/quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 285acc4aacc..809d03272c2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5343,6 +5343,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>  
> +/* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
> +static void quirk_no_flr_snet(struct pci_dev *dev)
> +{
> +	if (dev->revision == 0x1)
> +		quirk_no_flr(dev);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLIDRUN, 0x1000, quirk_no_flr_snet);
> +
>  static void quirk_no_ext_tags(struct pci_dev *pdev)
>  {
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
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
