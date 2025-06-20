Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3717E
	for <virtualization@lists.linux.dev>; Fri, 20 Jun 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421023; cv=none; b=BmFTprrNcpMTM+f9QtVPTyZTmXqdIyfd3i0QFCB5sgDX37/25ao+GKcpA3iQnBrMtb9OBz1Wjw0rLxsla4lC9GuGqAalAUk2k4WoaFvYh19+Rhh3+dnzqkQoQZvSo4Ue6bpFRuttMxMH5p+KRQ4+aXOE3dZcvhswiXT7M8vtG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421023; c=relaxed/simple;
	bh=FDVn6kzGJUMG813ArcDGLuAChLYEGlTwgPSx629w6Ps=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=uRJ0/+5Ky+0X/jQonFq8+mnpOEPIRqjCErCxkUATVsuFk04WnpZYc2yt0NE8e3CGo9HD8OKglivDK8Bp2hr2jjZAOpJmBql5GCOtlE7G0IPw6ph5mWpRXr1BoQKWxb59v6PS751BJprAkGRn+IU0QSETpikzlhotXDNekZkzRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2njbydh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2njbydh"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7490702fc7cso622430b3a.1
        for <virtualization@lists.linux.dev>; Fri, 20 Jun 2025 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750421021; x=1751025821; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdQekhyjCzmH4tNfpfSgyUB7lCWhyPe9Dj+g7h1mCmg=;
        b=i2njbydhNwWL2JX4KPYHSxbHej+nYql1hrnp9xSKH7SDs+C/Wb7glfiiXCVD6LWkXM
         VBR34V8cMFCHilZnsAwDqTYVUCa2kIwbZKPo45h/ErS9+vcvQnQXr5KXbc0hcSruI9RX
         6i9zNGAEjy2dLOTzPe1S6FeaRQ+Lxlc2faPEV/YQBZFpJ8D4qBj19P/qG6TW73G1QbZf
         73gE1G965r/wwaHlEibdzdYCLeIeJiRoytdSvnhWEYfGJ4Xz5RfPd2jI2jf4A4SHVIc9
         LEZ/YMWn/YhAPceWFrDA2vxRWx6YT/Nx7ElX0E/EX0u7wkXuaLtFFKeB42a6rqN1SNin
         PtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750421021; x=1751025821;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XdQekhyjCzmH4tNfpfSgyUB7lCWhyPe9Dj+g7h1mCmg=;
        b=HFZHsltTH1PEBz2Ccb3AOTVe0pyCVVDz3twCjaNk5+zkTewqNsIq/3lbmcWjY6yOZ0
         7bYfxjyMqssA97KWFos6PJF6Ng0vOmA9PbOq82UfLy75cgqcO7+G8ovhEdJ/hpjZTjdf
         A9V0iyYIn4or4P77T68gBRljIYCF6Y/Sw/KW4CprdwZV6RZhXQ5JRRl1AgyuLe/wIGjr
         LpwcwErj5483lmoBFIKtj0kEET7Iz8bbQXCA1L8sCrezsXfOm+m5JedoF2UMj1h5jdEL
         V/X8b6J6M8X6+4wKf7JF0ZGuPACfZq9+DO4IMxBfd2xyO3DquknGcAZreA1T+PQrEsWt
         r3vw==
X-Forwarded-Encrypted: i=1; AJvYcCUSbHbKTMRaNl5Q3rd3cZAfGcIXRs5V8Qu1/cZ75BIhEn9dqf7jpXfhVFZMr2rJ7Ff9nrTY9rp7FHyZOXYP3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXlkMetkW/uZWKKFoKs4o8qE7FmxQHxcRn+ir8ybPB2XQsM3YR
	bDtU36VhImBUZn0q8d3pAoIseA1GAK2ztSqpfwXk7t6tYgw/aAgTs/Xs
X-Gm-Gg: ASbGncvVak43s/8pPjTwPchNSeeyYCiTeqBV4jTqKYaUkADpnk/aTWM9gvZHNyAAKag
	KqvWPYQS2G6tV8uYYJmNcK442IpxCrmv+VJmb1ziQtisTaSljDKCKtiP3+MyXAPSDj1D5K6bEze
	gyNIfYlIH07IQljzXsr1snH0mRFNR1Bughnv1PWxp9cNBJZxz1toRfrvfUMxSlv8S9YH4H4SxAr
	QpzssBN6gzW1yL+aeZZhe91jua7OeFp68cSSZv7J6oyXddEFVOs//uzSoYbfQtTKPmqMaf4PK8y
	oWZSGKShASTsV2fRM/CgBusURDp3bSoSZbTeMIyiygJ1a2TN7/G7Ww==
X-Google-Smtp-Source: AGHT+IFLHQB0eNT6ur3ow177JDXob9FKBK/stJsroAx+A8CaHFBkobGYBsZY3Si9wYrKAZj/R0GKQg==
X-Received: by 2002:a05:6a00:3c89:b0:748:3849:e790 with SMTP id d2e1a72fcca58-7490d201941mr3889412b3a.0.1750421020893;
        Fri, 20 Jun 2025 05:03:40 -0700 (PDT)
Received: from localhost ([240d:1a:f76:b500:4431:46e3:c76b:79bc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a46b788sm1915365b3a.5.2025.06.20.05.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 05:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 21:03:34 +0900
Message-Id: <DARCGOT0TKN8.OC6467QNJA9O@gmail.com>
From: "Alexandre Courbot" <gnurou@gmail.com>
To: "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
Cc: "Albert Esteve" <aesteve@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Hans
 Verkuil" <hverkuil@xs4all.nl>, "Jason Wang" <jasowang@redhat.com>, "Xuan
 Zhuo" <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, <gurchetansingh@google.com>,
 <daniel.almeida@collabora.com>, <adelva@google.com>,
 <changyeon@google.com>, <nicolas.dufresne@collabora.com>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <virtualization@lists.linux.dev>
Subject: Re: [PATCH v3] media: add virtio-media driver
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250412-virtio-media-v3-1-97dc94c18398@gmail.com>
 <20250526141316.7e907032@foz.lan> <DA6Q0LZPGS2D.2QCV889PQL2A7@gmail.com>
 <20250527111311.105246f2@sal.lan>
 <CAAVeFu+=RpEfu3i_Fh9_eq_g=cmDFF0gcurT0gU9AX1UX+UNVA@mail.gmail.com>
 <20250527153547.6603eaf4@sal.lan>
 <CAAVeFuJtp=UEEULeMSVpmYDmH81Y6OQgj6NCeuPUhabSRHw4dA@mail.gmail.com>
 <20250617104938.09d21b7c@foz.lan> <20250617110318.7c89d999@foz.lan>
 <20250617122034.3e570b4e@foz.lan> <DAPQ9L3FCLIF.24FIDLQST2S1O@gmail.com>
 <20250618170500.1e60aacf@sal.lan>
In-Reply-To: <20250618170500.1e60aacf@sal.lan>

Hi Mauro,

Really appreciating the time you are spending reviewing and testing
this! m(__)m Thanks also for sharing your script, I've learned a few
things I didn't know about crosvm. :P

On Thu Jun 19, 2025 at 12:05 AM JST, Mauro Carvalho Chehab wrote:
<snip>
>> > Found how to setup cpus and memory, but didn't find a way to setup
>> > network without running it as root. The gpu parameter has several
>> > options. Not sure what backend works well for media apps like qv4l2,
>> > camorama, X11, ... =20
>>=20
>> I'm afraid getting GPU and graphics in general to work is more involved
>> and tricky on a regular Linux setup (crosvm was primarily designed for
>> ChromeOS). If you really need it I can do some more research; most of my
>> tests have been done using v4l2-ctl or ffmpeg and saving the output on
>> disk for later inspection.
>
> It was actually easier than what I expected, but it had to run
> as root. Due to that, I had to move it to a test machine that I
> use just for such kind of tests. I updated it to the Ubuntu=20
> version 24.10, but crossvm refused to build even. I end needing
> to install rust via rustup, as only version 1.81.0 had what it is
> required to run with the needed features (network, media and gpu).

Yes, rustup is the preferred way (if not traditional from the point of
view of Linux distros) to get the latest Rust toolchain.

>
>> >> > Btw, on a quick test with v4l2-compliance, something looks weird:
>> >> > I started a camera application at the host. Still, v4l2-compliance
>> >> > said successfully excecuted mmap:
>> >> >=20
>> >> > Streaming ioctls:
>> >> >         test read/write: OK (Not Supported)
>> >> >         test blocking wait: OK
>> >> >         test MMAP (no poll): OK                          =20
>> >> >         test MMAP (select): OK                           =20
>> >> >         Vide[2025-06-17T08:44:49.177972817+00:00 ERROR virtio_media=
::ioctl] VIDIOC_REQBUFS: memory type DmaBuf is currently unsupported
>> >> > [2025-06-17T08:44:49.178164554+00:00 ERROR virtio_media::ioctl] VID=
IOC_REQBUFS: memory type DmaBuf is currently unsupported
>> >> > o Capturtest MMAP (epoll): OK                            =20
>> >> >         test USERPTR (no poll): OK (Not Supported)
>> >> >         test USERPTR (select): OK (Not Supported)
>> >> >         test DMABUF (no poll): OK (Not Supported)
>> >> >         test DMABUF (select): OK (Not Supported)
>> >> >=20
>> >> > Which doesn't make any sense, as the host OS should not allow acces=
s
>> >> > to mmap while streaming.   =20
>> >>=20
>> >> Ah, this was with the "simple" device, not with the proxy one.
>> >> With the proxy one, I'm getting:
>> >>=20
>> >> # v4l2-ctl --all
>> >> Driver Info:
>> >>         Driver name      : virtio-media
>> >>         Card type        : usb video: usb video
>> >>         Bus info         : platform:virtio-media
>> >>         Driver version   : 6.15.0
>> >>         Capabilities     : 0x84200001
>> >>                 Video Capture
>> >>                 Streaming
>> >>                 Extended Pix Format
>> >>                 Device Capabilities
>> >>         Device Caps      : 0x04200001
>> >>                 Video Capture
>> >>                 Streaming
>> >>                 Extended Pix Format
>> >> Priority: 2
>> >> Video input : 0 (Camera 1: ok)
>> >> Format Video Capture:
>> >>         Width/Height      : 1280/720
>> >>         Pixel Format      : 'MJPG' (Motion-JPEG)
>> >>         Field             : None
>> >>         Bytes per Line    : 0
>> >>         Size Image        : 1843200
>> >>         Colorspace        : sRGB
>> >>         Transfer Function : Rec. 709
>> >>         YCbCr/HSV Encoding: ITU-R 601
>> >>         Quantization      : Default (maps to Full Range)
>> >>         Flags             :=20
>> >> Crop Capability Video Capture:
>> >>         Bounds      : Left 0, Top 0, Width 1280, Height 720
>> >>         Default     : Left 0, Top 0, Width 1280, Height 720
>> >>         Pixel Aspect: 1/1
>> >> Selection Video Capture: crop_default, Left 0, Top 0, Width 1280, Hei=
ght 720, Flags:=20
>> >> Selection Video Capture: crop_bounds, Left 0, Top 0, Width 1280, Heig=
ht 720, Flags:=20
>> >> Streaming Parameters Video Capture:
>> >>         Capabilities     : timeperframe
>> >>         Frames per second: 30.000 (30/1)
>> >>         Read buffers     : 0
>> >>=20
>> >> User Controls
>> >>=20
>> >>                      brightness 0x00980900 (int)    : min=3D-128 max=
=3D127 step=3D1 default=3D-11 value=3D-11
>> >>                        contrast 0x00980901 (int)    : min=3D0 max=3D2=
55 step=3D1 default=3D148 value=3D148
>> >>                      saturation 0x00980902 (int)    : min=3D0 max=3D2=
55 step=3D1 default=3D180 value=3D180
>> >>                             hue 0x00980903 (int)    : min=3D-128 max=
=3D127 step=3D1 default=3D0 value=3D0
>> >>=20
>> >> # v4l2-compliance -d0 -s
>> >>=20
>> >> Streaming ioctls:
>> >>         test read/write: OK (Not Supported)
>> >>         test blocking wait: OK
>> >>                 fail: v4l2-test-buffers.cpp(1345): node->streamon(q.g=
_type()) !=3D EINVAL
>> >>         test MMAP (no poll): FAIL
>> >>                 fail: v4l2-test-buffers.cpp(1345): node->streamon(q.g=
_type()) !=3D EINVAL
>> >>         test MMAP (select): FAIL
>> >>                 fail: v4l2-test-buffers.cpp(1345): node->streamon(q.g=
_type()) !=3D EINVAL
>> >>         test MMAP (epoll): FAIL
>> >>         test USERPTR (no poll): OK (Not Supported)
>> >>         test USERPTR (select): OK (Not Supported)
>> >> [2025-06-17T08:55:20.768760714+00:00 ERROR virtio_media::ioctl] VIDIO=
C_REQBUFS: memory type DmaBuf is currently unsupported
>> >>         test DMABUF (no poll): OK (Not Supported)
>> >> [2025-06-17T08:55:20.769745707+00:00 ERROR virtio_media::ioctl] VIDIO=
C_REQBUFS: memory type DmaBuf is currently unsupported
>> >>         test DMABUF (select): OK (Not Supported)
>> >>=20
>> >> At the host, I'm getting:
>> >>=20
>> >> Streaming ioctls:
>> >>         test read/write: OK (Not Supported)
>> >>         test blocking wait: OK
>> >>                 fail: ../utils/v4l2-compliance/v4l2-test-buffers.cpp(=
1346): node->streamon(q.g_type()) !=3D EINVAL
>> >>         test MMAP (no poll): FAIL
>> >>                 fail: ../utils/v4l2-compliance/v4l2-test-buffers.cpp(=
1346): node->streamon(q.g_type()) !=3D EINVAL
>> >>         test MMAP (select): FAIL
>> >>                 fail: ../utils/v4l2-compliance/v4l2-test-buffers.cpp(=
1346): node->streamon(q.g_type()) !=3D EINVAL
>> >>         test MMAP (epoll): FAIL
>> >>         test USERPTR (no poll): OK                       =20
>> >>         test USERPTR (select): OK                        =20
>> >>         test DMABUF: Cannot test, specify --expbuf-device =20
>>=20
>> These logs look ok to me: the MMAP tests are failing on the host, so
>> they are also expected to fail on the guest (still I expect regular
>> streaming to work on both). USERPTR is not supported on the guest, as
>> per your request to not support this memory type in new drivers. DMABUF
>> is not supported at all at the moment.
>
> In the specific case of a virtio driver, while it is OK for the first
> versions to support MMAP only, USERPTR support could make sense, as=20
> this is not a real driver for a certain hardware, but instead it is
> replicating at the guest whatever the host driver has, which may or
> may not have MMAP.

There is a module parameter (allow_userptr) which you can set to enable
USERPTR buffers, in case you want to try this as well.

>
> That's said, I don't recall any driver with USERPTR and without MMAP
> those days. I did a quick check: VB2 devices always seem to have MMAP.
>
> -
>
> There is one case where only read ioctl is supported: pvrusb2, which
> is probably not interesting enough those days, but IMHO, for the few
> cases where a device can't be used at the guest due to the lack of a=20
> compatible streaming API, virtio-media should not expose it to the
> guest and/or issue an error or warning.

I've never tested virtio-media with a PVR driver, to be honest. :) Only
regular cameras and video accelerators. So I cannot guarantee other
kinds of devices will work properly - there may also be limitations in
the crosvm proxy device that will prevent these devices from working.
Just a heads-up.
