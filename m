Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D533ADAF
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867055; cv=pass; b=aV0u3O3ZTg+t1tKGqOdfQHPwIdq/6ox21umWtnb1gbbcv4CBUhPP/Ng4OkB2WRZ9TD35XMGM7v6/2IsagzdZiePEf46rShUVVg91lasDyb7RQLF+SvSB0dvF7R4YtKTaUKpmG4+kUvtFNdOHWz0U9nvbpncfxgQgk8Pf6SsI8aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867055; c=relaxed/simple;
	bh=x8NjBfmUM/Mkh66e35DaYoT32122kenxJ4YI6GRB12w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRHtIe9bTV0OWw7IBhYAiNpk9DlLyofk1dQAeAs5vqtFeAB6aB2Uu7lAUp/zC/XxuSjebDIDb6AO2jz40NZIw0RZicHiz2srZoBFije9mLaKhtcD5/nk5ZJegTOf2wG0fQ8PCzcKl/obnmv88hGwIbhF0LYtFeO9i6/D+y3qnb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZTLNxqyb; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZTLNxqyb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab97c86bdso15355ad.1
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 11:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785867052; cv=none;
        d=google.com; s=arc-20260327;
        b=Sr4I5XmghmPcSfo9HqTJB7hPBdxQN9rZFRfT412JLe3JWQUSkglo9VATLYTllVnM7R
         CUXudRaEohTf1EDafwszzv6lm989ETWlMEXKBqwfCyhCq//i5bM1po0xsGBXSJfzwM4r
         om1orR6FtC/iWN9WL4gSI7Rhn+eWq/oDt1wtqTquN4m4d6nEB6y2xhRR8wRVZOyuOV2q
         cUHE9OOb9y3xs2LWDULgIR0qRMBCxcXpsv7dZeUrZn9+NM1ZKwFPo/9KsRPkjkAz2YZj
         WNnecDKvBxn/VERafowK454vlKPFruadkyqswm/bec2lligCrJvKz4Ookp1L1Ofkiqxn
         5k/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Et49/Qpe61Glq8v/g+L5hxqOuVOu2zmRpdyoDZXMnQ0=;
        fh=seyf4jneTG+NxFMdXc68TJV5zfmqTMaob5vSEA6Hr9A=;
        b=bQNKONQTs69gyJWsHoNVpQoEDNH+cKA7Ra1YtdNVYvlJ28fZ4WA/iAvU2CY2LdYApy
         ONZWEvLbx8bkmi0gGZxGAR8cIFdiFDBwZ2AF/9NTHZaZ0wXs4SFz4SolGytxvnTptpwj
         TjJvWYX5KqXGX3AdeQhKQ6V4d3/ZivGfZyfRHrwKig1FbteO9oO4nq6u0mbe2M41Q/vg
         OgLIi+NLtg1yp1CchxwjjMzr3EIj3aOn+89GF+xNJ1YmeRIZjFAmVA44ZwWzlnkXYq6s
         7q0MKcbr55NQZED1On033wu0Pa8ryBDjNVXW5g+NYz0IMLdqIBSOZbHidS5a4np8zRlr
         7aJw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785867052; x=1786471852; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Et49/Qpe61Glq8v/g+L5hxqOuVOu2zmRpdyoDZXMnQ0=;
        b=ZTLNxqybg7iP4umMH17xmCXOzRjLIK20CvUebsPANfehE5PRgNH716I0xN//gDAVnt
         KQUUOGaVxBWouRB70iiH7EWdrv6U9GBaJD64YQ93NXquinxX4ZaSoXOk683uuQWdvXqR
         cIrdiMop2vM7z7J1W4rH9KcVVkqNbtqB+L1NZhobkUHTxZF+4V4A8KEQCd5RAahn6GTg
         0/or2pHdJgoNPVDngWboEg5lq6ivkhcyiHehmyaHwS9cEiIFBtu1t/+jLICCAv4jxNoh
         T2F9l4aB0OO9Z7jXGprUfmPG2B10A5fbgercD9hgQtAavLSRv8IddOGlx8YAu2AB55qc
         7ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867052; x=1786471852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Et49/Qpe61Glq8v/g+L5hxqOuVOu2zmRpdyoDZXMnQ0=;
        b=LpWhCoLLGWUDNfhsZ7YIN/IuxbbXf/cG/QQwj3xBusXmlxnyrZ7O0Ngu7KFLQ8aVh3
         v/9cJ5VaM41iX4FIuaqWYaq5+6+L6Kprdkm+DbO/+Ky76s2R2aXLimtD2iR/Bv/3BKL4
         3KQAYxJE7OdfOMAbSv+LcWaoP+poAdoWEAJ1xnRmsjW3LGjvVzN7IwhgeiIjMh1z5X3I
         ZL9rPlj/Mvp/ugw+bYGS05n6gLEpAI9fEgfF1zL6t1dg2O2q6aosSq/PpIBR4rC8yAUH
         8D+ILIVevbwfJPG19WHcjXAqekYTT+ajHDM7YjcUft1AqDN2hSJG8s3UFCTW5jQc4ka8
         s0FA==
X-Forwarded-Encrypted: i=1; AHgh+RpZuBCbrUzxsTGkktiFRFXJj9wVYinlQrdmi8EpD1VlMy4twGTSARTrZgcSuuzNlxSqw6LABXT3s1WJfoP49w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJ5ybldDRlRkx3EZFxhYIrFULRbRFIstlaF4qnCFfTjdp9hq+q
	FGRiWEwRkGpYaMMTOZMLzXXavQwjR31Ch4v7sPTRzBeh3ZfYutLCrJhbdv0cijtHymIcsru2Omm
	7FqMt/Ws8NtenNgYj65j32+Ouvuq9AO/n8kM7bno=
X-Gm-Gg: AR+sD11lxIrY30gHbMcUXTRLYs5LaNDhyZHWlsFk8j1+UCJwhIT2dBDKOqPaswmqHZx
	1ujTtNshhG4LgE409RoHdX+ViGplqrHN6iq1Fh5NJFT0O9Rp2TalVdx8pGOKvhzjQWT4bA97fbM
	FJmFGVi2xI+bXjQVRhOmBzeqcCo40d+Sk4IuG25zql/vBALxOMXcYXJuy//RjaC0QS5YP6wPSA+
	lpba3UT3WfZl6nvNq4/WZ26UFgdFOjmr/XMOVVGIGKqOhbksHjBMLrzueRx/TbD2W8LCFnZ9SOq
	H4lUex0u5hZno6RawafC/bL17IkCrTylwHM1jXMU+a7hNSLTB5WxgddT2HbUeXgv4rVFKtVoXA=
	=
X-Received: by 2002:a17:903:90d:b0:2c7:a13a:7fe6 with SMTP id
 d9443c01a7336-2d0caf1ac97mr596635ad.10.1785867050488; Tue, 04 Aug 2026
 11:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260723183219.737296-1-briandaniels@google.com>
In-Reply-To: <20260723183219.737296-1-briandaniels@google.com>
From: Brian Daniels <briandaniels@google.com>
Date: Tue, 4 Aug 2026 14:10:37 -0400
X-Gm-Features: AUfX_mwNzud8kV83KR1BF1tGcdx7vOtGLlwCoK3nyWfxgzrcWFa1vF59WjuiklA
Message-ID: <CAD4i_GQ_orVz8D-pkA9gx173t+BiEs1mHZ3NDfQ+SE+YE4UA0Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] media: add virtio-media driver
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mst@redhat.com, 
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:32=E2=80=AFPM Brian Daniels <briandaniels@google.=
com> wrote:
>
> From: Alexandre Courbot <gnurou@gmail.com>
>
> Add the first version of the virtio-media driver.
>
> This driver acts roughly as a V4L2 relay between user-space and the
> virtio virtual device on the host, so it is relatively simple, yet
> unconventional. It doesn't use VB2 or other frameworks typically used in
> a V4L2 driver, and most of its complexity resides in correctly and
> efficiently building the virtio descriptor chain to pass to the host,
> avoiding copies whenever possible. This is done by
> scatterlist_builder.[ch].
>
> This version supports MMAP buffers, while USERPTR buffers can also be
> enabled through a driver option. DMABUF support is still pending.
>
> NOTE: This depends on the VIRTIO ID being added in this patch:
> https://lore.kernel.org/all/20260310-virtio-media-id-v1-1-be211bcf682b@re=
dhat.com
>
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>
> ---
> Guest Setup
>
> Tests were ran on a Debian 12 guest running with crosvm. The guest image
> was created with:
>
> $ virt-builder debian-12 --root-password password:""
>
> Build crosvm and launch the guest starting at the "Crosvm" section on
> this page: https://github.com/chromeos/virtio-media/blob/main/TRY_IT_OUT.=
md#crosvm
>
> NOTE: Before running v4l2-compliance in the guest, you need to install
> v4l-utils and ffmpeg:
>
> $ apt update && apt install v4l-utils ffmpeg
>
> ---
> Compliance Testing
>
> This was tested using v4l2-compliance. Since virtio-media serves as
> a proxy to host devices for the guest VMs, we expect the guest
> compliance test to essentially match the host compliance test for the
> same device.
>
> NOTE: v4l2-compliance changes its test behavior depending on the driver
> name. In the guest, the driver name for virtio-media proxied-devices is
> always "virtio-media", even if the actual host device has a driver name
> of e.g. "uvcvideo". To ensure the test is consistent between the host
> and the guest, I created a patch for the v4l2-compliance tool that
> allows you to override the driver name. All test results that follow use
> this patch:
> https://lore.kernel.org/r/20260528163448.4031965-1-briandaniels@google.co=
m/
>
> All tests used a Logitech USB Webcam C925e.
>
> As tested on the host:
>
> $ v4l2-compliance -d1 -s
>
> v4l2-compliance 1.33.0-5471, 64 bits, 64-bit time_t
> v4l2-compliance SHA: 9f2d3ea879ff 2026-05-28 14:45:11
>
> Compliance test for uvcvideo device /dev/video1:
>
> Driver Info:
>         Driver name      : uvcvideo
>         Card type        : Logitech Webcam C925e
>         Bus info         : usb-0000:04:00.1-3
>         Driver version   : 6.18.14
>         Capabilities     : 0x84a00001
>                 Video Capture
>                 Metadata Capture
>                 Streaming
>                 Extended Pix Format
>                 Device Capabilities
>         Device Caps      : 0x04200001
>                 Video Capture
>                 Streaming
>                 Extended Pix Format
> Media Driver Info:
>         Driver name      : uvcvideo
>         Model            : Logitech Webcam C925e
>         Serial           : 686F371F
>         Bus info         : usb-0000:04:00.1-3
>         Media version    : 6.18.14
>         Hardware revision: 0x00000016 (22)
>         Driver version   : 6.18.14
> Interface Info:
>         ID               : 0x03000002
>         Type             : V4L Video
> Entity Info:
>         ID               : 0x00000001 (1)
>         Name             : Logitech Webcam C925e
>         Function         : V4L2 I/O
>         Flags            : default
>         Pad 0x01000007   : 0: Sink
>           Link 0x0200001f: from remote pad 0x100000a of entity 'Processin=
g 3' (Video Pixel Formatter): Data, Enabled, Immutable
>
> Required ioctls:
>         test MC information (see 'Media Driver Info' above): OK
>         test VIDIOC_QUERYCAP: OK
>         test invalid ioctls: OK
>
> Allow for multiple opens:
>         test second /dev/video1 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>         test for unlimited opens: OK
>
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>         test VIDIOC_LOG_STATUS: OK (Not Supported)
>
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 1 Audio Inputs: 0 Tuners: 0
>
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
>
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
>
> Control ioctls (Input 0):
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>         test VIDIOC_QUERYCTRL: OK
>         test VIDIOC_G/S_CTRL: OK
>                 fail: v4l2-test-controls.cpp(983): ret !=3D EINVAL (got 1=
3)
>         test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 19 Private Controls: 0
>
> Format ioctls (Input 0):
>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>         test VIDIOC_G/S_PARM: OK
>         test VIDIOC_G_FBUF: OK (Not Supported)
>         test VIDIOC_G_FMT: OK
>         test VIDIOC_TRY_FMT: OK
>         test VIDIOC_S_FMT: OK
>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>         test Cropping: OK (Not Supported)
>         test Composing: OK (Not Supported)
>         test Scaling: OK (Not Supported)
>
> Codec ioctls (Input 0):
>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
>
> Buffer ioctls (Input 0):
>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test CREATE_BUFS maximum buffers: OK
>         test VIDIOC_REMOVE_BUFS: OK
>         test VIDIOC_EXPBUF: OK
>         test Requests: OK (Not Supported)
>         test blocking wait: OK
>
> Test input 0:
>
> Streaming ioctls:
>         test read/write: OK (Not Supported)
>
>         Video Capture: Frame #000
>         Video Capture: Frame #001
>         Video Capture: Frame #002
>         Video Capture: Frame #003
>         Video Capture: Frame #004
>         Video Capture: Frame #005
>         Video Capture: Frame #006
>         Video Capture: Frame #007
>         Video Capture: Frame #008
>         Video Capture: Frame #009
>         Video Capture: Frame #010
>         Video Capture: Frame #011
>         Video Capture: Frame #012
>         Video Capture: Frame #013
>         Video Capture: Frame #014
>         Video Capture: Frame #015
>         Video Capture: Frame #016
>         Video Capture: Frame #017
>         Video Capture: Frame #018
>         Video Capture: Frame #019
>         Video Capture: Frame #020
>         Video Capture: Frame #021
>         Video Capture: Frame #022
>         Video Capture: Frame #023
>         Video Capture: Frame #024
>         Video Capture: Frame #025
>         Video Capture: Frame #026
>         Video Capture: Frame #027
>         Video Capture: Frame #028
>         Video Capture: Frame #029
>         Video Capture: Frame #030
>         Video Capture: Frame #031
>         Video Capture: Frame #032
>         Video Capture: Frame #033
>         Video Capture: Frame #034
>         Video Capture: Frame #035
>         Video Capture: Frame #036
>         Video Capture: Frame #037
>         Video Capture: Frame #038
>         Video Capture: Frame #039
>         Video Capture: Frame #040
>         Video Capture: Frame #041
>         Video Capture: Frame #042
>         Video Capture: Frame #043
>         Video Capture: Frame #044
>         Video Capture: Frame #045
>         Video Capture: Frame #046
>         Video Capture: Frame #047
>         Video Capture: Frame #048
>         Video Capture: Frame #049
>         Video Capture: Frame #050
>         Video Capture: Frame #051
>         Video Capture: Frame #052
>         Video Capture: Frame #053
>         Video Capture: Frame #054
>         Video Capture: Frame #055
>         Video Capture: Frame #056
>         Video Capture: Frame #057
>         Video Capture: Frame #058
>         Video Capture: Frame #059
>
>         test MMAP (no poll, REQBUFS): OK
>
>         Video Capture: Frame #000 (select)
>         Video Capture: Frame #001 (select)
>         Video Capture: Frame #002 (select)
>         Video Capture: Frame #003 (select)
>         Video Capture: Frame #004 (select)
>         Video Capture: Frame #005 (select)
>         Video Capture: Frame #006 (select)
>         Video Capture: Frame #007 (select)
>         Video Capture: Frame #008 (select)
>         Video Capture: Frame #009 (select)
>         Video Capture: Frame #010 (select)
>         Video Capture: Frame #011 (select)
>         Video Capture: Frame #012 (select)
>         Video Capture: Frame #013 (select)
>         Video Capture: Frame #014 (select)
>         Video Capture: Frame #015 (select)
>         Video Capture: Frame #016 (select)
>         Video Capture: Frame #017 (select)
>         Video Capture: Frame #018 (select)
>         Video Capture: Frame #019 (select)
>         Video Capture: Frame #020 (select)
>         Video Capture: Frame #021 (select)
>         Video Capture: Frame #022 (select)
>         Video Capture: Frame #023 (select)
>         Video Capture: Frame #024 (select)
>         Video Capture: Frame #025 (select)
>         Video Capture: Frame #026 (select)
>         Video Capture: Frame #027 (select)
>         Video Capture: Frame #028 (select)
>         Video Capture: Frame #029 (select)
>         Video Capture: Frame #030 (select)
>         Video Capture: Frame #031 (select)
>         Video Capture: Frame #032 (select)
>         Video Capture: Frame #033 (select)
>         Video Capture: Frame #034 (select)
>         Video Capture: Frame #035 (select)
>         Video Capture: Frame #036 (select)
>         Video Capture: Frame #037 (select)
>         Video Capture: Frame #038 (select)
>         Video Capture: Frame #039 (select)
>         Video Capture: Frame #040 (select)
>         Video Capture: Frame #041 (select)
>         Video Capture: Frame #042 (select)
>         Video Capture: Frame #043 (select)
>         Video Capture: Frame #044 (select)
>         Video Capture: Frame #045 (select)
>         Video Capture: Frame #046 (select)
>         Video Capture: Frame #047 (select)
>         Video Capture: Frame #048 (select)
>         Video Capture: Frame #049 (select)
>         Video Capture: Frame #050 (select)
>         Video Capture: Frame #051 (select)
>         Video Capture: Frame #052 (select)
>         Video Capture: Frame #053 (select)
>         Video Capture: Frame #054 (select)
>         Video Capture: Frame #055 (select)
>         Video Capture: Frame #056 (select)
>         Video Capture: Frame #057 (select)
>         Video Capture: Frame #058 (select)
>         Video Capture: Frame #059 (select)
>
>         test MMAP (select, REQBUFS): OK
>
>         Video Capture: Frame #000 (epoll)
>         Video Capture: Frame #001 (epoll)
>         Video Capture: Frame #002 (epoll)
>         Video Capture: Frame #003 (epoll)
>         Video Capture: Frame #004 (epoll)
>         Video Capture: Frame #005 (epoll)
>         Video Capture: Frame #006 (epoll)
>         Video Capture: Frame #007 (epoll)
>         Video Capture: Frame #008 (epoll)
>         Video Capture: Frame #009 (epoll)
>         Video Capture: Frame #010 (epoll)
>         Video Capture: Frame #011 (epoll)
>         Video Capture: Frame #012 (epoll)
>         Video Capture: Frame #013 (epoll)
>         Video Capture: Frame #014 (epoll)
>         Video Capture: Frame #015 (epoll)
>         Video Capture: Frame #016 (epoll)
>         Video Capture: Frame #017 (epoll)
>         Video Capture: Frame #018 (epoll)
>         Video Capture: Frame #019 (epoll)
>         Video Capture: Frame #020 (epoll)
>         Video Capture: Frame #021 (epoll)
>         Video Capture: Frame #022 (epoll)
>         Video Capture: Frame #023 (epoll)
>         Video Capture: Frame #024 (epoll)
>         Video Capture: Frame #025 (epoll)
>         Video Capture: Frame #026 (epoll)
>         Video Capture: Frame #027 (epoll)
>         Video Capture: Frame #028 (epoll)
>         Video Capture: Frame #029 (epoll)
>         Video Capture: Frame #030 (epoll)
>         Video Capture: Frame #031 (epoll)
>         Video Capture: Frame #032 (epoll)
>         Video Capture: Frame #033 (epoll)
>         Video Capture: Frame #034 (epoll)
>         Video Capture: Frame #035 (epoll)
>         Video Capture: Frame #036 (epoll)
>         Video Capture: Frame #037 (epoll)
>         Video Capture: Frame #038 (epoll)
>         Video Capture: Frame #039 (epoll)
>         Video Capture: Frame #040 (epoll)
>         Video Capture: Frame #041 (epoll)
>         Video Capture: Frame #042 (epoll)
>         Video Capture: Frame #043 (epoll)
>         Video Capture: Frame #044 (epoll)
>         Video Capture: Frame #045 (epoll)
>         Video Capture: Frame #046 (epoll)
>         Video Capture: Frame #047 (epoll)
>         Video Capture: Frame #048 (epoll)
>         Video Capture: Frame #049 (epoll)
>         Video Capture: Frame #050 (epoll)
>         Video Capture: Frame #051 (epoll)
>         Video Capture: Frame #052 (epoll)
>         Video Capture: Frame #053 (epoll)
>         Video Capture: Frame #054 (epoll)
>         Video Capture: Frame #055 (epoll)
>         Video Capture: Frame #056 (epoll)
>         Video Capture: Frame #057 (epoll)
>         Video Capture: Frame #058 (epoll)
>         Video Capture: Frame #059 (epoll)
>
>         test MMAP (epoll, REQBUFS): OK
>
>         Video Capture: Frame #000
>         Video Capture: Frame #001
>         Video Capture: Frame #002
>         Video Capture: Frame #003
>         Video Capture: Frame #004
>         Video Capture: Frame #005
>         Video Capture: Frame #006
>         Video Capture: Frame #007
>         Video Capture: Frame #008
>         Video Capture: Frame #009
>         Video Capture: Frame #010
>         Video Capture: Frame #011
>         Video Capture: Frame #012
>         Video Capture: Frame #013
>         Video Capture: Frame #014
>         Video Capture: Frame #015
>         Video Capture: Frame #016
>         Video Capture: Frame #017
>         Video Capture: Frame #018
>         Video Capture: Frame #019
>         Video Capture: Frame #020
>         Video Capture: Frame #021
>         Video Capture: Frame #022
>         Video Capture: Frame #023
>         Video Capture: Frame #024
>         Video Capture: Frame #025
>         Video Capture: Frame #026
>         Video Capture: Frame #027
>         Video Capture: Frame #028
>         Video Capture: Frame #029
>         Video Capture: Frame #030
>         Video Capture: Frame #031
>         Video Capture: Frame #032
>         Video Capture: Frame #033
>         Video Capture: Frame #034
>         Video Capture: Frame #035
>         Video Capture: Frame #036
>         Video Capture: Frame #037
>         Video Capture: Frame #038
>         Video Capture: Frame #039
>         Video Capture: Frame #040
>         Video Capture: Frame #041
>         Video Capture: Frame #042
>         Video Capture: Frame #043
>         Video Capture: Frame #044
>         Video Capture: Frame #045
>         Video Capture: Frame #046
>         Video Capture: Frame #047
>         Video Capture: Frame #048
>         Video Capture: Frame #049
>         Video Capture: Frame #050
>         Video Capture: Frame #051
>         Video Capture: Frame #052
>         Video Capture: Frame #053
>         Video Capture: Frame #054
>         Video Capture: Frame #055
>         Video Capture: Frame #056
>         Video Capture: Frame #057
>         Video Capture: Frame #058
>         Video Capture: Frame #059
>
>         test MMAP (no poll, CREATE_BUFS): OK
>
>         Video Capture: Frame #000 (select)
>         Video Capture: Frame #001 (select)
>         Video Capture: Frame #002 (select)
>         Video Capture: Frame #003 (select)
>         Video Capture: Frame #004 (select)
>         Video Capture: Frame #005 (select)
>         Video Capture: Frame #006 (select)
>         Video Capture: Frame #007 (select)
>         Video Capture: Frame #008 (select)
>         Video Capture: Frame #009 (select)
>         Video Capture: Frame #010 (select)
>         Video Capture: Frame #011 (select)
>         Video Capture: Frame #012 (select)
>         Video Capture: Frame #013 (select)
>         Video Capture: Frame #014 (select)
>         Video Capture: Frame #015 (select)
>         Video Capture: Frame #016 (select)
>         Video Capture: Frame #017 (select)
>         Video Capture: Frame #018 (select)
>         Video Capture: Frame #019 (select)
>         Video Capture: Frame #020 (select)
>         Video Capture: Frame #021 (select)
>         Video Capture: Frame #022 (select)
>         Video Capture: Frame #023 (select)
>         Video Capture: Frame #024 (select)
>         Video Capture: Frame #025 (select)
>         Video Capture: Frame #026 (select)
>         Video Capture: Frame #027 (select)
>         Video Capture: Frame #028 (select)
>         Video Capture: Frame #029 (select)
>         Video Capture: Frame #030 (select)
>         Video Capture: Frame #031 (select)
>         Video Capture: Frame #032 (select)
>         Video Capture: Frame #033 (select)
>         Video Capture: Frame #034 (select)
>         Video Capture: Frame #035 (select)
>         Video Capture: Frame #036 (select)
>         Video Capture: Frame #037 (select)
>         Video Capture: Frame #038 (select)
>         Video Capture: Frame #039 (select)
>         Video Capture: Frame #040 (select)
>         Video Capture: Frame #041 (select)
>         Video Capture: Frame #042 (select)
>         Video Capture: Frame #043 (select)
>         Video Capture: Frame #044 (select)
>         Video Capture: Frame #045 (select)
>         Video Capture: Frame #046 (select)
>         Video Capture: Frame #047 (select)
>         Video Capture: Frame #048 (select)
>         Video Capture: Frame #049 (select)
>         Video Capture: Frame #050 (select)
>         Video Capture: Frame #051 (select)
>         Video Capture: Frame #052 (select)
>         Video Capture: Frame #053 (select)
>         Video Capture: Frame #054 (select)
>         Video Capture: Frame #055 (select)
>         Video Capture: Frame #056 (select)
>         Video Capture: Frame #057 (select)
>         Video Capture: Frame #058 (select)
>         Video Capture: Frame #059 (select)
>
>         test MMAP (select, CREATE_BUFS): OK
>
>         Video Capture: Frame #000 (epoll)
>         Video Capture: Frame #001 (epoll)
>         Video Capture: Frame #002 (epoll)
>         Video Capture: Frame #003 (epoll)
>         Video Capture: Frame #004 (epoll)
>         Video Capture: Frame #005 (epoll)
>         Video Capture: Frame #006 (epoll)
>         Video Capture: Frame #007 (epoll)
>         Video Capture: Frame #008 (epoll)
>         Video Capture: Frame #009 (epoll)
>         Video Capture: Frame #010 (epoll)
>         Video Capture: Frame #011 (epoll)
>         Video Capture: Frame #012 (epoll)
>         Video Capture: Frame #013 (epoll)
>         Video Capture: Frame #014 (epoll)
>         Video Capture: Frame #015 (epoll)
>         Video Capture: Frame #016 (epoll)
>         Video Capture: Frame #017 (epoll)
>         Video Capture: Frame #018 (epoll)
>         Video Capture: Frame #019 (epoll)
>         Video Capture: Frame #020 (epoll)
>         Video Capture: Frame #021 (epoll)
>         Video Capture: Frame #022 (epoll)
>         Video Capture: Frame #023 (epoll)
>         Video Capture: Frame #024 (epoll)
>         Video Capture: Frame #025 (epoll)
>         Video Capture: Frame #026 (epoll)
>         Video Capture: Frame #027 (epoll)
>         Video Capture: Frame #028 (epoll)
>         Video Capture: Frame #029 (epoll)
>         Video Capture: Frame #030 (epoll)
>         Video Capture: Frame #031 (epoll)
>         Video Capture: Frame #032 (epoll)
>         Video Capture: Frame #033 (epoll)
>         Video Capture: Frame #034 (epoll)
>         Video Capture: Frame #035 (epoll)
>         Video Capture: Frame #036 (epoll)
>         Video Capture: Frame #037 (epoll)
>         Video Capture: Frame #038 (epoll)
>         Video Capture: Frame #039 (epoll)
>         Video Capture: Frame #040 (epoll)
>         Video Capture: Frame #041 (epoll)
>         Video Capture: Frame #042 (epoll)
>         Video Capture: Frame #043 (epoll)
>         Video Capture: Frame #044 (epoll)
>         Video Capture: Frame #045 (epoll)
>         Video Capture: Frame #046 (epoll)
>         Video Capture: Frame #047 (epoll)
>         Video Capture: Frame #048 (epoll)
>         Video Capture: Frame #049 (epoll)
>         Video Capture: Frame #050 (epoll)
>         Video Capture: Frame #051 (epoll)
>         Video Capture: Frame #052 (epoll)
>         Video Capture: Frame #053 (epoll)
>         Video Capture: Frame #054 (epoll)
>         Video Capture: Frame #055 (epoll)
>         Video Capture: Frame #056 (epoll)
>         Video Capture: Frame #057 (epoll)
>         Video Capture: Frame #058 (epoll)
>         Video Capture: Frame #059 (epoll)
>
>         test MMAP (epoll, CREATE_BUFS): OK
>
>         Video Capture: Frame #000
>         Video Capture: Frame #001
>         Video Capture: Frame #002
>         Video Capture: Frame #003
>         Video Capture: Frame #004
>         Video Capture: Frame #005
>         Video Capture: Frame #006
>         Video Capture: Frame #007
>         Video Capture: Frame #008
>         Video Capture: Frame #009
>         Video Capture: Frame #010
>         Video Capture: Frame #011
>         Video Capture: Frame #012
>         Video Capture: Frame #013
>         Video Capture: Frame #014
>         Video Capture: Frame #015
>         Video Capture: Frame #016
>         Video Capture: Frame #017
>         Video Capture: Frame #018
>         Video Capture: Frame #019
>         Video Capture: Frame #020
>         Video Capture: Frame #021
>         Video Capture: Frame #022
>         Video Capture: Frame #023
>         Video Capture: Frame #024
>         Video Capture: Frame #025
>         Video Capture: Frame #026
>         Video Capture: Frame #027
>         Video Capture: Frame #028
>         Video Capture: Frame #029
>         Video Capture: Frame #030
>         Video Capture: Frame #031
>         Video Capture: Frame #032
>         Video Capture: Frame #033
>         Video Capture: Frame #034
>         Video Capture: Frame #035
>         Video Capture: Frame #036
>         Video Capture: Frame #037
>         Video Capture: Frame #038
>         Video Capture: Frame #039
>         Video Capture: Frame #040
>         Video Capture: Frame #041
>         Video Capture: Frame #042
>         Video Capture: Frame #043
>         Video Capture: Frame #044
>         Video Capture: Frame #045
>         Video Capture: Frame #046
>         Video Capture: Frame #047
>         Video Capture: Frame #048
>         Video Capture: Frame #049
>         Video Capture: Frame #050
>         Video Capture: Frame #051
>         Video Capture: Frame #052
>         Video Capture: Frame #053
>         Video Capture: Frame #054
>         Video Capture: Frame #055
>         Video Capture: Frame #056
>         Video Capture: Frame #057
>         Video Capture: Frame #058
>         Video Capture: Frame #059
>
>         test USERPTR (no poll): OK
>
>         Video Capture: Frame #000 (select)
>         Video Capture: Frame #001 (select)
>         Video Capture: Frame #002 (select)
>         Video Capture: Frame #003 (select)
>         Video Capture: Frame #004 (select)
>         Video Capture: Frame #005 (select)
>         Video Capture: Frame #006 (select)
>         Video Capture: Frame #007 (select)
>         Video Capture: Frame #008 (select)
>         Video Capture: Frame #009 (select)
>         Video Capture: Frame #010 (select)
>         Video Capture: Frame #011 (select)
>         Video Capture: Frame #012 (select)
>         Video Capture: Frame #013 (select)
>         Video Capture: Frame #014 (select)
>         Video Capture: Frame #015 (select)
>         Video Capture: Frame #016 (select)
>         Video Capture: Frame #017 (select)
>         Video Capture: Frame #018 (select)
>         Video Capture: Frame #019 (select)
>         Video Capture: Frame #020 (select)
>         Video Capture: Frame #021 (select)
>         Video Capture: Frame #022 (select)
>         Video Capture: Frame #023 (select)
>         Video Capture: Frame #024 (select)
>         Video Capture: Frame #025 (select)
>         Video Capture: Frame #026 (select)
>         Video Capture: Frame #027 (select)
>         Video Capture: Frame #028 (select)
>         Video Capture: Frame #029 (select)
>         Video Capture: Frame #030 (select)
>         Video Capture: Frame #031 (select)
>         Video Capture: Frame #032 (select)
>         Video Capture: Frame #033 (select)
>         Video Capture: Frame #034 (select)
>         Video Capture: Frame #035 (select)
>         Video Capture: Frame #036 (select)
>         Video Capture: Frame #037 (select)
>         Video Capture: Frame #038 (select)
>         Video Capture: Frame #039 (select)
>         Video Capture: Frame #040 (select)
>         Video Capture: Frame #041 (select)
>         Video Capture: Frame #042 (select)
>         Video Capture: Frame #043 (select)
>         Video Capture: Frame #044 (select)
>         Video Capture: Frame #045 (select)
>         Video Capture: Frame #046 (select)
>         Video Capture: Frame #047 (select)
>         Video Capture: Frame #048 (select)
>         Video Capture: Frame #049 (select)
>         Video Capture: Frame #050 (select)
>         Video Capture: Frame #051 (select)
>         Video Capture: Frame #052 (select)
>         Video Capture: Frame #053 (select)
>         Video Capture: Frame #054 (select)
>         Video Capture: Frame #055 (select)
>         Video Capture: Frame #056 (select)
>         Video Capture: Frame #057 (select)
>         Video Capture: Frame #058 (select)
>         Video Capture: Frame #059 (select)
>
>         test USERPTR (select): OK
>         test DMABUF: Cannot test, specify --expbuf-device
>
> Total for uvcvideo device /dev/video1: 58, Succeeded: 57, Failed: 1, Warn=
ings: 0
>
> As tested on the guest:
>
> $ v4l2-compliance -d0 -s --driver-name uvcvideo
>
> v4l2-compliance 1.33.0-5457, 64 bits, 64-bit time_t
> v4l2-compliance SHA: e7e240f546f3 2026-05-28 17:06:12
>
> Compliance test for uvcvideo device (overridden from virtio-media) /dev/v=
ideo0:
>
> Driver Info:
>         Driver name      : uvcvideo
>         Card type        : Logitech Webcam C925e
>         Bus info         : platform:virtio-media
>         Driver version   : 7.1.0
>         Capabilities     : 0x84200001
>                 Video Capture
>                 Streaming
>                 Extended Pix Format
>                 Device Capabilities
>         Device Caps      : 0x04200001
>                 Video Capture
>                 Streaming
>                 Extended Pix Format
>
> Required ioctls:
>         test VIDIOC_QUERYCAP: OK
>         test invalid ioctls: OK
>
> Allow for multiple opens:
>         test second /dev/video0 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>         test for unlimited opens: OK
>
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>         test VIDIOC_LOG_STATUS: OK (Not Supported)
>
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 1 Audio Inputs: 0 Tuners: 0
>
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
>
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
>
> Control ioctls (Input 0):
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>         test VIDIOC_QUERYCTRL: OK
>         test VIDIOC_G/S_CTRL: OK
>                 fail: v4l2-test-controls.cpp(981): ret (got 22)
>         test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 19 Private Controls: 0
>
> Format ioctls (Input 0):
>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>         test VIDIOC_G/S_PARM: OK
>         test VIDIOC_G_FBUF: OK (Not Supported)
>         test VIDIOC_G_FMT: OK
>         test VIDIOC_TRY_FMT: OK
>         test VIDIOC_S_FMT: OK
>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>         test Cropping: OK (Not Supported)
>         test Composing: OK (Not Supported)
>         test Scaling: OK (Not Supported)
>
> Codec ioctls (Input 0):
>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
>
> Buffer ioctls (Input 0):
>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test CREATE_BUFS maximum buffers: OK
>         test VIDIOC_REMOVE_BUFS: OK
>         test VIDIOC_EXPBUF: OK (Not Supported)
>         test Requests: OK (Not Supported)
>         test blocking wait: OK
>
> Test input 0:
>
> Streaming ioctls:
>         test read/write: OK (Not Supported)
>
>         Video Capture: Frame #000
>         Video Capture: Frame #001
>         Video Capture: Frame #002
>         Video Capture: Frame #003
>         Video Capture: Frame #004
>         Video Capture: Frame #005
>         Video Capture: Frame #006
>         Video Capture: Frame #007
>         Video Capture: Frame #008
>         Video Capture: Frame #009
>         Video Capture: Frame #010
>         Video Capture: Frame #011
>         Video Capture: Frame #012
>         Video Capture: Frame #013
>         Video Capture: Frame #014
>         Video Capture: Frame #015
>         Video Capture: Frame #016
>         Video Capture: Frame #017
>         Video Capture: Frame #018
>         Video Capture: Frame #019
>         Video Capture: Frame #020
>         Video Capture: Frame #021
>         Video Capture: Frame #022
>         Video Capture: Frame #023
>         Video Capture: Frame #024
>         Video Capture: Frame #025
>         Video Capture: Frame #026
>         Video Capture: Frame #027
>         Video Capture: Frame #028
>         Video Capture: Frame #029
>         Video Capture: Frame #030
>         Video Capture: Frame #031
>         Video Capture: Frame #032
>         Video Capture: Frame #033
>         Video Capture: Frame #034
>         Video Capture: Frame #035
>         Video Capture: Frame #036
>         Video Capture: Frame #037
>         Video Capture: Frame #038
>         Video Capture: Frame #039
>         Video Capture: Frame #040
>         Video Capture: Frame #041
>         Video Capture: Frame #042
>         Video Capture: Frame #043
>         Video Capture: Frame #044
>         Video Capture: Frame #045
>         Video Capture: Frame #046
>         Video Capture: Frame #047
>         Video Capture: Frame #048
>         Video Capture: Frame #049
>         Video Capture: Frame #050
>         Video Capture: Frame #051
>         Video Capture: Frame #052
>         Video Capture: Frame #053
>         Video Capture: Frame #054
>         Video Capture: Frame #055
>         Video Capture: Frame #056
>         Video Capture: Frame #057
>         Video Capture: Frame #058
>         Video Capture: Frame #059
>
>         test MMAP (no poll, REQBUFS): OK
>
>         Video Capture: Frame #000 (select)
>         Video Capture: Frame #001 (select)
>         Video Capture: Frame #002 (select)
>         Video Capture: Frame #003 (select)
>         Video Capture: Frame #004 (select)
>         Video Capture: Frame #005 (select)
>         Video Capture: Frame #006 (select)
>         Video Capture: Frame #007 (select)
>         Video Capture: Frame #008 (select)
>         Video Capture: Frame #009 (select)
>         Video Capture: Frame #010 (select)
>         Video Capture: Frame #011 (select)
>         Video Capture: Frame #012 (select)
>         Video Capture: Frame #013 (select)
>         Video Capture: Frame #014 (select)
>         Video Capture: Frame #015 (select)
>         Video Capture: Frame #016 (select)
>         Video Capture: Frame #017 (select)
>         Video Capture: Frame #018 (select)
>         Video Capture: Frame #019 (select)
>         Video Capture: Frame #020 (select)
>         Video Capture: Frame #021 (select)
>         Video Capture: Frame #022 (select)
>         Video Capture: Frame #023 (select)
>         Video Capture: Frame #024 (select)
>         Video Capture: Frame #025 (select)
>         Video Capture: Frame #026 (select)
>         Video Capture: Frame #027 (select)
>         Video Capture: Frame #028 (select)
>         Video Capture: Frame #029 (select)
>         Video Capture: Frame #030 (select)
>         Video Capture: Frame #031 (select)
>         Video Capture: Frame #032 (select)
>         Video Capture: Frame #033 (select)
>         Video Capture: Frame #034 (select)
>         Video Capture: Frame #035 (select)
>         Video Capture: Frame #036 (select)
>         Video Capture: Frame #037 (select)
>         Video Capture: Frame #038 (select)
>         Video Capture: Frame #039 (select)
>         Video Capture: Frame #040 (select)
>         Video Capture: Frame #041 (select)
>         Video Capture: Frame #042 (select)
>         Video Capture: Frame #043 (select)
>         Video Capture: Frame #044 (select)
>         Video Capture: Frame #045 (select)
>         Video Capture: Frame #046 (select)
>         Video Capture: Frame #047 (select)
>         Video Capture: Frame #048 (select)
>         Video Capture: Frame #049 (select)
>         Video Capture: Frame #050 (select)
>         Video Capture: Frame #051 (select)
>         Video Capture: Frame #052 (select)
>         Video Capture: Frame #053 (select)
>         Video Capture: Frame #054 (select)
>         Video Capture: Frame #055 (select)
>         Video Capture: Frame #056 (select)
>         Video Capture: Frame #057 (select)
>         Video Capture: Frame #058 (select)
>         Video Capture: Frame #059 (select)
>
>         test MMAP (select, REQBUFS): OK
>
>         Video Capture: Frame #000 (epoll)
>         Video Capture: Frame #001 (epoll)
>         Video Capture: Frame #002 (epoll)
>         Video Capture: Frame #003 (epoll)
>         Video Capture: Frame #004 (epoll)
>         Video Capture: Frame #005 (epoll)
>         Video Capture: Frame #006 (epoll)
>         Video Capture: Frame #007 (epoll)
>         Video Capture: Frame #008 (epoll)
>         Video Capture: Frame #009 (epoll)
>         Video Capture: Frame #010 (epoll)
>         Video Capture: Frame #011 (epoll)
>         Video Capture: Frame #012 (epoll)
>         Video Capture: Frame #013 (epoll)
>         Video Capture: Frame #014 (epoll)
>         Video Capture: Frame #015 (epoll)
>         Video Capture: Frame #016 (epoll)
>         Video Capture: Frame #017 (epoll)
>         Video Capture: Frame #018 (epoll)
>         Video Capture: Frame #019 (epoll)
>         Video Capture: Frame #020 (epoll)
>         Video Capture: Frame #021 (epoll)
>         Video Capture: Frame #022 (epoll)
>         Video Capture: Frame #023 (epoll)
>         Video Capture: Frame #024 (epoll)
>         Video Capture: Frame #025 (epoll)
>         Video Capture: Frame #026 (epoll)
>         Video Capture: Frame #027 (epoll)
>         Video Capture: Frame #028 (epoll)
>         Video Capture: Frame #029 (epoll)
>         Video Capture: Frame #030 (epoll)
>         Video Capture: Frame #031 (epoll)
>         Video Capture: Frame #032 (epoll)
>         Video Capture: Frame #033 (epoll)
>         Video Capture: Frame #034 (epoll)
>         Video Capture: Frame #035 (epoll)
>         Video Capture: Frame #036 (epoll)
>         Video Capture: Frame #037 (epoll)
>         Video Capture: Frame #038 (epoll)
>         Video Capture: Frame #039 (epoll)
>         Video Capture: Frame #040 (epoll)
>         Video Capture: Frame #041 (epoll)
>         Video Capture: Frame #042 (epoll)
>         Video Capture: Frame #043 (epoll)
>         Video Capture: Frame #044 (epoll)
>         Video Capture: Frame #045 (epoll)
>         Video Capture: Frame #046 (epoll)
>         Video Capture: Frame #047 (epoll)
>         Video Capture: Frame #048 (epoll)
>         Video Capture: Frame #049 (epoll)
>         Video Capture: Frame #050 (epoll)
>         Video Capture: Frame #051 (epoll)
>         Video Capture: Frame #052 (epoll)
>         Video Capture: Frame #053 (epoll)
>         Video Capture: Frame #054 (epoll)
>         Video Capture: Frame #055 (epoll)
>         Video Capture: Frame #056 (epoll)
>         Video Capture: Frame #057 (epoll)
>         Video Capture: Frame #058 (epoll)
>         Video Capture: Frame #059 (epoll)
>
>         test MMAP (epoll, REQBUFS): OK
>
>         Video Capture: Frame #000
>         Video Capture: Frame #001
>         Video Capture: Frame #002
>         Video Capture: Frame #003
>         Video Capture: Frame #004
>         Video Capture: Frame #005
>         Video Capture: Frame #006
>         Video Capture: Frame #007
>         Video Capture: Frame #008
>         Video Capture: Frame #009
>         Video Capture: Frame #010
>         Video Capture: Frame #011
>         Video Capture: Frame #012
>         Video Capture: Frame #013
>         Video Capture: Frame #014
>         Video Capture: Frame #015
>         Video Capture: Frame #016
>         Video Capture: Frame #017
>         Video Capture: Frame #018
>         Video Capture: Frame #019
>         Video Capture: Frame #020
>         Video Capture: Frame #021
>         Video Capture: Frame #022
>         Video Capture: Frame #023
>         Video Capture: Frame #024
>         Video Capture: Frame #025
>         Video Capture: Frame #026
>         Video Capture: Frame #027
>         Video Capture: Frame #028
>         Video Capture: Frame #029
>         Video Capture: Frame #030
>         Video Capture: Frame #031
>         Video Capture: Frame #032
>         Video Capture: Frame #033
>         Video Capture: Frame #034
>         Video Capture: Frame #035
>         Video Capture: Frame #036
>         Video Capture: Frame #037
>         Video Capture: Frame #038
>         Video Capture: Frame #039
>         Video Capture: Frame #040
>         Video Capture: Frame #041
>         Video Capture: Frame #042
>         Video Capture: Frame #043
>         Video Capture: Frame #044
>         Video Capture: Frame #045
>         Video Capture: Frame #046
>         Video Capture: Frame #047
>         Video Capture: Frame #048
>         Video Capture: Frame #049
>         Video Capture: Frame #050
>         Video Capture: Frame #051
>         Video Capture: Frame #052
>         Video Capture: Frame #053
>         Video Capture: Frame #054
>         Video Capture: Frame #055
>         Video Capture: Frame #056
>         Video Capture: Frame #057
>         Video Capture: Frame #058
>         Video Capture: Frame #059
>
>         test MMAP (no poll, CREATE_BUFS): OK
>
>         Video Capture: Frame #000 (select)
>         Video Capture: Frame #001 (select)
>         Video Capture: Frame #002 (select)
>         Video Capture: Frame #003 (select)
>         Video Capture: Frame #004 (select)
>         Video Capture: Frame #005 (select)
>         Video Capture: Frame #006 (select)
>         Video Capture: Frame #007 (select)
>         Video Capture: Frame #008 (select)
>         Video Capture: Frame #009 (select)
>         Video Capture: Frame #010 (select)
>         Video Capture: Frame #011 (select)
>         Video Capture: Frame #012 (select)
>         Video Capture: Frame #013 (select)
>         Video Capture: Frame #014 (select)
>         Video Capture: Frame #015 (select)
>         Video Capture: Frame #016 (select)
>         Video Capture: Frame #017 (select)
>         Video Capture: Frame #018 (select)
>         Video Capture: Frame #019 (select)
>         Video Capture: Frame #020 (select)
>         Video Capture: Frame #021 (select)
>         Video Capture: Frame #022 (select)
>         Video Capture: Frame #023 (select)
>         Video Capture: Frame #024 (select)
>         Video Capture: Frame #025 (select)
>         Video Capture: Frame #026 (select)
>         Video Capture: Frame #027 (select)
>         Video Capture: Frame #028 (select)
>         Video Capture: Frame #029 (select)
>         Video Capture: Frame #030 (select)
>         Video Capture: Frame #031 (select)
>         Video Capture: Frame #032 (select)
>         Video Capture: Frame #033 (select)
>         Video Capture: Frame #034 (select)
>         Video Capture: Frame #035 (select)
>         Video Capture: Frame #036 (select)
>         Video Capture: Frame #037 (select)
>         Video Capture: Frame #038 (select)
>         Video Capture: Frame #039 (select)
>         Video Capture: Frame #040 (select)
>         Video Capture: Frame #041 (select)
>         Video Capture: Frame #042 (select)
>         Video Capture: Frame #043 (select)
>         Video Capture: Frame #044 (select)
>         Video Capture: Frame #045 (select)
>         Video Capture: Frame #046 (select)
>         Video Capture: Frame #047 (select)
>         Video Capture: Frame #048 (select)
>         Video Capture: Frame #049 (select)
>         Video Capture: Frame #050 (select)
>         Video Capture: Frame #051 (select)
>         Video Capture: Frame #052 (select)
>         Video Capture: Frame #053 (select)
>         Video Capture: Frame #054 (select)
>         Video Capture: Frame #055 (select)
>         Video Capture: Frame #056 (select)
>         Video Capture: Frame #057 (select)
>         Video Capture: Frame #058 (select)
>         Video Capture: Frame #059 (select)
>
>         test MMAP (select, CREATE_BUFS): OK
>
>         Video Capture: Frame #000 (epoll)
>         Video Capture: Frame #001 (epoll)
>         Video Capture: Frame #002 (epoll)
>         Video Capture: Frame #003 (epoll)
>         Video Capture: Frame #004 (epoll)
>         Video Capture: Frame #005 (epoll)
>         Video Capture: Frame #006 (epoll)
>         Video Capture: Frame #007 (epoll)
>         Video Capture: Frame #008 (epoll)
>         Video Capture: Frame #009 (epoll)
>         Video Capture: Frame #010 (epoll)
>         Video Capture: Frame #011 (epoll)
>         Video Capture: Frame #012 (epoll)
>         Video Capture: Frame #013 (epoll)
>         Video Capture: Frame #014 (epoll)
>         Video Capture: Frame #015 (epoll)
>         Video Capture: Frame #016 (epoll)
>         Video Capture: Frame #017 (epoll)
>         Video Capture: Frame #018 (epoll)
>         Video Capture: Frame #019 (epoll)
>         Video Capture: Frame #020 (epoll)
>         Video Capture: Frame #021 (epoll)
>         Video Capture: Frame #022 (epoll)
>         Video Capture: Frame #023 (epoll)
>         Video Capture: Frame #024 (epoll)
>         Video Capture: Frame #025 (epoll)
>         Video Capture: Frame #026 (epoll)
>         Video Capture: Frame #027 (epoll)
>         Video Capture: Frame #028 (epoll)
>         Video Capture: Frame #029 (epoll)
>         Video Capture: Frame #030 (epoll)
>         Video Capture: Frame #031 (epoll)
>         Video Capture: Frame #032 (epoll)
>         Video Capture: Frame #033 (epoll)
>         Video Capture: Frame #034 (epoll)
>         Video Capture: Frame #035 (epoll)
>         Video Capture: Frame #036 (epoll)
>         Video Capture: Frame #037 (epoll)
>         Video Capture: Frame #038 (epoll)
>         Video Capture: Frame #039 (epoll)
>         Video Capture: Frame #040 (epoll)
>         Video Capture: Frame #041 (epoll)
>         Video Capture: Frame #042 (epoll)
>         Video Capture: Frame #043 (epoll)
>         Video Capture: Frame #044 (epoll)
>         Video Capture: Frame #045 (epoll)
>         Video Capture: Frame #046 (epoll)
>         Video Capture: Frame #047 (epoll)
>         Video Capture: Frame #048 (epoll)
>         Video Capture: Frame #049 (epoll)
>         Video Capture: Frame #050 (epoll)
>         Video Capture: Frame #051 (epoll)
>         Video Capture: Frame #052 (epoll)
>         Video Capture: Frame #053 (epoll)
>         Video Capture: Frame #054 (epoll)
>         Video Capture: Frame #055 (epoll)
>         Video Capture: Frame #056 (epoll)
>         Video Capture: Frame #057 (epoll)
>         Video Capture: Frame #058 (epoll)
>         Video Capture: Frame #059 (epoll)
>
>         test MMAP (epoll, CREATE_BUFS): OK
>         test USERPTR (no poll): OK (Not Supported)
>         test USERPTR (select): OK (Not Supported)
>         test DMABUF (no poll): OK (Not Supported)
>         test DMABUF (select): OK (Not Supported)
>
> Total for uvcvideo device /dev/video0: 59, Succeeded: 58, Failed: 1, Warn=
ings: 0
>
> ---
> Changes in v5:
> - Add DMA buffer alignment and padding for commands, responses, and the e=
vent
>   buffer
> - Corrected styling of kernel-doc comments
> - Removed the configurable ``driver_name`` module parameter
> - Moved the protocol to ``include/uapi/linux/virtio_media.h``
> - Link to v4: https://lore.kernel.org/all/20260622204343.1994418-1-briand=
aniels@google.com/
>
> Changes in v4:
> - Rebased on top of v7.1-rc1
> - Replace usages of filep->private_data with file_to_v4l2_fh()
>   throughout the driver
> - Link to v3: https://lore.kernel.org/r/20250412-virtio-media-v3-1-97dc94=
c18398@gmail.com
>
> Changes in v3:
> - Rebased on top of v6.15-rc1 and removes obsolete control callbacks.
> - Link to v2: https://lore.kernel.org/r/20250201-virtio-media-v2-1-ac8406=
81452d@gmail.com
>
> Changes in v2:
> - Fixed kernel test robot and media CI warnings (ignored a few false
>   positives).
> - Changed in-driver email address to personal one since my Google one
>   will soon become invalid.
> - Link to v1: https://lore.kernel.org/r/20250123-virtio-media-v1-1-81e254=
9b86b9@gmail.com
>
> Brian Daniels (5):
>   media: virtio: Add skeleton virtio-media driver
>   media: virtio: Add session management
>   media: virtio: Add scatterlist builder
>   media: virtio: Add ioctl operations and driver logic
>   media: virtio: Add USERPTR memory type support
>
>  MAINTAINERS                                |    8 +
>  drivers/media/Kconfig                      |   13 +
>  drivers/media/Makefile                     |    2 +
>  drivers/media/virtio/Makefile              |    7 +
>  drivers/media/virtio/scatterlist_builder.c |  579 +++++++++
>  drivers/media/virtio/scatterlist_builder.h |  112 ++
>  drivers/media/virtio/session.h             |  132 ++
>  drivers/media/virtio/virtio_media.h        |   97 ++
>  drivers/media/virtio/virtio_media_driver.c |  951 ++++++++++++++
>  drivers/media/virtio/virtio_media_ioctls.c | 1326 ++++++++++++++++++++
>  include/uapi/linux/virtio_media.h          |  287 +++++
>  11 files changed, 3514 insertions(+)
>  create mode 100644 drivers/media/virtio/Makefile
>  create mode 100644 drivers/media/virtio/scatterlist_builder.c
>  create mode 100644 drivers/media/virtio/scatterlist_builder.h
>  create mode 100644 drivers/media/virtio/session.h
>  create mode 100644 drivers/media/virtio/virtio_media.h
>  create mode 100644 drivers/media/virtio/virtio_media_driver.c
>  create mode 100644 drivers/media/virtio/virtio_media_ioctls.c
>  create mode 100644 include/uapi/linux/virtio_media.h
>
>
> base-commit: 06cb687a5132fcffe624c0070576ab852ac6b568
> --
> 2.55.0.229.g6434b31f56-goog
>

I've been getting some automated emails about the license header being
incorrect in `include/uapi/linux/virtio_media.h`:

  # Test bisect:0002-04cd07234d1aa0229720568467f37cf4804ae5f8 bisect build
  error: include/uapi/linux/virtio_media.h: missing "WITH
Linux-syscall-note" for SPDX-License-Identifier
  make[2]: *** [scripts/Makefile.headersinst:63:
usr/include/linux/virtio_media.h] Error 1
  make[2]: *** Waiting for unfinished jobs....
  make[1]: *** [/builds/linux-media/users/patchwork/Makefile:1503:
headers] Error 2
  make[1]: *** Waiting for unfinished jobs....
  make: *** [Makefile:248: __sub-make] Error 2

I'll be sure to fix that in v6. But before sending that, I wanted to
wait and see if anyone had any comments on this version (v5).

Let me know if I should instead send v6 with only that correction, thanks!
