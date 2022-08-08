Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64D0C25B0C
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 18:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 167C2400AB;
	Mon,  8 Aug 2022 18:48:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 167C2400AB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=P2rPpRRu;
	dkim=fail reason="signature verification failed" header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed1 header.b=s9QBiZO6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QzKXMl8s80Lk; Mon,  8 Aug 2022 18:48:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8BBFE400FE;
	Mon,  8 Aug 2022 18:48:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BBFE400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F91AC0033;
	Mon,  8 Aug 2022 18:48:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 781A4C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5259A60774
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:48:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5259A60774
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ravnborg.org
 header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=P2rPpRRu; 
 dkim=pass header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256
 header.s=ed1 header.b=s9QBiZO6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dkUy5lZHPOsa
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:48:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56CB160746
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com
 (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56CB160746
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=BhhRnrAt9wyuOY21AkpBELEGGKnK2sl/WTGi2e4pR6Y=;
 b=P2rPpRRutX2GxTjySu/NEabaRTyGMieEn/XPhmxRH+gihWaj1c7fYxSWiScgNv0zNsbwV5Mcgw0gD
 uhqLAu1vzJI3N68YCQqlcKbWfHYU+GRIw7W3ILjsglfkGEI5pBVqkOibjFN+AtbaH11TrMUlzU0Iqb
 sLYVsG8wJ01tLH+Dlqfq8IbWIunE7lq/xkRl3ixfBmIgkW+eICUWxNeiqvj75r1x+yrl4SE6EDxAsN
 nEo7v44xo5vyKmGY3JZq48DXP029e6xS+FOHF4+8vcrtnXVbBXLmP2rFMOIg71F9fUQDZgipkiDh4r
 wVueqbzh+S5xI6RS9KN0zWxx8iWUgQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=BhhRnrAt9wyuOY21AkpBELEGGKnK2sl/WTGi2e4pR6Y=;
 b=s9QBiZO6o2FS+3Z8d6BzQSoFZiXrsu1f56QjqReWzKR4p7rbTRqjGpew8WCzJIGEg380mtWM9JGUu
 1L7KLdTCA==
X-HalOne-Cookie: c556d9ec8f471dba3901cbcfc1141056435aafd9
X-HalOne-ID: a32d9dc2-174a-11ed-8244-d0431ea8bb10
Received: from mailproxy2.cst.dirpod3-cph3.one.com
 (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
 id a32d9dc2-174a-11ed-8244-d0431ea8bb10;
 Mon, 08 Aug 2022 18:48:05 +0000 (UTC)
Date: Mon, 8 Aug 2022 20:48:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 13/14] drm/format-helper: Move destination-buffer
 handling into internal helper
Message-ID: <YvFaY9qRZ+zIPiTS@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
 <20220808125406.20752-14-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-14-tzimmermann@suse.de>
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

On Mon, Aug 08, 2022 at 02:54:05PM +0200, Thomas Zimmermann wrote:
> The format-convertion helpers handle several cases for different
> values of destination buffer and pitch. Move that code into the
> internal helper drm_fb_xfrm() and avoid quite a bit of duplication.
> 
> v2:
> 	* remove a duplicated blank line (Jose)
> 	* use drm_format_info_bpp() (Sam)
>  	* fix vaddr_cached_hint bug (Sam)
> 	* add TODO on vaddr location (Sam)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
