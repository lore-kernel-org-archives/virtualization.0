Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E67C6379F
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 17:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49EA54195F;
	Thu, 16 Feb 2023 17:21:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49EA54195F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WYkIUCtG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6tmO_Nxks_R; Thu, 16 Feb 2023 17:21:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7824841961;
	Thu, 16 Feb 2023 17:21:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7824841961
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 340C3C0033;
	Thu, 16 Feb 2023 17:21:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A22B4C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 17:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7DF7F40391
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 17:21:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DF7F40391
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WYkIUCtG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kslMU1dYlMOk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 17:21:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7E9E40158
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7E9E40158
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676568081; x=1708104081;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=dNVMHfU/r/DzOG+MoceUhtdAZ1gs3oDljzYjt9d0AR0=;
 b=WYkIUCtG1SV/axQKtJqQXESD5G7uQwOIP1ynsrOIu4Qetw1y6pz3SqdP
 FmA20A58eDWNPRekkX0BAlSAmje2FFtac/mAg/BCzBauVPvY43/YclQqI
 So3T446upBs3bK2btdKqIDq314BDk7evrVbd+FMMEBwiE8l9W0Fxds7UH
 NE+osDXgAkq9/fNXxNfpqvodHg5JzELfCavPDwQTw45wYyEsxJfmdBXOR
 qO6g7qmARDY1Dh45cTHIHE2vNCtqs9JlvpINuqnw3Hg3m6QE52VWKzTkF
 uvg+5vynZdnKdwY+aCarBpQEW59Lml81C+M3w3fHb3D0oqiZgHhGGWBOw Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333973613"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; d="scan'208";a="333973613"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2023 09:21:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="663543671"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; d="scan'208";a="663543671"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
 by orsmga007.jf.intel.com with SMTP; 16 Feb 2023 09:20:57 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Thu, 16 Feb 2023 19:20:56 +0200
Date: Thu, 16 Feb 2023 19:20:56 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 17/17] drm/cirrus: Use VGA macro constants to unblank
Message-ID: <Y+5l+BbN7JjpaQlH@intel.com>
References: <20230215161517.5113-1-tzimmermann@suse.de>
 <20230215161517.5113-18-tzimmermann@suse.de>
 <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>
 <306e110d-4d1f-cb9c-6f9b-c8a5ddd48a61@suse.de>
 <Y+4nIxRhF7KF2Qo0@intel.com>
 <ba4daf50-4882-5009-5c68-4385cacfdccb@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ba4daf50-4882-5009-5c68-4385cacfdccb@suse.de>
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

On Thu, Feb 16, 2023 at 02:21:43PM +0100, Thomas Zimmermann wrote:
> Hi
> =

> Am 16.02.23 um 13:52 schrieb Ville Syrj=E4l=E4:
> > On Thu, Feb 16, 2023 at 01:03:02PM +0100, Thomas Zimmermann wrote:
> >> Hi,
> >>
> >> thanks for taking a look at the patches.
> >>
> >> Am 16.02.23 um 12:33 schrieb Gerd Hoffmann:
> >>> On Wed, Feb 15, 2023 at 05:15:17PM +0100, Thomas Zimmermann wrote:
> >>>> Set the VGA bit for unblanking with macro constants instead of magic
> >>>> values. No functional changes.
> >>>
> >>> blank/unblank should work simliar to bochs (see commit 250e743915d4),
> >>> that is maybe a nice thing to add of you modernize the driver anyway.
> >> Yeah, it's the VGA PAS field. [1] But is it really called blanking? PAS
> >> controls palette access, but blanking is sounds more like DPMS.
> > =

> > Why aren't people just using the normal way of flipping the
> > screen off bit in sequencer register 01?
> =

> Setting the SD bit in SR01 isn't a bad idea. We can do this as part of =

> enabling/disabling the plane.
> =

> But for PAS, we don't have a choice. It's one of the bazillion obscure =

> VGA settings and (according to a comment in the source code) we need to =

> update it for compatibility.

Well, you do need to enable the palette to see something
other that border color. Not sure tha't a very obscure thing :P

On a related note, the code looks pretty sketchy. It just
blindly writes to 0x3c0 assuming it is the attribute controller
index register. But unless you explicitly reset the flip-flop
it could actually be the data write register instead. That could
easily happen if the previous access to the attribute controller
was a read since reads do not toggle the register role.

-- =

Ville Syrj=E4l=E4
Intel
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
