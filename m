Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994ACC00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 18:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1DE9A40135;
	Mon,  8 Aug 2022 18:51:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1DE9A40135
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=ofvJIALL;
	dkim=fail reason="signature verification failed" header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed1 header.b=ZuyWonf+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gMc1qIveE79M; Mon,  8 Aug 2022 18:51:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93DA640125;
	Mon,  8 Aug 2022 18:51:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93DA640125
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52A65C0033;
	Mon,  8 Aug 2022 18:51:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65A1CC0033
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 331E281427
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:51:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 331E281427
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ravnborg.org
 header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=ofvJIALL; 
 dkim=pass header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256
 header.s=ed1 header.b=ZuyWonf+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cL-aAE59312Q
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:51:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3AF1813B6
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com
 (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3AF1813B6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=s+0IzkHyklav4T4uKNIPC8LopLc1E14ktyVPjmXa5fo=;
 b=ofvJIALLPeLtYlXYuzkfTVRzn/6JQBW2j3y7Y9Osrp3KMGYQpv0E15FDHX4cqeKgDhEaaZm2O6FMn
 W6jYN5Sv9+hHxowCS1/0blyi4P068NEHuTE5uhz5+0AQ4HmB4kJYu2oUNiL2BFtR01CimUpVTWCLsA
 3Yybrj07eXNOLkU4NEh8FxDVBv1Yz9FVEYF3Pz+VdtJlpchq4GiVEM248zuHkZvmkFV8O2WFJHUlaW
 VjiAxkB3nw5yOUM6fnHRgP9lpu5wGeT4QvxiJDzGbPBg6//IyiyJnKcJrvR2ztRjHxoFTgTAHDF2iC
 T2J0pfOXSJ9bRLQ3lyeU1GqCabObZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=s+0IzkHyklav4T4uKNIPC8LopLc1E14ktyVPjmXa5fo=;
 b=ZuyWonf+u7HEq4n4GnMb3ltEwU1vl+o1dVh7eBOuIZiawi/GirMN9+hC6O+ncnrnzhli4InIb6RoG
 cyPi23YDg==
X-HalOne-Cookie: a9907ca109aae20e7cc54585a792875938ecdf2c
X-HalOne-ID: 100811f6-174b-11ed-a6cc-d0431ea8a283
Received: from mailproxy3.cst.dirpod4-cph3.one.com
 (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
 id 100811f6-174b-11ed-a6cc-d0431ea8a283;
 Mon, 08 Aug 2022 18:51:08 +0000 (UTC)
Date: Mon, 8 Aug 2022 20:51:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 00/14] drm/format-helper: Move to struct iosys_map
Message-ID: <YvFbGry6dvfTwceK@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-1-tzimmermann@suse.de>
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

Hi Thomas,

On Mon, Aug 08, 2022 at 02:53:52PM +0200, Thomas Zimmermann wrote:
> Change format-conversion helpers to use struct iosys_map for source
> and destination buffers. Update all users. Also prepare interface for
> multi-plane color formats.
> 
> The format-conversion helpers mostly used to convert to I/O memory
> or system memory. To actual memory type depended on the usecase. We
> now have drivers upcomming that do the conversion entirely in system
> memory. It's a good opportunity to stream-line the interface of the
> conversion helpers to use struct iosys_map. Source and destination
> buffers can now be either in system or in I/O memory. Note that the
> implementation still only supports source buffers in system memory.
> 
> This patchset also changes the interface to support multi-plane
> color formats, where the values for each component are stored in
> distinct memory locations. Converting from RGBRGBRGB to RRRGGGBBB
> would require a single source buffer with RGB values and 3 destination
> buffers for the R, G and B values. Conversion-helper interfaces now
> support this.
> 
> v2:
> 	* add IOSYS_MAP_INIT_VADDR_IOMEM (Sam)
> 	* use drm_format_info_bpp() (Sam)
> 	* update documentation (Sam)
> 	* rename 'vmap' to 'src' (Sam)
> 	* many smaller cleanups and fixes (Sam, Jose)
Thanks for the quick respin - I reviewed the remaining patches and looks
good. Nice cleanup of the API and it makes is easier to add more
conversions.

	Sam
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
