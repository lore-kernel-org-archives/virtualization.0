Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA942BEFF3
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256840; cv=none; b=s9oAHPDBHoDIkpAPllts+0sRyF24QhrRybpeagrhzA6PMGjJTVu9mSvazAtkhGiPomon+98CuGzKquk+IU6UAc+p9u7hudArg/QS10qvoWjiMW6FuJyK6NvBCo9iegj6k2QgLZBoNPG/QqeXIuD9z9miwdZ7+kB28JX0SDXRAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256840; c=relaxed/simple;
	bh=0MyDPyc9Xv4iW1PBFbyN9/ARZN1/Ul9zCil6X+k+0gg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Dd/F0ARs2hlXB4IXyVyYCB/JP6915z56r96+7/adJD0y05t+hmrrxJ1NqBrZcjxxcBL9YM011ZMKezaX2/AzzAmb8lyIE4TvKvmZ6oEss6E4RH73bOzXN43Fq2/y2UsfZUvN2tbifLyq5Ktjb6GNm5rQYk4Ex5uoTPJRb98Pi9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt7ZgBih; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt7ZgBih"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23694cec0feso18167365ad.2
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750256838; x=1750861638; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDnfJ25L8a52gq/NA/cJbhdph8aKbv0AyNMqnP72X0w=;
        b=Rt7ZgBihSgpX3bj6inRLF6NIf7DdPI75dEw2Tytl65Xq+sOK3WSAOCZQjWYVWroPyQ
         I33+eXnBPIxRH488/aSlUMZisU143tPNQrVQAmPz92BUrz9PrtYh0/3jSU70ongFLnZN
         EUlDOuxyEvve7CBCAUQKB3geAy0//vTQgq/H1Mi0nCe8Q7JrKqnkOHyE8TyQgLis6YGy
         ES10xm8YLJvMMuCFQpW/6XSoVEsthGjIjl2Utijy0JjH6nY99b6lBsQlkB1f8YeWCU2A
         Aomt1/qrpehB8UB8rx+nv9Ii8DEc4ahznH2VTx1jtI1ih+AFWCJ6GOF41DIYilgZdreP
         B8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750256838; x=1750861638;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cDnfJ25L8a52gq/NA/cJbhdph8aKbv0AyNMqnP72X0w=;
        b=xQx42m3QDRyArci1a2UESvkGfWo4RLxwFP1mmf6Of51FE/ji76tfpOm8JeHpFZwEFW
         I9ELpWb/whMGdxs0ZjRg8f6HBeqsDay3I25FE8/hsBUwN/4VdBq9EoVT2q5emy0ikCFd
         EXYKgysfte/fAU2uu3vjzZnaqo13THkZnSuWfdJMCOWAL5/x6SmVgyItGLSYdp2QNt18
         1NtndHvuw9/p4Cfkv1WMh10zmt3mRdbxgSozFrpzzqdQRbpqws2F2aXi+w2GL1TguO+w
         lbbPluB/TtpEZ1fvvRN484plw3/B8ZA38JjDVtu59Dl/neWp+jqwkPTO0GS/1YvuBbDg
         JCww==
X-Forwarded-Encrypted: i=1; AJvYcCWmP+EziKPBJZFtop7ENtZwFcXmXd3xsw2TXbzZ/EioPMIv8nge/8BOOwl/f7A9dNsw4XOHKmcbUjud/llR+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzS7a/Z8sf9oC/cbo/4QSNxtBLmqqswHiF3Xkv9GAnddH3HQrdC
	U6YVHH79WqVMD9os8qNzbafS0XxAWWogPwZZJNVZ2FP4OKQlGRR4YSVz
X-Gm-Gg: ASbGncv0LGBeJY2BQV4EaS9MOPBBLtghtNuRLSXJdXYgsyJ6j08Fd2BVKNyGhP0PNfc
	9GQPyYtJdFl7mT9Ib20fGQN3+cGpStZMlNbRQ1BrCfC6kGKDzgUTlsBF7uX6mgMD2TY9ZxCdT8t
	yo48RMoX1sCeo6jYubemPJ665i2MgXgVZNUCrV4Usq8Ty+7FJg5M1SyjwVjIvznMJR9XLSbUZjf
	aPu+v16gpSs/O/HWCka9jev8FIcyCOb2puPh4XxdkTSqD5iHTAiQNn6V5c8n/zoujE+ccv0JyR4
	yl5wh6uXcIF/wAdE0L+gmhv2JHNwvC2Zf6Tl5GsYOAEJtdBIZbUuZA==
X-Google-Smtp-Source: AGHT+IHeLAlgKV+3gxI9GWnscujBRTm3Fy2QahxbYDaiCLiTYC+XwgiSpSL1nD0tpsw2X3ysEp0YcQ==
X-Received: by 2002:a17:902:fcc3:b0:235:6aa:1675 with SMTP id d9443c01a7336-2366b14d39cmr178361745ad.52.1750256838199;
        Wed, 18 Jun 2025 07:27:18 -0700 (PDT)
Received: from localhost ([240d:1a:f76:b500:4431:46e3:c76b:79bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0cffe6sm100100165ad.245.2025.06.18.07.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 07:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Jun 2025 23:27:13 +0900
Message-Id: <DAPQ9L3FCLIF.24FIDLQST2S1O@gmail.com>
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
From: "Alexandre Courbot" <gnurou@gmail.com>
To: "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250412-virtio-media-v3-1-97dc94c18398@gmail.com>
 <20250526141316.7e907032@foz.lan> <DA6Q0LZPGS2D.2QCV889PQL2A7@gmail.com>
 <20250527111311.105246f2@sal.lan>
 <CAAVeFu+=RpEfu3i_Fh9_eq_g=cmDFF0gcurT0gU9AX1UX+UNVA@mail.gmail.com>
 <20250527153547.6603eaf4@sal.lan>
 <CAAVeFuJtp=UEEULeMSVpmYDmH81Y6OQgj6NCeuPUhabSRHw4dA@mail.gmail.com>
 <20250617104938.09d21b7c@foz.lan> <20250617110318.7c89d999@foz.lan>
 <20250617122034.3e570b4e@foz.lan>
In-Reply-To: <20250617122034.3e570b4e@foz.lan>

On Tue Jun 17, 2025 at 7:20 PM JST, Mauro Carvalho Chehab wrote:
> Em Tue, 17 Jun 2025 11:03:18 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>
>> Em Tue, 17 Jun 2025 10:49:38 +0200
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>>=20
>> > Hi Alex,
>> >=20
>> > Em Tue, 27 May 2025 23:03:39 +0900
>> > Alexandre Courbot <gnurou@gmail.com> escreveu:
>> >  =20
>> > > > > > Btw, I was looking at:
>> > > > > >
>> > > > > >         https://github.com/chromeos/virtio-media
>> > > > > >
>> > > > > > (I'm assuming that this is the QEMU counterpart, right?)     =
=20
>> > > > >
>> > > > > crosvm actually, but QEMU support is also being worked on.     =
=20
>> > > >
>> > > > Do you have already QEMU patches? The best is to have the Kernel d=
river
>> > > > submitted altogether with QEMU, as Kernel developers need it to do=
 the
>> > > > tests. In my case, I never use crosvm, and I don't have any Chrome=
book
>> > > > anymore.     =20
>> > >=20
>> > > IIRC Albert Esteve was working on this, maybe he can share the curre=
nt status.   =20
>> >=20
>> > Any news regards to it?
>> >  =20
>> > > Note that crosvm does not require a Chromebook, you can build and ru=
n
>> > > it pretty easily on a regular PC. I have put together a document to
>> > > help with that:
>> > >=20
>> > > https://github.com/chromeos/virtio-media/blob/main/TRY_IT_OUT.md   =
=20
>> >=20
>> > I started looking on it today. Already installed crossvm (I had to
>> > install libcap-devel to build it). Still, I'm not familiar with
>> > crossvm, which is a little be painful. In particular, how can I
>> > enable network on it and speedup it? With suggested parameters,
>> > it picked only one CPU, and very few memory on it:
>> >=20
>> > 	# cat /proc/cpuinfo|grep processor
>> > 	processor       : 0
>> >=20
>> > 	# free
>> >                total        used        free      shared  buff/cache  =
 available
>> > 	Mem:          221876       34780      139712         272       56096 =
     187096
>> > 	Swap:              0           0           0
>> >=20
>> > I'd like to be able to compile things on it and use ssh/scp. So,
>> > the VM needs more CPUs, more memory, more network and GPU.
>
> Found how to setup cpus and memory, but didn't find a way to setup
> network without running it as root. The gpu parameter has several
> options. Not sure what backend works well for media apps like qv4l2,
> camorama, X11, ...

I'm afraid getting GPU and graphics in general to work is more involved
and tricky on a regular Linux setup (crosvm was primarily designed for
ChromeOS). If you really need it I can do some more research; most of my
tests have been done using v4l2-ctl or ffmpeg and saving the output on
disk for later inspection.

>
>> >=20
>> > Btw, on a quick test with v4l2-compliance, something looks weird:
>> > I started a camera application at the host. Still, v4l2-compliance
>> > said successfully excecuted mmap:
>> >=20
>> > Streaming ioctls:
>> >         test read/write: OK (Not Supported)
>> >         test blocking wait: OK
>> >         test MMAP (no poll): OK                          =20
>> >         test MMAP (select): OK                           =20
>> >         Vide[2025-06-17T08:44:49.177972817+00:00 ERROR virtio_media::i=
octl] VIDIOC_REQBUFS: memory type DmaBuf is currently unsupported
>> > [2025-06-17T08:44:49.178164554+00:00 ERROR virtio_media::ioctl] VIDIOC=
_REQBUFS: memory type DmaBuf is currently unsupported
>> > o Capturtest MMAP (epoll): OK                            =20
>> >         test USERPTR (no poll): OK (Not Supported)
>> >         test USERPTR (select): OK (Not Supported)
>> >         test DMABUF (no poll): OK (Not Supported)
>> >         test DMABUF (select): OK (Not Supported)
>> >=20
>> > Which doesn't make any sense, as the host OS should not allow access
>> > to mmap while streaming. =20
>>=20
>> Ah, this was with the "simple" device, not with the proxy one.
>> With the proxy one, I'm getting:
>>=20
>> # v4l2-ctl --all
>> Driver Info:
>>         Driver name      : virtio-media
>>         Card type        : usb video: usb video
>>         Bus info         : platform:virtio-media
>>         Driver version   : 6.15.0
>>         Capabilities     : 0x84200001
>>                 Video Capture
>>                 Streaming
>>                 Extended Pix Format
>>                 Device Capabilities
>>         Device Caps      : 0x04200001
>>                 Video Capture
>>                 Streaming
>>                 Extended Pix Format
>> Priority: 2
>> Video input : 0 (Camera 1: ok)
>> Format Video Capture:
>>         Width/Height      : 1280/720
>>         Pixel Format      : 'MJPG' (Motion-JPEG)
>>         Field             : None
>>         Bytes per Line    : 0
>>         Size Image        : 1843200
>>         Colorspace        : sRGB
>>         Transfer Function : Rec. 709
>>         YCbCr/HSV Encoding: ITU-R 601
>>         Quantization      : Default (maps to Full Range)
>>         Flags             :=20
>> Crop Capability Video Capture:
>>         Bounds      : Left 0, Top 0, Width 1280, Height 720
>>         Default     : Left 0, Top 0, Width 1280, Height 720
>>         Pixel Aspect: 1/1
>> Selection Video Capture: crop_default, Left 0, Top 0, Width 1280, Height=
 720, Flags:=20
>> Selection Video Capture: crop_bounds, Left 0, Top 0, Width 1280, Height =
720, Flags:=20
>> Streaming Parameters Video Capture:
>>         Capabilities     : timeperframe
>>         Frames per second: 30.000 (30/1)
>>         Read buffers     : 0
>>=20
>> User Controls
>>=20
>>                      brightness 0x00980900 (int)    : min=3D-128 max=3D1=
27 step=3D1 default=3D-11 value=3D-11
>>                        contrast 0x00980901 (int)    : min=3D0 max=3D255 =
step=3D1 default=3D148 value=3D148
>>                      saturation 0x00980902 (int)    : min=3D0 max=3D255 =
step=3D1 default=3D180 value=3D180
>>                             hue 0x00980903 (int)    : min=3D-128 max=3D1=
27 step=3D1 default=3D0 value=3D0
>>=20
>> # v4l2-compliance -d0 -s
>>=20
>> Streaming ioctls:
>>         test read/write: OK (Not Supported)
>>         test blocking wait: OK
>>                 fail: v4l2-test-buffers.cpp(1345): node->streamon(q.g_ty=
pe()) !=3D EINVAL
>>         test MMAP (no poll): FAIL
>>                 fail: v4l2-test-buffers.cpp(1345): node->streamon(q.g_ty=
pe()) !=3D EINVAL
>>         test MMAP (select): FAIL
>>                 fail: v4l2-test-buffers.cpp(1345): node->streamon(q.g_ty=
pe()) !=3D EINVAL
>>         test MMAP (epoll): FAIL
>>         test USERPTR (no poll): OK (Not Supported)
>>         test USERPTR (select): OK (Not Supported)
>> [2025-06-17T08:55:20.768760714+00:00 ERROR virtio_media::ioctl] VIDIOC_R=
EQBUFS: memory type DmaBuf is currently unsupported
>>         test DMABUF (no poll): OK (Not Supported)
>> [2025-06-17T08:55:20.769745707+00:00 ERROR virtio_media::ioctl] VIDIOC_R=
EQBUFS: memory type DmaBuf is currently unsupported
>>         test DMABUF (select): OK (Not Supported)
>>=20
>> At the host, I'm getting:
>>=20
>> Streaming ioctls:
>>         test read/write: OK (Not Supported)
>>         test blocking wait: OK
>>                 fail: ../utils/v4l2-compliance/v4l2-test-buffers.cpp(134=
6): node->streamon(q.g_type()) !=3D EINVAL
>>         test MMAP (no poll): FAIL
>>                 fail: ../utils/v4l2-compliance/v4l2-test-buffers.cpp(134=
6): node->streamon(q.g_type()) !=3D EINVAL
>>         test MMAP (select): FAIL
>>                 fail: ../utils/v4l2-compliance/v4l2-test-buffers.cpp(134=
6): node->streamon(q.g_type()) !=3D EINVAL
>>         test MMAP (epoll): FAIL
>>         test USERPTR (no poll): OK                       =20
>>         test USERPTR (select): OK                        =20
>>         test DMABUF: Cannot test, specify --expbuf-device

These logs look ok to me: the MMAP tests are failing on the host, so
they are also expected to fail on the guest (still I expect regular
streaming to work on both). USERPTR is not supported on the guest, as
per your request to not support this memory type in new drivers. DMABUF
is not supported at all at the moment.

If the host cannot pass compliance, the guest will inevitably suffer
from the same shortcomings. :) But at least on the devices I tested I
was still able to stream something onto the disk and the result was
correct.
