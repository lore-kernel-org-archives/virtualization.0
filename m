Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B6CC00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 18:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1637D400FE;
	Mon,  8 Aug 2022 18:37:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1637D400FE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=GfTxWZlV;
	dkim=fail reason="signature verification failed" header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed1 header.b=tawh23rV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o3VypYk4dDrZ; Mon,  8 Aug 2022 18:37:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 75581400AB;
	Mon,  8 Aug 2022 18:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 75581400AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE76C0033;
	Mon,  8 Aug 2022 18:37:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFDBDC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A52B812FC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A52B812FC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ravnborg.org
 header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=GfTxWZlV; 
 dkim=pass header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256
 header.s=ed1 header.b=tawh23rV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vyALCFwUnTHo
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:37:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68AC5812F9
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com
 (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68AC5812F9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=i0y6RSQK7dE3A6Y/eYZg4QjyeroqpJKUhXu6rdO6Qo4=;
 b=GfTxWZlVCPYtW8oNroCmmebJL5AFtXwNVBNy0ZjSv4JyMp6eqSLzDTKAJCXULXmuDIyV7FHzuEOOM
 76r1CkYC+LRKwM6LRnDBGAAuQfoiOpZMNPUc5j7Mt6rrHkK6tSiyyT+B18FYxSYsCkizxx8QDRRLUe
 hs+tLPByYjCNkKYPS+p7AMU2U+uJZkbWhUjt9Ia5+OvRlGLb4X1NZmyAKn/uSuwxGdVkzkYpi4TaJZ
 jecVpkRIj5CmFrRS1qKACrLgb3eIx5C9BfeVeimODedH+Dz/hcdchHq+x1b04B4hRZOxiQ9z6mNM6V
 4HHkRpO26nAiA6T7z9+YSQzVbHTxHOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=i0y6RSQK7dE3A6Y/eYZg4QjyeroqpJKUhXu6rdO6Qo4=;
 b=tawh23rV8gu8jKqNH/F+PQjY0phHkkqLNbhyRaeMeid8e4h303EMqugcfZwDtgW8U21GPOT+IZ8FF
 AHUcMwFAQ==
X-HalOne-Cookie: 03e7d3fadb5e1d8e6e2175ae13c72f7a820641fa
X-HalOne-ID: 24432e59-1749-11ed-8244-d0431ea8bb10
Received: from mailproxy4.cst.dirpod3-cph3.one.com
 (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
 id 24432e59-1749-11ed-8244-d0431ea8bb10;
 Mon, 08 Aug 2022 18:37:23 +0000 (UTC)
Date: Mon, 8 Aug 2022 20:37:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 01/14] iosys-map: Add IOSYS_MAP_INIT_VADDR_IOMEM()
Message-ID: <YvFX4eSZ8/PU4+RL@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
 <20220808125406.20752-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-2-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, david@lechnology.com, airlied@linux.ie,
 lucas.demarchi@intel.com, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, javierm@redhat.com, mripard@kernel.org,
 virtualization@lists.linux-foundation.org, drawat.floss@gmail.com,
 noralf@tronnes.org, daniel@ffwll.ch, jose.exposito89@gmail.com
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

On Mon, Aug 08, 2022 at 02:53:53PM +0200, Thomas Zimmermann wrote:
> Add IOSYS_MAP_INIT_VADDR_IOMEM() for static init of variables of type
> struct iosys_map.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  include/linux/iosys-map.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
> index a533cae189d7..cb71aa616bd3 100644
> --- a/include/linux/iosys-map.h
> +++ b/include/linux/iosys-map.h
> @@ -46,10 +46,13 @@
>   *
>   *	iosys_map_set_vaddr(&map, 0xdeadbeaf);
>   *
> - * To set an address in I/O memory, use iosys_map_set_vaddr_iomem().
> + * To set an address in I/O memory, use IOSYS_MAP_INIT_VADDR_IOMEM() or
> + * iosys_map_set_vaddr_iomem().
>   *
>   * .. code-block:: c
>   *
> + *	struct iosys_map map = IOSYS_MAP_INIT_VADDR_IOMEM(0xdeadbeaf);
> + *
>   *	iosys_map_set_vaddr_iomem(&map, 0xdeadbeaf);
>   *
>   * Instances of struct iosys_map do not have to be cleaned up, but
> @@ -121,6 +124,16 @@ struct iosys_map {
>  		.is_iomem = false,	\
>  	}
>  
> +/**
> + * IOSYS_MAP_INIT_VADDR_IOMEM - Initializes struct iosys_map to an address in I/O memory
> + * @vaddr_iomem_:	An I/O-memory address
> + */
> +#define IOSYS_MAP_INIT_VADDR_IOMEM(vaddr_iomem_)	\
> +	{						\
> +		.vaddr_iomem = (vaddr_iomem_),		\
> +		.is_iomem = true,			\
> +	}
> +
>  /**
>   * IOSYS_MAP_INIT_OFFSET - Initializes struct iosys_map from another iosys_map
>   * @map_:	The dma-buf mapping structure to copy from
> -- 
> 2.37.1
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
