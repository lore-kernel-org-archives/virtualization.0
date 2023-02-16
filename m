Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2629C677F1
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 12:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 490894186F;
	Thu, 16 Feb 2023 12:53:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 490894186F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mAVv60tl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BsQfKDmjz2V0; Thu, 16 Feb 2023 12:53:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7744841872;
	Thu, 16 Feb 2023 12:53:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7744841872
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F7FDC0032;
	Thu, 16 Feb 2023 12:53:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A868C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D29C680C1C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:53:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D29C680C1C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mAVv60tl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZaV1FzjGFiX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:53:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C5F180BB2
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C5F180BB2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676551982; x=1708087982;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=STp968vNJjTs7QU1ZnUXo9mg8t5kgUObqdNlZ4ETOKM=;
 b=mAVv60tlcoikcV5iSxozu/5VJm3k1qRLDf27UKb0K4PLxhJy9YYl9vtW
 kourfp4uuwfIh5uZk0I05xkrxehTLFggkjdqeZHHoK/+JEhQotypi56A9
 XInzvFJGnqxGMPoW947dlw7UpXqRTp9v5qhQweVPEShliPfqhaTdI8oQc
 9Fgyg26IlJhAewyU3u6jyd8eFBEct8A9gXuhrcKm/P+GwOmbYkOGVz620
 SgWjXcaZwPG7LwcmeTXd1PJ1kpy/KQPEp0hWq/DZqx3BWzUxZ2FlT4Sy+
 BaEHp80sEA3cXJFwg9EyJkYAPmW0Lyo0F3lqRso9AyR2VTvR6SwQ1l1z3 Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="417929913"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; d="scan'208";a="417929913"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2023 04:53:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="794013670"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; d="scan'208";a="794013670"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.168])
 by orsmga004.jf.intel.com with SMTP; 16 Feb 2023 04:52:57 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Thu, 16 Feb 2023 14:52:51 +0200
Date: Thu, 16 Feb 2023 14:52:51 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 17/17] drm/cirrus: Use VGA macro constants to unblank
Message-ID: <Y+4nIxRhF7KF2Qo0@intel.com>
References: <20230215161517.5113-1-tzimmermann@suse.de>
 <20230215161517.5113-18-tzimmermann@suse.de>
 <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>
 <306e110d-4d1f-cb9c-6f9b-c8a5ddd48a61@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <306e110d-4d1f-cb9c-6f9b-c8a5ddd48a61@suse.de>
X-Patchwork-Hint: comment
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, airlied@redhat.com,
 sam@ravnborg.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Feb 16, 2023 at 01:03:02PM +0100, Thomas Zimmermann wrote:
> Hi,
> =

> thanks for taking a look at the patches.
> =

> Am 16.02.23 um 12:33 schrieb Gerd Hoffmann:
> > On Wed, Feb 15, 2023 at 05:15:17PM +0100, Thomas Zimmermann wrote:
> >> Set the VGA bit for unblanking with macro constants instead of magic
> >> values. No functional changes.
> > =

> > blank/unblank should work simliar to bochs (see commit 250e743915d4),
> > that is maybe a nice thing to add of you modernize the driver anyway.
> Yeah, it's the VGA PAS field. [1] But is it really called blanking? PAS =

> controls palette access, but blanking is sounds more like DPMS.

Why aren't people just using the normal way of flipping the
screen off bit in sequencer register 01?


> =

> The PAS setting is actually part of the primary plane, so it's current =

> location in the CRTC code is misleading. I didn't want to change the =

> driver logic too much, but I guess I'll fix that in the next iteration.
> =

> Best regards
> Thomas
> =

> [1] =

> https://web.stanford.edu/class/cs140/projects/pintos/specs/freevga/vga/at=
trreg.htm#3C0
> =

> > =

> > take care,
> >    Gerd
> > =

> =

> -- =

> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> (HRB 36809, AG N=FCrnberg)
> Gesch=E4ftsf=FChrer: Ivo Totev




-- =

Ville Syrj=E4l=E4
Intel
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
