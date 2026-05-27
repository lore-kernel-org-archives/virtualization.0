Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4EA43637C
	for <virtualization@lists.linux.dev>; Wed, 27 May 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899496; cv=pass; b=ehmU7t2751HJfr4YTeeYm07d5lAUMQzakXalPGf8fO+0yZaQ/LoW05QcWADLpi/aPx4n63tNoi8oF+fJZojvupjBrk3cjFtmjCIU6rHZnpzKi0IEKXogTdfuFS+QlkQACzKOD0geFYU7RrGcQGE8UIT/+j8fx6GeaeYQTfN4+Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899496; c=relaxed/simple;
	bh=41fjdWeo1ypd6ycqKoTySWJowPiFRaJs4jlzo281OZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1ND/Hg6CTbufGEeWcqKDh1OybvVkskPhxzbYkpw0nhTfVxY0zrFeXv8ocnAgBiTTecvo3Ku62Xi8RF8bnl3fp+gdz8my+AhQfF4djHf6NB4UEEmXRMe2qrlJf56doK/sn/1s6vEGH6KCKvKVMeoJHvP86zug+kKBIIrcKoBYkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu6nE3QO; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu6nE3QO"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65e15fb394bso8367594d50.2
        for <virtualization@lists.linux.dev>; Wed, 27 May 2026 09:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779899492; cv=none;
        d=google.com; s=arc-20240605;
        b=AUJ3RoCwKIO1b12ILQS/BfeANOE9wK2x3B4fcEU1L0nlEuykhbnjqO3TZw/DhemlTj
         CqMMqaWODmuhLEZBF9Y3UMO03MjwhKqLVGHoghCp6rgZQY4LPOMvAIs1WdNlX2SqypGj
         qN3Qh5A6extEcSy5/Zs94kzCGCSbq4cBNJLARiTnYczzPBzPmEKqPcAmZQZ2HzGFPZgF
         hkg5cRt86vig6nylcWlZETiisqLIgxC4CNpEsD1lEsPLZNJxKYmxWx7MV7hjuh5Kq8tN
         fuqj6u3NmO2L+tJre5za7sb0H9uB+44Uq9HA6MXYFHEpbj1u36LSiJXpc0VxLA56upGl
         bQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
        fh=NI0mB/s83ocJET8xw/DpePnrcBID6k+U13gnLawIMAQ=;
        b=H52ZbFtOi3E9ilypy5cWqA7vvein/XM4UxZ6X+TMMlel13ShELt2BF64+Ujl8sxao+
         hRxcmMeysS536TqCRIL61TNMgTZu1NwaMoarjyKDtL5W3FWKr77pjZsin09bDEBJ/JsS
         RD8IaKli4QJPK6aZY39ziJsgsPysbMAog/vuBGpUjZeV35Hb2+iHvuVHAKo4ikX2FjQ8
         zgCri41LB4CbQGilK2MwHxTypIp13RMF4k9rFAEppLlEm8EpjT800pQkN964PmEpXYDL
         20XfNMD93nkk4+Elkju8TT1mcTO1iHJfHo8r8mUrRQbrQctZmjaYn9CVK/2J57mfI59Z
         i2VA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779899492; x=1780504292; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
        b=Xu6nE3QO4XZCUjhIXtrxYWVnhfa1p/L9EV6tovXFvU4LDSsv18fqF9uURiJc6Mocv3
         TzwoRtBcy0S4MT1ryXGSuRot/po6Y19ujPlgGsMiDebaNAVqLMTmkVBcmKwraIhmwy7S
         jKPuDRsdTlYmWKbLeOOAyMP3A6HXlqvUyI06K+8qi9FyTKuVUzQPxtNAg2eADnlzNn4r
         +TYNyVRHYffRob3I2damkGaA0OXOBhsG+PFrkYSi8je7cAQwH/B8yyhHSnbOt/UwQ/dB
         0VhYXsLaJhaST52dOY4a5sqPYF8MMOZv89gDcCWsjLqNy9YSiAlJ2HPss34BIkVSFljF
         jffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899492; x=1780504292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
        b=TFTRfu2U7EraT3PdYKiYTVBddX8/8iNYLkHLjxVWvLoCkPWHbpl3cXkos3oT3uZBXi
         O9ZApMCcWlWWTSVIsqRqQC+iJifXDMJqgULxzPaU3qUIli0Rf/cqsmSgzbqHmXbiLl0g
         A1Joq49HZgRux7Eb4tdcUFmGZirDQYqlLPS5WpDVzGFOIPd+53tdnYjGxFkYm1QFaFR/
         3yfoUbUij79Mhl1BdicWaYnGZgpEvkHD/70ZmExoBZVgq9q3KySf5nFzX1d3dXjr6ijm
         WkDiKkprY/3tnHl9kIVsbJ6YKSXTede2Uxih1AEiXLOYy9B9gwhjJm8QIn1HLSITZtDw
         iuPw==
X-Forwarded-Encrypted: i=1; AFNElJ9NFte13iPqdB2mwi0x+PRxqs95YVOmV1g+AEt9WU8ji7YVnrPsUaa5cueNDHAESNIlwwQgHoHMqGGOMo2iLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsMQZ+LaHBvy3zB3+5XjqZMmCSNYeQp+e3yPztTR+3E/JYjnbz
	JMG6X70qblxMZJZUO0Oso87xfXSAFHOiGUx0kdU6XY4DqyoJ/Go69zpscqJLtWOpcHrghwtDwpY
	bwUOO39ZIDvjwUQ9c+k27U34x9QF4a30=
X-Gm-Gg: Acq92OH/yIHPGTyasciKh1ugQCLPaQZ7+th+e4bzE9aP3ht9exQCZBssmdKH1m+0o96
	CbuHIujo9nwpat74Hnb1zJwFg1tMYGHHtggByGUw4FFccOuKT77UV2k7kgZamG5on7zWQfo2RFu
	li9887FfmK/4vThwR85joiVey2qBj7H3UD/zqdjsv/Rpi39bw354EGMxCW0rD5sMXCArukGzEAs
	yrfVC6yPDMdAryrm9wmCMn9Qh1jT3KsoBFbBI9oi4dGhEaYt3CNINm0V2+tecPSENFHuqbmNeXX
	2JMF1Ca+09A43N9bgbmx6DO28x436YCAuCPWlaiPsaodcs6NwV65WluE1TDH4cmAsEie5msq
X-Received: by 2002:a05:690e:158f:10b0:65e:14b6:b1c3 with SMTP id
 956f58d0204a3-65ec965c9f8mr17896814d50.16.1779899491716; Wed, 27 May 2026
 09:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260527133917.207150-1-tzimmermann@suse.de>
In-Reply-To: <20260527133917.207150-1-tzimmermann@suse.de>
From: Julian Orth <ju.orth@gmail.com>
Date: Wed, 27 May 2026 18:31:22 +0200
X-Gm-Features: AVHnY4LiGKeklklqrya8rDzPqcZQqpOuXv9liIo0k9FzrL8MbPYNMzvo_QUUG_E
Message-ID: <CAHijbEVZBRTK7yhZy8gaZwb19JMzUD_nA2S1LOKX2NrK19RBsQ@mail.gmail.com>
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

On Wed, May 27, 2026 at 3:39=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
> refresh. This is meaningless with vblank timers, which run unrelated
> to the hardware's vblank.
>
> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
> for CRTCs with simulated vblank events in all such drivers. The vblank
> timers of these devices still rate-limit the number of page-flip events
> to match the display refresh.
>
> According to maintainers, user-space compositors do not require the ioctl
> for rate-limitting display output. Weston, Kwin and Mutter rely on comple=
tion
> events. Mutter optionally uses the WAIT_VBLANK ioctl only to optimize the
> time from input to output.
>
> When testing with mutter and weston, the page-flip rate appears correct
> with the patch set applied.

To avoid this being a regression, you need to test that this change
does not regress input latency.

As discussed on IRC, compositors use vblank data to predict the time
of the next flip event. For each device that you are touching here,
there are two possibilities:

- The vblank data is related to the flip timing, i.e. flip events and
vblank events are sent at almost the same time. In this case removing
these apis removes the path for compositors to predict the time of the
next flip event. Input latency will therefore regress after idle
periods when the compositor no longer has the time of the last vblank.

- The vblank data has nothing to do with the time of the next flip
event. In this case this series could in fact improve latency because
it removes the incorrect data from the compositor.

Whether the times of the flip events correspond to hardware timings is
not relevant. Everything in wayland compositors is scheduled against
flip event timings and they are also forwarded to clients for their
frame scheduling. If the flip timings are wrong/out of sync with the
hardware, then removing the vblank apis does not improve this
situation.

>
> This change has been discussed at length on IRC recently.
>
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-08&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-12&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-13&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-15&show_html=3Dtrue
>
> v2:
> - add filter to CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Michel)
> - clarify Mutter's behavior in cover letter (Michel)
>
> Thomas Zimmermann (9):
>   drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
>   drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
>   drm/amdgpu: vkms: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/cirrus: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/hypervdrm: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/qxl: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/virtgpu: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/vkms: Set DRM_VBLANK_FLAG_SIMULATED
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    |  3 ++-
>  drivers/gpu/drm/drm_vblank.c                | 26 +++++++++++++++------
>  drivers/gpu/drm/drm_vblank_helper.c         |  2 +-
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  2 +-
>  drivers/gpu/drm/qxl/qxl_display.c           |  2 +-
>  drivers/gpu/drm/tiny/bochs.c                |  2 +-
>  drivers/gpu/drm/tiny/cirrus-qemu.c          |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_display.c    |  2 +-
>  drivers/gpu/drm/vkms/vkms_drv.c             |  4 ++--
>  include/drm/drm_crtc.h                      |  2 +-
>  include/drm/drm_device.h                    |  2 +-
>  include/drm/drm_vblank.h                    | 15 +++++++++++-
>  12 files changed, 45 insertions(+), 19 deletions(-)
>
>
> base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
> --
> 2.54.0
>
