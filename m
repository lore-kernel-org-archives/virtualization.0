Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569541B365;
	Tue, 31 Mar 2026 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972278; cv=none; b=cw8nX5XX0s/WpGqsu85mgAqNiIL/kqsapRoLywv2IV8dC9rW0wN8y/Vumo6dxGLwshmxF/4IrIbQkR31Jul0r7qwGzOSBjAnmj4SxZt2RJyphB1MigOM6tcPPZdiFMkwd/bE2iIkKJUnwwuneaZkvXlIY7eF0ETNpUTHY52rn14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972278; c=relaxed/simple;
	bh=Nge5zor6zpLsko98SNlgKwkLdBZ67zYKvW4fhw7iRFI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ivsFXA6BQVMWOHwDpSivCyjeWuuZsp1pGAFXDgx/5PVFRpdq4JsPKCEGqGC+IjXUn/AG6RiGqCopSNsMmI5mE1WdKiGudHpm3BzKqVrFfSckDyyiOcc/B274wswWoCflP/osVufzh6yGD5ydNaGLRnubhhOplS2NAIcKGRO9zBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPPVnCRl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPPVnCRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774972276; x=1806508276;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nge5zor6zpLsko98SNlgKwkLdBZ67zYKvW4fhw7iRFI=;
  b=jPPVnCRl3+uoiRh+4DgQvV86Ct1cBMK5Eq9riRtLf5ynwETwAs/xPLNS
   vHUtLgsnSno/c58W4rANBoF6O+V4wT3AyTUpwRL9qBeD5ZnURhUWTWCz9
   51IZVfzVR32MjE/vjcZRvU8kYerekzLHWZWMmTkZ0v6GUGzWU2JuTN55w
   GJHySzkENll/g0YKzOQvaV4pHBuhjqEz1WMQVyYgFXPoRXq4QQSt/aBQy
   y0hjhZj01hRlapoRekY6Dg2vbc473HahP8SOy9Qzp5Xk9Jwh51zWuVjB+
   L+WmFoDez6QEQ0B5EcwwiOLpEB1fNC6ZdAuRJTm/mae43oeeSmJtzol4C
   A==;
X-CSE-ConnectionGUID: GmcUQSrDRSixPb7ziHLC7g==
X-CSE-MsgGUID: 4uEdOzxTTumIq9smZzRfnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75162635"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75162635"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:51:14 -0700
X-CSE-ConnectionGUID: Erx6h0j4SBaLVonmWZa8AQ==
X-CSE-MsgGUID: i5Ax2DCyQZGon6IlICWnbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230465746"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:50:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 31 Mar 2026 18:50:52 +0300 (EEST)
To: Danilo Krummrich <dakr@kernel.org>
cc: Russell King <linux@armlinux.org.uk>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>, 
    Nikhil Agarwal <nikhil.agarwal@amd.com>, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Mathieu Poirier <mathieu.poirier@linaro.org>, 
    Vineeth Vijayan <vneethv@linux.ibm.com>, 
    Peter Oberparleiter <oberpar@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, 
    Harald Freudenberger <freude@linux.ibm.com>, 
    Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
    "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
    Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
    =?ISO-8859-15?Q?Eugenio_P=E9rez?= <eperezma@redhat.com>, 
    Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, driver-core@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
    linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
    linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, 
    virtualization@lists.linux.dev, kvm@vger.kernel.org, 
    xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org, 
    Gui-Dong Han <hanguidong02@gmail.com>
Subject: Re: [PATCH 06/12] platform/wmi: use generic driver_override
 infrastructure
In-Reply-To: <f819b7d8-5c80-4463-9afa-933a2ddc8ab3@kernel.org>
Message-ID: <dc11f3fd-a5c7-16e9-8417-6dddb63129fa@linux.intel.com>
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-7-dakr@kernel.org> <f15629e4-ef8f-b1b6-0158-064f40f111da@linux.intel.com> <f819b7d8-5c80-4463-9afa-933a2ddc8ab3@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2141551316-1774972252=:989"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2141551316-1774972252=:989
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 31 Mar 2026, Danilo Krummrich wrote:

> On 3/31/26 5:02 PM, Ilpo J=C3=A4rvinen wrote:
> > I tried applying this to platform-drivers tree but it failed to compile=
 so=20
> > I ended up dropping the changed.
>=20
> As the cover letter mentions, it sits on top of v7.0-rc5, did you conside=
r this?

I noticed it but I just assumed you were working on top of that, not that=
=20
there's something past -rc1 that is required.

> I can also pick it up via the driver-core tree.

If there's some post -rc1 material this depends, it's probably better that=
=20
way.

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-2141551316-1774972252=:989--
