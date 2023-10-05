Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936DFE92FD0
	for <virtualization@archiver.kernel.org>; Thu,  5 Oct 2023 22:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 212C24261A;
	Thu,  5 Oct 2023 22:10:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 212C24261A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N+1tqzKx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zjmzl6ZGSTlZ; Thu,  5 Oct 2023 22:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 53F5B4012A;
	Thu,  5 Oct 2023 22:10:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53F5B4012A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB289C0071;
	Thu,  5 Oct 2023 22:10:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 776DCC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 22:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B9B44261A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 22:10:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B9B44261A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UkcdjyjTXIYt
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 22:10:52 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A576F4012A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 22:10:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A576F4012A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D3B1561B6C;
 Thu,  5 Oct 2023 22:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB93C433C7;
 Thu,  5 Oct 2023 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696543851;
 bh=UoU4cn3m/iQDeTvZ6sJCJc+J83ON7noH/i6xOi4WLLw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=N+1tqzKxM8k5U6oPZNf+PbjiiKdMm854tLVYikTTC5eIDDeVyg+N+NTEIrli6XAe9
 AYJvP4opqpuj/fwoMKh9l3oTV2QNACLfQNXHsca4VUbGX/t7yMWk1ahpiMV16G3KI2
 gVxDw5TYrM003BVXZYcEqNJi6Vf6nVXVw44yULSR14G2i/UPDrXwH3zM2QxvlfqlaT
 vKWPyNRZK4xcdUICXbjPso4zu+95Lit1pfcb3uTNBnaEqfpU0++MC6xignIlkdGzMh
 lJLcoGIjhWwBePNWlzuSPrTtXJkEPpJFxq3ht7XnhWrObZP78PjziFHLMjYQ0GcThX
 Ikd5tEHIkCbqA==
Date: Thu, 5 Oct 2023 17:10:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [-next 4/5] drm/virgpu: Switch to pci_is_vga()
Message-ID: <20231005221049.GA793091@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231005215714.GA792609@bhelgaas>
Cc: Sui Jingfeng <suijingfeng@loongson.cn>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@redhat.com>,
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

On Thu, Oct 05, 2023 at 04:57:14PM -0500, Bjorn Helgaas wrote:
> In subject: "drm/virtio" to match previous history.
> 
> On Wed, Aug 30, 2023 at 07:15:31PM +0800, Sui Jingfeng wrote:
> > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > 
> > Should be no functional change, just for cleanup purpose.
> > 
> > Cc: David Airlie <airlied@redhat.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> > Cc: Chia-I Wu <olvaffe@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > index add075681e18..3a368304475a 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > @@ -51,7 +51,7 @@ static int virtio_gpu_pci_quirk(struct drm_device *dev)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev->dev);
> >  	const char *pname = dev_name(&pdev->dev);
> > -	bool vga = (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
> > +	bool vga = pci_is_vga(pdev);
> 
> This *is* a functional change: Previously "vga" was only true for
> PCI_CLASS_DISPLAY_VGA (0x0300).  Now it will be true for both
> PCI_CLASS_DISPLAY_VGA (0x0300) and PCI_CLASS_DISPLAY_OTHER (0x0380).

Oops, sorry, my mistake here.  I meant PCI_CLASS_NOT_DEFINED_VGA, not
PCI_CLASS_DISPLAY_OTHER.  pci_is_vga() is true for either of:

  PCI_CLASS_DISPLAY_VGA       0x0300
  PCI_CLASS_NOT_DEFINED_VGA   0x0001

(PCI_CLASS_NOT_DEFINED_VGA is defined in the PCI Code and Assignment
spec r1.15, sec 1.1; PCI_CLASS_DISPLAY_VGA is sec 1.4.)

> Is that desirable?  I can't tell.  Maybe the GPU folks will chime in.
> 
> >  	int ret;
> >  
> >  	DRM_INFO("pci: %s detected at %s\n",
> > -- 
> > 2.34.1
> > 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
