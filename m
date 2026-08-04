Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032337E5F4
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876491; cv=none; b=amhGY70NmJfWUqWeRNCs9vkMYrzTdvB+gzf+bebZ50D+ZfEMJXGY4UNtedU4ZhJC3qgFHtPE4tZv7Syle5NMJezrjbZ7McisJRmxMFZI7HecgotmW31xElA2TpvlQBtSsobWTdXE929UlKX9+ckp4qTm5qxy8AjHS6PdHA61hQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876491; c=relaxed/simple;
	bh=myt4mmaKOmhdVcrQwLAvsojxK3rrGIlG69z3q49B6hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gj8cQ7ijafS2mBqbMm9sKDV1NhucoO8FrtpAd8YJN4zLuyCxFz7dorwwYHwkZmXhLtuUoToagLg0ocNmTuqx6bMA6eXzqWhzckXs+XzX9OByIQxieV0rO980YuWzmmw/8ClsJrf/nulNBE0Mhr1ct67MGbBgVwBJgBD8b3DZET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcBhbkh8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcBhbkh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785876487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzR7P75XzOt05n3YW/zJgiInUPz7PXBzhaU7EDbsuLM=;
	b=QcBhbkh8mx7rajFPKtUFQm6nPS1n9yNsE49S/eHldUR/Iv6DhmSuF3VbwqI84mN70kNvup
	riVxJA+2f+fu2dV1zswyZsKEHxKqz2PKr2GXtGM7uJmd58DfDFQr3/CC1sU6fRWUOFfbfO
	9sJsPjXJT+Ll6bzW+ISRC3LT3BmkYgY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-k8oKz_68Pi-v5KnM_nLJow-1; Tue, 04 Aug 2026 16:47:50 -0400
X-MC-Unique: k8oKz_68Pi-v5KnM_nLJow-1
X-Mimecast-MFC-AGG-ID: k8oKz_68Pi-v5KnM_nLJow_1785876469
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49564d4b849so676835e9.3
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 13:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876469; x=1786481269;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzR7P75XzOt05n3YW/zJgiInUPz7PXBzhaU7EDbsuLM=;
        b=Npg9aEWlgbOwJh1gtvx/mwafrYsQIIoD1g7TFPKOLT/molTUaISrVQENVNkKMg8dUF
         92YAM14BIJPWOad4e8yUOxPZVSJS5n74cNpHSvj0RX7Jcsz+WwQxI1HlaLT8TxlevG66
         zkjZINqkjimkDOBiyUUULTd2RUwTxtXakOd+7gVDdbiqyAVu5/tABy0GpAovegAV4m/Y
         13MTHmKY0YsiP4me0hRW4J59f8JZLtsBIjl15tsveXBSR7qUVS+urRehuex9KT3LkLCE
         GqLtr3BY1oT6YLCJ6d7uNHubGypL8BSClGNRaB7IEWbNlCGQz73TUNMCvWXDdzIe8zqp
         nEvA==
X-Forwarded-Encrypted: i=1; AHgh+RpxXPsk5ejX+nlRzBr1xIsKKneImibB2oNin/zUpOOFe6p4EWigBEp2dAleO32BrHHf9tyqvZT8xQgA89oEXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxevQ4E0C7RHzzBGtUQBHhnJNs3EPzspW0FyQuLQVh6JDiwIB+h
	NhGNlAXzy/pPtTGHLrhCJ+Yovqmi/1hwDq1JotNUoJbLe4/e7CP82gO3XK55TD2ksteuf74gC/7
	grk9zcJGghwab+ZIDFN76yfcYYgbnU/DgTYbpFh61JifqkppwteQ7b9xwobol7LaFVgcg
X-Gm-Gg: AR+sD13xliBOuqyybOtvkx1IgUDESKuFoqaJqwycEIiJK8+3vsGTW5o32g9x7J4+Sow
	cD38dGboYnia/6sx3gDJ9wj5TPtzqIEugA61Ybx7xDagY/OOEMrW2oSS2n3nWBGU8OVRP7b3iwF
	LRQIR8UhEROTMr7udKb4mrDMhVRwU2/GBlBOlUXlhop++kyhi9n0yw5Pfx7BL8YnWVhcFxRJDUW
	0VJawqfDXBOx//iT2GHT1Ys5KzAsHVlQBpG6agR5obmGC90GPfhT0CD8tf4JHQG3RK+07fWCYOS
	bFoKfLILQayaZ1SdS0OCT88LTVl4m6Qb4SQtv7oVt84rVCMderUPIKer+t/Zu5kmnCRQ2gH+QZk
	1azQ+yl5E8RZoLQfnS45rfA==
X-Received: by 2002:a05:600c:4f4c:b0:499:4892:e84e with SMTP id 5b1f17b1804b1-4994e7b74afmr13862445e9.11.1785876469320;
        Tue, 04 Aug 2026 13:47:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4f4c:b0:499:4892:e84e with SMTP id 5b1f17b1804b1-4994e7b74afmr13861745e9.11.1785876468699;
        Tue, 04 Aug 2026 13:47:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec24a279sm2874274f8f.35.2026.08.04.13.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:47:48 -0700 (PDT)
Date: Tue, 4 Aug 2026 16:47:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brian Daniels <briandaniels@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, adelva@google.com,
	aesteve@redhat.com, changyeon@google.com,
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com,
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v5 0/5] media: add virtio-media driver
Message-ID: <20260804164639-mutt-send-email-mst@kernel.org>
References: <20260723183219.737296-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260723183219.737296-1-briandaniels@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4bHcsGJxlX2EhMZ1O54lCG6-JurF_wJWql2ZtCkZFV4_1785876469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 23, 2026 at 02:32:14PM -0400, Brian Daniels wrote:
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

Pls note trying to merge this in linux next caused kbuild failures.

> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>


I don't see what these 2 tags mean, and generally patch 0 does not need
a signoff.

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
> Changes in v5:
> - Add DMA buffer alignment and padding for commands, responses, and the event
>   buffer
> - Corrected styling of kernel-doc comments
> - Removed the configurable ``driver_name`` module parameter
> - Moved the protocol to ``include/uapi/linux/virtio_media.h``
> - Link to v4: https://lore.kernel.org/all/20260622204343.1994418-1-briandaniels@google.com/
> 
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

