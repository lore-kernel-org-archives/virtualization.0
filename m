Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020680;
	b=Tods9eJ5C1e50/FKJZV6ynH0eEGH1cRmkvKwYOxdJVz5AUwqbQQNu7erDV+fWFQgwK1J
	 gYVVe8vXp1krHEiwmoVE/nvquZEjp2JX0EPnG1ea2Fx0dm3rD22R2z9IIM5EflVL2fzFg
	 sdljW+vRh6NEsZSknMLc4e1xqc6VEd4twmEN4sYwuZC8kvrT48J+R4AGOcXTXRgzgSpgQ
	 ADH1JjUDUidGMOcsIq9wS1ls72a+d7vnhgK7XdHjg+vRNleNz662aHdTHD2Q+pGP7erp8
	 dPFA/ni4Uj6NAzsP/RZB5kUIns6RtNj5mRTQHy5W1G5RYzsWGRFlyRL1gdtJgrYJ2rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020680;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/cUldU1e2XAI/ZxV0Ch4uDE5FUyxfirjC3SAjGA4JrA=;
	b=MdOsyd5LBjGK8ictZiH3Sl6o/W92FdT9eWuDEAT6TIxJW4D6oE57uLfjSyWWjKdccfDc
	 vmz6qYzZJz+90OY29Y5YAmbGJJQqsJUHwuiclA7bKaf5ws+ZniT5cki9Z52y6eyyb83D8
	 pMPnjUgYqUJxz6BFJQHgE3eh8/38s+HCgYW6mKIJDY9FQcSY2bxr+EEeVqN8krKf9IJVx
	 +v7Pw8wimSnww8Ob35XiApCmbPclTt4P30tBQ+EMXXX0REdc7qlhbnwu+nl+Zf5ZdXnU9
	 6AJ14xCfo+oLS8HiaLUoWX0xMxXo5ftY1H4Vh3FAMzxuDkoU5L3+ul4/A7EClMr5RUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="E7bR/4DJ";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42760A263C;
	Wed, 18 Nov 2026 16:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C42760A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E7bR/4DJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795020680; x=1826556680;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ajDnh0zw+64dcFPrEUfvS5sWfWZYQWJZbcQwO+AcVNs=;
  b=E7bR/4DJh5YbzHocFFIpAPmtKk9ggCJnqN7MeuUBIy77erwdx4Qj0zW9
   7AmNZZdHn+mbO/c8iNCVhx+Lf1UfjdgKq4PCJAfcKdEtPaOqOltBKxMJ4
   yhIwzQ34h21kM/n6FLQc8d5UapQYlDuwkIWIp7NMq5rPlOEl66TH293FC
   P9QbpRnJNgc+z2koC+4bFreXbDesML2ZT9GreUYVunZu5FhlSX5AixWDL
   vUItwz6XzUEKLENsGQNIGbqkJ6vXRu2s1H/EZQ3oIWrCsXpQF49egqqqj
   adaqme7U88uBmf5gmN2NZ/S46kgz/B1arycKCWvwZkIxUFzAfuU27qXxt
   w==;
X-CSE-ConnectionGUID: 2pM0sEieQwey1oInVeA3WQ==
X-CSE-MsgGUID: poBVPHPaTf+8pvsf5oAIYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3699698"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3699698"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:50:31 -0800
X-CSE-ConnectionGUID: k/DCmaX/Qp2q9S20vakyDw==
X-CSE-MsgGUID: YVFQiz1BSVmcIhLrCJbvrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9985477"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:50:21 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sasha
 Finkelstein <k@chaosmail.tech>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, dri-devel@lists.freedesktop.org,
 asahi@lists.linux.dev, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-riscv@lists.infradead.org, etnaviv@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imagination@lists.freedesktop.org,
 linux-mips@vger.kernel.org, lima@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 9/9] drm: Unify coding style for *_device_id arrays
In-Reply-To: <av2rKJQ0AKU9CFZI@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1795002467.git.ukleinek@kernel.org>
 <a2d5ce256b8ec150de4a6494c177b19693a33222.1795002467.git.ukleinek@kernel.org>
 <7692c160e418e7ad0528739fcc879b11fbac8ab0@intel.com>
 <av2rKJQ0AKU9CFZI@monoceros>
Date: Wed, 18 Nov 2026 18:50:19 +0200
Message-ID: <8ebe3b7219ffd963a498cccbcfe6cefc92717f0c@intel.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Nov 2026, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> w=
rote:
> Hello Jani,
>
> On Wed, Nov 18, 2026 at 03:27:40PM +0200, Jani Nikula wrote:
>> > [...]
>> >  drivers/gpu/ipu-v3/ipu-common.c               |   8 +-
>> >  drivers/gpu/ipu-v3/ipu-pre.c                  |   4 +-
>> >  drivers/gpu/ipu-v3/ipu-prg.c                  |   4 +-
>> >  254 files changed, 1155 insertions(+), 940 deletions(-)
>>=20
>> How do you expect a patch of this size be merged?
>
> Using b4 am :-) Honestly, in the cover letter I wrote about an immutable
> branch and offered to rebase to 7.4-rc1. When trying to apply this
> series on top ov 7.4-rc1 there are only 6 conflicts (1x modify/delete
> and 5x content); these are all not so hard to resolve (and even dropping
> the respective hunks (i.e. resolving using `git checkout HEAD`) is fine
> for me.)
>
>> > diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i9=
15_pci.c
>> > index 84a7dc6ab5db..faceb3de4fa3 100644
>> > --- a/drivers/gpu/drm/i915/i915_pci.c
>> > +++ b/drivers/gpu/drm/i915/i915_pci.c
>> > @@ -870,7 +870,7 @@ static const struct pci_device_id pciidlist[] =3D {
>> >  	INTEL_ATS_M_IDS(INTEL_VGA_DEVICE, &ats_m_info),
>> >  	INTEL_ARL_IDS(INTEL_VGA_DEVICE, &mtl_info),
>> >  	INTEL_MTL_IDS(INTEL_VGA_DEVICE, &mtl_info),
>> > -	{}
>> > +	{ }
>>=20
>> Personally, I would *always* use {} instead of { }, and would rather not
>> change.
>>=20
>> Across the tree, {} is slightly more common than { }. IMO changing them
>> is pointless churn.
>
> It depends on how you count. My statistic looks as follows (on top of
> next-20261117):
>
> 	$ git grep -l device_id | xargs -n 1 perl -g -n -e 'print "$1\n" if m/de=
vice_id\s*[a-zA-Z_0-9]*\[\]\s*=3D\s*{(?:\s*{[^}]*},\s*({\s*}))/' | sort | u=
niq -c
> 	      2 	}
> 	      2 {
> 	      6 {  }
> 	   2598 { }
> 	   1262 {}
>
> So over all *_device_id { } is more common by a factor of > 2. This
> series fixes one {  } and reduces the number of {} by 37. For only
> pci_device_id it's:
>
> 	$ git grep -l pci_device_id | xargs -n 1 perl -g -n -e 'print "$1\n" if =
m/pci_device_id\s*[a-zA-Z_0-9]*\[\]\s*=3D\s*{(?:\s*{[^}]*},\s*({\s*}))/' | =
sort | uniq -c
> 	    159 { }
> 	     32 {}
>
> Without the context of an array initializer there are many empty
> code blocks (function bodys or `do {} while (0)`), empty dt nodes, and
> {} in Rust code, which IMHO have to be considered off-topic for this
> statistic.

I realize my phrasing was careless.

My point was not so much about one being more common than the other, but
rather that there are *thousands* of instances of both, specifically as
C compound literals with empty initializer list. I think it's pointless
to convert one to other, regardless of whether you're adding or removing
a space.

I mentioned my preference, because if I were to go on a style fixing
spree, I'd go the other direction. But I think that too would be
pointless.

I suggest to just accept either.


BR,
Jani.


--=20
Jani Nikula, Intel
