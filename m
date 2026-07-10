Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A939989B
	for <virtualization@lists.linux.dev>; Fri, 10 Jul 2026 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716270; cv=pass; b=bRktAdtqTTVCdCTTyPP4rJEUcsRJQp0FXg9h75auINlzkZW8gqXRts0yZ47whzPatoohyPv1zo9o0Isd42QqqOG7itEEr8pMKg3skjEOJuX0otOpiVboC/zAXJzQzXzzSGR+/ymKBLCbokgjcEdZMKtCS0/fsrp/VTVEv3mz6FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716270; c=relaxed/simple;
	bh=F5eZusRBSt34kb/9CWPjvSF402YGSRkm2ceEuoDaj4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JM8MobZx94KW08/EDJnq2I+ZSdtcNHnzfJw1zwIMFMfjLcOYBDkdyuNgLOap/x0Z91yT78domRYdPZpygZQofCKBIxv55KduFF5P3GER7oZMsI0Poj4hYXkKmA9+3vvHqcJ1pRK31MuCgrIF8gIMFExek0Gc0Z+FPmMEqkMrdyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gst/8VqU; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gst/8VqU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cab97c86bdso6225ad.1
        for <virtualization@lists.linux.dev>; Fri, 10 Jul 2026 13:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783716266; cv=none;
        d=google.com; s=arc-20260327;
        b=HVKbS1XY0GZlRNMaPPCiSLtuGPMh0Cqd2k1kJ1LoF6MrGSAWMhjvi1BNQYg4HZAQuO
         aja9OFJc4RWYFPd6j/qs3h5EhHXz92b3gxMFm4a1/IYKxadhH0i/DGLB+mQ2PEd9omH4
         2dW0hCoJR88PnkAkA5MFjHUNMzyyeEDeS1KQwaWMJY9iUnUDFsYKZcJU+3s0mjFuVFtV
         jknKfyKVtkLNSQDHWy4gpjC5DlNKTKEyxTwjS5+b6dh5qWnY1JyA6z+yGVe0g04L0dWY
         /cG4GyFnj/F4a6R8UxbbYJKi/Ir//dt/DTX2N/9TYn5UhI6jUeCV/S35/xjL7KSOC69l
         SHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhBAM2JNDsd+HBeR0c5nF4AnoyxJXmTeYD7S/5azQn0=;
        fh=+4w09c/jTTDznfXxnVVxB6kv/SlrHExY3ZpXAR38yTI=;
        b=VgiMBfDnR4hjWCVskO9i05tH3kzYxGfoDxx1bES1TVW5bxoNxAmKLJvaolOUYuf7E8
         UwR7u6mse9hrRVuUhNq3SNW7sf+qcJUlWulDwN+SPlTS9rwSN/7URsprYiCYKMN3KJV7
         NFFO6l9DPuNZ0csIKAuXg8SjsJnyLzApRtfSVlOvlh9brYTjVEUuiJu8Ehuzq0pYKrG6
         buEUBXUGLuKpO3nsu3g4owjcCaJqcsqGf9q8QgVN0JYbnhmHJZQA8E262qadLcawZd8/
         NAvK8eYc5/+JfUTEhDeYwFcNpFqAHAmYr/9IICzp2gfC1rq0J7/B1YmHwXQ3ZwlWx8st
         1WEA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783716266; x=1784321066; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hhBAM2JNDsd+HBeR0c5nF4AnoyxJXmTeYD7S/5azQn0=;
        b=Gst/8VqUrSIA/EGxW4rC2OA0ZUnPJaqScF/n86keR+L+sEB21bINUpaL7WtyT395ph
         vbU+qIB2SSwiDiIsP0a6eVLOA1Kg4lw8k+PG+W9OtHVQGUHT/RCKJ3+oRLlrA3zrUv7F
         OrpUlVumdHL+WID5M18fWRXyTZm5hg6SqBgbDELqZcZfFt6435pDuY433xonp7hoV6Aj
         AINj+8/Mmf7paPl0MDpZZjpgSPGYFv0J+vdvb5qp+Bl3/qAQU3KrcNtUcY+6KaOBn8GX
         T7Zl89igRztPf6TwCiNzVk/mya6UI/OAkCP0PrcNgZ+zcWf/LVd28vaXAG+j2EorXStJ
         gwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716266; x=1784321066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhBAM2JNDsd+HBeR0c5nF4AnoyxJXmTeYD7S/5azQn0=;
        b=Fj2n42cBxC8Li+xsTITTLX2QDXUhbxFtNE2YHsV/BWxxgiNkSqkrwBCpCjlb2793KV
         TL5rTkoRWsYdg44+/6pNM+6Fhg10bt5X/RbGl0o84lC/5paqDZJ/J6Hdchzsit0cFMbw
         7KPnCHpbAyi3ZpL/h5vSFFKepPBCRcf+yISglzmzdsaQaWv7hYjhzyLv0tG44GA0LR5W
         vZAtSAFjrX+BzfU+TA3uUTbQPl/JDf5nZAG/XVvg2gyFovIC//oWqYr1v2grQ6E8XcME
         hkH0Y9xosE7MBN9lksUDhjXvTDnLNaWYs/14noMEUmB/vFXKxvMBpS5PVG9VpGalOkgX
         msAA==
X-Forwarded-Encrypted: i=1; AHgh+RoAybHyewCpdom6Uq76PrzbCVf9SH9ISX9PG/9eV1RHLBjwy6uvU2IVHqjZ+JBGXhZwx+XnPyiPf32EYDFYwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHIhPsCz1Djxi5GMAIG18zAWFyuh1cxGpPZ46Jq+RkMcRDGIum
	X/tSn8KaQTMQ9E1Ep3DD8n5nnTCglXEyi9eJGVTAFzPW7C5qilIwnCzZ+bTZgAvZC2XKjzYq1Xp
	7nTGXGG3azkZ9FazrWxGraAzdeYqlHSXjnXFv2T8=
X-Gm-Gg: AfdE7cmeDfUZ8BlmRNcBvFrJybYBFheujD4d6QjAz1pxOFJNVkbErMPFm0vi1tRefRz
	LVL/T1gmy6aTFql6h11EgaaGSq2WK03m2gnVmdsUtTswYlBqgl6Dg0+62vIxDrJeyE/oPHXB2Dx
	Gq/9xygRNA2fF39KCdFdep+9uA6n96PqY5s7XhXwtcR1lFh9JYhLynoncVKdNkRap/hkLZv918Z
	UdD+zpJlHhOchPeMzeUZabafM5r2peHaI0Z0PdHB+qP5qNuZMa/FLE25iGSb2gKE1HuN5S31ciA
	BiC/tg==
X-Received: by 2002:a17:902:e54e:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2ce9ebf87bdmr958205ad.2.1783716265438; Fri, 10 Jul 2026
 13:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622170857-mutt-send-email-mst@kernel.org> <20260625202130.2983760-1-briandaniels@google.com>
In-Reply-To: <20260625202130.2983760-1-briandaniels@google.com>
From: Brian Daniels <briandaniels@google.com>
Date: Fri, 10 Jul 2026 16:44:14 -0400
X-Gm-Features: AVVi8Cfi_ey1wcct767LgdMcybrMm5FxESkoRiHCFDkt0VRF9O-s_tCnVLHtIwY
Message-ID: <CAD4i_GTPO2vEoCtDM1p1APapWv5TYqP_Hhn41kOCodTYJB5Yiw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] media: add virtio-media driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, adelva@google.com, 
	aesteve@redhat.com, changyeon@google.com, daniel.almeida@collabora.com, 
	eperezma@redhat.com, gnurou@gmail.com, gurchetansingh@google.com, 
	hverkuil@xs4all.nl, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Would you prefer more time to review these changes, or should I go
ahead and upload a v5 based on the existing comments?

Thanks,
Brian

On Thu, Jun 25, 2026 at 4:21=E2=80=AFPM Brian Daniels <briandaniels@google.=
com> wrote:
>
> > > From: Alexandre Courbot <gnurou@gmail.com>
> > >
> > > Add the first version of the virtio-media driver.
> > >
> > > This driver acts roughly as a V4L2 relay between user-space and the
> > > virtio virtual device on the host, so it is relatively simple, yet
> > > unconventional. It doesn't use VB2 or other frameworks typically used=
 in
> > > a V4L2 driver, and most of its complexity resides in correctly and
> > > efficiently building the virtio descriptor chain to pass to the host,
> > > avoiding copies whenever possible. This is done by
> > > scatterlist_builder.[ch].
> > >
> > > This version supports MMAP buffers, while USERPTR buffers can also be
> > > enabled through a driver option. DMABUF support is still pending.
> > >
> > > NOTE: This depends on the VIRTIO ID being added in this patch:
> > > https://lore.kernel.org/all/20260310-virtio-media-id-v1-1-be211bcf682=
b@redhat.com
>
> I saw some CI build failures come back, but that should be resolved if th=
e
> patch above is merged. If you'd rather me add it to this patch series let=
 me
> know.
>
> > > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > > Signed-off-by: Brian Daniels <briandaniels@google.com>
> >
> > Thanks for the patches!
> > Sent some comments on individual patches.
>
> Thanks for the feedback!
>
> I've started to prepare v5 based on the comments so far, I'll hold off on
> sending it until we've resolved the other open threads.
>
> > > ---
> > > Guest Setup
> > >
> > > Tests were ran on a Debian 12 guest running with crosvm. The guest im=
age
> > > was created with:
> > >
> > > $ virt-builder debian-12 --root-password password:""
> > >
> > > Build crosvm and launch the guest starting at the "Crosvm" section on
> > > this page: https://github.com/chromeos/virtio-media/blob/main/TRY_IT_=
OUT.md#crosvm
> > >
> > > NOTE: Before running v4l2-compliance in the guest, you need to instal=
l
> > > v4l-utils and ffmpeg:
> > >
> > > $ apt update && apt install v4l-utils ffmpeg
> > >
> > > ---
> > > Compliance Testing
> > >
> > > This was tested using v4l2-compliance. Since virtio-media serves as
> > > a proxy to host devices for the guest VMs, we expect the guest
> > > compliance test to essentially match the host compliance test for the
> > > same device.
> > >
> > > NOTE: v4l2-compliance changes its test behavior depending on the driv=
er
> > > name. In the guest, the driver name for virtio-media proxied-devices =
is
> > > always "virtio-media", even if the actual host device has a driver na=
me
> > > of e.g. "uvcvideo". To ensure the test is consistent between the host
> > > and the guest, I created a patch for the v4l2-compliance tool that
> > > allows you to override the driver name. All test results that follow =
use
> > > this patch:
> > > https://lore.kernel.org/r/20260528163448.4031965-1-briandaniels@googl=
e.com/
> > >
> > > All tests used a Logitech USB Webcam C925e.
> > >
> > > As tested on the host:
> > >
> > > $ v4l2-compliance -d1 -s
> > >
> > > v4l2-compliance 1.33.0-5471, 64 bits, 64-bit time_t
> > > v4l2-compliance SHA: 9f2d3ea879ff 2026-05-28 14:45:11
> > >
> > > Compliance test for uvcvideo device /dev/video1:
> > >
> > > Driver Info:
> > >     Driver name      : uvcvideo
> > >     Card type        : Logitech Webcam C925e
> > >     Bus info         : usb-0000:04:00.1-3
> > >     Driver version   : 6.18.14
> > >     Capabilities     : 0x84a00001
> > >             Video Capture
> > >             Metadata Capture
> > >             Streaming
> > >             Extended Pix Format
> > >             Device Capabilities
> > >     Device Caps      : 0x04200001
> > >             Video Capture
> > >             Streaming
> > >             Extended Pix Format
> > > Media Driver Info:
> > >     Driver name      : uvcvideo
> > >     Model            : Logitech Webcam C925e
> > >     Serial           : 686F371F
> > >     Bus info         : usb-0000:04:00.1-3
> > >     Media version    : 6.18.14
> > >     Hardware revision: 0x00000016 (22)
> > >     Driver version   : 6.18.14
> > > Interface Info:
> > >     ID               : 0x03000002
> > >     Type             : V4L Video
> > > Entity Info:
> > >     ID               : 0x00000001 (1)
> > >     Name             : Logitech Webcam C925e
> > >     Function         : V4L2 I/O
> > >     Flags            : default
> > >     Pad 0x01000007   : 0: Sink
> > >       Link 0x0200001f: from remote pad 0x100000a of entity 'Processin=
g 3' (Video Pixel Formatter): Data, Enabled, Immutable
> > >
> > > Required ioctls:
> > >     test MC information (see 'Media Driver Info' above): OK
> > >     test VIDIOC_QUERYCAP: OK
> > >     test invalid ioctls: OK
> > >
> > > Allow for multiple opens:
> > >     test second /dev/video1 open: OK
> > >     test VIDIOC_QUERYCAP: OK
> > >     test VIDIOC_G/S_PRIORITY: OK
> > >     test for unlimited opens: OK
> > >
> > > Debug ioctls:
> > >     test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> > >     test VIDIOC_LOG_STATUS: OK (Not Supported)
> > >
> > > Input ioctls:
> > >     test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> > >     test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > >     test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> > >     test VIDIOC_ENUMAUDIO: OK (Not Supported)
> > >     test VIDIOC_G/S/ENUMINPUT: OK
> > >     test VIDIOC_G/S_AUDIO: OK (Not Supported)
> > >     Inputs: 1 Audio Inputs: 0 Tuners: 0
> > >
> > > Output ioctls:
> > >     test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> > >     test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > >     test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> > >     test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> > >     test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> > >     Outputs: 0 Audio Outputs: 0 Modulators: 0
> > >
> > > Input/Output configuration ioctls:
> > >     test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> > >     test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> > >     test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> > >     test VIDIOC_G/S_EDID: OK (Not Supported)
> > >
> > > Control ioctls (Input 0):
> > >     test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> > >     test VIDIOC_QUERYCTRL: OK
> > >     test VIDIOC_G/S_CTRL: OK
> > >             fail: v4l2-test-controls.cpp(983): ret !=3D EINVAL (got 1=
3)
> > >     test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
> > >     test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> > >     test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> > >     Standard Controls: 19 Private Controls: 0
> > >
> > > Format ioctls (Input 0):
> > >     test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> > >     test VIDIOC_G/S_PARM: OK
> > >     test VIDIOC_G_FBUF: OK (Not Supported)
> > >     test VIDIOC_G_FMT: OK
> > >     test VIDIOC_TRY_FMT: OK
> > >     test VIDIOC_S_FMT: OK
> > >     test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> > >     test Cropping: OK (Not Supported)
> > >     test Composing: OK (Not Supported)
> > >     test Scaling: OK (Not Supported)
> > >
> > > Codec ioctls (Input 0):
> > >     test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> > >     test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> > >     test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> > >
> > > Buffer ioctls (Input 0):
> > >     test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> > >     test CREATE_BUFS maximum buffers: OK
> > >     test VIDIOC_REMOVE_BUFS: OK
> > >     test VIDIOC_EXPBUF: OK
> > >     test Requests: OK (Not Supported)
> > >     test blocking wait: OK
> > >
> > > Test input 0:
> > >
> > > Streaming ioctls:
> > >     test read/write: OK (Not Supported)
> > >
> > >     Video Capture: Frame #000
> > >     Video Capture: Frame #001
> > >     Video Capture: Frame #002
> > >     Video Capture: Frame #003
> > >     Video Capture: Frame #004
> > >     Video Capture: Frame #005
> > >     Video Capture: Frame #006
> > >     Video Capture: Frame #007
> > >     Video Capture: Frame #008
> > >     Video Capture: Frame #009
> > >     Video Capture: Frame #010
> > >     Video Capture: Frame #011
> > >     Video Capture: Frame #012
> > >     Video Capture: Frame #013
> > >     Video Capture: Frame #014
> > >     Video Capture: Frame #015
> > >     Video Capture: Frame #016
> > >     Video Capture: Frame #017
> > >     Video Capture: Frame #018
> > >     Video Capture: Frame #019
> > >     Video Capture: Frame #020
> > >     Video Capture: Frame #021
> > >     Video Capture: Frame #022
> > >     Video Capture: Frame #023
> > >     Video Capture: Frame #024
> > >     Video Capture: Frame #025
> > >     Video Capture: Frame #026
> > >     Video Capture: Frame #027
> > >     Video Capture: Frame #028
> > >     Video Capture: Frame #029
> > >     Video Capture: Frame #030
> > >     Video Capture: Frame #031
> > >     Video Capture: Frame #032
> > >     Video Capture: Frame #033
> > >     Video Capture: Frame #034
> > >     Video Capture: Frame #035
> > >     Video Capture: Frame #036
> > >     Video Capture: Frame #037
> > >     Video Capture: Frame #038
> > >     Video Capture: Frame #039
> > >     Video Capture: Frame #040
> > >     Video Capture: Frame #041
> > >     Video Capture: Frame #042
> > >     Video Capture: Frame #043
> > >     Video Capture: Frame #044
> > >     Video Capture: Frame #045
> > >     Video Capture: Frame #046
> > >     Video Capture: Frame #047
> > >     Video Capture: Frame #048
> > >     Video Capture: Frame #049
> > >     Video Capture: Frame #050
> > >     Video Capture: Frame #051
> > >     Video Capture: Frame #052
> > >     Video Capture: Frame #053
> > >     Video Capture: Frame #054
> > >     Video Capture: Frame #055
> > >     Video Capture: Frame #056
> > >     Video Capture: Frame #057
> > >     Video Capture: Frame #058
> > >     Video Capture: Frame #059
> > >
> > >     test MMAP (no poll, REQBUFS): OK
> > >
> > >     Video Capture: Frame #000 (select)
> > >     Video Capture: Frame #001 (select)
> > >     Video Capture: Frame #002 (select)
> > >     Video Capture: Frame #003 (select)
> > >     Video Capture: Frame #004 (select)
> > >     Video Capture: Frame #005 (select)
> > >     Video Capture: Frame #006 (select)
> > >     Video Capture: Frame #007 (select)
> > >     Video Capture: Frame #008 (select)
> > >     Video Capture: Frame #009 (select)
> > >     Video Capture: Frame #010 (select)
> > >     Video Capture: Frame #011 (select)
> > >     Video Capture: Frame #012 (select)
> > >     Video Capture: Frame #013 (select)
> > >     Video Capture: Frame #014 (select)
> > >     Video Capture: Frame #015 (select)
> > >     Video Capture: Frame #016 (select)
> > >     Video Capture: Frame #017 (select)
> > >     Video Capture: Frame #018 (select)
> > >     Video Capture: Frame #019 (select)
> > >     Video Capture: Frame #020 (select)
> > >     Video Capture: Frame #021 (select)
> > >     Video Capture: Frame #022 (select)
> > >     Video Capture: Frame #023 (select)
> > >     Video Capture: Frame #024 (select)
> > >     Video Capture: Frame #025 (select)
> > >     Video Capture: Frame #026 (select)
> > >     Video Capture: Frame #027 (select)
> > >     Video Capture: Frame #028 (select)
> > >     Video Capture: Frame #029 (select)
> > >     Video Capture: Frame #030 (select)
> > >     Video Capture: Frame #031 (select)
> > >     Video Capture: Frame #032 (select)
> > >     Video Capture: Frame #033 (select)
> > >     Video Capture: Frame #034 (select)
> > >     Video Capture: Frame #035 (select)
> > >     Video Capture: Frame #036 (select)
> > >     Video Capture: Frame #037 (select)
> > >     Video Capture: Frame #038 (select)
> > >     Video Capture: Frame #039 (select)
> > >     Video Capture: Frame #040 (select)
> > >     Video Capture: Frame #041 (select)
> > >     Video Capture: Frame #042 (select)
> > >     Video Capture: Frame #043 (select)
> > >     Video Capture: Frame #044 (select)
> > >     Video Capture: Frame #045 (select)
> > >     Video Capture: Frame #046 (select)
> > >     Video Capture: Frame #047 (select)
> > >     Video Capture: Frame #048 (select)
> > >     Video Capture: Frame #049 (select)
> > >     Video Capture: Frame #050 (select)
> > >     Video Capture: Frame #051 (select)
> > >     Video Capture: Frame #052 (select)
> > >     Video Capture: Frame #053 (select)
> > >     Video Capture: Frame #054 (select)
> > >     Video Capture: Frame #055 (select)
> > >     Video Capture: Frame #056 (select)
> > >     Video Capture: Frame #057 (select)
> > >     Video Capture: Frame #058 (select)
> > >     Video Capture: Frame #059 (select)
> > >
> > >     test MMAP (select, REQBUFS): OK
> > >
> > >     Video Capture: Frame #000 (epoll)
> > >     Video Capture: Frame #001 (epoll)
> > >     Video Capture: Frame #002 (epoll)
> > >     Video Capture: Frame #003 (epoll)
> > >     Video Capture: Frame #004 (epoll)
> > >     Video Capture: Frame #005 (epoll)
> > >     Video Capture: Frame #006 (epoll)
> > >     Video Capture: Frame #007 (epoll)
> > >     Video Capture: Frame #008 (epoll)
> > >     Video Capture: Frame #009 (epoll)
> > >     Video Capture: Frame #010 (epoll)
> > >     Video Capture: Frame #011 (epoll)
> > >     Video Capture: Frame #012 (epoll)
> > >     Video Capture: Frame #013 (epoll)
> > >     Video Capture: Frame #014 (epoll)
> > >     Video Capture: Frame #015 (epoll)
> > >     Video Capture: Frame #016 (epoll)
> > >     Video Capture: Frame #017 (epoll)
> > >     Video Capture: Frame #018 (epoll)
> > >     Video Capture: Frame #019 (epoll)
> > >     Video Capture: Frame #020 (epoll)
> > >     Video Capture: Frame #021 (epoll)
> > >     Video Capture: Frame #022 (epoll)
> > >     Video Capture: Frame #023 (epoll)
> > >     Video Capture: Frame #024 (epoll)
> > >     Video Capture: Frame #025 (epoll)
> > >     Video Capture: Frame #026 (epoll)
> > >     Video Capture: Frame #027 (epoll)
> > >     Video Capture: Frame #028 (epoll)
> > >     Video Capture: Frame #029 (epoll)
> > >     Video Capture: Frame #030 (epoll)
> > >     Video Capture: Frame #031 (epoll)
> > >     Video Capture: Frame #032 (epoll)
> > >     Video Capture: Frame #033 (epoll)
> > >     Video Capture: Frame #034 (epoll)
> > >     Video Capture: Frame #035 (epoll)
> > >     Video Capture: Frame #036 (epoll)
> > >     Video Capture: Frame #037 (epoll)
> > >     Video Capture: Frame #038 (epoll)
> > >     Video Capture: Frame #039 (epoll)
> > >     Video Capture: Frame #040 (epoll)
> > >     Video Capture: Frame #041 (epoll)
> > >     Video Capture: Frame #042 (epoll)
> > >     Video Capture: Frame #043 (epoll)
> > >     Video Capture: Frame #044 (epoll)
> > >     Video Capture: Frame #045 (epoll)
> > >     Video Capture: Frame #046 (epoll)
> > >     Video Capture: Frame #047 (epoll)
> > >     Video Capture: Frame #048 (epoll)
> > >     Video Capture: Frame #049 (epoll)
> > >     Video Capture: Frame #050 (epoll)
> > >     Video Capture: Frame #051 (epoll)
> > >     Video Capture: Frame #052 (epoll)
> > >     Video Capture: Frame #053 (epoll)
> > >     Video Capture: Frame #054 (epoll)
> > >     Video Capture: Frame #055 (epoll)
> > >     Video Capture: Frame #056 (epoll)
> > >     Video Capture: Frame #057 (epoll)
> > >     Video Capture: Frame #058 (epoll)
> > >     Video Capture: Frame #059 (epoll)
> > >
> > >     test MMAP (epoll, REQBUFS): OK
> > >
> > >     Video Capture: Frame #000
> > >     Video Capture: Frame #001
> > >     Video Capture: Frame #002
> > >     Video Capture: Frame #003
> > >     Video Capture: Frame #004
> > >     Video Capture: Frame #005
> > >     Video Capture: Frame #006
> > >     Video Capture: Frame #007
> > >     Video Capture: Frame #008
> > >     Video Capture: Frame #009
> > >     Video Capture: Frame #010
> > >     Video Capture: Frame #011
> > >     Video Capture: Frame #012
> > >     Video Capture: Frame #013
> > >     Video Capture: Frame #014
> > >     Video Capture: Frame #015
> > >     Video Capture: Frame #016
> > >     Video Capture: Frame #017
> > >     Video Capture: Frame #018
> > >     Video Capture: Frame #019
> > >     Video Capture: Frame #020
> > >     Video Capture: Frame #021
> > >     Video Capture: Frame #022
> > >     Video Capture: Frame #023
> > >     Video Capture: Frame #024
> > >     Video Capture: Frame #025
> > >     Video Capture: Frame #026
> > >     Video Capture: Frame #027
> > >     Video Capture: Frame #028
> > >     Video Capture: Frame #029
> > >     Video Capture: Frame #030
> > >     Video Capture: Frame #031
> > >     Video Capture: Frame #032
> > >     Video Capture: Frame #033
> > >     Video Capture: Frame #034
> > >     Video Capture: Frame #035
> > >     Video Capture: Frame #036
> > >     Video Capture: Frame #037
> > >     Video Capture: Frame #038
> > >     Video Capture: Frame #039
> > >     Video Capture: Frame #040
> > >     Video Capture: Frame #041
> > >     Video Capture: Frame #042
> > >     Video Capture: Frame #043
> > >     Video Capture: Frame #044
> > >     Video Capture: Frame #045
> > >     Video Capture: Frame #046
> > >     Video Capture: Frame #047
> > >     Video Capture: Frame #048
> > >     Video Capture: Frame #049
> > >     Video Capture: Frame #050
> > >     Video Capture: Frame #051
> > >     Video Capture: Frame #052
> > >     Video Capture: Frame #053
> > >     Video Capture: Frame #054
> > >     Video Capture: Frame #055
> > >     Video Capture: Frame #056
> > >     Video Capture: Frame #057
> > >     Video Capture: Frame #058
> > >     Video Capture: Frame #059
> > >
> > >     test MMAP (no poll, CREATE_BUFS): OK
> > >
> > >     Video Capture: Frame #000 (select)
> > >     Video Capture: Frame #001 (select)
> > >     Video Capture: Frame #002 (select)
> > >     Video Capture: Frame #003 (select)
> > >     Video Capture: Frame #004 (select)
> > >     Video Capture: Frame #005 (select)
> > >     Video Capture: Frame #006 (select)
> > >     Video Capture: Frame #007 (select)
> > >     Video Capture: Frame #008 (select)
> > >     Video Capture: Frame #009 (select)
> > >     Video Capture: Frame #010 (select)
> > >     Video Capture: Frame #011 (select)
> > >     Video Capture: Frame #012 (select)
> > >     Video Capture: Frame #013 (select)
> > >     Video Capture: Frame #014 (select)
> > >     Video Capture: Frame #015 (select)
> > >     Video Capture: Frame #016 (select)
> > >     Video Capture: Frame #017 (select)
> > >     Video Capture: Frame #018 (select)
> > >     Video Capture: Frame #019 (select)
> > >     Video Capture: Frame #020 (select)
> > >     Video Capture: Frame #021 (select)
> > >     Video Capture: Frame #022 (select)
> > >     Video Capture: Frame #023 (select)
> > >     Video Capture: Frame #024 (select)
> > >     Video Capture: Frame #025 (select)
> > >     Video Capture: Frame #026 (select)
> > >     Video Capture: Frame #027 (select)
> > >     Video Capture: Frame #028 (select)
> > >     Video Capture: Frame #029 (select)
> > >     Video Capture: Frame #030 (select)
> > >     Video Capture: Frame #031 (select)
> > >     Video Capture: Frame #032 (select)
> > >     Video Capture: Frame #033 (select)
> > >     Video Capture: Frame #034 (select)
> > >     Video Capture: Frame #035 (select)
> > >     Video Capture: Frame #036 (select)
> > >     Video Capture: Frame #037 (select)
> > >     Video Capture: Frame #038 (select)
> > >     Video Capture: Frame #039 (select)
> > >     Video Capture: Frame #040 (select)
> > >     Video Capture: Frame #041 (select)
> > >     Video Capture: Frame #042 (select)
> > >     Video Capture: Frame #043 (select)
> > >     Video Capture: Frame #044 (select)
> > >     Video Capture: Frame #045 (select)
> > >     Video Capture: Frame #046 (select)
> > >     Video Capture: Frame #047 (select)
> > >     Video Capture: Frame #048 (select)
> > >     Video Capture: Frame #049 (select)
> > >     Video Capture: Frame #050 (select)
> > >     Video Capture: Frame #051 (select)
> > >     Video Capture: Frame #052 (select)
> > >     Video Capture: Frame #053 (select)
> > >     Video Capture: Frame #054 (select)
> > >     Video Capture: Frame #055 (select)
> > >     Video Capture: Frame #056 (select)
> > >     Video Capture: Frame #057 (select)
> > >     Video Capture: Frame #058 (select)
> > >     Video Capture: Frame #059 (select)
> > >
> > >     test MMAP (select, CREATE_BUFS): OK
> > >
> > >     Video Capture: Frame #000 (epoll)
> > >     Video Capture: Frame #001 (epoll)
> > >     Video Capture: Frame #002 (epoll)
> > >     Video Capture: Frame #003 (epoll)
> > >     Video Capture: Frame #004 (epoll)
> > >     Video Capture: Frame #005 (epoll)
> > >     Video Capture: Frame #006 (epoll)
> > >     Video Capture: Frame #007 (epoll)
> > >     Video Capture: Frame #008 (epoll)
> > >     Video Capture: Frame #009 (epoll)
> > >     Video Capture: Frame #010 (epoll)
> > >     Video Capture: Frame #011 (epoll)
> > >     Video Capture: Frame #012 (epoll)
> > >     Video Capture: Frame #013 (epoll)
> > >     Video Capture: Frame #014 (epoll)
> > >     Video Capture: Frame #015 (epoll)
> > >     Video Capture: Frame #016 (epoll)
> > >     Video Capture: Frame #017 (epoll)
> > >     Video Capture: Frame #018 (epoll)
> > >     Video Capture: Frame #019 (epoll)
> > >     Video Capture: Frame #020 (epoll)
> > >     Video Capture: Frame #021 (epoll)
> > >     Video Capture: Frame #022 (epoll)
> > >     Video Capture: Frame #023 (epoll)
> > >     Video Capture: Frame #024 (epoll)
> > >     Video Capture: Frame #025 (epoll)
> > >     Video Capture: Frame #026 (epoll)
> > >     Video Capture: Frame #027 (epoll)
> > >     Video Capture: Frame #028 (epoll)
> > >     Video Capture: Frame #029 (epoll)
> > >     Video Capture: Frame #030 (epoll)
> > >     Video Capture: Frame #031 (epoll)
> > >     Video Capture: Frame #032 (epoll)
> > >     Video Capture: Frame #033 (epoll)
> > >     Video Capture: Frame #034 (epoll)
> > >     Video Capture: Frame #035 (epoll)
> > >     Video Capture: Frame #036 (epoll)
> > >     Video Capture: Frame #037 (epoll)
> > >     Video Capture: Frame #038 (epoll)
> > >     Video Capture: Frame #039 (epoll)
> > >     Video Capture: Frame #040 (epoll)
> > >     Video Capture: Frame #041 (epoll)
> > >     Video Capture: Frame #042 (epoll)
> > >     Video Capture: Frame #043 (epoll)
> > >     Video Capture: Frame #044 (epoll)
> > >     Video Capture: Frame #045 (epoll)
> > >     Video Capture: Frame #046 (epoll)
> > >     Video Capture: Frame #047 (epoll)
> > >     Video Capture: Frame #048 (epoll)
> > >     Video Capture: Frame #049 (epoll)
> > >     Video Capture: Frame #050 (epoll)
> > >     Video Capture: Frame #051 (epoll)
> > >     Video Capture: Frame #052 (epoll)
> > >     Video Capture: Frame #053 (epoll)
> > >     Video Capture: Frame #054 (epoll)
> > >     Video Capture: Frame #055 (epoll)
> > >     Video Capture: Frame #056 (epoll)
> > >     Video Capture: Frame #057 (epoll)
> > >     Video Capture: Frame #058 (epoll)
> > >     Video Capture: Frame #059 (epoll)
> > >
> > >     test MMAP (epoll, CREATE_BUFS): OK
> > >
> > >     Video Capture: Frame #000
> > >     Video Capture: Frame #001
> > >     Video Capture: Frame #002
> > >     Video Capture: Frame #003
> > >     Video Capture: Frame #004
> > >     Video Capture: Frame #005
> > >     Video Capture: Frame #006
> > >     Video Capture: Frame #007
> > >     Video Capture: Frame #008
> > >     Video Capture: Frame #009
> > >     Video Capture: Frame #010
> > >     Video Capture: Frame #011
> > >     Video Capture: Frame #012
> > >     Video Capture: Frame #013
> > >     Video Capture: Frame #014
> > >     Video Capture: Frame #015
> > >     Video Capture: Frame #016
> > >     Video Capture: Frame #017
> > >     Video Capture: Frame #018
> > >     Video Capture: Frame #019
> > >     Video Capture: Frame #020
> > >     Video Capture: Frame #021
> > >     Video Capture: Frame #022
> > >     Video Capture: Frame #023
> > >     Video Capture: Frame #024
> > >     Video Capture: Frame #025
> > >     Video Capture: Frame #026
> > >     Video Capture: Frame #027
> > >     Video Capture: Frame #028
> > >     Video Capture: Frame #029
> > >     Video Capture: Frame #030
> > >     Video Capture: Frame #031
> > >     Video Capture: Frame #032
> > >     Video Capture: Frame #033
> > >     Video Capture: Frame #034
> > >     Video Capture: Frame #035
> > >     Video Capture: Frame #036
> > >     Video Capture: Frame #037
> > >     Video Capture: Frame #038
> > >     Video Capture: Frame #039
> > >     Video Capture: Frame #040
> > >     Video Capture: Frame #041
> > >     Video Capture: Frame #042
> > >     Video Capture: Frame #043
> > >     Video Capture: Frame #044
> > >     Video Capture: Frame #045
> > >     Video Capture: Frame #046
> > >     Video Capture: Frame #047
> > >     Video Capture: Frame #048
> > >     Video Capture: Frame #049
> > >     Video Capture: Frame #050
> > >     Video Capture: Frame #051
> > >     Video Capture: Frame #052
> > >     Video Capture: Frame #053
> > >     Video Capture: Frame #054
> > >     Video Capture: Frame #055
> > >     Video Capture: Frame #056
> > >     Video Capture: Frame #057
> > >     Video Capture: Frame #058
> > >     Video Capture: Frame #059
> > >
> > >     test USERPTR (no poll): OK
> > >
> > >     Video Capture: Frame #000 (select)
> > >     Video Capture: Frame #001 (select)
> > >     Video Capture: Frame #002 (select)
> > >     Video Capture: Frame #003 (select)
> > >     Video Capture: Frame #004 (select)
> > >     Video Capture: Frame #005 (select)
> > >     Video Capture: Frame #006 (select)
> > >     Video Capture: Frame #007 (select)
> > >     Video Capture: Frame #008 (select)
> > >     Video Capture: Frame #009 (select)
> > >     Video Capture: Frame #010 (select)
> > >     Video Capture: Frame #011 (select)
> > >     Video Capture: Frame #012 (select)
> > >     Video Capture: Frame #013 (select)
> > >     Video Capture: Frame #014 (select)
> > >     Video Capture: Frame #015 (select)
> > >     Video Capture: Frame #016 (select)
> > >     Video Capture: Frame #017 (select)
> > >     Video Capture: Frame #018 (select)
> > >     Video Capture: Frame #019 (select)
> > >     Video Capture: Frame #020 (select)
> > >     Video Capture: Frame #021 (select)
> > >     Video Capture: Frame #022 (select)
> > >     Video Capture: Frame #023 (select)
> > >     Video Capture: Frame #024 (select)
> > >     Video Capture: Frame #025 (select)
> > >     Video Capture: Frame #026 (select)
> > >     Video Capture: Frame #027 (select)
> > >     Video Capture: Frame #028 (select)
> > >     Video Capture: Frame #029 (select)
> > >     Video Capture: Frame #030 (select)
> > >     Video Capture: Frame #031 (select)
> > >     Video Capture: Frame #032 (select)
> > >     Video Capture: Frame #033 (select)
> > >     Video Capture: Frame #034 (select)
> > >     Video Capture: Frame #035 (select)
> > >     Video Capture: Frame #036 (select)
> > >     Video Capture: Frame #037 (select)
> > >     Video Capture: Frame #038 (select)
> > >     Video Capture: Frame #039 (select)
> > >     Video Capture: Frame #040 (select)
> > >     Video Capture: Frame #041 (select)
> > >     Video Capture: Frame #042 (select)
> > >     Video Capture: Frame #043 (select)
> > >     Video Capture: Frame #044 (select)
> > >     Video Capture: Frame #045 (select)
> > >     Video Capture: Frame #046 (select)
> > >     Video Capture: Frame #047 (select)
> > >     Video Capture: Frame #048 (select)
> > >     Video Capture: Frame #049 (select)
> > >     Video Capture: Frame #050 (select)
> > >     Video Capture: Frame #051 (select)
> > >     Video Capture: Frame #052 (select)
> > >     Video Capture: Frame #053 (select)
> > >     Video Capture: Frame #054 (select)
> > >     Video Capture: Frame #055 (select)
> > >     Video Capture: Frame #056 (select)
> > >     Video Capture: Frame #057 (select)
> > >     Video Capture: Frame #058 (select)
> > >     Video Capture: Frame #059 (select)
> > >
> > >     test USERPTR (select): OK
> > >     test DMABUF: Cannot test, specify --expbuf-device
> > >
> > > Total for uvcvideo device /dev/video1: 58, Succeeded: 57, Failed: 1, =
Warnings: 0
> > >
> > > As tested on the guest:
> > >
> > > $ v4l2-compliance -d0 -s --driver-name uvcvideo
> > >
> > > v4l2-compliance 1.33.0-5457, 64 bits, 64-bit time_t
> > > v4l2-compliance SHA: e7e240f546f3 2026-05-28 17:06:12
> > >
> > > Compliance test for uvcvideo device (overridden from virtio-media) /d=
ev/video0:
> > >
> > > Driver Info:
> > >     Driver name      : uvcvideo
> > >     Card type        : Logitech Webcam C925e
> > >     Bus info         : platform:virtio-media
> > >     Driver version   : 7.1.0
> > >     Capabilities     : 0x84200001
> > >             Video Capture
> > >             Streaming
> > >             Extended Pix Format
> > >             Device Capabilities
> > >     Device Caps      : 0x04200001
> > >             Video Capture
> > >             Streaming
> > >             Extended Pix Format
> > >
> > > Required ioctls:
> > >     test VIDIOC_QUERYCAP: OK
> > >     test invalid ioctls: OK
> > >
> > > Allow for multiple opens:
> > >     test second /dev/video0 open: OK
> > >     test VIDIOC_QUERYCAP: OK
> > >     test VIDIOC_G/S_PRIORITY: OK
> > >     test for unlimited opens: OK
> > >
> > > Debug ioctls:
> > >     test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> > >     test VIDIOC_LOG_STATUS: OK (Not Supported)
> > >
> > > Input ioctls:
> > >     test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> > >     test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > >     test VIDIOC_S_HW_FREQ_SEEK: OK
> > >     test VIDIOC_ENUMAUDIO: OK (Not Supported)
> > >     test VIDIOC_G/S/ENUMINPUT: OK
> > >     test VIDIOC_G/S_AUDIO: OK (Not Supported)
> > >     Inputs: 1 Audio Inputs: 0 Tuners: 0
> > >
> > > Output ioctls:
> > >     test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> > >     test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > >     test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> > >     test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> > >     test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> > >     Outputs: 0 Audio Outputs: 0 Modulators: 0
> > >
> > > Input/Output configuration ioctls:
> > >     test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> > >     test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> > >     test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> > >     test VIDIOC_G/S_EDID: OK (Not Supported)
> > >
> > > Control ioctls (Input 0):
> > >     test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> > >     test VIDIOC_QUERYCTRL: OK
> > >     test VIDIOC_G/S_CTRL: OK
> > >             fail: v4l2-test-controls.cpp(981): ret (got 22)
> > >     test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
> > >     test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> > >     test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> > >     Standard Controls: 19 Private Controls: 0
> > >
> > > Format ioctls (Input 0):
> > >     test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> > >     test VIDIOC_G/S_PARM: OK
> > >     test VIDIOC_G_FBUF: OK (Not Supported)
> > >     test VIDIOC_G_FMT: OK
> > >     test VIDIOC_TRY_FMT: OK
> > >     test VIDIOC_S_FMT: OK
> > >     test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> > >     test Cropping: OK (Not Supported)
> > >     test Composing: OK (Not Supported)
> > >     test Scaling: OK (Not Supported)
> > >
> > > Codec ioctls (Input 0):
> > >     test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> > >     test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> > >     test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> > >
> > > Buffer ioctls (Input 0):
> > >     test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> > >     test CREATE_BUFS maximum buffers: OK
> > >     test VIDIOC_REMOVE_BUFS: OK
> > >     test VIDIOC_EXPBUF: OK (Not Supported)
> > >     test Requests: OK (Not Supported)
> > >     test blocking wait: OK
> > >
> > > Test input 0:
> > >
> > > Streaming ioctls:
> > >     test read/write: OK (Not Supported)
> > >
> > >     Video Capture: Frame #000
> > >     Video Capture: Frame #001
> > >     Video Capture: Frame #002
> > >     Video Capture: Frame #003
> > >     Video Capture: Frame #004
> > >     Video Capture: Frame #005
> > >     Video Capture: Frame #006
> > >     Video Capture: Frame #007
> > >     Video Capture: Frame #008
> > >     Video Capture: Frame #009
> > >     Video Capture: Frame #010
> > >     Video Capture: Frame #011
> > >     Video Capture: Frame #012
> > >     Video Capture: Frame #013
> > >     Video Capture: Frame #014
> > >     Video Capture: Frame #015
> > >     Video Capture: Frame #016
> > >     Video Capture: Frame #017
> > >     Video Capture: Frame #018
> > >     Video Capture: Frame #019
> > >     Video Capture: Frame #020
> > >     Video Capture: Frame #021
> > >     Video Capture: Frame #022
> > >     Video Capture: Frame #023
> > >     Video Capture: Frame #024
> > >     Video Capture: Frame #025
> > >     Video Capture: Frame #026
> > >     Video Capture: Frame #027
> > >     Video Capture: Frame #028
> > >     Video Capture: Frame #029
> > >     Video Capture: Frame #030
> > >     Video Capture: Frame #031
> > >     Video Capture: Frame #032
> > >     Video Capture: Frame #033
> > >     Video Capture: Frame #034
> > >     Video Capture: Frame #035
> > >     Video Capture: Frame #036
> > >     Video Capture: Frame #037
> > >     Video Capture: Frame #038
> > >     Video Capture: Frame #039
> > >     Video Capture: Frame #040
> > >     Video Capture: Frame #041
> > >     Video Capture: Frame #042
> > >     Video Capture: Frame #043
> > >     Video Capture: Frame #044
> > >     Video Capture: Frame #045
> > >     Video Capture: Frame #046
> > >     Video Capture: Frame #047
> > >     Video Capture: Frame #048
> > >     Video Capture: Frame #049
> > >     Video Capture: Frame #050
> > >     Video Capture: Frame #051
> > >     Video Capture: Frame #052
> > >     Video Capture: Frame #053
> > >     Video Capture: Frame #054
> > >     Video Capture: Frame #055
> > >     Video Capture: Frame #056
> > >     Video Capture: Frame #057
> > >     Video Capture: Frame #058
> > >     Video Capture: Frame #059
> > >
> > >     test MMAP (no poll, REQBUFS): OK
> > >
> > >     Video Capture: Frame #000 (select)
> > >     Video Capture: Frame #001 (select)
> > >     Video Capture: Frame #002 (select)
> > >     Video Capture: Frame #003 (select)
> > >     Video Capture: Frame #004 (select)
> > >     Video Capture: Frame #005 (select)
> > >     Video Capture: Frame #006 (select)
> > >     Video Capture: Frame #007 (select)
> > >     Video Capture: Frame #008 (select)
> > >     Video Capture: Frame #009 (select)
> > >     Video Capture: Frame #010 (select)
> > >     Video Capture: Frame #011 (select)
> > >     Video Capture: Frame #012 (select)
> > >     Video Capture: Frame #013 (select)
> > >     Video Capture: Frame #014 (select)
> > >     Video Capture: Frame #015 (select)
> > >     Video Capture: Frame #016 (select)
> > >     Video Capture: Frame #017 (select)
> > >     Video Capture: Frame #018 (select)
> > >     Video Capture: Frame #019 (select)
> > >     Video Capture: Frame #020 (select)
> > >     Video Capture: Frame #021 (select)
> > >     Video Capture: Frame #022 (select)
> > >     Video Capture: Frame #023 (select)
> > >     Video Capture: Frame #024 (select)
> > >     Video Capture: Frame #025 (select)
> > >     Video Capture: Frame #026 (select)
> > >     Video Capture: Frame #027 (select)
> > >     Video Capture: Frame #028 (select)
> > >     Video Capture: Frame #029 (select)
> > >     Video Capture: Frame #030 (select)
> > >     Video Capture: Frame #031 (select)
> > >     Video Capture: Frame #032 (select)
> > >     Video Capture: Frame #033 (select)
> > >     Video Capture: Frame #034 (select)
> > >     Video Capture: Frame #035 (select)
> > >     Video Capture: Frame #036 (select)
> > >     Video Capture: Frame #037 (select)
> > >     Video Capture: Frame #038 (select)
> > >     Video Capture: Frame #039 (select)
> > >     Video Capture: Frame #040 (select)
> > >     Video Capture: Frame #041 (select)
> > >     Video Capture: Frame #042 (select)
> > >     Video Capture: Frame #043 (select)
> > >     Video Capture: Frame #044 (select)
> > >     Video Capture: Frame #045 (select)
> > >     Video Capture: Frame #046 (select)
> > >     Video Capture: Frame #047 (select)
> > >     Video Capture: Frame #048 (select)
> > >     Video Capture: Frame #049 (select)
> > >     Video Capture: Frame #050 (select)
> > >     Video Capture: Frame #051 (select)
> > >     Video Capture: Frame #052 (select)
> > >     Video Capture: Frame #053 (select)
> > >     Video Capture: Frame #054 (select)
> > >     Video Capture: Frame #055 (select)
> > >     Video Capture: Frame #056 (select)
> > >     Video Capture: Frame #057 (select)
> > >     Video Capture: Frame #058 (select)
> > >     Video Capture: Frame #059 (select)
> > >
> > >     test MMAP (select, REQBUFS): OK
> > >
> > >     Video Capture: Frame #000 (epoll)
> > >     Video Capture: Frame #001 (epoll)
> > >     Video Capture: Frame #002 (epoll)
> > >     Video Capture: Frame #003 (epoll)
> > >     Video Capture: Frame #004 (epoll)
> > >     Video Capture: Frame #005 (epoll)
> > >     Video Capture: Frame #006 (epoll)
> > >     Video Capture: Frame #007 (epoll)
> > >     Video Capture: Frame #008 (epoll)
> > >     Video Capture: Frame #009 (epoll)
> > >     Video Capture: Frame #010 (epoll)
> > >     Video Capture: Frame #011 (epoll)
> > >     Video Capture: Frame #012 (epoll)
> > >     Video Capture: Frame #013 (epoll)
> > >     Video Capture: Frame #014 (epoll)
> > >     Video Capture: Frame #015 (epoll)
> > >     Video Capture: Frame #016 (epoll)
> > >     Video Capture: Frame #017 (epoll)
> > >     Video Capture: Frame #018 (epoll)
> > >     Video Capture: Frame #019 (epoll)
> > >     Video Capture: Frame #020 (epoll)
> > >     Video Capture: Frame #021 (epoll)
> > >     Video Capture: Frame #022 (epoll)
> > >     Video Capture: Frame #023 (epoll)
> > >     Video Capture: Frame #024 (epoll)
> > >     Video Capture: Frame #025 (epoll)
> > >     Video Capture: Frame #026 (epoll)
> > >     Video Capture: Frame #027 (epoll)
> > >     Video Capture: Frame #028 (epoll)
> > >     Video Capture: Frame #029 (epoll)
> > >     Video Capture: Frame #030 (epoll)
> > >     Video Capture: Frame #031 (epoll)
> > >     Video Capture: Frame #032 (epoll)
> > >     Video Capture: Frame #033 (epoll)
> > >     Video Capture: Frame #034 (epoll)
> > >     Video Capture: Frame #035 (epoll)
> > >     Video Capture: Frame #036 (epoll)
> > >     Video Capture: Frame #037 (epoll)
> > >     Video Capture: Frame #038 (epoll)
> > >     Video Capture: Frame #039 (epoll)
> > >     Video Capture: Frame #040 (epoll)
> > >     Video Capture: Frame #041 (epoll)
> > >     Video Capture: Frame #042 (epoll)
> > >     Video Capture: Frame #043 (epoll)
> > >     Video Capture: Frame #044 (epoll)
> > >     Video Capture: Frame #045 (epoll)
> > >     Video Capture: Frame #046 (epoll)
> > >     Video Capture: Frame #047 (epoll)
> > >     Video Capture: Frame #048 (epoll)
> > >     Video Capture: Frame #049 (epoll)
> > >     Video Capture: Frame #050 (epoll)
> > >     Video Capture: Frame #051 (epoll)
> > >     Video Capture: Frame #052 (epoll)
> > >     Video Capture: Frame #053 (epoll)
> > >     Video Capture: Frame #054 (epoll)
> > >     Video Capture: Frame #055 (epoll)
> > >     Video Capture: Frame #056 (epoll)
> > >     Video Capture: Frame #057 (epoll)
> > >     Video Capture: Frame #058 (epoll)
> > >     Video Capture: Frame #059 (epoll)
> > >
> > >     test MMAP (epoll, REQBUFS): OK
> > >
> > >     Video Capture: Frame #000
> > >     Video Capture: Frame #001
> > >     Video Capture: Frame #002
> > >     Video Capture: Frame #003
> > >     Video Capture: Frame #004
> > >     Video Capture: Frame #005
> > >     Video Capture: Frame #006
> > >     Video Capture: Frame #007
> > >     Video Capture: Frame #008
> > >     Video Capture: Frame #009
> > >     Video Capture: Frame #010
> > >     Video Capture: Frame #011
> > >     Video Capture: Frame #012
> > >     Video Capture: Frame #013
> > >     Video Capture: Frame #014
> > >     Video Capture: Frame #015
> > >     Video Capture: Frame #016
> > >     Video Capture: Frame #017
> > >     Video Capture: Frame #018
> > >     Video Capture: Frame #019
> > >     Video Capture: Frame #020
> > >     Video Capture: Frame #021
> > >     Video Capture: Frame #022
> > >     Video Capture: Frame #023
> > >     Video Capture: Frame #024
> > >     Video Capture: Frame #025
> > >     Video Capture: Frame #026
> > >     Video Capture: Frame #027
> > >     Video Capture: Frame #028
> > >     Video Capture: Frame #029
> > >     Video Capture: Frame #030
> > >     Video Capture: Frame #031
> > >     Video Capture: Frame #032
> > >     Video Capture: Frame #033
> > >     Video Capture: Frame #034
> > >     Video Capture: Frame #035
> > >     Video Capture: Frame #036
> > >     Video Capture: Frame #037
> > >     Video Capture: Frame #038
> > >     Video Capture: Frame #039
> > >     Video Capture: Frame #040
> > >     Video Capture: Frame #041
> > >     Video Capture: Frame #042
> > >     Video Capture: Frame #043
> > >     Video Capture: Frame #044
> > >     Video Capture: Frame #045
> > >     Video Capture: Frame #046
> > >     Video Capture: Frame #047
> > >     Video Capture: Frame #048
> > >     Video Capture: Frame #049
> > >     Video Capture: Frame #050
> > >     Video Capture: Frame #051
> > >     Video Capture: Frame #052
> > >     Video Capture: Frame #053
> > >     Video Capture: Frame #054
> > >     Video Capture: Frame #055
> > >     Video Capture: Frame #056
> > >     Video Capture: Frame #057
> > >     Video Capture: Frame #058
> > >     Video Capture: Frame #059
> > >
> > >     test MMAP (no poll, CREATE_BUFS): OK
> > >
> > >     Video Capture: Frame #000 (select)
> > >     Video Capture: Frame #001 (select)
> > >     Video Capture: Frame #002 (select)
> > >     Video Capture: Frame #003 (select)
> > >     Video Capture: Frame #004 (select)
> > >     Video Capture: Frame #005 (select)
> > >     Video Capture: Frame #006 (select)
> > >     Video Capture: Frame #007 (select)
> > >     Video Capture: Frame #008 (select)
> > >     Video Capture: Frame #009 (select)
> > >     Video Capture: Frame #010 (select)
> > >     Video Capture: Frame #011 (select)
> > >     Video Capture: Frame #012 (select)
> > >     Video Capture: Frame #013 (select)
> > >     Video Capture: Frame #014 (select)
> > >     Video Capture: Frame #015 (select)
> > >     Video Capture: Frame #016 (select)
> > >     Video Capture: Frame #017 (select)
> > >     Video Capture: Frame #018 (select)
> > >     Video Capture: Frame #019 (select)
> > >     Video Capture: Frame #020 (select)
> > >     Video Capture: Frame #021 (select)
> > >     Video Capture: Frame #022 (select)
> > >     Video Capture: Frame #023 (select)
> > >     Video Capture: Frame #024 (select)
> > >     Video Capture: Frame #025 (select)
> > >     Video Capture: Frame #026 (select)
> > >     Video Capture: Frame #027 (select)
> > >     Video Capture: Frame #028 (select)
> > >     Video Capture: Frame #029 (select)
> > >     Video Capture: Frame #030 (select)
> > >     Video Capture: Frame #031 (select)
> > >     Video Capture: Frame #032 (select)
> > >     Video Capture: Frame #033 (select)
> > >     Video Capture: Frame #034 (select)
> > >     Video Capture: Frame #035 (select)
> > >     Video Capture: Frame #036 (select)
> > >     Video Capture: Frame #037 (select)
> > >     Video Capture: Frame #038 (select)
> > >     Video Capture: Frame #039 (select)
> > >     Video Capture: Frame #040 (select)
> > >     Video Capture: Frame #041 (select)
> > >     Video Capture: Frame #042 (select)
> > >     Video Capture: Frame #043 (select)
> > >     Video Capture: Frame #044 (select)
> > >     Video Capture: Frame #045 (select)
> > >     Video Capture: Frame #046 (select)
> > >     Video Capture: Frame #047 (select)
> > >     Video Capture: Frame #048 (select)
> > >     Video Capture: Frame #049 (select)
> > >     Video Capture: Frame #050 (select)
> > >     Video Capture: Frame #051 (select)
> > >     Video Capture: Frame #052 (select)
> > >     Video Capture: Frame #053 (select)
> > >     Video Capture: Frame #054 (select)
> > >     Video Capture: Frame #055 (select)
> > >     Video Capture: Frame #056 (select)
> > >     Video Capture: Frame #057 (select)
> > >     Video Capture: Frame #058 (select)
> > >     Video Capture: Frame #059 (select)
> > >
> > >     test MMAP (select, CREATE_BUFS): OK
> > >
> > >     Video Capture: Frame #000 (epoll)
> > >     Video Capture: Frame #001 (epoll)
> > >     Video Capture: Frame #002 (epoll)
> > >     Video Capture: Frame #003 (epoll)
> > >     Video Capture: Frame #004 (epoll)
> > >     Video Capture: Frame #005 (epoll)
> > >     Video Capture: Frame #006 (epoll)
> > >     Video Capture: Frame #007 (epoll)
> > >     Video Capture: Frame #008 (epoll)
> > >     Video Capture: Frame #009 (epoll)
> > >     Video Capture: Frame #010 (epoll)
> > >     Video Capture: Frame #011 (epoll)
> > >     Video Capture: Frame #012 (epoll)
> > >     Video Capture: Frame #013 (epoll)
> > >     Video Capture: Frame #014 (epoll)
> > >     Video Capture: Frame #015 (epoll)
> > >     Video Capture: Frame #016 (epoll)
> > >     Video Capture: Frame #017 (epoll)
> > >     Video Capture: Frame #018 (epoll)
> > >     Video Capture: Frame #019 (epoll)
> > >     Video Capture: Frame #020 (epoll)
> > >     Video Capture: Frame #021 (epoll)
> > >     Video Capture: Frame #022 (epoll)
> > >     Video Capture: Frame #023 (epoll)
> > >     Video Capture: Frame #024 (epoll)
> > >     Video Capture: Frame #025 (epoll)
> > >     Video Capture: Frame #026 (epoll)
> > >     Video Capture: Frame #027 (epoll)
> > >     Video Capture: Frame #028 (epoll)
> > >     Video Capture: Frame #029 (epoll)
> > >     Video Capture: Frame #030 (epoll)
> > >     Video Capture: Frame #031 (epoll)
> > >     Video Capture: Frame #032 (epoll)
> > >     Video Capture: Frame #033 (epoll)
> > >     Video Capture: Frame #034 (epoll)
> > >     Video Capture: Frame #035 (epoll)
> > >     Video Capture: Frame #036 (epoll)
> > >     Video Capture: Frame #037 (epoll)
> > >     Video Capture: Frame #038 (epoll)
> > >     Video Capture: Frame #039 (epoll)
> > >     Video Capture: Frame #040 (epoll)
> > >     Video Capture: Frame #041 (epoll)
> > >     Video Capture: Frame #042 (epoll)
> > >     Video Capture: Frame #043 (epoll)
> > >     Video Capture: Frame #044 (epoll)
> > >     Video Capture: Frame #045 (epoll)
> > >     Video Capture: Frame #046 (epoll)
> > >     Video Capture: Frame #047 (epoll)
> > >     Video Capture: Frame #048 (epoll)
> > >     Video Capture: Frame #049 (epoll)
> > >     Video Capture: Frame #050 (epoll)
> > >     Video Capture: Frame #051 (epoll)
> > >     Video Capture: Frame #052 (epoll)
> > >     Video Capture: Frame #053 (epoll)
> > >     Video Capture: Frame #054 (epoll)
> > >     Video Capture: Frame #055 (epoll)
> > >     Video Capture: Frame #056 (epoll)
> > >     Video Capture: Frame #057 (epoll)
> > >     Video Capture: Frame #058 (epoll)
> > >     Video Capture: Frame #059 (epoll)
> > >
> > >     test MMAP (epoll, CREATE_BUFS): OK
> > >     test USERPTR (no poll): OK (Not Supported)
> > >     test USERPTR (select): OK (Not Supported)
> > >     test DMABUF (no poll): OK (Not Supported)
> > >     test DMABUF (select): OK (Not Supported)
> > >
> > > Total for uvcvideo device /dev/video0: 59, Succeeded: 58, Failed: 1, =
Warnings: 0
> > >
> > > ---
> > > Changes in v4:
> > > - Rebased on top of v7.1-rc1
> > > - Replace usages of filep->private_data with file_to_v4l2_fh()
> > >   throughout the driver
> > > - Link to v3: https://lore.kernel.org/r/20250412-virtio-media-v3-1-97=
dc94c18398@gmail.com
> > >
> > > Changes in v3:
> > > - Rebased on top of v6.15-rc1 and removes obsolete control callbacks.
> > > - Link to v2: https://lore.kernel.org/r/20250201-virtio-media-v2-1-ac=
840681452d@gmail.com
> > >
> > > Changes in v2:
> > > - Fixed kernel test robot and media CI warnings (ignored a few false
> > >   positives).
> > > - Changed in-driver email address to personal one since my Google one
> > >   will soon become invalid.
> > > - Link to v1: https://lore.kernel.org/r/20250123-virtio-media-v1-1-81=
e2549b86b9@gmail.com
> > >
> > > Brian Daniels (8):
> > >   media: virtio: Add protocol
> > >   media: virtio: Add virtio-media driver structs and function
> > >     declarations
> > >   media: virtio: Add virtio-media session related structures
> > >   media: virtio: Add scatterlist_builder
> > >   media: virtio: Add virtio_media_ioctls
> > >   media: virtio: Add virtio_media_driver
> > >   media: virtio: Add virtio-media to the build system
> > >   media: virtio: Add MAINTAINERS entry
> > >
> > >  MAINTAINERS                                |    6 +
> > >  drivers/media/Kconfig                      |   13 +
> > >  drivers/media/Makefile                     |    2 +
> > >  drivers/media/virtio/Makefile              |    8 +
> > >  drivers/media/virtio/protocol.h            |  287 +++++
> > >  drivers/media/virtio/scatterlist_builder.c |  574 +++++++++
> > >  drivers/media/virtio/scatterlist_builder.h |  112 ++
> > >  drivers/media/virtio/session.h             |  130 ++
> > >  drivers/media/virtio/virtio_media.h        |   95 ++
> > >  drivers/media/virtio/virtio_media_driver.c |  959 ++++++++++++++
> > >  drivers/media/virtio/virtio_media_ioctls.c | 1338 ++++++++++++++++++=
++
> > >  11 files changed, 3524 insertions(+)
> > >  create mode 100644 drivers/media/virtio/Makefile
> > >  create mode 100644 drivers/media/virtio/protocol.h
> > >  create mode 100644 drivers/media/virtio/scatterlist_builder.c
> > >  create mode 100644 drivers/media/virtio/scatterlist_builder.h
> > >  create mode 100644 drivers/media/virtio/session.h
> > >  create mode 100644 drivers/media/virtio/virtio_media.h
> > >  create mode 100644 drivers/media/virtio/virtio_media_driver.c
> > >  create mode 100644 drivers/media/virtio/virtio_media_ioctls.c
> > >
> > >
> > > base-commit: 06cb687a5132fcffe624c0070576ab852ac6b568
>
>
