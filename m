Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211966;
	b=gZmWX8fJQ3bvWSlMMbzkH4WgpNoHSLxeHF8B6cy5EvYp5mTuaArUFwwogmtMdfjyttoo
	 WQkLhAipQWQo+xXYdc0xUL9qDBjYnoLdQibLcCMLmnDkfpxzD6IHLsErsTw6XOcmErhGx
	 BwyCYD6YHzqdVvBj3XXW0xPOPjsFEzVE9a3Ww0eN8ilfONT8dam/vDtf5d+4xVJOicI4L
	 42h7K8r+4yYGsc0XZS6ONHkT1EvDMgUxgr8Pkkr7cjCbaE6Co1lkq6ZG4FN9OJ8yyMxAj
	 shwMzPFUu3U3ld8R9j7mPhsim4J9dFIOCisZKKkI5vOrTf7jtwjnls3P2rkvzRc1sdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=RunBL8gx5lNA6/pLrwggGQRso9E1hnwNRa7NkJhtFr0=;
	b=d5j9BwEOmNxVR8ubqR1lKIA4hDyGeIKTFz4/UQBzsgRu1Xjt9zn1CHHFGff3VWJpcbh9
	 Gz3KLjq6e+s++Kir7aeoolpwZLU5ZIqToWlNBhfFQA4bBbpXKky1TeZwCyg5rQYRcfjFV
	 kHODE8iQpPOsP4FC299jNOR0q+PJjUSNR2QP3acuSLcaymQ37L9XSEmZdE9O2c0N5cg1n
	 v9h7wVAXBp6LWdAYfvGc1Lyq6FpuS8JRGdzSKq+wC3+XnMeSstjRntKRhEtvlPyuQEXSf
	 HAi6w/9qB+smcdKeh4uqY56kkSsRyFAopArnmKaDwj9PIAbSpbpPUC4loA5XnF7VzQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GeSMlSvb;
	arc=none smtp.remote-ip=209.85.219.71
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65903606A6A1
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 21:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65903606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GeSMlSvb
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9213c7a506fso17470986d6.1
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 13:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795211962; x=1795816762; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RunBL8gx5lNA6/pLrwggGQRso9E1hnwNRa7NkJhtFr0=;
        b=GeSMlSvbNE8+KmZVPOE1/ITOuGh6YoFnK9nuW6i5NWK5jW8s7L/ydg0VffLSwN5Qfn
         HT9h9iN/gh/Y9QJkVIsCxCtfhw7yUoUmHoJNsQ9sQsqAKKhcscQsOj7Rp6qLbq1pL3HE
         t63EMfcBoepZy0xvC15eYjilGv8FXfvJedrspMTiP7xfBmtXWo5wEVUMte8u16olDngR
         DFMEysuXuaJQlFxpDTls+tnuJ/MNkhCCCgEIjVTyixSJhschieWjdzvMVZgUCr3af4Eu
         3em9pw+EfgJyVQe6GJP5Ut+4e7D3DiwSfZvtf9tWPsqzria0IQtzG4+Y7zSn1V2gJVZZ
         FrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795211962; x=1795816762;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RunBL8gx5lNA6/pLrwggGQRso9E1hnwNRa7NkJhtFr0=;
        b=Ea0eFz7dwHlf/AAmMPH6BJRN/6agM7eRl1G2i8JOS/aAIW1Gb6/tKr5IQ8Ix0AlCik
         SlFCepq3hEBs0js4+vL0dPMH0gdAmZh8CS56jlLh8JbGpp3MGuo72O597DxGGqY4WsVH
         toMudIt4FZZFAf9eQGjoKWVSrEljWhwNhcwpZgZhRKe8KssReRK8YHxtlat8dp41Seq9
         MAGDvho7AHnV335O17EwHhXPS2oAYTLYcXIlcZNnf+rCKWOhuDW79ZyJjxFmFf/dzk5A
         SAWb4D96I7Ktb4ZvC6qd97eYzhUe1FxoLlcyx9sOlo9j2vWprSulE8j1nnps5852r3Ak
         xkdg==
X-Forwarded-Encrypted: i=1; AL+hErFBH5Xl0OZB0/dxgcA73h4iZCeAzNvlP6/NIuI5ZMrrLFp/WmITSd4zTdM/40p8AQH0C18pyxMCP+JBGtPKQw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+9vrWDSttOVkTP4Zj8L5/BZPsouZJjam0xPFSzui0N/YRAD7CI
	hBpN+5fnuir42/ZLk/qv6Td++Q3rOONJQYY/SHjmPzv8abCfnMVAcpyNt6n/geNcJIhB79FfSKc
	sJW9h2wVyprbaCw54FdTuXdVEU1Rl
X-Received: from qkcbk3-n1.prod.google.com ([2002:a05:620a:72c3:10b0:93f:2600:8e17])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1d05:b0:949:3066:556a with SMTP id af79cd13be357-949bab4d3f5mr706359585a.69.1795211961903;
 Fri, 20 Nov 2026 13:59:21 -0800 (PST)
Date: Fri, 20 Nov 2026 16:59:10 -0500
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120215916.3149345-1-briandaniels@google.com>
Subject: [PATCH v11 0/6] media: add virtio-media driver
From: Brian Daniels <briandaniels@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	dbassey@redhat.com, laurent.pinchart@ideasonboard.com, 
	Brian Daniels <briandaniels@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexandre Courbot <gnurou@gmail.com>

Add the first version of the virtio-media driver.

This driver acts roughly as a V4L2 relay between user-space and the
virtio virtual device on the host, so it is relatively simple, yet
unconventional. It doesn't use VB2 or other frameworks typically used in
a V4L2 driver, and most of its complexity resides in correctly and
efficiently building the virtio descriptor chain to pass to the host,
avoiding copies whenever possible. This is done by
scatterlist_builder.[ch].

This version supports MMAP buffers. DMABUF support is still pending.
---
Guest Setup

Tests were ran on a Debian 12 guest running with crosvm. The guest image
was created with:

$ virt-builder debian-12 --root-password password:""

Build crosvm and launch the guest starting at the "Crosvm" section on
this page: https://github.com/chromeos/virtio-media/blob/main/TRY_IT_OUT.md#crosvm

NOTE: Before running v4l2-compliance in the guest, you need to install
v4l-utils and ffmpeg:

$ apt update && apt install v4l-utils ffmpeg

---
Compliance Testing

This was tested using v4l2-compliance. Since virtio-media serves as
a proxy to host devices for the guest VMs, we expect the guest
compliance test to essentially match the host compliance test for the
same device.

NOTE: A single failure is fixed when v4l2-compliance is ran on the guest
by patching the v4l2r crate used by crosvm. The patch I used hasn't been
merged but is available here: https://github.com/Gnurou/v4l2r/pull/66.

All tests used a Logitech USB Webcam C925e.

As tested on the host:

$ v4l2-compliance -d0 -s

v4l2-compliance 1.33.0-5523, 64 bits, 64-bit time_t
v4l2-compliance SHA: 7e25bb929095 2026-10-29 15:02:40

Compliance test for uvcvideo device /dev/video0:

Driver Info:
	Driver name      : uvcvideo
	Card type        : Logitech Webcam C925e
	Bus info         : usb-0000:04:00.1-3
	Driver version   : 7.1.6
	Capabilities     : 0x84a00001
		Video Capture
		Metadata Capture
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04200001
		Video Capture
		Streaming
		Extended Pix Format
Media Driver Info:
	Driver name      : uvcvideo
	Model            : Logitech Webcam C925e
	Serial           : 686F371F
	Bus info         : usb-0000:04:00.1-3
	Media version    : 7.1.6
	Hardware revision: 0x00000016 (22)
	Driver version   : 7.1.6
Interface Info:
	ID               : 0x03000002
	Type             : V4L Video
Entity Info:
	ID               : 0x00000001 (1)
	Name             : Logitech Webcam C925e
	Function         : V4L2 I/O
	Flags            : default
	Pad 0x01000007   : 0: Sink
	  Link 0x0200001f: from remote pad 0x100000a of entity 'Processing 3' (Video Pixel Formatter): Data, Enabled, Immutable

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/video0 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 1 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls (Input 0):
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
	test VIDIOC_QUERYCTRL: OK
	test VIDIOC_G/S_CTRL: OK
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 19 Private Controls: 0

Format ioctls (Input 0):
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK (Not Supported)

Codec ioctls (Input 0):
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test CREATE_BUFS maximum buffers: OK
	test VIDIOC_REMOVE_BUFS: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)
	test blocking wait: OK

Test input 0:

Streaming ioctls:
	test read/write: OK (Not Supported)

	Video Capture: Frame #000
	Video Capture: Frame #001
	Video Capture: Frame #002
	Video Capture: Frame #003
	Video Capture: Frame #004
	Video Capture: Frame #005
	Video Capture: Frame #006
	Video Capture: Frame #007
	Video Capture: Frame #008
	Video Capture: Frame #009
	Video Capture: Frame #010
	Video Capture: Frame #011
	Video Capture: Frame #012
	Video Capture: Frame #013
	Video Capture: Frame #014
	Video Capture: Frame #015
	Video Capture: Frame #016
	Video Capture: Frame #017
	Video Capture: Frame #018
	Video Capture: Frame #019
	Video Capture: Frame #020
	Video Capture: Frame #021
	Video Capture: Frame #022
	Video Capture: Frame #023
	Video Capture: Frame #024
	Video Capture: Frame #025
	Video Capture: Frame #026
	Video Capture: Frame #027
	Video Capture: Frame #028
	Video Capture: Frame #029
	Video Capture: Frame #030
	Video Capture: Frame #031
	Video Capture: Frame #032
	Video Capture: Frame #033
	Video Capture: Frame #034
	Video Capture: Frame #035
	Video Capture: Frame #036
	Video Capture: Frame #037
	Video Capture: Frame #038
	Video Capture: Frame #039
	Video Capture: Frame #040
	Video Capture: Frame #041
	Video Capture: Frame #042
	Video Capture: Frame #043
	Video Capture: Frame #044
	Video Capture: Frame #045
	Video Capture: Frame #046
	Video Capture: Frame #047
	Video Capture: Frame #048
	Video Capture: Frame #049
	Video Capture: Frame #050
	Video Capture: Frame #051
	Video Capture: Frame #052
	Video Capture: Frame #053
	Video Capture: Frame #054
	Video Capture: Frame #055
	Video Capture: Frame #056
	Video Capture: Frame #057
	Video Capture: Frame #058
	Video Capture: Frame #059

	test MMAP (no poll, REQBUFS): OK

	Video Capture: Frame #000 (select)
	Video Capture: Frame #001 (select)
	Video Capture: Frame #002 (select)
	Video Capture: Frame #003 (select)
	Video Capture: Frame #004 (select)
	Video Capture: Frame #005 (select)
	Video Capture: Frame #006 (select)
	Video Capture: Frame #007 (select)
	Video Capture: Frame #008 (select)
	Video Capture: Frame #009 (select)
	Video Capture: Frame #010 (select)
	Video Capture: Frame #011 (select)
	Video Capture: Frame #012 (select)
	Video Capture: Frame #013 (select)
	Video Capture: Frame #014 (select)
	Video Capture: Frame #015 (select)
	Video Capture: Frame #016 (select)
	Video Capture: Frame #017 (select)
	Video Capture: Frame #018 (select)
	Video Capture: Frame #019 (select)
	Video Capture: Frame #020 (select)
	Video Capture: Frame #021 (select)
	Video Capture: Frame #022 (select)
	Video Capture: Frame #023 (select)
	Video Capture: Frame #024 (select)
	Video Capture: Frame #025 (select)
	Video Capture: Frame #026 (select)
	Video Capture: Frame #027 (select)
	Video Capture: Frame #028 (select)
	Video Capture: Frame #029 (select)
	Video Capture: Frame #030 (select)
	Video Capture: Frame #031 (select)
	Video Capture: Frame #032 (select)
	Video Capture: Frame #033 (select)
	Video Capture: Frame #034 (select)
	Video Capture: Frame #035 (select)
	Video Capture: Frame #036 (select)
	Video Capture: Frame #037 (select)
	Video Capture: Frame #038 (select)
	Video Capture: Frame #039 (select)
	Video Capture: Frame #040 (select)
	Video Capture: Frame #041 (select)
	Video Capture: Frame #042 (select)
	Video Capture: Frame #043 (select)
	Video Capture: Frame #044 (select)
	Video Capture: Frame #045 (select)
	Video Capture: Frame #046 (select)
	Video Capture: Frame #047 (select)
	Video Capture: Frame #048 (select)
	Video Capture: Frame #049 (select)
	Video Capture: Frame #050 (select)
	Video Capture: Frame #051 (select)
	Video Capture: Frame #052 (select)
	Video Capture: Frame #053 (select)
	Video Capture: Frame #054 (select)
	Video Capture: Frame #055 (select)
	Video Capture: Frame #056 (select)
	Video Capture: Frame #057 (select)
	Video Capture: Frame #058 (select)
	Video Capture: Frame #059 (select)

	test MMAP (select, REQBUFS): OK

	Video Capture: Frame #000 (epoll)
	Video Capture: Frame #001 (epoll)
	Video Capture: Frame #002 (epoll)
	Video Capture: Frame #003 (epoll)
	Video Capture: Frame #004 (epoll)
	Video Capture: Frame #005 (epoll)
	Video Capture: Frame #006 (epoll)
	Video Capture: Frame #007 (epoll)
	Video Capture: Frame #008 (epoll)
	Video Capture: Frame #009 (epoll)
	Video Capture: Frame #010 (epoll)
	Video Capture: Frame #011 (epoll)
	Video Capture: Frame #012 (epoll)
	Video Capture: Frame #013 (epoll)
	Video Capture: Frame #014 (epoll)
	Video Capture: Frame #015 (epoll)
	Video Capture: Frame #016 (epoll)
	Video Capture: Frame #017 (epoll)
	Video Capture: Frame #018 (epoll)
	Video Capture: Frame #019 (epoll)
	Video Capture: Frame #020 (epoll)
	Video Capture: Frame #021 (epoll)
	Video Capture: Frame #022 (epoll)
	Video Capture: Frame #023 (epoll)
	Video Capture: Frame #024 (epoll)
	Video Capture: Frame #025 (epoll)
	Video Capture: Frame #026 (epoll)
	Video Capture: Frame #027 (epoll)
	Video Capture: Frame #028 (epoll)
	Video Capture: Frame #029 (epoll)
	Video Capture: Frame #030 (epoll)
	Video Capture: Frame #031 (epoll)
	Video Capture: Frame #032 (epoll)
	Video Capture: Frame #033 (epoll)
	Video Capture: Frame #034 (epoll)
	Video Capture: Frame #035 (epoll)
	Video Capture: Frame #036 (epoll)
	Video Capture: Frame #037 (epoll)
	Video Capture: Frame #038 (epoll)
	Video Capture: Frame #039 (epoll)
	Video Capture: Frame #040 (epoll)
	Video Capture: Frame #041 (epoll)
	Video Capture: Frame #042 (epoll)
	Video Capture: Frame #043 (epoll)
	Video Capture: Frame #044 (epoll)
	Video Capture: Frame #045 (epoll)
	Video Capture: Frame #046 (epoll)
	Video Capture: Frame #047 (epoll)
	Video Capture: Frame #048 (epoll)
	Video Capture: Frame #049 (epoll)
	Video Capture: Frame #050 (epoll)
	Video Capture: Frame #051 (epoll)
	Video Capture: Frame #052 (epoll)
	Video Capture: Frame #053 (epoll)
	Video Capture: Frame #054 (epoll)
	Video Capture: Frame #055 (epoll)
	Video Capture: Frame #056 (epoll)
	Video Capture: Frame #057 (epoll)
	Video Capture: Frame #058 (epoll)
	Video Capture: Frame #059 (epoll)

	test MMAP (epoll, REQBUFS): OK

	Video Capture: Frame #000
	Video Capture: Frame #001
	Video Capture: Frame #002
	Video Capture: Frame #003
	Video Capture: Frame #004
	Video Capture: Frame #005
	Video Capture: Frame #006
	Video Capture: Frame #007
	Video Capture: Frame #008
	Video Capture: Frame #009
	Video Capture: Frame #010
	Video Capture: Frame #011
	Video Capture: Frame #012
	Video Capture: Frame #013
	Video Capture: Frame #014
	Video Capture: Frame #015
	Video Capture: Frame #016
	Video Capture: Frame #017
	Video Capture: Frame #018
	Video Capture: Frame #019
	Video Capture: Frame #020
	Video Capture: Frame #021
	Video Capture: Frame #022
	Video Capture: Frame #023
	Video Capture: Frame #024
	Video Capture: Frame #025
	Video Capture: Frame #026
	Video Capture: Frame #027
	Video Capture: Frame #028
	Video Capture: Frame #029
	Video Capture: Frame #030
	Video Capture: Frame #031
	Video Capture: Frame #032
	Video Capture: Frame #033
	Video Capture: Frame #034
	Video Capture: Frame #035
	Video Capture: Frame #036
	Video Capture: Frame #037
	Video Capture: Frame #038
	Video Capture: Frame #039
	Video Capture: Frame #040
	Video Capture: Frame #041
	Video Capture: Frame #042
	Video Capture: Frame #043
	Video Capture: Frame #044
	Video Capture: Frame #045
	Video Capture: Frame #046
	Video Capture: Frame #047
	Video Capture: Frame #048
	Video Capture: Frame #049
	Video Capture: Frame #050
	Video Capture: Frame #051
	Video Capture: Frame #052
	Video Capture: Frame #053
	Video Capture: Frame #054
	Video Capture: Frame #055
	Video Capture: Frame #056
	Video Capture: Frame #057
	Video Capture: Frame #058
	Video Capture: Frame #059

	test MMAP (no poll, CREATE_BUFS): OK

	Video Capture: Frame #000 (select)
	Video Capture: Frame #001 (select)
	Video Capture: Frame #002 (select)
	Video Capture: Frame #003 (select)
	Video Capture: Frame #004 (select)
	Video Capture: Frame #005 (select)
	Video Capture: Frame #006 (select)
	Video Capture: Frame #007 (select)
	Video Capture: Frame #008 (select)
	Video Capture: Frame #009 (select)
	Video Capture: Frame #010 (select)
	Video Capture: Frame #011 (select)
	Video Capture: Frame #012 (select)
	Video Capture: Frame #013 (select)
	Video Capture: Frame #014 (select)
	Video Capture: Frame #015 (select)
	Video Capture: Frame #016 (select)
	Video Capture: Frame #017 (select)
	Video Capture: Frame #018 (select)
	Video Capture: Frame #019 (select)
	Video Capture: Frame #020 (select)
	Video Capture: Frame #021 (select)
	Video Capture: Frame #022 (select)
	Video Capture: Frame #023 (select)
	Video Capture: Frame #024 (select)
	Video Capture: Frame #025 (select)
	Video Capture: Frame #026 (select)
	Video Capture: Frame #027 (select)
	Video Capture: Frame #028 (select)
	Video Capture: Frame #029 (select)
	Video Capture: Frame #030 (select)
	Video Capture: Frame #031 (select)
	Video Capture: Frame #032 (select)
	Video Capture: Frame #033 (select)
	Video Capture: Frame #034 (select)
	Video Capture: Frame #035 (select)
	Video Capture: Frame #036 (select)
	Video Capture: Frame #037 (select)
	Video Capture: Frame #038 (select)
	Video Capture: Frame #039 (select)
	Video Capture: Frame #040 (select)
	Video Capture: Frame #041 (select)
	Video Capture: Frame #042 (select)
	Video Capture: Frame #043 (select)
	Video Capture: Frame #044 (select)
	Video Capture: Frame #045 (select)
	Video Capture: Frame #046 (select)
	Video Capture: Frame #047 (select)
	Video Capture: Frame #048 (select)
	Video Capture: Frame #049 (select)
	Video Capture: Frame #050 (select)
	Video Capture: Frame #051 (select)
	Video Capture: Frame #052 (select)
	Video Capture: Frame #053 (select)
	Video Capture: Frame #054 (select)
	Video Capture: Frame #055 (select)
	Video Capture: Frame #056 (select)
	Video Capture: Frame #057 (select)
	Video Capture: Frame #058 (select)
	Video Capture: Frame #059 (select)

	test MMAP (select, CREATE_BUFS): OK

	Video Capture: Frame #000 (epoll)
	Video Capture: Frame #001 (epoll)
	Video Capture: Frame #002 (epoll)
	Video Capture: Frame #003 (epoll)
	Video Capture: Frame #004 (epoll)
	Video Capture: Frame #005 (epoll)
	Video Capture: Frame #006 (epoll)
	Video Capture: Frame #007 (epoll)
	Video Capture: Frame #008 (epoll)
	Video Capture: Frame #009 (epoll)
	Video Capture: Frame #010 (epoll)
	Video Capture: Frame #011 (epoll)
	Video Capture: Frame #012 (epoll)
	Video Capture: Frame #013 (epoll)
	Video Capture: Frame #014 (epoll)
	Video Capture: Frame #015 (epoll)
	Video Capture: Frame #016 (epoll)
	Video Capture: Frame #017 (epoll)
	Video Capture: Frame #018 (epoll)
	Video Capture: Frame #019 (epoll)
	Video Capture: Frame #020 (epoll)
	Video Capture: Frame #021 (epoll)
	Video Capture: Frame #022 (epoll)
	Video Capture: Frame #023 (epoll)
	Video Capture: Frame #024 (epoll)
	Video Capture: Frame #025 (epoll)
	Video Capture: Frame #026 (epoll)
	Video Capture: Frame #027 (epoll)
	Video Capture: Frame #028 (epoll)
	Video Capture: Frame #029 (epoll)
	Video Capture: Frame #030 (epoll)
	Video Capture: Frame #031 (epoll)
	Video Capture: Frame #032 (epoll)
	Video Capture: Frame #033 (epoll)
	Video Capture: Frame #034 (epoll)
	Video Capture: Frame #035 (epoll)
	Video Capture: Frame #036 (epoll)
	Video Capture: Frame #037 (epoll)
	Video Capture: Frame #038 (epoll)
	Video Capture: Frame #039 (epoll)
	Video Capture: Frame #040 (epoll)
	Video Capture: Frame #041 (epoll)
	Video Capture: Frame #042 (epoll)
	Video Capture: Frame #043 (epoll)
	Video Capture: Frame #044 (epoll)
	Video Capture: Frame #045 (epoll)
	Video Capture: Frame #046 (epoll)
	Video Capture: Frame #047 (epoll)
	Video Capture: Frame #048 (epoll)
	Video Capture: Frame #049 (epoll)
	Video Capture: Frame #050 (epoll)
	Video Capture: Frame #051 (epoll)
	Video Capture: Frame #052 (epoll)
	Video Capture: Frame #053 (epoll)
	Video Capture: Frame #054 (epoll)
	Video Capture: Frame #055 (epoll)
	Video Capture: Frame #056 (epoll)
	Video Capture: Frame #057 (epoll)
	Video Capture: Frame #058 (epoll)
	Video Capture: Frame #059 (epoll)

	test MMAP (epoll, CREATE_BUFS): OK

	Video Capture: Frame #000
	Video Capture: Frame #001
	Video Capture: Frame #002
	Video Capture: Frame #003
	Video Capture: Frame #004
	Video Capture: Frame #005
	Video Capture: Frame #006
	Video Capture: Frame #007
	Video Capture: Frame #008
	Video Capture: Frame #009
	Video Capture: Frame #010
	Video Capture: Frame #011
	Video Capture: Frame #012
	Video Capture: Frame #013
	Video Capture: Frame #014
	Video Capture: Frame #015
	Video Capture: Frame #016
	Video Capture: Frame #017
	Video Capture: Frame #018
	Video Capture: Frame #019
	Video Capture: Frame #020
	Video Capture: Frame #021
	Video Capture: Frame #022
	Video Capture: Frame #023
	Video Capture: Frame #024
	Video Capture: Frame #025
	Video Capture: Frame #026
	Video Capture: Frame #027
	Video Capture: Frame #028
	Video Capture: Frame #029
	Video Capture: Frame #030
	Video Capture: Frame #031
	Video Capture: Frame #032
	Video Capture: Frame #033
	Video Capture: Frame #034
	Video Capture: Frame #035
	Video Capture: Frame #036
	Video Capture: Frame #037
	Video Capture: Frame #038
	Video Capture: Frame #039
	Video Capture: Frame #040
	Video Capture: Frame #041
	Video Capture: Frame #042
	Video Capture: Frame #043
	Video Capture: Frame #044
	Video Capture: Frame #045
	Video Capture: Frame #046
	Video Capture: Frame #047
	Video Capture: Frame #048
	Video Capture: Frame #049
	Video Capture: Frame #050
	Video Capture: Frame #051
	Video Capture: Frame #052
	Video Capture: Frame #053
	Video Capture: Frame #054
	Video Capture: Frame #055
	Video Capture: Frame #056
	Video Capture: Frame #057
	Video Capture: Frame #058
	Video Capture: Frame #059

	test USERPTR (no poll): OK

	Video Capture: Frame #000 (select)
	Video Capture: Frame #001 (select)
	Video Capture: Frame #002 (select)
	Video Capture: Frame #003 (select)
	Video Capture: Frame #004 (select)
	Video Capture: Frame #005 (select)
	Video Capture: Frame #006 (select)
	Video Capture: Frame #007 (select)
	Video Capture: Frame #008 (select)
	Video Capture: Frame #009 (select)
	Video Capture: Frame #010 (select)
	Video Capture: Frame #011 (select)
	Video Capture: Frame #012 (select)
	Video Capture: Frame #013 (select)
	Video Capture: Frame #014 (select)
	Video Capture: Frame #015 (select)
	Video Capture: Frame #016 (select)
	Video Capture: Frame #017 (select)
	Video Capture: Frame #018 (select)
	Video Capture: Frame #019 (select)
	Video Capture: Frame #020 (select)
	Video Capture: Frame #021 (select)
	Video Capture: Frame #022 (select)
	Video Capture: Frame #023 (select)
	Video Capture: Frame #024 (select)
	Video Capture: Frame #025 (select)
	Video Capture: Frame #026 (select)
	Video Capture: Frame #027 (select)
	Video Capture: Frame #028 (select)
	Video Capture: Frame #029 (select)
	Video Capture: Frame #030 (select)
	Video Capture: Frame #031 (select)
	Video Capture: Frame #032 (select)
	Video Capture: Frame #033 (select)
	Video Capture: Frame #034 (select)
	Video Capture: Frame #035 (select)
	Video Capture: Frame #036 (select)
	Video Capture: Frame #037 (select)
	Video Capture: Frame #038 (select)
	Video Capture: Frame #039 (select)
	Video Capture: Frame #040 (select)
	Video Capture: Frame #041 (select)
	Video Capture: Frame #042 (select)
	Video Capture: Frame #043 (select)
	Video Capture: Frame #044 (select)
	Video Capture: Frame #045 (select)
	Video Capture: Frame #046 (select)
	Video Capture: Frame #047 (select)
	Video Capture: Frame #048 (select)
	Video Capture: Frame #049 (select)
	Video Capture: Frame #050 (select)
	Video Capture: Frame #051 (select)
	Video Capture: Frame #052 (select)
	Video Capture: Frame #053 (select)
	Video Capture: Frame #054 (select)
	Video Capture: Frame #055 (select)
	Video Capture: Frame #056 (select)
	Video Capture: Frame #057 (select)
	Video Capture: Frame #058 (select)
	Video Capture: Frame #059 (select)

	test USERPTR (select): OK
		warn: v4l2-test-buffers.cpp(2220): Cannot test DMABUF, specify --expbuf-device
	test DMABUF (no poll): OK (Not Supported)
	test DMABUF (select): OK (Not Supported)

Total for uvcvideo device /dev/video0: 60, Succeeded: 60, Failed: 0, Warnings: 1

As tested on the guest:

$ v4l2-compliance -d0 -s --is-uvc

v4l2-compliance 1.33.0-5523, 64 bits, 64-bit time_t
v4l2-compliance SHA: b3a7e9f866ed 2026-10-29 15:25:03

Compliance test for virtio-media device /dev/video0:

Driver Info:
	Driver name      : virtio-media
	Card type        : Logitech Webcam C925e
	Bus info         : platform:virtio-media
	Driver version   : 7.3.0
	Capabilities     : 0x84200001
		Video Capture
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04200001
		Video Capture
		Streaming
		Extended Pix Format

Required ioctls:
	test VIDIOC_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/video0 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 1 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls (Input 0):
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
	test VIDIOC_QUERYCTRL: OK
	test VIDIOC_G/S_CTRL: OK
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 19 Private Controls: 0

Format ioctls (Input 0):
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK (Not Supported)

Codec ioctls (Input 0):
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test CREATE_BUFS maximum buffers: OK
	test VIDIOC_REMOVE_BUFS: OK
	test VIDIOC_EXPBUF: OK (Not Supported)
	test Requests: OK (Not Supported)
	test blocking wait: OK

Test input 0:

Streaming ioctls:
	test read/write: OK (Not Supported)

	Video Capture: Frame #000
	Video Capture: Frame #001
	Video Capture: Frame #002
	Video Capture: Frame #003
	Video Capture: Frame #004
	Video Capture: Frame #005
	Video Capture: Frame #006
	Video Capture: Frame #007
	Video Capture: Frame #008
	Video Capture: Frame #009
	Video Capture: Frame #010
	Video Capture: Frame #011
	Video Capture: Frame #012
	Video Capture: Frame #013
	Video Capture: Frame #014
	Video Capture: Frame #015
	Video Capture: Frame #016
	Video Capture: Frame #017
	Video Capture: Frame #018
	Video Capture: Frame #019
	Video Capture: Frame #020
	Video Capture: Frame #021
	Video Capture: Frame #022
	Video Capture: Frame #023
	Video Capture: Frame #024
	Video Capture: Frame #025
	Video Capture: Frame #026
	Video Capture: Frame #027
	Video Capture: Frame #028
	Video Capture: Frame #029
	Video Capture: Frame #030
	Video Capture: Frame #031
	Video Capture: Frame #032
	Video Capture: Frame #033
	Video Capture: Frame #034
	Video Capture: Frame #035
	Video Capture: Frame #036
	Video Capture: Frame #037
	Video Capture: Frame #038
	Video Capture: Frame #039
	Video Capture: Frame #040
	Video Capture: Frame #041
	Video Capture: Frame #042
	Video Capture: Frame #043
	Video Capture: Frame #044
	Video Capture: Frame #045
	Video Capture: Frame #046
	Video Capture: Frame #047
	Video Capture: Frame #048
	Video Capture: Frame #049
	Video Capture: Frame #050
	Video Capture: Frame #051
	Video Capture: Frame #052
	Video Capture: Frame #053
	Video Capture: Frame #054
	Video Capture: Frame #055
	Video Capture: Frame #056
	Video Capture: Frame #057
	Video Capture: Frame #058
	Video Capture: Frame #059

	test MMAP (no poll, REQBUFS): OK

	Video Capture: Frame #000 (select)
	Video Capture: Frame #001 (select)
	Video Capture: Frame #002 (select)
	Video Capture: Frame #003 (select)
	Video Capture: Frame #004 (select)
	Video Capture: Frame #005 (select)
	Video Capture: Frame #006 (select)
	Video Capture: Frame #007 (select)
	Video Capture: Frame #008 (select)
	Video Capture: Frame #009 (select)
	Video Capture: Frame #010 (select)
	Video Capture: Frame #011 (select)
	Video Capture: Frame #012 (select)
	Video Capture: Frame #013 (select)
	Video Capture: Frame #014 (select)
	Video Capture: Frame #015 (select)
	Video Capture: Frame #016 (select)
	Video Capture: Frame #017 (select)
	Video Capture: Frame #018 (select)
	Video Capture: Frame #019 (select)
	Video Capture: Frame #020 (select)
	Video Capture: Frame #021 (select)
	Video Capture: Frame #022 (select)
	Video Capture: Frame #023 (select)
	Video Capture: Frame #024 (select)
	Video Capture: Frame #025 (select)
	Video Capture: Frame #026 (select)
	Video Capture: Frame #027 (select)
	Video Capture: Frame #028 (select)
	Video Capture: Frame #029 (select)
	Video Capture: Frame #030 (select)
	Video Capture: Frame #031 (select)
	Video Capture: Frame #032 (select)
	Video Capture: Frame #033 (select)
	Video Capture: Frame #034 (select)
	Video Capture: Frame #035 (select)
	Video Capture: Frame #036 (select)
	Video Capture: Frame #037 (select)
	Video Capture: Frame #038 (select)
	Video Capture: Frame #039 (select)
	Video Capture: Frame #040 (select)
	Video Capture: Frame #041 (select)
	Video Capture: Frame #042 (select)
	Video Capture: Frame #043 (select)
	Video Capture: Frame #044 (select)
	Video Capture: Frame #045 (select)
	Video Capture: Frame #046 (select)
	Video Capture: Frame #047 (select)
	Video Capture: Frame #048 (select)
	Video Capture: Frame #049 (select)
	Video Capture: Frame #050 (select)
	Video Capture: Frame #051 (select)
	Video Capture: Frame #052 (select)
	Video Capture: Frame #053 (select)
	Video Capture: Frame #054 (select)
	Video Capture: Frame #055 (select)
	Video Capture: Frame #056 (select)
	Video Capture: Frame #057 (select)
	Video Capture: Frame #058 (select)
	Video Capture: Frame #059 (select)

	test MMAP (select, REQBUFS): OK

	Video Capture: Frame #000 (epoll)
	Video Capture: Frame #001 (epoll)
	Video Capture: Frame #002 (epoll)
	Video Capture: Frame #003 (epoll)
	Video Capture: Frame #004 (epoll)
	Video Capture: Frame #005 (epoll)
	Video Capture: Frame #006 (epoll)
	Video Capture: Frame #007 (epoll)
	Video Capture: Frame #008 (epoll)
	Video Capture: Frame #009 (epoll)
	Video Capture: Frame #010 (epoll)
	Video Capture: Frame #011 (epoll)
	Video Capture: Frame #012 (epoll)
	Video Capture: Frame #013 (epoll)
	Video Capture: Frame #014 (epoll)
	Video Capture: Frame #015 (epoll)
	Video Capture: Frame #016 (epoll)
	Video Capture: Frame #017 (epoll)
	Video Capture: Frame #018 (epoll)
	Video Capture: Frame #019 (epoll)
	Video Capture: Frame #020 (epoll)
	Video Capture: Frame #021 (epoll)
	Video Capture: Frame #022 (epoll)
	Video Capture: Frame #023 (epoll)
	Video Capture: Frame #024 (epoll)
	Video Capture: Frame #025 (epoll)
	Video Capture: Frame #026 (epoll)
	Video Capture: Frame #027 (epoll)
	Video Capture: Frame #028 (epoll)
	Video Capture: Frame #029 (epoll)
	Video Capture: Frame #030 (epoll)
	Video Capture: Frame #031 (epoll)
	Video Capture: Frame #032 (epoll)
	Video Capture: Frame #033 (epoll)
	Video Capture: Frame #034 (epoll)
	Video Capture: Frame #035 (epoll)
	Video Capture: Frame #036 (epoll)
	Video Capture: Frame #037 (epoll)
	Video Capture: Frame #038 (epoll)
	Video Capture: Frame #039 (epoll)
	Video Capture: Frame #040 (epoll)
	Video Capture: Frame #041 (epoll)
	Video Capture: Frame #042 (epoll)
	Video Capture: Frame #043 (epoll)
	Video Capture: Frame #044 (epoll)
	Video Capture: Frame #045 (epoll)
	Video Capture: Frame #046 (epoll)
	Video Capture: Frame #047 (epoll)
	Video Capture: Frame #048 (epoll)
	Video Capture: Frame #049 (epoll)
	Video Capture: Frame #050 (epoll)
	Video Capture: Frame #051 (epoll)
	Video Capture: Frame #052 (epoll)
	Video Capture: Frame #053 (epoll)
	Video Capture: Frame #054 (epoll)
	Video Capture: Frame #055 (epoll)
	Video Capture: Frame #056 (epoll)
	Video Capture: Frame #057 (epoll)
	Video Capture: Frame #058 (epoll)
	Video Capture: Frame #059 (epoll)

	test MMAP (epoll, REQBUFS): OK

	Video Capture: Frame #000
	Video Capture: Frame #001
	Video Capture: Frame #002
	Video Capture: Frame #003
	Video Capture: Frame #004
	Video Capture: Frame #005
	Video Capture: Frame #006
	Video Capture: Frame #007
	Video Capture: Frame #008
	Video Capture: Frame #009
	Video Capture: Frame #010
	Video Capture: Frame #011
	Video Capture: Frame #012
	Video Capture: Frame #013
	Video Capture: Frame #014
	Video Capture: Frame #015
	Video Capture: Frame #016
	Video Capture: Frame #017
	Video Capture: Frame #018
	Video Capture: Frame #019
	Video Capture: Frame #020
	Video Capture: Frame #021
	Video Capture: Frame #022
	Video Capture: Frame #023
	Video Capture: Frame #024
	Video Capture: Frame #025
	Video Capture: Frame #026
	Video Capture: Frame #027
	Video Capture: Frame #028
	Video Capture: Frame #029
	Video Capture: Frame #030
	Video Capture: Frame #031
	Video Capture: Frame #032
	Video Capture: Frame #033
	Video Capture: Frame #034
	Video Capture: Frame #035
	Video Capture: Frame #036
	Video Capture: Frame #037
	Video Capture: Frame #038
	Video Capture: Frame #039
	Video Capture: Frame #040
	Video Capture: Frame #041
	Video Capture: Frame #042
	Video Capture: Frame #043
	Video Capture: Frame #044
	Video Capture: Frame #045
	Video Capture: Frame #046
	Video Capture: Frame #047
	Video Capture: Frame #048
	Video Capture: Frame #049
	Video Capture: Frame #050
	Video Capture: Frame #051
	Video Capture: Frame #052
	Video Capture: Frame #053
	Video Capture: Frame #054
	Video Capture: Frame #055
	Video Capture: Frame #056
	Video Capture: Frame #057
	Video Capture: Frame #058
	Video Capture: Frame #059

	test MMAP (no poll, CREATE_BUFS): OK

	Video Capture: Frame #000 (select)
	Video Capture: Frame #001 (select)
	Video Capture: Frame #002 (select)
	Video Capture: Frame #003 (select)
	Video Capture: Frame #004 (select)
	Video Capture: Frame #005 (select)
	Video Capture: Frame #006 (select)
	Video Capture: Frame #007 (select)
	Video Capture: Frame #008 (select)
	Video Capture: Frame #009 (select)
	Video Capture: Frame #010 (select)
	Video Capture: Frame #011 (select)
	Video Capture: Frame #012 (select)
	Video Capture: Frame #013 (select)
	Video Capture: Frame #014 (select)
	Video Capture: Frame #015 (select)
	Video Capture: Frame #016 (select)
	Video Capture: Frame #017 (select)
	Video Capture: Frame #018 (select)
	Video Capture: Frame #019 (select)
	Video Capture: Frame #020 (select)
	Video Capture: Frame #021 (select)
	Video Capture: Frame #022 (select)
	Video Capture: Frame #023 (select)
	Video Capture: Frame #024 (select)
	Video Capture: Frame #025 (select)
	Video Capture: Frame #026 (select)
	Video Capture: Frame #027 (select)
	Video Capture: Frame #028 (select)
	Video Capture: Frame #029 (select)
	Video Capture: Frame #030 (select)
	Video Capture: Frame #031 (select)
	Video Capture: Frame #032 (select)
	Video Capture: Frame #033 (select)
	Video Capture: Frame #034 (select)
	Video Capture: Frame #035 (select)
	Video Capture: Frame #036 (select)
	Video Capture: Frame #037 (select)
	Video Capture: Frame #038 (select)
	Video Capture: Frame #039 (select)
	Video Capture: Frame #040 (select)
	Video Capture: Frame #041 (select)
	Video Capture: Frame #042 (select)
	Video Capture: Frame #043 (select)
	Video Capture: Frame #044 (select)
	Video Capture: Frame #045 (select)
	Video Capture: Frame #046 (select)
	Video Capture: Frame #047 (select)
	Video Capture: Frame #048 (select)
	Video Capture: Frame #049 (select)
	Video Capture: Frame #050 (select)
	Video Capture: Frame #051 (select)
	Video Capture: Frame #052 (select)
	Video Capture: Frame #053 (select)
	Video Capture: Frame #054 (select)
	Video Capture: Frame #055 (select)
	Video Capture: Frame #056 (select)
	Video Capture: Frame #057 (select)
	Video Capture: Frame #058 (select)
	Video Capture: Frame #059 (select)

	test MMAP (select, CREATE_BUFS): OK

	Video Capture: Frame #000 (epoll)
	Video Capture: Frame #001 (epoll)
	Video Capture: Frame #002 (epoll)
	Video Capture: Frame #003 (epoll)
	Video Capture: Frame #004 (epoll)
	Video Capture: Frame #005 (epoll)
	Video Capture: Frame #006 (epoll)
	Video Capture: Frame #007 (epoll)
	Video Capture: Frame #008 (epoll)
	Video Capture: Frame #009 (epoll)
	Video Capture: Frame #010 (epoll)
	Video Capture: Frame #011 (epoll)
	Video Capture: Frame #012 (epoll)
	Video Capture: Frame #013 (epoll)
	Video Capture: Frame #014 (epoll)
	Video Capture: Frame #015 (epoll)
	Video Capture: Frame #016 (epoll)
	Video Capture: Frame #017 (epoll)
	Video Capture: Frame #018 (epoll)
	Video Capture: Frame #019 (epoll)
	Video Capture: Frame #020 (epoll)
	Video Capture: Frame #021 (epoll)
	Video Capture: Frame #022 (epoll)
	Video Capture: Frame #023 (epoll)
	Video Capture: Frame #024 (epoll)
	Video Capture: Frame #025 (epoll)
	Video Capture: Frame #026 (epoll)
	Video Capture: Frame #027 (epoll)
	Video Capture: Frame #028 (epoll)
	Video Capture: Frame #029 (epoll)
	Video Capture: Frame #030 (epoll)
	Video Capture: Frame #031 (epoll)
	Video Capture: Frame #032 (epoll)
	Video Capture: Frame #033 (epoll)
	Video Capture: Frame #034 (epoll)
	Video Capture: Frame #035 (epoll)
	Video Capture: Frame #036 (epoll)
	Video Capture: Frame #037 (epoll)
	Video Capture: Frame #038 (epoll)
	Video Capture: Frame #039 (epoll)
	Video Capture: Frame #040 (epoll)
	Video Capture: Frame #041 (epoll)
	Video Capture: Frame #042 (epoll)
	Video Capture: Frame #043 (epoll)
	Video Capture: Frame #044 (epoll)
	Video Capture: Frame #045 (epoll)
	Video Capture: Frame #046 (epoll)
	Video Capture: Frame #047 (epoll)
	Video Capture: Frame #048 (epoll)
	Video Capture: Frame #049 (epoll)
	Video Capture: Frame #050 (epoll)
	Video Capture: Frame #051 (epoll)
	Video Capture: Frame #052 (epoll)
	Video Capture: Frame #053 (epoll)
	Video Capture: Frame #054 (epoll)
	Video Capture: Frame #055 (epoll)
	Video Capture: Frame #056 (epoll)
	Video Capture: Frame #057 (epoll)
	Video Capture: Frame #058 (epoll)
	Video Capture: Frame #059 (epoll)

	test MMAP (epoll, CREATE_BUFS): OK
	test USERPTR (no poll): OK (Not Supported)
	test USERPTR (select): OK (Not Supported)
	test DMABUF (no poll): OK (Not Supported)
	test DMABUF (select): OK (Not Supported)

Total for virtio-media device /dev/video0: 59, Succeeded: 59, Failed: 0, Warnings: 0

---
Changes in v11:
- Initialize controls' size value to zero
  (https://lore.kernel.org/all/20260925080140.44696-1-nick@getfieldwork.ai)
- Framevec updated to work for multiple controls
- virtio_device_ready() is now called after early error paths
- Make g_input and g_output ioctls use _IOR version of cmd instead of _IOWR
- Fix behavior where poll does not report the CAPTURE queue readable after the LAST buffer
- Ensure event mutex is locked during probe
- Mmap returns EIO if the session error state is set
- Changed g_input and g_output ioctls to be _IOR instead of _IOWR to
  match the v4l2 specification and virtio-media virtual device
  implementation

Changes in v10:
- Rebased on top of v7.3-rc1
- Add missing padding in ``struct virtio_media_cmd_mmap``
- Add ``virtio_media_config`` to uapi header and use proper ``cread`` during init
- Remove redundant assignment of ``vfl_type``
- Fix tear down order of the video device and resources in
  ``virtio_media_remove()``
- Call ``virtio_device_ready()`` before starting device
- Move from ``devm`` to manual memory management to prevent potential use after
  free
- Detach unused buffers from the virtqueues during device remove
- Remove wait timeout during kick command
- Fix use after free in case of transport-level error
- Add additional validity check for scatterlist data buffer
- Ensure PFNs are not truncated
- Use dynamic ``shadow_buffer_size`` in ``scatterlist_builder`` instead of the
  ``VIRTIO_SHADOW_BUF_SIZE`` constant to guard against future modifications
- Fix case where exact fit into a shadow buffer was wrongly rejected
- Fail early if ``virtio_get_shm_region()`` fails
- Move guest allocation before host call in ``reqbufs`` and ``createbufs``
- Clean up host-side mmap if ``io_remap_pfn_range()`` fails
- Ensure command failure returns in ``ext_controls`` ioctls
- Replace array ``vmalloc`` allocations with ``vcalloc`` for overflow protection
- Add check in ``dqbuf`` ioctl if no buffer is in the queue in case multiple
  threads call ``VIDIOC_DQBUF``
- Change ``copy_from_user()``/``copy_to_user()`` failure return value from
  ``EINVAL`` to ``EFAULT``
- Ensure reserved fields are initialized to zero
- Ensure ``device_type`` from config area is valid
- Set ``done`` flag after ``resp_len`` to address a race in the condition check
  fast path
- Do not leave host session open if guest allocations fail
- Rename ``errno`` to ``error`` in ``virtio_media`` UAPI to prevent
  compilation errors in userspaces apps that include ``errno.h``
- Keep user pages pinned during ``ext_ctrls`` request

Changes in v9:
- Removed note from cover letter about the dependency on the VIRTIO_ID_MEDIA
  patch since this was merged.

Changes in v8:
- Fix usage of integer types in uapi
- Add uapi header test exemption due to depenency on currently exempt videodev2.h

Changes in v7:
- Removed USERPTR feature
- Updated Kconfig dependency to include little endian and 64bit platforms (not
  only ARM and x86)
- Fixed incorrect constant in vfl_dir detection
- Clarified that error codes returned by the host are positive integers

Changes in v6:
- Added missing "WITH Linux-syscall-note" for SPDX-License-Identifier in
  ``include/uapi/linux/virtio_media.h``
- Rebased on top of v7.2-rc1

Changes in v5:
- Add DMA buffer alignment and padding for commands, responses, and the event
  buffer
- Corrected styling of kernel-doc comments
- Removed the configurable ``driver_name`` module parameter
- Moved the protocol to ``include/uapi/linux/virtio_media.h``
- Link to v4: https://lore.kernel.org/all/20260622204343.1994418-1-briandaniels@google.com/

Changes in v4:
- Rebased on top of v7.1-rc1
- Replace usages of filep->private_data with file_to_v4l2_fh()
  throughout the driver
- Link to v3: https://lore.kernel.org/r/20250412-virtio-media-v3-1-97dc94c18398@gmail.com

Changes in v3:
- Rebased on top of v6.15-rc1 and removes obsolete control callbacks.
- Link to v2: https://lore.kernel.org/r/20250201-virtio-media-v2-1-ac840681452d@gmail.com

Changes in v2:
- Fixed kernel test robot and media CI warnings (ignored a few false
  positives).
- Changed in-driver email address to personal one since my Google one
  will soon become invalid.
- Link to v1: https://lore.kernel.org/r/20250123-virtio-media-v1-1-81e2549b86b9@gmail.com

Brian Daniels (5):
  media: virtio: Add core driver and session management
  media: virtio: Add V4L2 ioctl forwarding infrastructure
  media: virtio: Add extended controls support
  media: virtio: Add buffer streaming, event handling, and poll
  media: virtio: Add MMAP buffer mapping support

Nick Rogers (1):
  media: virtio: clear the size of legacy controls built on the stack

 MAINTAINERS                                |    8 +
 drivers/media/Kconfig                      |   13 +
 drivers/media/Makefile                     |    2 +
 drivers/media/virtio/Makefile              |    7 +
 drivers/media/virtio/scatterlist_builder.c |  596 +++++++++
 drivers/media/virtio/scatterlist_builder.h |  125 ++
 drivers/media/virtio/session.h             |  135 ++
 drivers/media/virtio/virtio_media.h        |   95 ++
 drivers/media/virtio/virtio_media_driver.c | 1071 +++++++++++++++
 drivers/media/virtio/virtio_media_ioctls.c | 1411 ++++++++++++++++++++
 include/uapi/linux/virtio_media.h          |  309 +++++
 usr/include/Makefile                       |    1 +
 12 files changed, 3773 insertions(+)
 create mode 100644 drivers/media/virtio/Makefile
 create mode 100644 drivers/media/virtio/scatterlist_builder.c
 create mode 100644 drivers/media/virtio/scatterlist_builder.h
 create mode 100644 drivers/media/virtio/session.h
 create mode 100644 drivers/media/virtio/virtio_media.h
 create mode 100644 drivers/media/virtio/virtio_media_driver.c
 create mode 100644 drivers/media/virtio/virtio_media_ioctls.c
 create mode 100644 include/uapi/linux/virtio_media.h


base-commit: d7e7bca7169873b46e857c025c10f3336c1258d8
-- 
2.56.1.750.gf70dc682cf-goog

