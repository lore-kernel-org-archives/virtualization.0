Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77969305678
	for <virtualization@lists.linux.dev>; Thu, 28 May 2026 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962472; cv=pass; b=tKm22lvuJzIYe4ewpKSarqukRDQHsZnUHomp+/henQMo/aycmxwI8qHfrAF4Sl2FSv/tV+ouzYk96YoRcyp+DXmTqrHGoB1UayacUJQf6ZM65nGZ3m3eNtNk9YdxMJ/Vh+kSgM2rqypNVCyrPr8Stj1cGYaM8Zo8H7xDpyT1cTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962472; c=relaxed/simple;
	bh=FzjUixVwJw0+1KE94lj+u5deezMCXP0d7xN7kG2mtOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G50oUy8NWuLDZwH9cFS+MBjiygSWviK5Vy2z3/7cozVO7Pa0LjYf8ROHBNipDZW3FA6LvnOKIdnFX9w0SfShoO3axEE2awmZWZHFxoMDbOpEHPacXCX6jo8OJfo/ltRgk/1OkSjUlwrJF81fj0VKdw7QgdLiexsMN9veVo6HK1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bmfi7n7r; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmfi7n7r"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c477a3278so12873628d50.3
        for <virtualization@lists.linux.dev>; Thu, 28 May 2026 03:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779962469; cv=none;
        d=google.com; s=arc-20240605;
        b=agAZxzlg0A9rz6fW1uYlJbQGNyy0Ye2uoBwmsh11hM/jFKWTxM0Eq10OYsy6cMhngj
         k3yRBcmZX2cW3MwsTzyYp+uxbv3K8Sv9CcPTlWN6zGMT8EYG0FOY75oyBXfStzKkt03x
         ASFlwphBfCdFHMPjrmV2nj0Dy7TyOeNCdv9ulzIn4NoAve0meLcD03SjKd5t9C/OfT7U
         uY31POaORPeWzyIlhO6eZcsnZE5Kd2ReSkgmRky9eSGeDLV33/paC+GBVhhLmroPbm6L
         lyIeiOJr+T7Vcapa4afApkE2CeYa3iBZAckucuA9uSMypEf3gYn9xPsauuvWN9ZdEUxZ
         H9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENaGop7hdOhRvlo9/v6zprcr5Co1+opC5qv3HonlvMs=;
        fh=l3GTyPSqpBW8BHjU5SWkoHzHiE+V64nzEoIAT5MJnWk=;
        b=cf9R4sAy1KBb6YozSZHxn32FGgEMprk1c24cUE/6rsPJyg2gGKSWT4bIqyL6/01CTq
         IsQwmtEo4wio+l+OL7UKMDdVKxmyH561ZDBzZ/Nq3TVP7zhofyxfPw7phxS+bxwOwRhH
         iO72E42NZ5+bsb18C0GwNNqyev3qR+8GyeKAGEkfn4+THstdzxl0LTXKIH/E99zX7KrY
         n9HZOGwmEaNNHXPmJRUriEk/gsvQ/cl0ZoKrcIBTbU93uzKEy1wpGR131q2cbofE6aJS
         sNm4WioSixIVt738kAWK+8ZSz8oLPH5mbfSm2eBhfhYE7ZXnmjYBN+mlvtc5CkDNMBen
         9SZA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779962469; x=1780567269; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENaGop7hdOhRvlo9/v6zprcr5Co1+opC5qv3HonlvMs=;
        b=Bmfi7n7r6iyIPIkehKmPrxisOZGWCZ+R4O7WPk8e7K0tPk4qxYOQ1ILfguvuVAeLAl
         abf9PBbXEnhRJMvrD0/5RWRXJeiYQmd96nhUm9tJ4JNT2ioVSBcLzx0djVpY6XA5/Npf
         tP0loE8ow8ovvK9seAa6tRc6q+SkR30NTmPwIZv6u/4kH2lg4q+tSFOw6rnqFSBL4ehh
         OXCz+zybtkhbhnStC3fzPtAeXyS6Umdw+oRkXnOaw1QPIm9Ra06Laif36KOx0wGtoX5c
         dzJLehYyOj587fL4fjMSUIGeEKsseJTwTEt7tq6RQbRYzhC6sfXiJfjHP7WLvKbyMAYW
         ny+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779962469; x=1780567269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENaGop7hdOhRvlo9/v6zprcr5Co1+opC5qv3HonlvMs=;
        b=r/6qDZR0gNnL0XlL5w/Uf7VW7xORoi9KmajZUao1nxNFJ7o9HooKggaZ4FFvJaNF/0
         XsSCUjxTUQ+7hiaUaPRgt959N/hW6WlLPkZVmkxmEJWZDP9kVYxIR7yNifLIigR8dXZr
         DITG9MqrdcXZTldMEZwIZw6+dur18c7bJ9Pk69p1dGiIT4VuXy3Z1QCtNY+oUz/RbS+9
         akU0o3jxgw+PUUCxlQFaGR68pBYSvhARfaGrzWksld4O8rpCMfyYi7vWuLDDfiXiHw7A
         47eooIBGLInEzXto3pdiGE5acChJei3yQ++hAjLAuY7P6FohQDevOWnX1HbgmJsjmALR
         ou2g==
X-Forwarded-Encrypted: i=1; AFNElJ/50nHMWXJ7WYbHK9/RdLJlrWZ36hMpIi387exBvhq6grY0HkIg21ymt7oWK8EmWCzSIDl1tQLG4X3idlg9Pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRDzAEByoYvkN1UZEEWWpcNugdQwUedjZ6QOFFgJsn9ZD+8dCP
	lup5nnaGXqFqdhpKsiz8ChTNJ536S4bkaidFKtIBS4BmAtP3M7/0FLuKLg3bSDs9SsKXoP9RrRt
	1u50dX+Ii/PYxez4klNG7ovDnog2BfBQ=
X-Gm-Gg: Acq92OFkPdieMRLi92URVc8QuSvcDUrSVzMwKPOGJzDbqIMcL/Talysp9UKne5TkLIc
	P4rAbJnHkJYZrzpC7Lku+vg4+dQBRdewNKpiqfO0Q4OLUO7A2d7v+lCmQL21AdFxPLIMb5K1c61
	vEpCklLgpTec0z3keXH0vXUQIykbbWDt+5wf8iJdHwWsO5nmPnt+qPmIf2R3sJrvLlFb3zQrJcO
	a5WLbH5YFTS+T9RcwtupHoXepARSbfTgHMUcefK5yT9cwY8cyjbnzOKZ8pxLryjhVfxSQiQp0oS
	hEDn16oNXlvJpDG9huWOxBYA/FhIOyxJbMrWEpfct3SQsdp4nAJe/iwn8kUkfacZ0fCrVGSomGb
	FAz78pw==
X-Received: by 2002:a05:690e:4090:b0:65e:421f:25a with SMTP id
 956f58d0204a3-65ec9938b9dmr23205364d50.53.1779962469261; Thu, 28 May 2026
 03:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260527133917.207150-1-tzimmermann@suse.de> <CAHijbEVZBRTK7yhZy8gaZwb19JMzUD_nA2S1LOKX2NrK19RBsQ@mail.gmail.com>
 <1d399c2d-b50f-4d19-8170-9db8961e4227@suse.de>
In-Reply-To: <1d399c2d-b50f-4d19-8170-9db8961e4227@suse.de>
From: Julian Orth <ju.orth@gmail.com>
Date: Thu, 28 May 2026 12:01:01 +0200
X-Gm-Features: AVHnY4Kd6TXNqqh3i-IesxOIMTyuSSIzXsJX_ARE_lWWTyd_wM1yd783Bw12QD0
Message-ID: <CAHijbEUKpOuDLJES9AbSp8Pk+egeDPe7KPyBy1xBFM9ET9peCg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank interrupts
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, mdaenzer@redhat.com, 
	pekka.paalanen@collabora.com, jadahl@gmail.com, contact@emersion.fr, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, mhklinux@outlook.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	wayland-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 9:54=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 27.05.26 um 18:31 schrieb Julian Orth:
> > On Wed, May 27, 2026 at 3:39=E2=80=AFPM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
> >> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
> >> refresh. This is meaningless with vblank timers, which run unrelated
> >> to the hardware's vblank.
> >>
> >> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
> >> for CRTCs with simulated vblank events in all such drivers. The vblank
> >> timers of these devices still rate-limit the number of page-flip event=
s
> >> to match the display refresh.
> >>
> >> According to maintainers, user-space compositors do not require the io=
ctl
> >> for rate-limitting display output. Weston, Kwin and Mutter rely on com=
pletion
> >> events. Mutter optionally uses the WAIT_VBLANK ioctl only to optimize =
the
> >> time from input to output.
> >>
> >> When testing with mutter and weston, the page-flip rate appears correc=
t
> >> with the patch set applied.
> > To avoid this being a regression, you need to test that this change
> > does not regress input latency.
>
> Let me stress that the current situation is that there's high-quality,
> and low-quality and no timing information. Depends on the driver and
> hardware.
>
> >
> > As discussed on IRC, compositors use vblank data to predict the time
> > of the next flip event. For each device that you are touching here,
> > there are two possibilities:
> >
> > - The vblank data is related to the flip timing, i.e. flip events and
> > vblank events are sent at almost the same time. In this case removing
> > these apis removes the path for compositors to predict the time of the
> > next flip event. Input latency will therefore regress after idle
> > periods when the compositor no longer has the time of the last vblank.
>
> User-space compositors seem to operate under this assumption. That, I
> think, makes sense on better hardware with rendering and vblank IRQs.
> Page flips are fast on such systems.
>
> >
> > - The vblank data has nothing to do with the time of the next flip
> > event. In this case this series could in fact improve latency because
> > it removes the incorrect data from the compositor.
>
> Most of the hardware that would use vblank timers falls in this
> category. Page flips often consist of memcpys into video memory, or they
> transfer pixel data over slow peripheral busses. The amount of work per
> page flip varies with the size of the damage rectangles.
>
> Any vblank timing information here is therefore of low quality. For some
> scenarios, it would be common to miss a vblank or even the one after it.

What matters is if the flip event will be aligned to _some_ vblank
event. As long as that is the case, the compositor can estimate which
vblank it will hit based on previous frames and can schedule its work
accordingly. I believe KWin and Mutter already support scheduling
frames for multiple vblanks in the future to support low-powered
devices or devices that are under high load. I have not looked into
this myself.

But even on high-powered devices compositors already take per-commit
kernel work into account. For example, by default I aim to commit 1.5
ms before vblank. This grace period is adjusted dynamically if I miss
the expected vblank.

Therefore I don't think this is an argument against exposing vblank
info. Even if the hardware had such an interrupt, the memcpy and
slow-bus issues would continue to apply.

>
>
> IMHO, the first thing to discuss is whether having possibly low-quality
> timing information is preferable to having either high-quality timing or
> none. I have no strong opinion, but would tend to the latter.

If you want to make userspace aware that vblank events are not backed
by hardware interrupts, then maybe this could be exposed as a driver
cap or a flag in the vblank event. Userspace could then decide on
their own what to do with that information.

Currently I don't think any compositor would use that information
since they target flip times and don't care if those times are driven
by hardware or software (since this is not actionable by userspace
anyway). So maybe the useful flag would be "flip times will not be
aligned to any vblank event" if that applies to any driver.

>
> Best regards
> Thomas
>
>
> >
> > Whether the times of the flip events correspond to hardware timings is
> > not relevant. Everything in wayland compositors is scheduled against
> > flip event timings and they are also forwarded to clients for their
> > frame scheduling. If the flip timings are wrong/out of sync with the
> > hardware, then removing the vblank apis does not improve this
> > situation.
> >
> >> This change has been discussed at length on IRC recently.
> >>
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-08&show_html=3Dtrue
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-12&show_html=3Dtrue
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-13&show_html=3Dtrue
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-15&show_html=3Dtrue
> >>
> >> v2:
> >> - add filter to CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Mich=
el)
> >> - clarify Mutter's behavior in cover letter (Michel)
> >>
> >> Thomas Zimmermann (9):
> >>    drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
> >>    drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
> >>    drm/amdgpu: vkms: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/cirrus: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/hypervdrm: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/qxl: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/virtgpu: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/vkms: Set DRM_VBLANK_FLAG_SIMULATED
> >>
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    |  3 ++-
> >>   drivers/gpu/drm/drm_vblank.c                | 26 +++++++++++++++----=
--
> >>   drivers/gpu/drm/drm_vblank_helper.c         |  2 +-
> >>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  2 +-
> >>   drivers/gpu/drm/qxl/qxl_display.c           |  2 +-
> >>   drivers/gpu/drm/tiny/bochs.c                |  2 +-
> >>   drivers/gpu/drm/tiny/cirrus-qemu.c          |  2 +-
> >>   drivers/gpu/drm/virtio/virtgpu_display.c    |  2 +-
> >>   drivers/gpu/drm/vkms/vkms_drv.c             |  4 ++--
> >>   include/drm/drm_crtc.h                      |  2 +-
> >>   include/drm/drm_device.h                    |  2 +-
> >>   include/drm/drm_vblank.h                    | 15 +++++++++++-
> >>   12 files changed, 45 insertions(+), 19 deletions(-)
> >>
> >>
> >> base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
> >> --
> >> 2.54.0
> >>
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=
=BCrnberg)
>
>
