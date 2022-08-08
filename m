Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC57C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 18:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF34F40125;
	Mon,  8 Aug 2022 18:43:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF34F40125
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=qhGpcxdb;
	dkim=fail reason="signature verification failed" header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed1 header.b=krHftYRN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78QVPqZsSSHm; Mon,  8 Aug 2022 18:43:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4EB07400AB;
	Mon,  8 Aug 2022 18:43:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EB07400AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AA12C0033;
	Mon,  8 Aug 2022 18:43:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DF7AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8A24400FD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:43:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8A24400FD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CSOsDOaMIR1c
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:43:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4517400AB
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com
 (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4517400AB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=ZTp6SIDLt5GT3+bYAdxWFxhygxOBr/A7Riii2XrJfsc=;
 b=qhGpcxdb5iTbEBtvZPVLEA6ZpqKHR8yu4ZU8RMLVyULUlpuViXjv5sLW9s8EbpNBeuxkp3vOy+A3i
 ro3rWUTX2ntUy3aMfpdUg7VFehlTK83iDTfAA9xgwWrwwYQatToe5Q6Nn0lnkYJ5ebYDUbBF8Z9Ik2
 pWh1qlFKhJKTIgYAHepzyWGLCkYI5XJSk7f9rnow+JEsAoXU0B+yLxaoCQgdaBOx7CYyzjmoMupNxH
 ptVn1RYFMy9LM272K9Ab9qzU8/wMXvLpa+ASdikJ/bk75JFfibKV0nrg1gN2Aauj5kNT/2KrXiZg5n
 FLj+eSxKJHb+Y9hVxJs0wDH1aRHj5Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=ZTp6SIDLt5GT3+bYAdxWFxhygxOBr/A7Riii2XrJfsc=;
 b=krHftYRNaUIwUi2jPUvODBthBMPhm1UnlHVDq/my2tEemJ0SoWJXWf5GYoaSsokq99Zl2pUloaXyx
 6/KigL3CA==
X-HalOne-Cookie: eb00fd88576e255c300373dd3168e6e64109d575
X-HalOne-ID: 02a222c7-174a-11ed-a91b-d0431ea8a290
Received: from mailproxy3.cst.dirpod3-cph3.one.com
 (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
 id 02a222c7-174a-11ed-a91b-d0431ea8a290;
 Mon, 08 Aug 2022 18:43:36 +0000 (UTC)
Date: Mon, 8 Aug 2022 20:43:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 03/14] drm/format-helper: Merge drm_fb_memcpy() and
 drm_fb_memcpy_toio()
Message-ID: <YvFZVlkfUFowPeu3@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
 <20220808125406.20752-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-4-tzimmermann@suse.de>
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

On Mon, Aug 08, 2022 at 02:53:55PM +0200, Thomas Zimmermann wrote:
> Merge drm_fb_memcpy() and drm_fb_memcpy_toio() into a drm_fb_memcpy()
> that uses struct iosys_map for buffers. The new function also supports
> multi-plane color formats. Convert all users of the original helpers.
> 
> v2:
> 	* rebase onto refactored mgag200
> 	* use drm_formap_info_bpp() (Sam)
> 	* do static init in hyperv and mgag200 (Sam)
> 	* update documentation (Sam)
> 	* add TODO on vaddr location (Sam)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
