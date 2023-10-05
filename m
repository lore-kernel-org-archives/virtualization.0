Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AEAE92FCE
	for <virtualization@archiver.kernel.org>; Thu,  5 Oct 2023 21:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0AC4242E9D;
	Thu,  5 Oct 2023 21:57:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AC4242E9D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KAE6vQh5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5trl8bYEJUTO; Thu,  5 Oct 2023 21:57:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 35E314018F;
	Thu,  5 Oct 2023 21:57:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35E314018F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 161EEC0039;
	Thu,  5 Oct 2023 21:57:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C691AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 21:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 987A242C23
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 21:57:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 987A242C23
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=KAE6vQh5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dFcFRFwmFRLY
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 21:57:18 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A26CD42C21
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 21:57:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A26CD42C21
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2369A61BB9;
 Thu,  5 Oct 2023 21:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2377FC433C7;
 Thu,  5 Oct 2023 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696543036;
 bh=vaHJxIHe4zRt2ghkUleXPakGs+EDbrcTc1rXqc3MsKg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=KAE6vQh542k4VeuofajcdFNi7UAR0AHGTAwk6fcvUpWM5DwqusqTcyZnRQoWRSIR0
 wYjFVNuURnB1QjY/Qb9DF6Diq7rsAUmimE/zSlLYtW3USLdRgg3FEQIf6bVS/XGpfO
 I3WqidB3O7HNh59ixD49Rii8SrxWj9EhBNVYvMMhwFTMyWgl96grV8AbY0IkP+GTR+
 jU+Fo0j6zuMdYCTgMoYsXStu3ZbFLm8B7bomR77EVstC3H4dxtITqujpsNzF8Gf/D4
 hH+2Q9BqVILErLxtzHhW2TlCJLG7E/Z7A4yUhP7cErgkT0vFZqzp1dSM9sBTqlO04S
 +7f70D4DMQ42A==
Date: Thu, 5 Oct 2023 16:57:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [-next 4/5] drm/virgpu: Switch to pci_is_vga()
Message-ID: <20231005215714.GA792609@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230830111532.444535-5-sui.jingfeng@linux.dev>
Cc: Sui Jingfeng <suijingfeng@loongson.cn>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>
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

In subject: "drm/virtio" to match previous history.

On Wed, Aug 30, 2023 at 07:15:31PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> Should be no functional change, just for cleanup purpose.
> 
> Cc: David Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index add075681e18..3a368304475a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -51,7 +51,7 @@ static int virtio_gpu_pci_quirk(struct drm_device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  	const char *pname = dev_name(&pdev->dev);
> -	bool vga = (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
> +	bool vga = pci_is_vga(pdev);

This *is* a functional change: Previously "vga" was only true for
PCI_CLASS_DISPLAY_VGA (0x0300).  Now it will be true for both
PCI_CLASS_DISPLAY_VGA (0x0300) and PCI_CLASS_DISPLAY_OTHER (0x0380).

Is that desirable?  I can't tell.  Maybe the GPU folks will chime in.

>  	int ret;
>  
>  	DRM_INFO("pci: %s detected at %s\n",
> -- 
> 2.34.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
