Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7D1D5159
	for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850096; cv=none; b=VWpgV0vwlI8cuYkQcdG2rhEzEPZUa9ORgycw3yVfg0WMkV0kVOE8e54sVlu+t5HBDunQ46xPFVAMWbI5aQk5egp5Q5eHYJh2os7YxjX7D/u1sHF5rcwpqXZsU44UqBvK/NCmFa1adQqIexBlCkUSmGSAHvyCbwNU6Ue3zwVzVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850096; c=relaxed/simple;
	bh=ovzUCbOnf8ad3/AG/s6edyQx3Y96JvN5zzmYGNZvn88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrGc3RYfdVBCEwsm3mvWg8MaiChO+SVdIYSkkdEFkTHGJkAPVS/RAWqH6yGJjK1LhmBNetdmJJY9Sne2GeWpOqkKyYTP4clSP/MiVKF5Lok2goMkvkhM17li8TZZ3I61nyFgySJEkNSP4Tz8X5qj/XjcUKYpF75MO/faASO0KRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H5VG8UHp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5VG8UHp"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e35f08e23eso18031097b3.2
        for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729850093; x=1730454893; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovzUCbOnf8ad3/AG/s6edyQx3Y96JvN5zzmYGNZvn88=;
        b=H5VG8UHprfP+BDpti5JNXss+n524PmWLwpGHc201cp21N6H/VFEUp8pBwdgoY4MX6l
         jSfd1zPpxyGosUzcWa3uLchdwD/hYO/8F83B1yk8QsLPKUkLol1Jdm8UfT+3NtY7HQ8r
         JYO+WK3DKhLAFeLQxLOaeuwjdu6ryBeJzIyExC8EHUkolQ/asmdP1R/arEqSKZ5c43ut
         8IytPU8jpM2LSQTSjnKtdL61//+tjavWD+rt5GPRHnIKHqCBveFAza8h6I3C2b7Oymmp
         sgctWFrofQRN7hkO6Fav/OPrhGvtY97Ja4ehmR5FRKH6F0Wh5Wv05y07aUhnLyLxBMjN
         8CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729850093; x=1730454893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovzUCbOnf8ad3/AG/s6edyQx3Y96JvN5zzmYGNZvn88=;
        b=mBZ/R/xYoIykDgGjG4BqtkkgfB4MtfAHtUxYGOOSB1KU41GnBdkwVMYtsvYBUVBcsc
         pdPlfTtkJD3mokMXbONcnMJMBqBk1rliUvVam66gWowKSYTS5ZVjnrZoL67Xsnnt/kMb
         kaLRzO9rhLsICBqFDzNpS5igCLWIAmYKM+FwqpsEXC8A04CsK3geFFk9DQRDq6w0747x
         TyxH6OANreGgoYinHRWFozdMo6JTy4cfWZmEl7bD7Nde5w++mRGfTDCuL+RZ99niIHYL
         5DGaBQ0rlIUEl94l6CtO2SnEViam1mvvr8ve49dbf70K9WUZEblQcL3ozMK7C/+n5ocf
         fxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4wflgFkrdszROFZBcl8Tnr7gtADyEygQ6JF8nHs82avd56n1uHgZp8VI3OfspSu3o1ZlCCdls+CpDk3mSQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVEIog0BN3C/C+Nq9UGCvf3qBoa9V5yDZR8R343nY1JOzje/V/
	4tguBC66Ep4uMvgstJOmB1CcrdcGcsW609Fyd7KVTUyXMW05OpDAmGt37GmukCIKguzAFqWJXel
	BovvXBqyrALHnNBO9rtnh/aX6FQstiAg1myOXJQ==
X-Google-Smtp-Source: AGHT+IFZu/LyAjfpwX5MrN+JVkr0x0xSzSrKk0A5Mdi5tj38z9PJE4G47Yh4NVVkEqgziX0kL7VNUYJrsxipC6JS6p4=
X-Received: by 2002:a05:690c:fc7:b0:6e7:fb87:7094 with SMTP id
 00721157ae682-6e85814d77fmr57343097b3.6.1729850092872; Fri, 25 Oct 2024
 02:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241002182200.15363-1-ville.syrjala@linux.intel.com> <ZxtMz8JP3DbzpMew@intel.com>
In-Reply-To: <ZxtMz8JP3DbzpMew@intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 12:54:42 +0300
Message-ID: <CAA8EJprT=BGyMnvkjS4BkRqar1hHn_hpXFaz9gstPL_9u1rAsQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm: Treewide plane/crtc legacy state sweeping
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Alexey Brodkin <abrodkin@synopsys.com>, 
	amd-gfx@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Danilo Krummrich <dakr@redhat.com>, freedreno@lists.freedesktop.org, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Inki Dae <inki.dae@samsung.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Karol Herbst <kherbst@redhat.com>, linux-amlogic@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-msm@vger.kernel.orga, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Liviu Dudau <liviu.dudau@arm.com>, Lyude Paul <lyude@redhat.com>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, 
	Marijn Suijten <marijn.suijten@somainline.org>, nouveau@lists.freedesktop.org, 
	nouveau@lists.freedesktop.orga, 
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Rob Clark <robdclark@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Sandy Huang <hjc@rock-chips.com>, Sean Paul <sean@poorly.run>, 
	spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Xinhui Pan <Xinhui.Pan@amd.com>, 
	Zack Rusin <zack.rusin@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Oct 2024 at 10:46, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Wed, Oct 02, 2024 at 09:21:58PM +0300, Ville Syrjala wrote:
> > From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> >
> > An attempt to hide the drm_plane/crtc legacy state better.
> >
> > This also highlights the fact that a lot of supposedly
> > atomic drivers are poking around in the legacy crtc state,
> > which is rather questionable. For planes we did force the
> > legacy state to NULL already to force drivers to behave.
> > But even then it seems capable of confusing people with
> > its high profile location directly under drm_plane.
> >
> > This might end up as some kind of conflict
> > galore, but the alternative would involve trying
> > to wean the atomic drivers off one by one,
> > which would probably take forever. At least with
> > this the issue becomes visible and shouldn't be
> > forgotten as easily.
>
> Ping, anyone have thoughts on this? I'd like to get something
> like this in at some point to make the legacy state (ab)users
> easily visible...

I think that's a good idea. I hope to find a time slot and check the
(ab)using of legacy state in drm/msm driver.

>
> >
> > The cc list was getting way out of hand, so I had
> > to trim it a bit. Hopefully I didn't chop off too
> > many names...



--=20
With best wishes
Dmitry
