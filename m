Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7A3612F1
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162575; cv=none; b=Y0fEFrFUjsC4GeC20wk/dr9UpEvslmByiA+JOYEeAFlBeBna0dS+kOQKnLtSDes+urTaP+uYHhYx0Q9C4aUFEekbYPv97KA0UPRUpL8SNEt3KdwqhtPhfzqi0TxfibuWs4iHkSJSLAinDcfYqoPwDyfUCR968RMCV4EXLQivdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162575; c=relaxed/simple;
	bh=XTAQ+6oe8hMIm6r15u7/ez6+ohxSjp+36uLTFYAb4oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mn4KQJkZrMj2Cs8/oDbguTZj36tvWHdz8gQP9FBww958OY6GU+srxmE36bs/AP8QTw9UUrV1cQWoqUZtNjINTpvfuezxpdxj2FB9wGP2z/v/rQZDJlrhOhzY4uf9luDfOXosRI8omHTyrvQsRx7tynf4jieVlcpGISRZXB7T3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyrbf5uG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyrbf5uG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782162571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYNbvA8cKh5Ad+hJ/sfgAMalnUc0LPoAk63rJHcpTpE=;
	b=gyrbf5uGSruoKirOf3YQd12ETaKfdHKc6FOHcBRQwBc9KCQCq/zaOoF9M0F0axf9INmeT5
	tlIHjwgzK0LbOHvzmdKGbu+7B+vriOsOfTy+4vBatXe/d1jAacZZEQ3H7VrSQUWyCokAVQ
	xQ59NbJsgoCrPKrVX1lLQgK9KqC5SVw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-usi0OlhZNR2JPCEhFhEk1A-1; Mon, 22 Jun 2026 17:09:30 -0400
X-MC-Unique: usi0OlhZNR2JPCEhFhEk1A-1
X-Mimecast-MFC-AGG-ID: usi0OlhZNR2JPCEhFhEk1A_1782162569
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4924583c7baso33295885e9.1
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 14:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782162569; x=1782767369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYNbvA8cKh5Ad+hJ/sfgAMalnUc0LPoAk63rJHcpTpE=;
        b=MB7KhDHYZ6/HulKnh+3g1Wu6WxNVJ+M3KsonKpxicqcaMp82R4Fo1eenDqIJ5LwNsl
         TOK44UNWV0AsWBPwPEK0Aa8c1UuZatj0KiZsTLP7uyeAP5LHt+133XKHazXDlWbPSoBL
         l7939g1bxhPYkNHff+XlXbQGVRF6z54h7YouxJ9IdezCx7Yc+cDXgv1oQHPn7LZigY+j
         HahR2PA2fMChQhGhTwn7x6KaSlaDPgvWUMNomDzx4coC9IE5aivvmHiS96O6vSS7pC4r
         zKA/C9Wzx3mujjDKlBPqN7g9eRMYC2cqrL59dStueCVXSqc/G9QrjSQ3/qJmvpvHQf57
         yJHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FfLE7/PgcAnlEfojMj6Q+ch4l2CHWqAMq0R7Pyq9FK2N168fVzPWLnlg0kf1dPBtoC622XsRg7qqFkGV8bA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2e5EkzLAFhA8izyOF5T2IB4kJVW6ZbdhYC+7rL5slbl6TADT/
	Iem9a67pHv9bzzpVMGiBWMfN5rMEInkoo2556BaCLjEQarJ62jxFHpnWaq3cYMSYNnqFtGA6Z75
	fiy3f77ClyoX4kSsiMszkgRmgWS2+2p/J7oy+DeenkFTltHVaJsrPdNp+v7Qci3EcJoje
X-Gm-Gg: AfdE7cnUpZZ2cxewPY9HwteGvyAyteffCskmhPT3NePczHSLU3TiHa4IfJpaVrP/o7C
	lNPMSeWqVgXzBL7WQQMxbN+5IZIVaOGNlZI7E6NqYrGfLh8mQRV12zpS57NDyQYlyocf4Y3UFan
	jIQHrAdUgE0s99uLm2+9myDbmTaLlKhFzkoYpiznDMTnN2kKoeJTQYG4HMLBJmg8hQqq24HXW/Z
	ksQgu5ceQq0aTfBLjQ6fYZ+bnmG9LIT9DO7ONkDGSsAQUp+7aTCLByH1ilEIkYPkCwtAejThR22
	ZhQs2lqDKBnAjdV0AyzHRHAWCGRIBMa5Gie5vkIiAdwY/yWhtedo2FquJZUjbl1zlXHbluPtF/+
	1ohGxLxCppObpU0OMzjCsZoW0DSL05LWL
X-Received: by 2002:a05:600c:6087:b0:492:4e6f:d994 with SMTP id 5b1f17b1804b1-4924e6fdab4mr150016365e9.32.1782162568553;
        Mon, 22 Jun 2026 14:09:28 -0700 (PDT)
X-Received: by 2002:a05:600c:6087:b0:492:4e6f:d994 with SMTP id 5b1f17b1804b1-4924e6fdab4mr150015895e9.32.1782162567883;
        Mon, 22 Jun 2026 14:09:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240f054e3sm326877515e9.2.2026.06.22.14.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:09:27 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:09:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brian Daniels <briandaniels@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com,
	adelva@google.com, aesteve@redhat.com, changyeon@google.com,
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com,
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v4 0/8] media: add virtio-media driver
Message-ID: <20260622170857-mutt-send-email-mst@kernel.org>
References: <20260622204343.1994418-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260622204343.1994418-1-briandaniels@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1zHmcdAFOtLuBOVL5QHbmlrTufxrKLko2V5d8TXginQ_1782162569
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2026 at 04:43:35PM -0400, Brian Daniels wrote:
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
> https://lore.kernel.org/all/20260310-virtio-media-id-v1-1-be211bcf682b@redhat.com
> 
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>

Thanks for the patches!
Sent some comments on individual patches.

> ---
> Guest Setup
> 
> Tests were ran on a Debian 12 guest running with crosvm. The guest image
> was created with:
> 
> $ virt-builder debian-12 --root-password password:""
> 
> Build crosvm and launch the guest starting at the "Crosvm" section on
> this page: https://github.com/chromeos/virtio-media/blob/main/TRY_IT_OUT.md#crosvm
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
> https://lore.kernel.org/r/20260528163448.4031965-1-briandaniels@google.com/
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
> 	Driver name      : uvcvideo
> 	Card type        : Logitech Webcam C925e
> 	Bus info         : usb-0000:04:00.1-3
> 	Driver version   : 6.18.14
> 	Capabilities     : 0x84a00001
> 		Video Capture
> 		Metadata Capture
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04200001
> 		Video Capture
> 		Streaming
> 		Extended Pix Format
> Media Driver Info:
> 	Driver name      : uvcvideo
> 	Model            : Logitech Webcam C925e
> 	Serial           : 686F371F
> 	Bus info         : usb-0000:04:00.1-3
> 	Media version    : 6.18.14
> 	Hardware revision: 0x00000016 (22)
> 	Driver version   : 6.18.14
> Interface Info:
> 	ID               : 0x03000002
> 	Type             : V4L Video
> Entity Info:
> 	ID               : 0x00000001 (1)
> 	Name             : Logitech Webcam C925e
> 	Function         : V4L2 I/O
> 	Flags            : default
> 	Pad 0x01000007   : 0: Sink
> 	  Link 0x0200001f: from remote pad 0x100000a of entity 'Processing 3' (Video Pixel Formatter): Data, Enabled, Immutable
> 
> Required ioctls:
> 	test MC information (see 'Media Driver Info' above): OK
> 	test VIDIOC_QUERYCAP: OK
> 	test invalid ioctls: OK
> 
> Allow for multiple opens:
> 	test second /dev/video1 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 1 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls (Input 0):
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 		fail: v4l2-test-controls.cpp(983): ret != EINVAL (got 13)
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 19 Private Controls: 0
> 
> Format ioctls (Input 0):
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK (Not Supported)
> 	test Composing: OK (Not Supported)
> 	test Scaling: OK (Not Supported)
> 
> Codec ioctls (Input 0):
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls (Input 0):
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test CREATE_BUFS maximum buffers: OK
> 	test VIDIOC_REMOVE_BUFS: OK
> 	test VIDIOC_EXPBUF: OK
> 	test Requests: OK (Not Supported)
> 	test blocking wait: OK
> 
> Test input 0:
> 
> Streaming ioctls:
> 	test read/write: OK (Not Supported)
> 
> 	Video Capture: Frame #000
> 	Video Capture: Frame #001
> 	Video Capture: Frame #002
> 	Video Capture: Frame #003
> 	Video Capture: Frame #004
> 	Video Capture: Frame #005
> 	Video Capture: Frame #006
> 	Video Capture: Frame #007
> 	Video Capture: Frame #008
> 	Video Capture: Frame #009
> 	Video Capture: Frame #010
> 	Video Capture: Frame #011
> 	Video Capture: Frame #012
> 	Video Capture: Frame #013
> 	Video Capture: Frame #014
> 	Video Capture: Frame #015
> 	Video Capture: Frame #016
> 	Video Capture: Frame #017
> 	Video Capture: Frame #018
> 	Video Capture: Frame #019
> 	Video Capture: Frame #020
> 	Video Capture: Frame #021
> 	Video Capture: Frame #022
> 	Video Capture: Frame #023
> 	Video Capture: Frame #024
> 	Video Capture: Frame #025
> 	Video Capture: Frame #026
> 	Video Capture: Frame #027
> 	Video Capture: Frame #028
> 	Video Capture: Frame #029
> 	Video Capture: Frame #030
> 	Video Capture: Frame #031
> 	Video Capture: Frame #032
> 	Video Capture: Frame #033
> 	Video Capture: Frame #034
> 	Video Capture: Frame #035
> 	Video Capture: Frame #036
> 	Video Capture: Frame #037
> 	Video Capture: Frame #038
> 	Video Capture: Frame #039
> 	Video Capture: Frame #040
> 	Video Capture: Frame #041
> 	Video Capture: Frame #042
> 	Video Capture: Frame #043
> 	Video Capture: Frame #044
> 	Video Capture: Frame #045
> 	Video Capture: Frame #046
> 	Video Capture: Frame #047
> 	Video Capture: Frame #048
> 	Video Capture: Frame #049
> 	Video Capture: Frame #050
> 	Video Capture: Frame #051
> 	Video Capture: Frame #052
> 	Video Capture: Frame #053
> 	Video Capture: Frame #054
> 	Video Capture: Frame #055
> 	Video Capture: Frame #056
> 	Video Capture: Frame #057
> 	Video Capture: Frame #058
> 	Video Capture: Frame #059
> 
> 	test MMAP (no poll, REQBUFS): OK
> 
> 	Video Capture: Frame #000 (select)
> 	Video Capture: Frame #001 (select)
> 	Video Capture: Frame #002 (select)
> 	Video Capture: Frame #003 (select)
> 	Video Capture: Frame #004 (select)
> 	Video Capture: Frame #005 (select)
> 	Video Capture: Frame #006 (select)
> 	Video Capture: Frame #007 (select)
> 	Video Capture: Frame #008 (select)
> 	Video Capture: Frame #009 (select)
> 	Video Capture: Frame #010 (select)
> 	Video Capture: Frame #011 (select)
> 	Video Capture: Frame #012 (select)
> 	Video Capture: Frame #013 (select)
> 	Video Capture: Frame #014 (select)
> 	Video Capture: Frame #015 (select)
> 	Video Capture: Frame #016 (select)
> 	Video Capture: Frame #017 (select)
> 	Video Capture: Frame #018 (select)
> 	Video Capture: Frame #019 (select)
> 	Video Capture: Frame #020 (select)
> 	Video Capture: Frame #021 (select)
> 	Video Capture: Frame #022 (select)
> 	Video Capture: Frame #023 (select)
> 	Video Capture: Frame #024 (select)
> 	Video Capture: Frame #025 (select)
> 	Video Capture: Frame #026 (select)
> 	Video Capture: Frame #027 (select)
> 	Video Capture: Frame #028 (select)
> 	Video Capture: Frame #029 (select)
> 	Video Capture: Frame #030 (select)
> 	Video Capture: Frame #031 (select)
> 	Video Capture: Frame #032 (select)
> 	Video Capture: Frame #033 (select)
> 	Video Capture: Frame #034 (select)
> 	Video Capture: Frame #035 (select)
> 	Video Capture: Frame #036 (select)
> 	Video Capture: Frame #037 (select)
> 	Video Capture: Frame #038 (select)
> 	Video Capture: Frame #039 (select)
> 	Video Capture: Frame #040 (select)
> 	Video Capture: Frame #041 (select)
> 	Video Capture: Frame #042 (select)
> 	Video Capture: Frame #043 (select)
> 	Video Capture: Frame #044 (select)
> 	Video Capture: Frame #045 (select)
> 	Video Capture: Frame #046 (select)
> 	Video Capture: Frame #047 (select)
> 	Video Capture: Frame #048 (select)
> 	Video Capture: Frame #049 (select)
> 	Video Capture: Frame #050 (select)
> 	Video Capture: Frame #051 (select)
> 	Video Capture: Frame #052 (select)
> 	Video Capture: Frame #053 (select)
> 	Video Capture: Frame #054 (select)
> 	Video Capture: Frame #055 (select)
> 	Video Capture: Frame #056 (select)
> 	Video Capture: Frame #057 (select)
> 	Video Capture: Frame #058 (select)
> 	Video Capture: Frame #059 (select)
> 
> 	test MMAP (select, REQBUFS): OK
> 
> 	Video Capture: Frame #000 (epoll)
> 	Video Capture: Frame #001 (epoll)
> 	Video Capture: Frame #002 (epoll)
> 	Video Capture: Frame #003 (epoll)
> 	Video Capture: Frame #004 (epoll)
> 	Video Capture: Frame #005 (epoll)
> 	Video Capture: Frame #006 (epoll)
> 	Video Capture: Frame #007 (epoll)
> 	Video Capture: Frame #008 (epoll)
> 	Video Capture: Frame #009 (epoll)
> 	Video Capture: Frame #010 (epoll)
> 	Video Capture: Frame #011 (epoll)
> 	Video Capture: Frame #012 (epoll)
> 	Video Capture: Frame #013 (epoll)
> 	Video Capture: Frame #014 (epoll)
> 	Video Capture: Frame #015 (epoll)
> 	Video Capture: Frame #016 (epoll)
> 	Video Capture: Frame #017 (epoll)
> 	Video Capture: Frame #018 (epoll)
> 	Video Capture: Frame #019 (epoll)
> 	Video Capture: Frame #020 (epoll)
> 	Video Capture: Frame #021 (epoll)
> 	Video Capture: Frame #022 (epoll)
> 	Video Capture: Frame #023 (epoll)
> 	Video Capture: Frame #024 (epoll)
> 	Video Capture: Frame #025 (epoll)
> 	Video Capture: Frame #026 (epoll)
> 	Video Capture: Frame #027 (epoll)
> 	Video Capture: Frame #028 (epoll)
> 	Video Capture: Frame #029 (epoll)
> 	Video Capture: Frame #030 (epoll)
> 	Video Capture: Frame #031 (epoll)
> 	Video Capture: Frame #032 (epoll)
> 	Video Capture: Frame #033 (epoll)
> 	Video Capture: Frame #034 (epoll)
> 	Video Capture: Frame #035 (epoll)
> 	Video Capture: Frame #036 (epoll)
> 	Video Capture: Frame #037 (epoll)
> 	Video Capture: Frame #038 (epoll)
> 	Video Capture: Frame #039 (epoll)
> 	Video Capture: Frame #040 (epoll)
> 	Video Capture: Frame #041 (epoll)
> 	Video Capture: Frame #042 (epoll)
> 	Video Capture: Frame #043 (epoll)
> 	Video Capture: Frame #044 (epoll)
> 	Video Capture: Frame #045 (epoll)
> 	Video Capture: Frame #046 (epoll)
> 	Video Capture: Frame #047 (epoll)
> 	Video Capture: Frame #048 (epoll)
> 	Video Capture: Frame #049 (epoll)
> 	Video Capture: Frame #050 (epoll)
> 	Video Capture: Frame #051 (epoll)
> 	Video Capture: Frame #052 (epoll)
> 	Video Capture: Frame #053 (epoll)
> 	Video Capture: Frame #054 (epoll)
> 	Video Capture: Frame #055 (epoll)
> 	Video Capture: Frame #056 (epoll)
> 	Video Capture: Frame #057 (epoll)
> 	Video Capture: Frame #058 (epoll)
> 	Video Capture: Frame #059 (epoll)
> 
> 	test MMAP (epoll, REQBUFS): OK
> 
> 	Video Capture: Frame #000
> 	Video Capture: Frame #001
> 	Video Capture: Frame #002
> 	Video Capture: Frame #003
> 	Video Capture: Frame #004
> 	Video Capture: Frame #005
> 	Video Capture: Frame #006
> 	Video Capture: Frame #007
> 	Video Capture: Frame #008
> 	Video Capture: Frame #009
> 	Video Capture: Frame #010
> 	Video Capture: Frame #011
> 	Video Capture: Frame #012
> 	Video Capture: Frame #013
> 	Video Capture: Frame #014
> 	Video Capture: Frame #015
> 	Video Capture: Frame #016
> 	Video Capture: Frame #017
> 	Video Capture: Frame #018
> 	Video Capture: Frame #019
> 	Video Capture: Frame #020
> 	Video Capture: Frame #021
> 	Video Capture: Frame #022
> 	Video Capture: Frame #023
> 	Video Capture: Frame #024
> 	Video Capture: Frame #025
> 	Video Capture: Frame #026
> 	Video Capture: Frame #027
> 	Video Capture: Frame #028
> 	Video Capture: Frame #029
> 	Video Capture: Frame #030
> 	Video Capture: Frame #031
> 	Video Capture: Frame #032
> 	Video Capture: Frame #033
> 	Video Capture: Frame #034
> 	Video Capture: Frame #035
> 	Video Capture: Frame #036
> 	Video Capture: Frame #037
> 	Video Capture: Frame #038
> 	Video Capture: Frame #039
> 	Video Capture: Frame #040
> 	Video Capture: Frame #041
> 	Video Capture: Frame #042
> 	Video Capture: Frame #043
> 	Video Capture: Frame #044
> 	Video Capture: Frame #045
> 	Video Capture: Frame #046
> 	Video Capture: Frame #047
> 	Video Capture: Frame #048
> 	Video Capture: Frame #049
> 	Video Capture: Frame #050
> 	Video Capture: Frame #051
> 	Video Capture: Frame #052
> 	Video Capture: Frame #053
> 	Video Capture: Frame #054
> 	Video Capture: Frame #055
> 	Video Capture: Frame #056
> 	Video Capture: Frame #057
> 	Video Capture: Frame #058
> 	Video Capture: Frame #059
> 
> 	test MMAP (no poll, CREATE_BUFS): OK
> 
> 	Video Capture: Frame #000 (select)
> 	Video Capture: Frame #001 (select)
> 	Video Capture: Frame #002 (select)
> 	Video Capture: Frame #003 (select)
> 	Video Capture: Frame #004 (select)
> 	Video Capture: Frame #005 (select)
> 	Video Capture: Frame #006 (select)
> 	Video Capture: Frame #007 (select)
> 	Video Capture: Frame #008 (select)
> 	Video Capture: Frame #009 (select)
> 	Video Capture: Frame #010 (select)
> 	Video Capture: Frame #011 (select)
> 	Video Capture: Frame #012 (select)
> 	Video Capture: Frame #013 (select)
> 	Video Capture: Frame #014 (select)
> 	Video Capture: Frame #015 (select)
> 	Video Capture: Frame #016 (select)
> 	Video Capture: Frame #017 (select)
> 	Video Capture: Frame #018 (select)
> 	Video Capture: Frame #019 (select)
> 	Video Capture: Frame #020 (select)
> 	Video Capture: Frame #021 (select)
> 	Video Capture: Frame #022 (select)
> 	Video Capture: Frame #023 (select)
> 	Video Capture: Frame #024 (select)
> 	Video Capture: Frame #025 (select)
> 	Video Capture: Frame #026 (select)
> 	Video Capture: Frame #027 (select)
> 	Video Capture: Frame #028 (select)
> 	Video Capture: Frame #029 (select)
> 	Video Capture: Frame #030 (select)
> 	Video Capture: Frame #031 (select)
> 	Video Capture: Frame #032 (select)
> 	Video Capture: Frame #033 (select)
> 	Video Capture: Frame #034 (select)
> 	Video Capture: Frame #035 (select)
> 	Video Capture: Frame #036 (select)
> 	Video Capture: Frame #037 (select)
> 	Video Capture: Frame #038 (select)
> 	Video Capture: Frame #039 (select)
> 	Video Capture: Frame #040 (select)
> 	Video Capture: Frame #041 (select)
> 	Video Capture: Frame #042 (select)
> 	Video Capture: Frame #043 (select)
> 	Video Capture: Frame #044 (select)
> 	Video Capture: Frame #045 (select)
> 	Video Capture: Frame #046 (select)
> 	Video Capture: Frame #047 (select)
> 	Video Capture: Frame #048 (select)
> 	Video Capture: Frame #049 (select)
> 	Video Capture: Frame #050 (select)
> 	Video Capture: Frame #051 (select)
> 	Video Capture: Frame #052 (select)
> 	Video Capture: Frame #053 (select)
> 	Video Capture: Frame #054 (select)
> 	Video Capture: Frame #055 (select)
> 	Video Capture: Frame #056 (select)
> 	Video Capture: Frame #057 (select)
> 	Video Capture: Frame #058 (select)
> 	Video Capture: Frame #059 (select)
> 
> 	test MMAP (select, CREATE_BUFS): OK
> 
> 	Video Capture: Frame #000 (epoll)
> 	Video Capture: Frame #001 (epoll)
> 	Video Capture: Frame #002 (epoll)
> 	Video Capture: Frame #003 (epoll)
> 	Video Capture: Frame #004 (epoll)
> 	Video Capture: Frame #005 (epoll)
> 	Video Capture: Frame #006 (epoll)
> 	Video Capture: Frame #007 (epoll)
> 	Video Capture: Frame #008 (epoll)
> 	Video Capture: Frame #009 (epoll)
> 	Video Capture: Frame #010 (epoll)
> 	Video Capture: Frame #011 (epoll)
> 	Video Capture: Frame #012 (epoll)
> 	Video Capture: Frame #013 (epoll)
> 	Video Capture: Frame #014 (epoll)
> 	Video Capture: Frame #015 (epoll)
> 	Video Capture: Frame #016 (epoll)
> 	Video Capture: Frame #017 (epoll)
> 	Video Capture: Frame #018 (epoll)
> 	Video Capture: Frame #019 (epoll)
> 	Video Capture: Frame #020 (epoll)
> 	Video Capture: Frame #021 (epoll)
> 	Video Capture: Frame #022 (epoll)
> 	Video Capture: Frame #023 (epoll)
> 	Video Capture: Frame #024 (epoll)
> 	Video Capture: Frame #025 (epoll)
> 	Video Capture: Frame #026 (epoll)
> 	Video Capture: Frame #027 (epoll)
> 	Video Capture: Frame #028 (epoll)
> 	Video Capture: Frame #029 (epoll)
> 	Video Capture: Frame #030 (epoll)
> 	Video Capture: Frame #031 (epoll)
> 	Video Capture: Frame #032 (epoll)
> 	Video Capture: Frame #033 (epoll)
> 	Video Capture: Frame #034 (epoll)
> 	Video Capture: Frame #035 (epoll)
> 	Video Capture: Frame #036 (epoll)
> 	Video Capture: Frame #037 (epoll)
> 	Video Capture: Frame #038 (epoll)
> 	Video Capture: Frame #039 (epoll)
> 	Video Capture: Frame #040 (epoll)
> 	Video Capture: Frame #041 (epoll)
> 	Video Capture: Frame #042 (epoll)
> 	Video Capture: Frame #043 (epoll)
> 	Video Capture: Frame #044 (epoll)
> 	Video Capture: Frame #045 (epoll)
> 	Video Capture: Frame #046 (epoll)
> 	Video Capture: Frame #047 (epoll)
> 	Video Capture: Frame #048 (epoll)
> 	Video Capture: Frame #049 (epoll)
> 	Video Capture: Frame #050 (epoll)
> 	Video Capture: Frame #051 (epoll)
> 	Video Capture: Frame #052 (epoll)
> 	Video Capture: Frame #053 (epoll)
> 	Video Capture: Frame #054 (epoll)
> 	Video Capture: Frame #055 (epoll)
> 	Video Capture: Frame #056 (epoll)
> 	Video Capture: Frame #057 (epoll)
> 	Video Capture: Frame #058 (epoll)
> 	Video Capture: Frame #059 (epoll)
> 
> 	test MMAP (epoll, CREATE_BUFS): OK
> 
> 	Video Capture: Frame #000
> 	Video Capture: Frame #001
> 	Video Capture: Frame #002
> 	Video Capture: Frame #003
> 	Video Capture: Frame #004
> 	Video Capture: Frame #005
> 	Video Capture: Frame #006
> 	Video Capture: Frame #007
> 	Video Capture: Frame #008
> 	Video Capture: Frame #009
> 	Video Capture: Frame #010
> 	Video Capture: Frame #011
> 	Video Capture: Frame #012
> 	Video Capture: Frame #013
> 	Video Capture: Frame #014
> 	Video Capture: Frame #015
> 	Video Capture: Frame #016
> 	Video Capture: Frame #017
> 	Video Capture: Frame #018
> 	Video Capture: Frame #019
> 	Video Capture: Frame #020
> 	Video Capture: Frame #021
> 	Video Capture: Frame #022
> 	Video Capture: Frame #023
> 	Video Capture: Frame #024
> 	Video Capture: Frame #025
> 	Video Capture: Frame #026
> 	Video Capture: Frame #027
> 	Video Capture: Frame #028
> 	Video Capture: Frame #029
> 	Video Capture: Frame #030
> 	Video Capture: Frame #031
> 	Video Capture: Frame #032
> 	Video Capture: Frame #033
> 	Video Capture: Frame #034
> 	Video Capture: Frame #035
> 	Video Capture: Frame #036
> 	Video Capture: Frame #037
> 	Video Capture: Frame #038
> 	Video Capture: Frame #039
> 	Video Capture: Frame #040
> 	Video Capture: Frame #041
> 	Video Capture: Frame #042
> 	Video Capture: Frame #043
> 	Video Capture: Frame #044
> 	Video Capture: Frame #045
> 	Video Capture: Frame #046
> 	Video Capture: Frame #047
> 	Video Capture: Frame #048
> 	Video Capture: Frame #049
> 	Video Capture: Frame #050
> 	Video Capture: Frame #051
> 	Video Capture: Frame #052
> 	Video Capture: Frame #053
> 	Video Capture: Frame #054
> 	Video Capture: Frame #055
> 	Video Capture: Frame #056
> 	Video Capture: Frame #057
> 	Video Capture: Frame #058
> 	Video Capture: Frame #059
> 
> 	test USERPTR (no poll): OK
> 
> 	Video Capture: Frame #000 (select)
> 	Video Capture: Frame #001 (select)
> 	Video Capture: Frame #002 (select)
> 	Video Capture: Frame #003 (select)
> 	Video Capture: Frame #004 (select)
> 	Video Capture: Frame #005 (select)
> 	Video Capture: Frame #006 (select)
> 	Video Capture: Frame #007 (select)
> 	Video Capture: Frame #008 (select)
> 	Video Capture: Frame #009 (select)
> 	Video Capture: Frame #010 (select)
> 	Video Capture: Frame #011 (select)
> 	Video Capture: Frame #012 (select)
> 	Video Capture: Frame #013 (select)
> 	Video Capture: Frame #014 (select)
> 	Video Capture: Frame #015 (select)
> 	Video Capture: Frame #016 (select)
> 	Video Capture: Frame #017 (select)
> 	Video Capture: Frame #018 (select)
> 	Video Capture: Frame #019 (select)
> 	Video Capture: Frame #020 (select)
> 	Video Capture: Frame #021 (select)
> 	Video Capture: Frame #022 (select)
> 	Video Capture: Frame #023 (select)
> 	Video Capture: Frame #024 (select)
> 	Video Capture: Frame #025 (select)
> 	Video Capture: Frame #026 (select)
> 	Video Capture: Frame #027 (select)
> 	Video Capture: Frame #028 (select)
> 	Video Capture: Frame #029 (select)
> 	Video Capture: Frame #030 (select)
> 	Video Capture: Frame #031 (select)
> 	Video Capture: Frame #032 (select)
> 	Video Capture: Frame #033 (select)
> 	Video Capture: Frame #034 (select)
> 	Video Capture: Frame #035 (select)
> 	Video Capture: Frame #036 (select)
> 	Video Capture: Frame #037 (select)
> 	Video Capture: Frame #038 (select)
> 	Video Capture: Frame #039 (select)
> 	Video Capture: Frame #040 (select)
> 	Video Capture: Frame #041 (select)
> 	Video Capture: Frame #042 (select)
> 	Video Capture: Frame #043 (select)
> 	Video Capture: Frame #044 (select)
> 	Video Capture: Frame #045 (select)
> 	Video Capture: Frame #046 (select)
> 	Video Capture: Frame #047 (select)
> 	Video Capture: Frame #048 (select)
> 	Video Capture: Frame #049 (select)
> 	Video Capture: Frame #050 (select)
> 	Video Capture: Frame #051 (select)
> 	Video Capture: Frame #052 (select)
> 	Video Capture: Frame #053 (select)
> 	Video Capture: Frame #054 (select)
> 	Video Capture: Frame #055 (select)
> 	Video Capture: Frame #056 (select)
> 	Video Capture: Frame #057 (select)
> 	Video Capture: Frame #058 (select)
> 	Video Capture: Frame #059 (select)
> 
> 	test USERPTR (select): OK
> 	test DMABUF: Cannot test, specify --expbuf-device
> 
> Total for uvcvideo device /dev/video1: 58, Succeeded: 57, Failed: 1, Warnings: 0
> 
> As tested on the guest:
> 
> $ v4l2-compliance -d0 -s --driver-name uvcvideo
> 
> v4l2-compliance 1.33.0-5457, 64 bits, 64-bit time_t
> v4l2-compliance SHA: e7e240f546f3 2026-05-28 17:06:12
> 
> Compliance test for uvcvideo device (overridden from virtio-media) /dev/video0:
> 
> Driver Info:
> 	Driver name      : uvcvideo
> 	Card type        : Logitech Webcam C925e
> 	Bus info         : platform:virtio-media
> 	Driver version   : 7.1.0
> 	Capabilities     : 0x84200001
> 		Video Capture
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04200001
> 		Video Capture
> 		Streaming
> 		Extended Pix Format
> 
> Required ioctls:
> 	test VIDIOC_QUERYCAP: OK
> 	test invalid ioctls: OK
> 
> Allow for multiple opens:
> 	test second /dev/video0 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 1 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls (Input 0):
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 		fail: v4l2-test-controls.cpp(981): ret (got 22)
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 19 Private Controls: 0
> 
> Format ioctls (Input 0):
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK (Not Supported)
> 	test Composing: OK (Not Supported)
> 	test Scaling: OK (Not Supported)
> 
> Codec ioctls (Input 0):
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls (Input 0):
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test CREATE_BUFS maximum buffers: OK
> 	test VIDIOC_REMOVE_BUFS: OK
> 	test VIDIOC_EXPBUF: OK (Not Supported)
> 	test Requests: OK (Not Supported)
> 	test blocking wait: OK
> 
> Test input 0:
> 
> Streaming ioctls:
> 	test read/write: OK (Not Supported)
> 
> 	Video Capture: Frame #000
> 	Video Capture: Frame #001
> 	Video Capture: Frame #002
> 	Video Capture: Frame #003
> 	Video Capture: Frame #004
> 	Video Capture: Frame #005
> 	Video Capture: Frame #006
> 	Video Capture: Frame #007
> 	Video Capture: Frame #008
> 	Video Capture: Frame #009
> 	Video Capture: Frame #010
> 	Video Capture: Frame #011
> 	Video Capture: Frame #012
> 	Video Capture: Frame #013
> 	Video Capture: Frame #014
> 	Video Capture: Frame #015
> 	Video Capture: Frame #016
> 	Video Capture: Frame #017
> 	Video Capture: Frame #018
> 	Video Capture: Frame #019
> 	Video Capture: Frame #020
> 	Video Capture: Frame #021
> 	Video Capture: Frame #022
> 	Video Capture: Frame #023
> 	Video Capture: Frame #024
> 	Video Capture: Frame #025
> 	Video Capture: Frame #026
> 	Video Capture: Frame #027
> 	Video Capture: Frame #028
> 	Video Capture: Frame #029
> 	Video Capture: Frame #030
> 	Video Capture: Frame #031
> 	Video Capture: Frame #032
> 	Video Capture: Frame #033
> 	Video Capture: Frame #034
> 	Video Capture: Frame #035
> 	Video Capture: Frame #036
> 	Video Capture: Frame #037
> 	Video Capture: Frame #038
> 	Video Capture: Frame #039
> 	Video Capture: Frame #040
> 	Video Capture: Frame #041
> 	Video Capture: Frame #042
> 	Video Capture: Frame #043
> 	Video Capture: Frame #044
> 	Video Capture: Frame #045
> 	Video Capture: Frame #046
> 	Video Capture: Frame #047
> 	Video Capture: Frame #048
> 	Video Capture: Frame #049
> 	Video Capture: Frame #050
> 	Video Capture: Frame #051
> 	Video Capture: Frame #052
> 	Video Capture: Frame #053
> 	Video Capture: Frame #054
> 	Video Capture: Frame #055
> 	Video Capture: Frame #056
> 	Video Capture: Frame #057
> 	Video Capture: Frame #058
> 	Video Capture: Frame #059
> 
> 	test MMAP (no poll, REQBUFS): OK
> 
> 	Video Capture: Frame #000 (select)
> 	Video Capture: Frame #001 (select)
> 	Video Capture: Frame #002 (select)
> 	Video Capture: Frame #003 (select)
> 	Video Capture: Frame #004 (select)
> 	Video Capture: Frame #005 (select)
> 	Video Capture: Frame #006 (select)
> 	Video Capture: Frame #007 (select)
> 	Video Capture: Frame #008 (select)
> 	Video Capture: Frame #009 (select)
> 	Video Capture: Frame #010 (select)
> 	Video Capture: Frame #011 (select)
> 	Video Capture: Frame #012 (select)
> 	Video Capture: Frame #013 (select)
> 	Video Capture: Frame #014 (select)
> 	Video Capture: Frame #015 (select)
> 	Video Capture: Frame #016 (select)
> 	Video Capture: Frame #017 (select)
> 	Video Capture: Frame #018 (select)
> 	Video Capture: Frame #019 (select)
> 	Video Capture: Frame #020 (select)
> 	Video Capture: Frame #021 (select)
> 	Video Capture: Frame #022 (select)
> 	Video Capture: Frame #023 (select)
> 	Video Capture: Frame #024 (select)
> 	Video Capture: Frame #025 (select)
> 	Video Capture: Frame #026 (select)
> 	Video Capture: Frame #027 (select)
> 	Video Capture: Frame #028 (select)
> 	Video Capture: Frame #029 (select)
> 	Video Capture: Frame #030 (select)
> 	Video Capture: Frame #031 (select)
> 	Video Capture: Frame #032 (select)
> 	Video Capture: Frame #033 (select)
> 	Video Capture: Frame #034 (select)
> 	Video Capture: Frame #035 (select)
> 	Video Capture: Frame #036 (select)
> 	Video Capture: Frame #037 (select)
> 	Video Capture: Frame #038 (select)
> 	Video Capture: Frame #039 (select)
> 	Video Capture: Frame #040 (select)
> 	Video Capture: Frame #041 (select)
> 	Video Capture: Frame #042 (select)
> 	Video Capture: Frame #043 (select)
> 	Video Capture: Frame #044 (select)
> 	Video Capture: Frame #045 (select)
> 	Video Capture: Frame #046 (select)
> 	Video Capture: Frame #047 (select)
> 	Video Capture: Frame #048 (select)
> 	Video Capture: Frame #049 (select)
> 	Video Capture: Frame #050 (select)
> 	Video Capture: Frame #051 (select)
> 	Video Capture: Frame #052 (select)
> 	Video Capture: Frame #053 (select)
> 	Video Capture: Frame #054 (select)
> 	Video Capture: Frame #055 (select)
> 	Video Capture: Frame #056 (select)
> 	Video Capture: Frame #057 (select)
> 	Video Capture: Frame #058 (select)
> 	Video Capture: Frame #059 (select)
> 
> 	test MMAP (select, REQBUFS): OK
> 
> 	Video Capture: Frame #000 (epoll)
> 	Video Capture: Frame #001 (epoll)
> 	Video Capture: Frame #002 (epoll)
> 	Video Capture: Frame #003 (epoll)
> 	Video Capture: Frame #004 (epoll)
> 	Video Capture: Frame #005 (epoll)
> 	Video Capture: Frame #006 (epoll)
> 	Video Capture: Frame #007 (epoll)
> 	Video Capture: Frame #008 (epoll)
> 	Video Capture: Frame #009 (epoll)
> 	Video Capture: Frame #010 (epoll)
> 	Video Capture: Frame #011 (epoll)
> 	Video Capture: Frame #012 (epoll)
> 	Video Capture: Frame #013 (epoll)
> 	Video Capture: Frame #014 (epoll)
> 	Video Capture: Frame #015 (epoll)
> 	Video Capture: Frame #016 (epoll)
> 	Video Capture: Frame #017 (epoll)
> 	Video Capture: Frame #018 (epoll)
> 	Video Capture: Frame #019 (epoll)
> 	Video Capture: Frame #020 (epoll)
> 	Video Capture: Frame #021 (epoll)
> 	Video Capture: Frame #022 (epoll)
> 	Video Capture: Frame #023 (epoll)
> 	Video Capture: Frame #024 (epoll)
> 	Video Capture: Frame #025 (epoll)
> 	Video Capture: Frame #026 (epoll)
> 	Video Capture: Frame #027 (epoll)
> 	Video Capture: Frame #028 (epoll)
> 	Video Capture: Frame #029 (epoll)
> 	Video Capture: Frame #030 (epoll)
> 	Video Capture: Frame #031 (epoll)
> 	Video Capture: Frame #032 (epoll)
> 	Video Capture: Frame #033 (epoll)
> 	Video Capture: Frame #034 (epoll)
> 	Video Capture: Frame #035 (epoll)
> 	Video Capture: Frame #036 (epoll)
> 	Video Capture: Frame #037 (epoll)
> 	Video Capture: Frame #038 (epoll)
> 	Video Capture: Frame #039 (epoll)
> 	Video Capture: Frame #040 (epoll)
> 	Video Capture: Frame #041 (epoll)
> 	Video Capture: Frame #042 (epoll)
> 	Video Capture: Frame #043 (epoll)
> 	Video Capture: Frame #044 (epoll)
> 	Video Capture: Frame #045 (epoll)
> 	Video Capture: Frame #046 (epoll)
> 	Video Capture: Frame #047 (epoll)
> 	Video Capture: Frame #048 (epoll)
> 	Video Capture: Frame #049 (epoll)
> 	Video Capture: Frame #050 (epoll)
> 	Video Capture: Frame #051 (epoll)
> 	Video Capture: Frame #052 (epoll)
> 	Video Capture: Frame #053 (epoll)
> 	Video Capture: Frame #054 (epoll)
> 	Video Capture: Frame #055 (epoll)
> 	Video Capture: Frame #056 (epoll)
> 	Video Capture: Frame #057 (epoll)
> 	Video Capture: Frame #058 (epoll)
> 	Video Capture: Frame #059 (epoll)
> 
> 	test MMAP (epoll, REQBUFS): OK
> 
> 	Video Capture: Frame #000
> 	Video Capture: Frame #001
> 	Video Capture: Frame #002
> 	Video Capture: Frame #003
> 	Video Capture: Frame #004
> 	Video Capture: Frame #005
> 	Video Capture: Frame #006
> 	Video Capture: Frame #007
> 	Video Capture: Frame #008
> 	Video Capture: Frame #009
> 	Video Capture: Frame #010
> 	Video Capture: Frame #011
> 	Video Capture: Frame #012
> 	Video Capture: Frame #013
> 	Video Capture: Frame #014
> 	Video Capture: Frame #015
> 	Video Capture: Frame #016
> 	Video Capture: Frame #017
> 	Video Capture: Frame #018
> 	Video Capture: Frame #019
> 	Video Capture: Frame #020
> 	Video Capture: Frame #021
> 	Video Capture: Frame #022
> 	Video Capture: Frame #023
> 	Video Capture: Frame #024
> 	Video Capture: Frame #025
> 	Video Capture: Frame #026
> 	Video Capture: Frame #027
> 	Video Capture: Frame #028
> 	Video Capture: Frame #029
> 	Video Capture: Frame #030
> 	Video Capture: Frame #031
> 	Video Capture: Frame #032
> 	Video Capture: Frame #033
> 	Video Capture: Frame #034
> 	Video Capture: Frame #035
> 	Video Capture: Frame #036
> 	Video Capture: Frame #037
> 	Video Capture: Frame #038
> 	Video Capture: Frame #039
> 	Video Capture: Frame #040
> 	Video Capture: Frame #041
> 	Video Capture: Frame #042
> 	Video Capture: Frame #043
> 	Video Capture: Frame #044
> 	Video Capture: Frame #045
> 	Video Capture: Frame #046
> 	Video Capture: Frame #047
> 	Video Capture: Frame #048
> 	Video Capture: Frame #049
> 	Video Capture: Frame #050
> 	Video Capture: Frame #051
> 	Video Capture: Frame #052
> 	Video Capture: Frame #053
> 	Video Capture: Frame #054
> 	Video Capture: Frame #055
> 	Video Capture: Frame #056
> 	Video Capture: Frame #057
> 	Video Capture: Frame #058
> 	Video Capture: Frame #059
> 
> 	test MMAP (no poll, CREATE_BUFS): OK
> 
> 	Video Capture: Frame #000 (select)
> 	Video Capture: Frame #001 (select)
> 	Video Capture: Frame #002 (select)
> 	Video Capture: Frame #003 (select)
> 	Video Capture: Frame #004 (select)
> 	Video Capture: Frame #005 (select)
> 	Video Capture: Frame #006 (select)
> 	Video Capture: Frame #007 (select)
> 	Video Capture: Frame #008 (select)
> 	Video Capture: Frame #009 (select)
> 	Video Capture: Frame #010 (select)
> 	Video Capture: Frame #011 (select)
> 	Video Capture: Frame #012 (select)
> 	Video Capture: Frame #013 (select)
> 	Video Capture: Frame #014 (select)
> 	Video Capture: Frame #015 (select)
> 	Video Capture: Frame #016 (select)
> 	Video Capture: Frame #017 (select)
> 	Video Capture: Frame #018 (select)
> 	Video Capture: Frame #019 (select)
> 	Video Capture: Frame #020 (select)
> 	Video Capture: Frame #021 (select)
> 	Video Capture: Frame #022 (select)
> 	Video Capture: Frame #023 (select)
> 	Video Capture: Frame #024 (select)
> 	Video Capture: Frame #025 (select)
> 	Video Capture: Frame #026 (select)
> 	Video Capture: Frame #027 (select)
> 	Video Capture: Frame #028 (select)
> 	Video Capture: Frame #029 (select)
> 	Video Capture: Frame #030 (select)
> 	Video Capture: Frame #031 (select)
> 	Video Capture: Frame #032 (select)
> 	Video Capture: Frame #033 (select)
> 	Video Capture: Frame #034 (select)
> 	Video Capture: Frame #035 (select)
> 	Video Capture: Frame #036 (select)
> 	Video Capture: Frame #037 (select)
> 	Video Capture: Frame #038 (select)
> 	Video Capture: Frame #039 (select)
> 	Video Capture: Frame #040 (select)
> 	Video Capture: Frame #041 (select)
> 	Video Capture: Frame #042 (select)
> 	Video Capture: Frame #043 (select)
> 	Video Capture: Frame #044 (select)
> 	Video Capture: Frame #045 (select)
> 	Video Capture: Frame #046 (select)
> 	Video Capture: Frame #047 (select)
> 	Video Capture: Frame #048 (select)
> 	Video Capture: Frame #049 (select)
> 	Video Capture: Frame #050 (select)
> 	Video Capture: Frame #051 (select)
> 	Video Capture: Frame #052 (select)
> 	Video Capture: Frame #053 (select)
> 	Video Capture: Frame #054 (select)
> 	Video Capture: Frame #055 (select)
> 	Video Capture: Frame #056 (select)
> 	Video Capture: Frame #057 (select)
> 	Video Capture: Frame #058 (select)
> 	Video Capture: Frame #059 (select)
> 
> 	test MMAP (select, CREATE_BUFS): OK
> 
> 	Video Capture: Frame #000 (epoll)
> 	Video Capture: Frame #001 (epoll)
> 	Video Capture: Frame #002 (epoll)
> 	Video Capture: Frame #003 (epoll)
> 	Video Capture: Frame #004 (epoll)
> 	Video Capture: Frame #005 (epoll)
> 	Video Capture: Frame #006 (epoll)
> 	Video Capture: Frame #007 (epoll)
> 	Video Capture: Frame #008 (epoll)
> 	Video Capture: Frame #009 (epoll)
> 	Video Capture: Frame #010 (epoll)
> 	Video Capture: Frame #011 (epoll)
> 	Video Capture: Frame #012 (epoll)
> 	Video Capture: Frame #013 (epoll)
> 	Video Capture: Frame #014 (epoll)
> 	Video Capture: Frame #015 (epoll)
> 	Video Capture: Frame #016 (epoll)
> 	Video Capture: Frame #017 (epoll)
> 	Video Capture: Frame #018 (epoll)
> 	Video Capture: Frame #019 (epoll)
> 	Video Capture: Frame #020 (epoll)
> 	Video Capture: Frame #021 (epoll)
> 	Video Capture: Frame #022 (epoll)
> 	Video Capture: Frame #023 (epoll)
> 	Video Capture: Frame #024 (epoll)
> 	Video Capture: Frame #025 (epoll)
> 	Video Capture: Frame #026 (epoll)
> 	Video Capture: Frame #027 (epoll)
> 	Video Capture: Frame #028 (epoll)
> 	Video Capture: Frame #029 (epoll)
> 	Video Capture: Frame #030 (epoll)
> 	Video Capture: Frame #031 (epoll)
> 	Video Capture: Frame #032 (epoll)
> 	Video Capture: Frame #033 (epoll)
> 	Video Capture: Frame #034 (epoll)
> 	Video Capture: Frame #035 (epoll)
> 	Video Capture: Frame #036 (epoll)
> 	Video Capture: Frame #037 (epoll)
> 	Video Capture: Frame #038 (epoll)
> 	Video Capture: Frame #039 (epoll)
> 	Video Capture: Frame #040 (epoll)
> 	Video Capture: Frame #041 (epoll)
> 	Video Capture: Frame #042 (epoll)
> 	Video Capture: Frame #043 (epoll)
> 	Video Capture: Frame #044 (epoll)
> 	Video Capture: Frame #045 (epoll)
> 	Video Capture: Frame #046 (epoll)
> 	Video Capture: Frame #047 (epoll)
> 	Video Capture: Frame #048 (epoll)
> 	Video Capture: Frame #049 (epoll)
> 	Video Capture: Frame #050 (epoll)
> 	Video Capture: Frame #051 (epoll)
> 	Video Capture: Frame #052 (epoll)
> 	Video Capture: Frame #053 (epoll)
> 	Video Capture: Frame #054 (epoll)
> 	Video Capture: Frame #055 (epoll)
> 	Video Capture: Frame #056 (epoll)
> 	Video Capture: Frame #057 (epoll)
> 	Video Capture: Frame #058 (epoll)
> 	Video Capture: Frame #059 (epoll)
> 
> 	test MMAP (epoll, CREATE_BUFS): OK
> 	test USERPTR (no poll): OK (Not Supported)
> 	test USERPTR (select): OK (Not Supported)
> 	test DMABUF (no poll): OK (Not Supported)
> 	test DMABUF (select): OK (Not Supported)
> 
> Total for uvcvideo device /dev/video0: 59, Succeeded: 58, Failed: 1, Warnings: 0
> 
> ---
> Changes in v4:
> - Rebased on top of v7.1-rc1
> - Replace usages of filep->private_data with file_to_v4l2_fh()
>   throughout the driver
> - Link to v3: https://lore.kernel.org/r/20250412-virtio-media-v3-1-97dc94c18398@gmail.com
> 
> Changes in v3:
> - Rebased on top of v6.15-rc1 and removes obsolete control callbacks.
> - Link to v2: https://lore.kernel.org/r/20250201-virtio-media-v2-1-ac840681452d@gmail.com
> 
> Changes in v2:
> - Fixed kernel test robot and media CI warnings (ignored a few false
>   positives).
> - Changed in-driver email address to personal one since my Google one
>   will soon become invalid.
> - Link to v1: https://lore.kernel.org/r/20250123-virtio-media-v1-1-81e2549b86b9@gmail.com
> 
> Brian Daniels (8):
>   media: virtio: Add protocol
>   media: virtio: Add virtio-media driver structs and function
>     declarations
>   media: virtio: Add virtio-media session related structures
>   media: virtio: Add scatterlist_builder
>   media: virtio: Add virtio_media_ioctls
>   media: virtio: Add virtio_media_driver
>   media: virtio: Add virtio-media to the build system
>   media: virtio: Add MAINTAINERS entry
> 
>  MAINTAINERS                                |    6 +
>  drivers/media/Kconfig                      |   13 +
>  drivers/media/Makefile                     |    2 +
>  drivers/media/virtio/Makefile              |    8 +
>  drivers/media/virtio/protocol.h            |  287 +++++
>  drivers/media/virtio/scatterlist_builder.c |  574 +++++++++
>  drivers/media/virtio/scatterlist_builder.h |  112 ++
>  drivers/media/virtio/session.h             |  130 ++
>  drivers/media/virtio/virtio_media.h        |   95 ++
>  drivers/media/virtio/virtio_media_driver.c |  959 ++++++++++++++
>  drivers/media/virtio/virtio_media_ioctls.c | 1338 ++++++++++++++++++++
>  11 files changed, 3524 insertions(+)
>  create mode 100644 drivers/media/virtio/Makefile
>  create mode 100644 drivers/media/virtio/protocol.h
>  create mode 100644 drivers/media/virtio/scatterlist_builder.c
>  create mode 100644 drivers/media/virtio/scatterlist_builder.h
>  create mode 100644 drivers/media/virtio/session.h
>  create mode 100644 drivers/media/virtio/virtio_media.h
>  create mode 100644 drivers/media/virtio/virtio_media_driver.c
>  create mode 100644 drivers/media/virtio/virtio_media_ioctls.c
> 
> 
> base-commit: 06cb687a5132fcffe624c0070576ab852ac6b568
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog

