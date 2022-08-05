Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29FAC25B08
	for <virtualization@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 113AB40556;
	Fri,  5 Aug 2022 17:59:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 113AB40556
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=u5wvGTKT;
	dkim=fail reason="signature verification failed" header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed1 header.b=Qk96pzna
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0goe2viVxXKN; Fri,  5 Aug 2022 17:59:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 80C59400AF;
	Fri,  5 Aug 2022 17:59:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80C59400AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6496DC0033;
	Fri,  5 Aug 2022 17:59:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEBC7C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 17:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9796160B77
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 17:59:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9796160B77
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ravnborg.org
 header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=u5wvGTKT; 
 dkim=pass header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256
 header.s=ed1 header.b=Qk96pzna
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eK36t3RQGhDd
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 17:59:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B52C460746
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com
 (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B52C460746
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 17:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=q/vKBB0XaDXfy/QTySPSqfse9Aar3Bz2vHnneZp8lno=;
 b=u5wvGTKTgDb38fZWgDJTDWkKmMS2tTjTDUpnZayyVEz8vStFY2ELLO6cywmVgyt2vm4bHlpjcThjT
 jJy0Xpe85xfz40wxk/mVnpEC1xfEasf1ZtzVD620ulFV1F6ER7VXGiXBVSyttPMjLUnxRjh8qGa5zC
 Q8uWoiT4VqCm8umbIdMM1teCyR2J4doEaBmdBXMXY5VOp6QDXjqs1GiGt0T7Xij2Yz9I/Epak9dikR
 MMjdL2qiSW6UhH6C2OqAt07H5ElotDCPd1AJpUrBb0BR5EBbs6fjWp2TxMLXYPYYxYlebfl116cktM
 EFtvDl/g3wL/5XGF+qtN+HpkSHMyDRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=q/vKBB0XaDXfy/QTySPSqfse9Aar3Bz2vHnneZp8lno=;
 b=Qk96pzna2LvnC+/Z/UklCBnIV7fLLSrVBKfa3bvhRviqZKb5gIdcHK+rDKz9RqSs8T4Co7Ns74qtD
 OcF265JAQ==
X-HalOne-Cookie: d59c01df2f2e30b20c4cba80847b11ee7a2fe26c
X-HalOne-ID: 5bc96b25-14e8-11ed-be82-d0431ea8bb03
Received: from mailproxy3.cst.dirpod4-cph3.one.com
 (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
 id 5bc96b25-14e8-11ed-be82-d0431ea8bb03;
 Fri, 05 Aug 2022 17:59:32 +0000 (UTC)
Date: Fri, 5 Aug 2022 19:59:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 00/12] drm/format-helper: Move to struct iosys_map
Message-ID: <Yu1ag4cElPDUJ4AM@ravnborg.org>
References: <20220727113312.22407-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220727113312.22407-1-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, david@lechnology.com, airlied@linux.ie,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 javierm@redhat.com, mripard@kernel.org,
 virtualization@lists.linux-foundation.org, drawat.floss@gmail.com,
 noralf@tronnes.org, daniel@ffwll.ch, jose.exposito89@gmail.com,
 airlied@redhat.com
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

On Wed, Jul 27, 2022 at 01:33:00PM +0200, Thomas Zimmermann wrote:
> Change format-conversion helpers to use struct iosys_map for source
> and destination buffers. Update all users. Also prepare interface for
> multi-plane color formats.
> 
> The format-conversion helpers mostly used to convert to I/O memory
> or system memory. To actual memory type depended on the usecase. We
> now have drivers upcomming that do the conversion entirely in system
> memory. It's a good opportunity to stream-line the interface of the
> conversion helpers to use struct iosys_map. Source and destination
> buffers can now be either in system or in I/O memory.

Thanks for looking into this - I like how we hide the memory details in
the helpers (system vs io).

And unifying the system and io variants makes the API simpler - also
good.

> Note that the
> implementation still only supports source buffers in system memory.
Yeah, I noted this in my feedback but realized only now that it is
written here.

I left a few comments (details only) in some of the patches, most are
reviewed without comments.

There is a few general things - mostly bikeshedding about naming and
such. As usual ignore what you think is irrelevant.

	Sam
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
