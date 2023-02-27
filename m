Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02463C7EE23
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 16:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A99361053;
	Mon, 27 Feb 2023 16:07:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A99361053
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jDfonnAl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Ip_K2fpIUDv; Mon, 27 Feb 2023 16:07:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 015B561046;
	Mon, 27 Feb 2023 16:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 015B561046
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB739C0032;
	Mon, 27 Feb 2023 16:07:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B193C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64B8F81F46
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:07:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64B8F81F46
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jDfonnAl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2hYmnyeuLazU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:07:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FBD881F22
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FBD881F22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 16:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677514024; x=1709050024;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=XaqUCRPxJCEP+4LkIaXq8C52rHZtBFl42QMvotTeXGs=;
 b=jDfonnAlaHwebM1AT+0RtnOjb/nrlNx2ecA9xsjw9bxEmoFAawUaV3ga
 sopacSlxXa1yVv6ozZGZkIQpbuz5U5akO4nk5vwbR4oUC6Xe234fRcICq
 aV7tKPuCgqezYQ+Llywl64Nc73yMfvU0Ap1HF9f65drnTT7qOTyZTvTGa
 /U/sQ+qimAU0P7t/IoFWUN+KtWq3FveXfkLc5OytxZN6fnGLCjHSYumLd
 hCPM5MajMVWUTg8rmbHuu83EU5oF6HkgQdrloU6FTyzHMxFAo3os2Ns5M
 /Fn+pmRxGHDjsBrpBsI67H9RzxCbGHsMN2smjuU9QbNZIbkx5Dvk88QAW w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="314317827"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; d="scan'208";a="314317827"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2023 08:06:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="742622331"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; d="scan'208";a="742622331"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
 by fmsmga004.fm.intel.com with SMTP; 27 Feb 2023 08:06:46 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Mon, 27 Feb 2023 18:06:45 +0200
Date: Mon, 27 Feb 2023 18:06:45 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
Message-ID: <Y/zVFfSLoO5Fz/3D@intel.com>
References: <20230224180225.2477641-1-robdclark@gmail.com>
 <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
 <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
X-Patchwork-Hint: comment
Cc: Rob Clark <robdclark@chromium.org>, Ryan Neph <ryanneph@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@redhat.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
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

On Mon, Feb 27, 2023 at 07:40:11AM -0800, Rob Clark wrote:
> On Sun, Feb 26, 2023 at 10:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Fri, Feb 24, 2023 at 10:02:24AM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Add a build option to disable modesetting support.  This is useful in
> > > cases where the guest only needs to use the GPU in a headless mode, or
> > > (such as in the CrOS usage) window surfaces are proxied to a host
> > > compositor.
> >
> > Why make that a compile time option?  There is a config option for the
> > number of scanouts (aka virtual displays) a device has.  Just set that
> > to zero (and fix the driver to not consider that configuration an
> > error).
> =

> The goal is to not advertise DRIVER_MODESET (and DRIVER_ATOMIC).. I
> guess that could be done based on whether there are any scanouts, but
> it would mean making the drm_driver struct non-const.

dev.driver_features is a thing.

-- =

Ville Syrj=E4l=E4
Intel
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
