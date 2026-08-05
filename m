Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A9483BDA
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947275; cv=pass; b=iKiLESobHV3ubdYn5eeHnfQL37N3dK59SGIoU4VpRsZfUxHWzOx/Xnf2XJR2f4B3qB02dEr6rfxAu/L7ZCrF2pPEta7+v1829vQBXXXdBZXu2U/TnwCZ/pVIvInQWwZhBKLsTNxLOeLAd8guk/askAoOFPs7Pf28PRrAf2LBOiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947275; c=relaxed/simple;
	bh=hseoeC19wiYla+sYfxxfvStTEAjwkpF9T3pd32AcDaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mflRVxy2ey96tYnuHv3iR7z0gnrhfZx/dCiUyuPkI3oeLtTiJs/7xAY+vc5NZYcRggAOf36HU4pdKJc/LrS9Oq9A4Z7eLlvXcRd3gMD6A/I7bdPtrCzUUN36bNYydjjGCa69PPvDwJDZQUYMx1uQxX9TFhLfztGMmtKF8/BPyOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnCsXRO3; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnCsXRO3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccdf36f63dso157735ad.0
        for <virtualization@lists.linux.dev>; Wed, 05 Aug 2026 09:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785947268; cv=none;
        d=google.com; s=arc-20260327;
        b=XJX5oOQISzb442Qb+loJcNV2Bvhntf5hVwT/ewsp0OQylkLCc7mv66dgBdnjJlcghf
         qXaB01N8fIgwY+Q0hLfq79P2gJFBEPiEX15eWvQiTHMv6AJOUK4ts/5kNlZokIMBAkCZ
         mJhmf1dVBzsdp0Eg64qnlmPff+aH3exhjoE5tBnsFLU9UaGBn8f4iYixWF5tzr3HsEhM
         jZvEarS6R8IgK+2Qm3b/vS+UOm30P8QZANc/SO9ayJ26FqwNav2BYi3f6IVNfFReiESi
         uxjmBJ/nvjor1rvNzzlEHeYLmTYnXNvxW5aqTrL6LLEqHnpqefiD8xNZmuUmxQ3rqhIn
         0/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OAgz5NF/5WQOFnknLOsKaQqU1yTKkPrJCjAgPKkqOxM=;
        fh=+xSgHNLEjKFtyO9ob9rYEJMGBGB+DlWMdRk2kLT+pJQ=;
        b=H2VYjo7tFLHJmV9Gky+fINVfD0qZ/f9lGt+PQc5Iw+xlVmLIe1kzChT2RwkpCnWeG8
         /+yApuTphlXuqMPR5MUl/lB9Zf90OLgFSH4wx6n4RXkUkq7zjT3/cC/hYbdUfzgHXv1E
         whhM9NwpDzlbRtcFi7F6P57oDPQAHYEnc4+crSRAT9xk7d4LGJXOrbIDHlpULQa4bq8W
         oEkPz2enqevnYmiCZmFdQn35FWT6ao6Nf98b53hMg0zjMc0QQCe0FcxIjb0YH8CiGw3g
         IwzfsqS1kHr1Z4yXYqfiXkiEYhUEzIp29Dls07XwqTLR+sYqhW7MVPWYm0n2MF8FPaVQ
         FaNw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785947268; x=1786552068; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OAgz5NF/5WQOFnknLOsKaQqU1yTKkPrJCjAgPKkqOxM=;
        b=gnCsXRO3g+4qADuLWfvaPnRXvmJBXb1AbBQxJbFvi5pG2N4FCBkm4C9C0EIgAXpodl
         Uvjo6X3OT9szVMZ9N/qlwyd2p1ieklDt0dgMN/prD9sKfWSJcMyeoLbYapxGds/xt0qW
         T2zqOFMl7qWFjdCufrOA3UdZP0BMpa3q7iRigkA7C3wtram6cwabiyyFEhmw9r3Cw6ua
         gQFVi6gfaVWgYal21uBLB5rLC+9hgBXeJiuqA6hnKKe3d7LupdXtvXikXco6ZZikug3x
         0dJZV+lORTWVJhDyziOOmanvX6/o8cfJxELbRbpYlTqcD64yvxlXF9YpbC0/3KWTaMN6
         TH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785947268; x=1786552068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAgz5NF/5WQOFnknLOsKaQqU1yTKkPrJCjAgPKkqOxM=;
        b=ddDtYgcnipKKQsQb4h73DnEcmVzVw32DdFz9eSaYCfL94eO+ggCnJO6ts+/AwlcD1/
         WATPCgrHRlV5VD3j4ECGxoEBKhrDm3vCaGpKMM9Ql9dXsJ3vzoTiAntK0gK644upaoJG
         BABKT6Ql2/hzQTNhQqYKnyIVYuHEnbqFzxSR88bh5DVElknQTL8kguijt2DL8QtbYLmO
         Mcpfug3sXsLyrafm6JHXN1hl+GWV/2eZ9CtKD1GDsQlzm5UY+uqaeQ4L05tBv3sDHW3b
         1eFjvng4s7UE/oH2CA1zfrarip6pbPvFtWjciZHGmT8NFCO2OpEfuKDL3XqwlK3wsuiS
         69sA==
X-Forwarded-Encrypted: i=1; AHgh+RojxguHkxtu3vbjeU/LmZLeqAuSj8LKVa0DKHmU95qYUydMQAsIwGCcjbCQ4vN96TCzDragNthGrQopnAuyvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwIGgz861zn5upu6Yhdad+P4RkwpMX5Yzu44rNqXxTnvNHc81u
	UmxTZWNzhsx2vziWlYm+2e6j5tyY2T0HPFx14LqI+682r1jairdhS1qZw50RAnqwfnZHEDf4Vux
	rh9Ev3wuFtdIA258J8oLGmJCZYo762PqCCTJCfLk=
X-Gm-Gg: AR+sD10SrPXQqS3rEW9uyGwvmK+k6LiC2vKXk4g3uHuFG9qNAzeMvF9+W4esYEUEeRm
	mVBh91x9uIL6J9kDWsbUovx6liVz4XZALzKM6+YJo8vL1uVVZSYNi6L6Vc3WpG1aTZtwZA/MS0G
	ADnEjDBqlXLLilQzAP3ZBCUA3SDNBkPTXC9t4O+Wu1hVdpVt2IqzQqtoqF9DbMXgfVOsR5Rm+BI
	vJyDo/4i5pg97JziG5qvI0xwfb9EdPXWJyqUpN/qfBF46SeU7nTJ4f7240vsGy5vGv1yddQ2lhK
	R+SugZY0p7tgUzpPYsXXheYSvn5KiWI9ejo0Torx9o9gJDsp3ZNzI9jR3UcCPxRvxeXbjqY=
X-Received: by 2002:a17:902:d042:b0:2ca:cbe5:c3af with SMTP id
 d9443c01a7336-2d0d0691a21mr8789735ad.7.1785947267080; Wed, 05 Aug 2026
 09:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260723183219.737296-1-briandaniels@google.com>
 <20260804164639-mutt-send-email-mst@kernel.org> <CADSE00LYv2dJKCExB4xcYpdCwpYkb7+q8ZhV+i1FZkEeKETtKQ@mail.gmail.com>
In-Reply-To: <CADSE00LYv2dJKCExB4xcYpdCwpYkb7+q8ZhV+i1FZkEeKETtKQ@mail.gmail.com>
From: Brian Daniels <briandaniels@google.com>
Date: Wed, 5 Aug 2026 12:27:35 -0400
X-Gm-Features: AUfX_myQ2PdyYCMb51Z0U6BWRvx1nPJu_lxTmAKWmTG3yOMPqSq0SCPQZ5-_o9A
Message-ID: <CAD4i_GSCzk-Ybx0LP+GcKm7_TN2agDAcN=Zj1VTrx2phhpHc7Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] media: add virtio-media driver
To: Albert Esteve <aesteve@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, adelva@google.com, 
	changyeon@google.com, daniel.almeida@collabora.com, eperezma@redhat.com, 
	gnurou@gmail.com, gurchetansingh@google.com, hverkuil@xs4all.nl, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 3:17=E2=80=AFAM Albert Esteve <aesteve@redhat.com> w=
rote:
>
> On Tue, Aug 4, 2026 at 10:48=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, Jul 23, 2026 at 02:32:14PM -0400, Brian Daniels wrote:
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
> >
> > Pls note trying to merge this in linux next caused kbuild failures.
>
> It requires the patch adding VIRTIO_ID_MEDIA (linked above) to build.
> I did not see any other failures after adding it when I tested?

I wasn't able to reproduce the build issue either. I will upload v6
today which fixes the license warning.

> >
> > > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > > Signed-off-by: Brian Daniels <briandaniels@google.com>
> >
> >
> > I don't see what these 2 tags mean, and generally patch 0 does not need
> > a signoff.

Thanks, will remove these for v6.


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
> > >       Driver name      : uvcvideo
> > >       Card type        : Logitech Webcam C925e
> > >       Bus info         : usb-0000:04:00.1-3
> > >       Driver version   : 6.18.14
> > >       Capabilities     : 0x84a00001
> > >               Video Capture
> > >               Metadata Capture
> > >               Streaming
> > >               Extended Pix Format
> > >               Device Capabilities
> > >       Device Caps      : 0x04200001
> > >               Video Capture
> > >               Streaming
> > >               Extended Pix Format
> > > Media Driver Info:
> > >       Driver name      : uvcvideo
> > >       Model            : Logitech Webcam C925e
> > >       Serial           : 686F371F
> > >       Bus info         : usb-0000:04:00.1-3
> > >       Media version    : 6.18.14
> > >       Hardware revision: 0x00000016 (22)
> > >       Driver version   : 6.18.14
> > > Interface Info:
> > >       ID               : 0x03000002
> > >       Type             : V4L Video
> > > Entity Info:
> > >       ID               : 0x00000001 (1)
> > >       Name             : Logitech Webcam C925e
> > >       Function         : V4L2 I/O
> > >       Flags            : default
> > >       Pad 0x01000007   : 0: Sink
> > >         Link 0x0200001f: from remote pad 0x100000a of entity 'Process=
ing 3' (Video Pixel Formatter): Data, Enabled, Immutable
> > >
> > > Required ioctls:
> > >       test MC information (see 'Media Driver Info' above): OK
> > >       test VIDIOC_QUERYCAP: OK
> > >       test invalid ioctls: OK
> > >
> > > Allow for multiple opens:
> > >       test second /dev/video1 open: OK
> > >       test VIDIOC_QUERYCAP: OK
> > >       test VIDIOC_G/S_PRIORITY: OK
> > >       test for unlimited opens: OK
> > >
> > > Debug ioctls:
> > >       test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> > >       test VIDIOC_LOG_STATUS: OK (Not Supported)
> > >
> > > Input ioctls:
> > >       test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> > >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > >       test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> > >       test VIDIOC_ENUMAUDIO: OK (Not Supported)
> > >       test VIDIOC_G/S/ENUMINPUT: OK
> > >       test VIDIOC_G/S_AUDIO: OK (Not Supported)
> > >       Inputs: 1 Audio Inputs: 0 Tuners: 0
> > >
> > > Output ioctls:
> > >       test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> > >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > >       test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> > >       test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> > >       test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> > >       Outputs: 0 Audio Outputs: 0 Modulators: 0
> > >
> > > Input/Output configuration ioctls:
> > >       test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> > >       test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> > >       test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> > >       test VIDIOC_G/S_EDID: OK (Not Supported)
> > >
> > > Control ioctls (Input 0):
> > >       test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> > >       test VIDIOC_QUERYCTRL: OK
> > >       test VIDIOC_G/S_CTRL: OK
> > >               fail: v4l2-test-controls.cpp(983): ret !=3D EINVAL (got=
 13)
> > >       test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
> > >       test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> > >       test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> > >       Standard Controls: 19 Private Controls: 0
> > >
> > > Format ioctls (Input 0):
> > >       test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> > >       test VIDIOC_G/S_PARM: OK
> > >       test VIDIOC_G_FBUF: OK (Not Supported)
> > >       test VIDIOC_G_FMT: OK
> > >       test VIDIOC_TRY_FMT: OK
> > >       test VIDIOC_S_FMT: OK
> > >       test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> > >       test Cropping: OK (Not Supported)
> > >       test Composing: OK (Not Supported)
> > >       test Scaling: OK (Not Supported)
> > >
> > > Codec ioctls (Input 0):
> > >       test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> > >       test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> > >       test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> > >
> > > Buffer ioctls (Input 0):
> > >       test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> > >       test CREATE_BUFS maximum buffers: OK
> > >       test VIDIOC_REMOVE_BUFS: OK
> > >       test VIDIOC_EXPBUF: OK
> > >       test Requests: OK (Not Supported)
> > >       test blocking wait: OK
> > >
> > > Test input 0:
> > >
> > > Streaming ioctls:
> > >       test read/write: OK (Not Supported)
> > >
> > >       Video Capture: Frame #000
> > >       Video Capture: Frame #001
> > >       Video Capture: Frame #002
> > >       Video Capture: Frame #003
> > >       Video Capture: Frame #004
> > >       Video Capture: Frame #005
> > >       Video Capture: Frame #006
> > >       Video Capture: Frame #007
> > >       Video Capture: Frame #008
> > >       Video Capture: Frame #009
> > >       Video Capture: Frame #010
> > >       Video Capture: Frame #011
> > >       Video Capture: Frame #012
> > >       Video Capture: Frame #013
> > >       Video Capture: Frame #014
> > >       Video Capture: Frame #015
> > >       Video Capture: Frame #016
> > >       Video Capture: Frame #017
> > >       Video Capture: Frame #018
> > >       Video Capture: Frame #019
> > >       Video Capture: Frame #020
> > >       Video Capture: Frame #021
> > >       Video Capture: Frame #022
> > >       Video Capture: Frame #023
> > >       Video Capture: Frame #024
> > >       Video Capture: Frame #025
> > >       Video Capture: Frame #026
> > >       Video Capture: Frame #027
> > >       Video Capture: Frame #028
> > >       Video Capture: Frame #029
> > >       Video Capture: Frame #030
> > >       Video Capture: Frame #031
> > >       Video Capture: Frame #032
> > >       Video Capture: Frame #033
> > >       Video Capture: Frame #034
> > >       Video Capture: Frame #035
> > >       Video Capture: Frame #036
> > >       Video Capture: Frame #037
> > >       Video Capture: Frame #038
> > >       Video Capture: Frame #039
> > >       Video Capture: Frame #040
> > >       Video Capture: Frame #041
> > >       Video Capture: Frame #042
> > >       Video Capture: Frame #043
> > >       Video Capture: Frame #044
> > >       Video Capture: Frame #045
> > >       Video Capture: Frame #046
> > >       Video Capture: Frame #047
> > >       Video Capture: Frame #048
> > >       Video Capture: Frame #049
> > >       Video Capture: Frame #050
> > >       Video Capture: Frame #051
> > >       Video Capture: Frame #052
> > >       Video Capture: Frame #053
> > >       Video Capture: Frame #054
> > >       Video Capture: Frame #055
> > >       Video Capture: Frame #056
> > >       Video Capture: Frame #057
> > >       Video Capture: Frame #058
> > >       Video Capture: Frame #059
> > >
> > >       test MMAP (no poll, REQBUFS): OK
> > >
> > >       Video Capture: Frame #000 (select)
> > >       Video Capture: Frame #001 (select)
> > >       Video Capture: Frame #002 (select)
> > >       Video Capture: Frame #003 (select)
> > >       Video Capture: Frame #004 (select)
> > >       Video Capture: Frame #005 (select)
> > >       Video Capture: Frame #006 (select)
> > >       Video Capture: Frame #007 (select)
> > >       Video Capture: Frame #008 (select)
> > >       Video Capture: Frame #009 (select)
> > >       Video Capture: Frame #010 (select)
> > >       Video Capture: Frame #011 (select)
> > >       Video Capture: Frame #012 (select)
> > >       Video Capture: Frame #013 (select)
> > >       Video Capture: Frame #014 (select)
> > >       Video Capture: Frame #015 (select)
> > >       Video Capture: Frame #016 (select)
> > >       Video Capture: Frame #017 (select)
> > >       Video Capture: Frame #018 (select)
> > >       Video Capture: Frame #019 (select)
> > >       Video Capture: Frame #020 (select)
> > >       Video Capture: Frame #021 (select)
> > >       Video Capture: Frame #022 (select)
> > >       Video Capture: Frame #023 (select)
> > >       Video Capture: Frame #024 (select)
> > >       Video Capture: Frame #025 (select)
> > >       Video Capture: Frame #026 (select)
> > >       Video Capture: Frame #027 (select)
> > >       Video Capture: Frame #028 (select)
> > >       Video Capture: Frame #029 (select)
> > >       Video Capture: Frame #030 (select)
> > >       Video Capture: Frame #031 (select)
> > >       Video Capture: Frame #032 (select)
> > >       Video Capture: Frame #033 (select)
> > >       Video Capture: Frame #034 (select)
> > >       Video Capture: Frame #035 (select)
> > >       Video Capture: Frame #036 (select)
> > >       Video Capture: Frame #037 (select)
> > >       Video Capture: Frame #038 (select)
> > >       Video Capture: Frame #039 (select)
> > >       Video Capture: Frame #040 (select)
> > >       Video Capture: Frame #041 (select)
> > >       Video Capture: Frame #042 (select)
> > >       Video Capture: Frame #043 (select)
> > >       Video Capture: Frame #044 (select)
> > >       Video Capture: Frame #045 (select)
> > >       Video Capture: Frame #046 (select)
> > >       Video Capture: Frame #047 (select)
> > >       Video Capture: Frame #048 (select)
> > >       Video Capture: Frame #049 (select)
> > >       Video Capture: Frame #050 (select)
> > >       Video Capture: Frame #051 (select)
> > >       Video Capture: Frame #052 (select)
> > >       Video Capture: Frame #053 (select)
> > >       Video Capture: Frame #054 (select)
> > >       Video Capture: Frame #055 (select)
> > >       Video Capture: Frame #056 (select)
> > >       Video Capture: Frame #057 (select)
> > >       Video Capture: Frame #058 (select)
> > >       Video Capture: Frame #059 (select)
> > >
> > >       test MMAP (select, REQBUFS): OK
> > >
> > >       Video Capture: Frame #000 (epoll)
> > >       Video Capture: Frame #001 (epoll)
> > >       Video Capture: Frame #002 (epoll)
> > >       Video Capture: Frame #003 (epoll)
> > >       Video Capture: Frame #004 (epoll)
> > >       Video Capture: Frame #005 (epoll)
> > >       Video Capture: Frame #006 (epoll)
> > >       Video Capture: Frame #007 (epoll)
> > >       Video Capture: Frame #008 (epoll)
> > >       Video Capture: Frame #009 (epoll)
> > >       Video Capture: Frame #010 (epoll)
> > >       Video Capture: Frame #011 (epoll)
> > >       Video Capture: Frame #012 (epoll)
> > >       Video Capture: Frame #013 (epoll)
> > >       Video Capture: Frame #014 (epoll)
> > >       Video Capture: Frame #015 (epoll)
> > >       Video Capture: Frame #016 (epoll)
> > >       Video Capture: Frame #017 (epoll)
> > >       Video Capture: Frame #018 (epoll)
> > >       Video Capture: Frame #019 (epoll)
> > >       Video Capture: Frame #020 (epoll)
> > >       Video Capture: Frame #021 (epoll)
> > >       Video Capture: Frame #022 (epoll)
> > >       Video Capture: Frame #023 (epoll)
> > >       Video Capture: Frame #024 (epoll)
> > >       Video Capture: Frame #025 (epoll)
> > >       Video Capture: Frame #026 (epoll)
> > >       Video Capture: Frame #027 (epoll)
> > >       Video Capture: Frame #028 (epoll)
> > >       Video Capture: Frame #029 (epoll)
> > >       Video Capture: Frame #030 (epoll)
> > >       Video Capture: Frame #031 (epoll)
> > >       Video Capture: Frame #032 (epoll)
> > >       Video Capture: Frame #033 (epoll)
> > >       Video Capture: Frame #034 (epoll)
> > >       Video Capture: Frame #035 (epoll)
> > >       Video Capture: Frame #036 (epoll)
> > >       Video Capture: Frame #037 (epoll)
> > >       Video Capture: Frame #038 (epoll)
> > >       Video Capture: Frame #039 (epoll)
> > >       Video Capture: Frame #040 (epoll)
> > >       Video Capture: Frame #041 (epoll)
> > >       Video Capture: Frame #042 (epoll)
> > >       Video Capture: Frame #043 (epoll)
> > >       Video Capture: Frame #044 (epoll)
> > >       Video Capture: Frame #045 (epoll)
> > >       Video Capture: Frame #046 (epoll)
> > >       Video Capture: Frame #047 (epoll)
> > >       Video Capture: Frame #048 (epoll)
> > >       Video Capture: Frame #049 (epoll)
> > >       Video Capture: Frame #050 (epoll)
> > >       Video Capture: Frame #051 (epoll)
> > >       Video Capture: Frame #052 (epoll)
> > >       Video Capture: Frame #053 (epoll)
> > >       Video Capture: Frame #054 (epoll)
> > >       Video Capture: Frame #055 (epoll)
> > >       Video Capture: Frame #056 (epoll)
> > >       Video Capture: Frame #057 (epoll)
> > >       Video Capture: Frame #058 (epoll)
> > >       Video Capture: Frame #059 (epoll)
> > >
> > >       test MMAP (epoll, REQBUFS): OK
> > >
> > >       Video Capture: Frame #000
> > >       Video Capture: Frame #001
> > >       Video Capture: Frame #002
> > >       Video Capture: Frame #003
> > >       Video Capture: Frame #004
> > >       Video Capture: Frame #005
> > >       Video Capture: Frame #006
> > >       Video Capture: Frame #007
> > >       Video Capture: Frame #008
> > >       Video Capture: Frame #009
> > >       Video Capture: Frame #010
> > >       Video Capture: Frame #011
> > >       Video Capture: Frame #012
> > >       Video Capture: Frame #013
> > >       Video Capture: Frame #014
> > >       Video Capture: Frame #015
> > >       Video Capture: Frame #016
> > >       Video Capture: Frame #017
> > >       Video Capture: Frame #018
> > >       Video Capture: Frame #019
> > >       Video Capture: Frame #020
> > >       Video Capture: Frame #021
> > >       Video Capture: Frame #022
> > >       Video Capture: Frame #023
> > >       Video Capture: Frame #024
> > >       Video Capture: Frame #025
> > >       Video Capture: Frame #026
> > >       Video Capture: Frame #027
> > >       Video Capture: Frame #028
> > >       Video Capture: Frame #029
> > >       Video Capture: Frame #030
> > >       Video Capture: Frame #031
> > >       Video Capture: Frame #032
> > >       Video Capture: Frame #033
> > >       Video Capture: Frame #034
> > >       Video Capture: Frame #035
> > >       Video Capture: Frame #036
> > >       Video Capture: Frame #037
> > >       Video Capture: Frame #038
> > >       Video Capture: Frame #039
> > >       Video Capture: Frame #040
> > >       Video Capture: Frame #041
> > >       Video Capture: Frame #042
> > >       Video Capture: Frame #043
> > >       Video Capture: Frame #044
> > >       Video Capture: Frame #045
> > >       Video Capture: Frame #046
> > >       Video Capture: Frame #047
> > >       Video Capture: Frame #048
> > >       Video Capture: Frame #049
> > >       Video Capture: Frame #050
> > >       Video Capture: Frame #051
> > >       Video Capture: Frame #052
> > >       Video Capture: Frame #053
> > >       Video Capture: Frame #054
> > >       Video Capture: Frame #055
> > >       Video Capture: Frame #056
> > >       Video Capture: Frame #057
> > >       Video Capture: Frame #058
> > >       Video Capture: Frame #059
> > >
> > >       test MMAP (no poll, CREATE_BUFS): OK
> > >
> > >       Video Capture: Frame #000 (select)
> > >       Video Capture: Frame #001 (select)
> > >       Video Capture: Frame #002 (select)
> > >       Video Capture: Frame #003 (select)
> > >       Video Capture: Frame #004 (select)
> > >       Video Capture: Frame #005 (select)
> > >       Video Capture: Frame #006 (select)
> > >       Video Capture: Frame #007 (select)
> > >       Video Capture: Frame #008 (select)
> > >       Video Capture: Frame #009 (select)
> > >       Video Capture: Frame #010 (select)
> > >       Video Capture: Frame #011 (select)
> > >       Video Capture: Frame #012 (select)
> > >       Video Capture: Frame #013 (select)
> > >       Video Capture: Frame #014 (select)
> > >       Video Capture: Frame #015 (select)
> > >       Video Capture: Frame #016 (select)
> > >       Video Capture: Frame #017 (select)
> > >       Video Capture: Frame #018 (select)
> > >       Video Capture: Frame #019 (select)
> > >       Video Capture: Frame #020 (select)
> > >       Video Capture: Frame #021 (select)
> > >       Video Capture: Frame #022 (select)
> > >       Video Capture: Frame #023 (select)
> > >       Video Capture: Frame #024 (select)
> > >       Video Capture: Frame #025 (select)
> > >       Video Capture: Frame #026 (select)
> > >       Video Capture: Frame #027 (select)
> > >       Video Capture: Frame #028 (select)
> > >       Video Capture: Frame #029 (select)
> > >       Video Capture: Frame #030 (select)
> > >       Video Capture: Frame #031 (select)
> > >       Video Capture: Frame #032 (select)
> > >       Video Capture: Frame #033 (select)
> > >       Video Capture: Frame #034 (select)
> > >       Video Capture: Frame #035 (select)
> > >       Video Capture: Frame #036 (select)
> > >       Video Capture: Frame #037 (select)
> > >       Video Capture: Frame #038 (select)
> > >       Video Capture: Frame #039 (select)
> > >       Video Capture: Frame #040 (select)
> > >       Video Capture: Frame #041 (select)
> > >       Video Capture: Frame #042 (select)
> > >       Video Capture: Frame #043 (select)
> > >       Video Capture: Frame #044 (select)
> > >       Video Capture: Frame #045 (select)
> > >       Video Capture: Frame #046 (select)
> > >       Video Capture: Frame #047 (select)
> > >       Video Capture: Frame #048 (select)
> > >       Video Capture: Frame #049 (select)
> > >       Video Capture: Frame #050 (select)
> > >       Video Capture: Frame #051 (select)
> > >       Video Capture: Frame #052 (select)
> > >       Video Capture: Frame #053 (select)
> > >       Video Capture: Frame #054 (select)
> > >       Video Capture: Frame #055 (select)
> > >       Video Capture: Frame #056 (select)
> > >       Video Capture: Frame #057 (select)
> > >       Video Capture: Frame #058 (select)
> > >       Video Capture: Frame #059 (select)
> > >
> > >       test MMAP (select, CREATE_BUFS): OK
> > >
> > >       Video Capture: Frame #000 (epoll)
> > >       Video Capture: Frame #001 (epoll)
> > >       Video Capture: Frame #002 (epoll)
> > >       Video Capture: Frame #003 (epoll)
> > >       Video Capture: Frame #004 (epoll)
> > >       Video Capture: Frame #005 (epoll)
> > >       Video Capture: Frame #006 (epoll)
> > >       Video Capture: Frame #007 (epoll)
> > >       Video Capture: Frame #008 (epoll)
> > >       Video Capture: Frame #009 (epoll)
> > >       Video Capture: Frame #010 (epoll)
> > >       Video Capture: Frame #011 (epoll)
> > >       Video Capture: Frame #012 (epoll)
> > >       Video Capture: Frame #013 (epoll)
> > >       Video Capture: Frame #014 (epoll)
> > >       Video Capture: Frame #015 (epoll)
> > >       Video Capture: Frame #016 (epoll)
> > >       Video Capture: Frame #017 (epoll)
> > >       Video Capture: Frame #018 (epoll)
> > >       Video Capture: Frame #019 (epoll)
> > >       Video Capture: Frame #020 (epoll)
> > >       Video Capture: Frame #021 (epoll)
> > >       Video Capture: Frame #022 (epoll)
> > >       Video Capture: Frame #023 (epoll)
> > >       Video Capture: Frame #024 (epoll)
> > >       Video Capture: Frame #025 (epoll)
> > >       Video Capture: Frame #026 (epoll)
> > >       Video Capture: Frame #027 (epoll)
> > >       Video Capture: Frame #028 (epoll)
> > >       Video Capture: Frame #029 (epoll)
> > >       Video Capture: Frame #030 (epoll)
> > >       Video Capture: Frame #031 (epoll)
> > >       Video Capture: Frame #032 (epoll)
> > >       Video Capture: Frame #033 (epoll)
> > >       Video Capture: Frame #034 (epoll)
> > >       Video Capture: Frame #035 (epoll)
> > >       Video Capture: Frame #036 (epoll)
> > >       Video Capture: Frame #037 (epoll)
> > >       Video Capture: Frame #038 (epoll)
> > >       Video Capture: Frame #039 (epoll)
> > >       Video Capture: Frame #040 (epoll)
> > >       Video Capture: Frame #041 (epoll)
> > >       Video Capture: Frame #042 (epoll)
> > >       Video Capture: Frame #043 (epoll)
> > >       Video Capture: Frame #044 (epoll)
> > >       Video Capture: Frame #045 (epoll)
> > >       Video Capture: Frame #046 (epoll)
> > >       Video Capture: Frame #047 (epoll)
> > >       Video Capture: Frame #048 (epoll)
> > >       Video Capture: Frame #049 (epoll)
> > >       Video Capture: Frame #050 (epoll)
> > >       Video Capture: Frame #051 (epoll)
> > >       Video Capture: Frame #052 (epoll)
> > >       Video Capture: Frame #053 (epoll)
> > >       Video Capture: Frame #054 (epoll)
> > >       Video Capture: Frame #055 (epoll)
> > >       Video Capture: Frame #056 (epoll)
> > >       Video Capture: Frame #057 (epoll)
> > >       Video Capture: Frame #058 (epoll)
> > >       Video Capture: Frame #059 (epoll)
> > >
> > >       test MMAP (epoll, CREATE_BUFS): OK
> > >
> > >       Video Capture: Frame #000
> > >       Video Capture: Frame #001
> > >       Video Capture: Frame #002
> > >       Video Capture: Frame #003
> > >       Video Capture: Frame #004
> > >       Video Capture: Frame #005
> > >       Video Capture: Frame #006
> > >       Video Capture: Frame #007
> > >       Video Capture: Frame #008
> > >       Video Capture: Frame #009
> > >       Video Capture: Frame #010
> > >       Video Capture: Frame #011
> > >       Video Capture: Frame #012
> > >       Video Capture: Frame #013
> > >       Video Capture: Frame #014
> > >       Video Capture: Frame #015
> > >       Video Capture: Frame #016
> > >       Video Capture: Frame #017
> > >       Video Capture: Frame #018
> > >       Video Capture: Frame #019
> > >       Video Capture: Frame #020
> > >       Video Capture: Frame #021
> > >       Video Capture: Frame #022
> > >       Video Capture: Frame #023
> > >       Video Capture: Frame #024
> > >       Video Capture: Frame #025
> > >       Video Capture: Frame #026
> > >       Video Capture: Frame #027
> > >       Video Capture: Frame #028
> > >       Video Capture: Frame #029
> > >       Video Capture: Frame #030
> > >       Video Capture: Frame #031
> > >       Video Capture: Frame #032
> > >       Video Capture: Frame #033
> > >       Video Capture: Frame #034
> > >       Video Capture: Frame #035
> > >       Video Capture: Frame #036
> > >       Video Capture: Frame #037
> > >       Video Capture: Frame #038
> > >       Video Capture: Frame #039
> > >       Video Capture: Frame #040
> > >       Video Capture: Frame #041
> > >       Video Capture: Frame #042
> > >       Video Capture: Frame #043
> > >       Video Capture: Frame #044
> > >       Video Capture: Frame #045
> > >       Video Capture: Frame #046
> > >       Video Capture: Frame #047
> > >       Video Capture: Frame #048
> > >       Video Capture: Frame #049
> > >       Video Capture: Frame #050
> > >       Video Capture: Frame #051
> > >       Video Capture: Frame #052
> > >       Video Capture: Frame #053
> > >       Video Capture: Frame #054
> > >       Video Capture: Frame #055
> > >       Video Capture: Frame #056
> > >       Video Capture: Frame #057
> > >       Video Capture: Frame #058
> > >       Video Capture: Frame #059
> > >
> > >       test USERPTR (no poll): OK
> > >
> > >       Video Capture: Frame #000 (select)
> > >       Video Capture: Frame #001 (select)
> > >       Video Capture: Frame #002 (select)
> > >       Video Capture: Frame #003 (select)
> > >       Video Capture: Frame #004 (select)
> > >       Video Capture: Frame #005 (select)
> > >       Video Capture: Frame #006 (select)
> > >       Video Capture: Frame #007 (select)
> > >       Video Capture: Frame #008 (select)
> > >       Video Capture: Frame #009 (select)
> > >       Video Capture: Frame #010 (select)
> > >       Video Capture: Frame #011 (select)
> > >       Video Capture: Frame #012 (select)
> > >       Video Capture: Frame #013 (select)
> > >       Video Capture: Frame #014 (select)
> > >       Video Capture: Frame #015 (select)
> > >       Video Capture: Frame #016 (select)
> > >       Video Capture: Frame #017 (select)
> > >       Video Capture: Frame #018 (select)
> > >       Video Capture: Frame #019 (select)
> > >       Video Capture: Frame #020 (select)
> > >       Video Capture: Frame #021 (select)
> > >       Video Capture: Frame #022 (select)
> > >       Video Capture: Frame #023 (select)
> > >       Video Capture: Frame #024 (select)
> > >       Video Capture: Frame #025 (select)
> > >       Video Capture: Frame #026 (select)
> > >       Video Capture: Frame #027 (select)
> > >       Video Capture: Frame #028 (select)
> > >       Video Capture: Frame #029 (select)
> > >       Video Capture: Frame #030 (select)
> > >       Video Capture: Frame #031 (select)
> > >       Video Capture: Frame #032 (select)
> > >       Video Capture: Frame #033 (select)
> > >       Video Capture: Frame #034 (select)
> > >       Video Capture: Frame #035 (select)
> > >       Video Capture: Frame #036 (select)
> > >       Video Capture: Frame #037 (select)
> > >       Video Capture: Frame #038 (select)
> > >       Video Capture: Frame #039 (select)
> > >       Video Capture: Frame #040 (select)
> > >       Video Capture: Frame #041 (select)
> > >       Video Capture: Frame #042 (select)
> > >       Video Capture: Frame #043 (select)
> > >       Video Capture: Frame #044 (select)
> > >       Video Capture: Frame #045 (select)
> > >       Video Capture: Frame #046 (select)
> > >       Video Capture: Frame #047 (select)
> > >       Video Capture: Frame #048 (select)
> > >       Video Capture: Frame #049 (select)
> > >       Video Capture: Frame #050 (select)
> > >       Video Capture: Frame #051 (select)
> > >       Video Capture: Frame #052 (select)
> > >       Video Capture: Frame #053 (select)
> > >       Video Capture: Frame #054 (select)
> > >       Video Capture: Frame #055 (select)
> > >       Video Capture: Frame #056 (select)
> > >       Video Capture: Frame #057 (select)
> > >       Video Capture: Frame #058 (select)
> > >       Video Capture: Frame #059 (select)
> > >
> > >       test USERPTR (select): OK
> > >       test DMABUF: Cannot test, specify --expbuf-device
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
> > >       Driver name      : uvcvideo
> > >       Card type        : Logitech Webcam C925e
> > >       Bus info         : platform:virtio-media
> > >       Driver version   : 7.1.0
> > >       Capabilities     : 0x84200001
> > >               Video Capture
> > >               Streaming
> > >               Extended Pix Format
> > >               Device Capabilities
> > >       Device Caps      : 0x04200001
> > >               Video Capture
> > >               Streaming
> > >               Extended Pix Format
> > >
> > > Required ioctls:
> > >       test VIDIOC_QUERYCAP: OK
> > >       test invalid ioctls: OK
> > >
> > > Allow for multiple opens:
> > >       test second /dev/video0 open: OK
> > >       test VIDIOC_QUERYCAP: OK
> > >       test VIDIOC_G/S_PRIORITY: OK
> > >       test for unlimited opens: OK
> > >
> > > Debug ioctls:
> > >       test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> > >       test VIDIOC_LOG_STATUS: OK (Not Supported)
> > >
> > > Input ioctls:
> > >       test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> > >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > >       test VIDIOC_S_HW_FREQ_SEEK: OK
> > >       test VIDIOC_ENUMAUDIO: OK (Not Supported)
> > >       test VIDIOC_G/S/ENUMINPUT: OK
> > >       test VIDIOC_G/S_AUDIO: OK (Not Supported)
> > >       Inputs: 1 Audio Inputs: 0 Tuners: 0
> > >
> > > Output ioctls:
> > >       test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> > >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > >       test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> > >       test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> > >       test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> > >       Outputs: 0 Audio Outputs: 0 Modulators: 0
> > >
> > > Input/Output configuration ioctls:
> > >       test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> > >       test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> > >       test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> > >       test VIDIOC_G/S_EDID: OK (Not Supported)
> > >
> > > Control ioctls (Input 0):
> > >       test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> > >       test VIDIOC_QUERYCTRL: OK
> > >       test VIDIOC_G/S_CTRL: OK
> > >               fail: v4l2-test-controls.cpp(981): ret (got 22)
> > >       test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
> > >       test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> > >       test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> > >       Standard Controls: 19 Private Controls: 0
> > >
> > > Format ioctls (Input 0):
> > >       test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> > >       test VIDIOC_G/S_PARM: OK
> > >       test VIDIOC_G_FBUF: OK (Not Supported)
> > >       test VIDIOC_G_FMT: OK
> > >       test VIDIOC_TRY_FMT: OK
> > >       test VIDIOC_S_FMT: OK
> > >       test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> > >       test Cropping: OK (Not Supported)
> > >       test Composing: OK (Not Supported)
> > >       test Scaling: OK (Not Supported)
> > >
> > > Codec ioctls (Input 0):
> > >       test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> > >       test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> > >       test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> > >
> > > Buffer ioctls (Input 0):
> > >       test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> > >       test CREATE_BUFS maximum buffers: OK
> > >       test VIDIOC_REMOVE_BUFS: OK
> > >       test VIDIOC_EXPBUF: OK (Not Supported)
> > >       test Requests: OK (Not Supported)
> > >       test blocking wait: OK
> > >
> > > Test input 0:
> > >
> > > Streaming ioctls:
> > >       test read/write: OK (Not Supported)
> > >
> > >       Video Capture: Frame #000
> > >       Video Capture: Frame #001
> > >       Video Capture: Frame #002
> > >       Video Capture: Frame #003
> > >       Video Capture: Frame #004
> > >       Video Capture: Frame #005
> > >       Video Capture: Frame #006
> > >       Video Capture: Frame #007
> > >       Video Capture: Frame #008
> > >       Video Capture: Frame #009
> > >       Video Capture: Frame #010
> > >       Video Capture: Frame #011
> > >       Video Capture: Frame #012
> > >       Video Capture: Frame #013
> > >       Video Capture: Frame #014
> > >       Video Capture: Frame #015
> > >       Video Capture: Frame #016
> > >       Video Capture: Frame #017
> > >       Video Capture: Frame #018
> > >       Video Capture: Frame #019
> > >       Video Capture: Frame #020
> > >       Video Capture: Frame #021
> > >       Video Capture: Frame #022
> > >       Video Capture: Frame #023
> > >       Video Capture: Frame #024
> > >       Video Capture: Frame #025
> > >       Video Capture: Frame #026
> > >       Video Capture: Frame #027
> > >       Video Capture: Frame #028
> > >       Video Capture: Frame #029
> > >       Video Capture: Frame #030
> > >       Video Capture: Frame #031
> > >       Video Capture: Frame #032
> > >       Video Capture: Frame #033
> > >       Video Capture: Frame #034
> > >       Video Capture: Frame #035
> > >       Video Capture: Frame #036
> > >       Video Capture: Frame #037
> > >       Video Capture: Frame #038
> > >       Video Capture: Frame #039
> > >       Video Capture: Frame #040
> > >       Video Capture: Frame #041
> > >       Video Capture: Frame #042
> > >       Video Capture: Frame #043
> > >       Video Capture: Frame #044
> > >       Video Capture: Frame #045
> > >       Video Capture: Frame #046
> > >       Video Capture: Frame #047
> > >       Video Capture: Frame #048
> > >       Video Capture: Frame #049
> > >       Video Capture: Frame #050
> > >       Video Capture: Frame #051
> > >       Video Capture: Frame #052
> > >       Video Capture: Frame #053
> > >       Video Capture: Frame #054
> > >       Video Capture: Frame #055
> > >       Video Capture: Frame #056
> > >       Video Capture: Frame #057
> > >       Video Capture: Frame #058
> > >       Video Capture: Frame #059
> > >
> > >       test MMAP (no poll, REQBUFS): OK
> > >
> > >       Video Capture: Frame #000 (select)
> > >       Video Capture: Frame #001 (select)
> > >       Video Capture: Frame #002 (select)
> > >       Video Capture: Frame #003 (select)
> > >       Video Capture: Frame #004 (select)
> > >       Video Capture: Frame #005 (select)
> > >       Video Capture: Frame #006 (select)
> > >       Video Capture: Frame #007 (select)
> > >       Video Capture: Frame #008 (select)
> > >       Video Capture: Frame #009 (select)
> > >       Video Capture: Frame #010 (select)
> > >       Video Capture: Frame #011 (select)
> > >       Video Capture: Frame #012 (select)
> > >       Video Capture: Frame #013 (select)
> > >       Video Capture: Frame #014 (select)
> > >       Video Capture: Frame #015 (select)
> > >       Video Capture: Frame #016 (select)
> > >       Video Capture: Frame #017 (select)
> > >       Video Capture: Frame #018 (select)
> > >       Video Capture: Frame #019 (select)
> > >       Video Capture: Frame #020 (select)
> > >       Video Capture: Frame #021 (select)
> > >       Video Capture: Frame #022 (select)
> > >       Video Capture: Frame #023 (select)
> > >       Video Capture: Frame #024 (select)
> > >       Video Capture: Frame #025 (select)
> > >       Video Capture: Frame #026 (select)
> > >       Video Capture: Frame #027 (select)
> > >       Video Capture: Frame #028 (select)
> > >       Video Capture: Frame #029 (select)
> > >       Video Capture: Frame #030 (select)
> > >       Video Capture: Frame #031 (select)
> > >       Video Capture: Frame #032 (select)
> > >       Video Capture: Frame #033 (select)
> > >       Video Capture: Frame #034 (select)
> > >       Video Capture: Frame #035 (select)
> > >       Video Capture: Frame #036 (select)
> > >       Video Capture: Frame #037 (select)
> > >       Video Capture: Frame #038 (select)
> > >       Video Capture: Frame #039 (select)
> > >       Video Capture: Frame #040 (select)
> > >       Video Capture: Frame #041 (select)
> > >       Video Capture: Frame #042 (select)
> > >       Video Capture: Frame #043 (select)
> > >       Video Capture: Frame #044 (select)
> > >       Video Capture: Frame #045 (select)
> > >       Video Capture: Frame #046 (select)
> > >       Video Capture: Frame #047 (select)
> > >       Video Capture: Frame #048 (select)
> > >       Video Capture: Frame #049 (select)
> > >       Video Capture: Frame #050 (select)
> > >       Video Capture: Frame #051 (select)
> > >       Video Capture: Frame #052 (select)
> > >       Video Capture: Frame #053 (select)
> > >       Video Capture: Frame #054 (select)
> > >       Video Capture: Frame #055 (select)
> > >       Video Capture: Frame #056 (select)
> > >       Video Capture: Frame #057 (select)
> > >       Video Capture: Frame #058 (select)
> > >       Video Capture: Frame #059 (select)
> > >
> > >       test MMAP (select, REQBUFS): OK
> > >
> > >       Video Capture: Frame #000 (epoll)
> > >       Video Capture: Frame #001 (epoll)
> > >       Video Capture: Frame #002 (epoll)
> > >       Video Capture: Frame #003 (epoll)
> > >       Video Capture: Frame #004 (epoll)
> > >       Video Capture: Frame #005 (epoll)
> > >       Video Capture: Frame #006 (epoll)
> > >       Video Capture: Frame #007 (epoll)
> > >       Video Capture: Frame #008 (epoll)
> > >       Video Capture: Frame #009 (epoll)
> > >       Video Capture: Frame #010 (epoll)
> > >       Video Capture: Frame #011 (epoll)
> > >       Video Capture: Frame #012 (epoll)
> > >       Video Capture: Frame #013 (epoll)
> > >       Video Capture: Frame #014 (epoll)
> > >       Video Capture: Frame #015 (epoll)
> > >       Video Capture: Frame #016 (epoll)
> > >       Video Capture: Frame #017 (epoll)
> > >       Video Capture: Frame #018 (epoll)
> > >       Video Capture: Frame #019 (epoll)
> > >       Video Capture: Frame #020 (epoll)
> > >       Video Capture: Frame #021 (epoll)
> > >       Video Capture: Frame #022 (epoll)
> > >       Video Capture: Frame #023 (epoll)
> > >       Video Capture: Frame #024 (epoll)
> > >       Video Capture: Frame #025 (epoll)
> > >       Video Capture: Frame #026 (epoll)
> > >       Video Capture: Frame #027 (epoll)
> > >       Video Capture: Frame #028 (epoll)
> > >       Video Capture: Frame #029 (epoll)
> > >       Video Capture: Frame #030 (epoll)
> > >       Video Capture: Frame #031 (epoll)
> > >       Video Capture: Frame #032 (epoll)
> > >       Video Capture: Frame #033 (epoll)
> > >       Video Capture: Frame #034 (epoll)
> > >       Video Capture: Frame #035 (epoll)
> > >       Video Capture: Frame #036 (epoll)
> > >       Video Capture: Frame #037 (epoll)
> > >       Video Capture: Frame #038 (epoll)
> > >       Video Capture: Frame #039 (epoll)
> > >       Video Capture: Frame #040 (epoll)
> > >       Video Capture: Frame #041 (epoll)
> > >       Video Capture: Frame #042 (epoll)
> > >       Video Capture: Frame #043 (epoll)
> > >       Video Capture: Frame #044 (epoll)
> > >       Video Capture: Frame #045 (epoll)
> > >       Video Capture: Frame #046 (epoll)
> > >       Video Capture: Frame #047 (epoll)
> > >       Video Capture: Frame #048 (epoll)
> > >       Video Capture: Frame #049 (epoll)
> > >       Video Capture: Frame #050 (epoll)
> > >       Video Capture: Frame #051 (epoll)
> > >       Video Capture: Frame #052 (epoll)
> > >       Video Capture: Frame #053 (epoll)
> > >       Video Capture: Frame #054 (epoll)
> > >       Video Capture: Frame #055 (epoll)
> > >       Video Capture: Frame #056 (epoll)
> > >       Video Capture: Frame #057 (epoll)
> > >       Video Capture: Frame #058 (epoll)
> > >       Video Capture: Frame #059 (epoll)
> > >
> > >       test MMAP (epoll, REQBUFS): OK
> > >
> > >       Video Capture: Frame #000
> > >       Video Capture: Frame #001
> > >       Video Capture: Frame #002
> > >       Video Capture: Frame #003
> > >       Video Capture: Frame #004
> > >       Video Capture: Frame #005
> > >       Video Capture: Frame #006
> > >       Video Capture: Frame #007
> > >       Video Capture: Frame #008
> > >       Video Capture: Frame #009
> > >       Video Capture: Frame #010
> > >       Video Capture: Frame #011
> > >       Video Capture: Frame #012
> > >       Video Capture: Frame #013
> > >       Video Capture: Frame #014
> > >       Video Capture: Frame #015
> > >       Video Capture: Frame #016
> > >       Video Capture: Frame #017
> > >       Video Capture: Frame #018
> > >       Video Capture: Frame #019
> > >       Video Capture: Frame #020
> > >       Video Capture: Frame #021
> > >       Video Capture: Frame #022
> > >       Video Capture: Frame #023
> > >       Video Capture: Frame #024
> > >       Video Capture: Frame #025
> > >       Video Capture: Frame #026
> > >       Video Capture: Frame #027
> > >       Video Capture: Frame #028
> > >       Video Capture: Frame #029
> > >       Video Capture: Frame #030
> > >       Video Capture: Frame #031
> > >       Video Capture: Frame #032
> > >       Video Capture: Frame #033
> > >       Video Capture: Frame #034
> > >       Video Capture: Frame #035
> > >       Video Capture: Frame #036
> > >       Video Capture: Frame #037
> > >       Video Capture: Frame #038
> > >       Video Capture: Frame #039
> > >       Video Capture: Frame #040
> > >       Video Capture: Frame #041
> > >       Video Capture: Frame #042
> > >       Video Capture: Frame #043
> > >       Video Capture: Frame #044
> > >       Video Capture: Frame #045
> > >       Video Capture: Frame #046
> > >       Video Capture: Frame #047
> > >       Video Capture: Frame #048
> > >       Video Capture: Frame #049
> > >       Video Capture: Frame #050
> > >       Video Capture: Frame #051
> > >       Video Capture: Frame #052
> > >       Video Capture: Frame #053
> > >       Video Capture: Frame #054
> > >       Video Capture: Frame #055
> > >       Video Capture: Frame #056
> > >       Video Capture: Frame #057
> > >       Video Capture: Frame #058
> > >       Video Capture: Frame #059
> > >
> > >       test MMAP (no poll, CREATE_BUFS): OK
> > >
> > >       Video Capture: Frame #000 (select)
> > >       Video Capture: Frame #001 (select)
> > >       Video Capture: Frame #002 (select)
> > >       Video Capture: Frame #003 (select)
> > >       Video Capture: Frame #004 (select)
> > >       Video Capture: Frame #005 (select)
> > >       Video Capture: Frame #006 (select)
> > >       Video Capture: Frame #007 (select)
> > >       Video Capture: Frame #008 (select)
> > >       Video Capture: Frame #009 (select)
> > >       Video Capture: Frame #010 (select)
> > >       Video Capture: Frame #011 (select)
> > >       Video Capture: Frame #012 (select)
> > >       Video Capture: Frame #013 (select)
> > >       Video Capture: Frame #014 (select)
> > >       Video Capture: Frame #015 (select)
> > >       Video Capture: Frame #016 (select)
> > >       Video Capture: Frame #017 (select)
> > >       Video Capture: Frame #018 (select)
> > >       Video Capture: Frame #019 (select)
> > >       Video Capture: Frame #020 (select)
> > >       Video Capture: Frame #021 (select)
> > >       Video Capture: Frame #022 (select)
> > >       Video Capture: Frame #023 (select)
> > >       Video Capture: Frame #024 (select)
> > >       Video Capture: Frame #025 (select)
> > >       Video Capture: Frame #026 (select)
> > >       Video Capture: Frame #027 (select)
> > >       Video Capture: Frame #028 (select)
> > >       Video Capture: Frame #029 (select)
> > >       Video Capture: Frame #030 (select)
> > >       Video Capture: Frame #031 (select)
> > >       Video Capture: Frame #032 (select)
> > >       Video Capture: Frame #033 (select)
> > >       Video Capture: Frame #034 (select)
> > >       Video Capture: Frame #035 (select)
> > >       Video Capture: Frame #036 (select)
> > >       Video Capture: Frame #037 (select)
> > >       Video Capture: Frame #038 (select)
> > >       Video Capture: Frame #039 (select)
> > >       Video Capture: Frame #040 (select)
> > >       Video Capture: Frame #041 (select)
> > >       Video Capture: Frame #042 (select)
> > >       Video Capture: Frame #043 (select)
> > >       Video Capture: Frame #044 (select)
> > >       Video Capture: Frame #045 (select)
> > >       Video Capture: Frame #046 (select)
> > >       Video Capture: Frame #047 (select)
> > >       Video Capture: Frame #048 (select)
> > >       Video Capture: Frame #049 (select)
> > >       Video Capture: Frame #050 (select)
> > >       Video Capture: Frame #051 (select)
> > >       Video Capture: Frame #052 (select)
> > >       Video Capture: Frame #053 (select)
> > >       Video Capture: Frame #054 (select)
> > >       Video Capture: Frame #055 (select)
> > >       Video Capture: Frame #056 (select)
> > >       Video Capture: Frame #057 (select)
> > >       Video Capture: Frame #058 (select)
> > >       Video Capture: Frame #059 (select)
> > >
> > >       test MMAP (select, CREATE_BUFS): OK
> > >
> > >       Video Capture: Frame #000 (epoll)
> > >       Video Capture: Frame #001 (epoll)
> > >       Video Capture: Frame #002 (epoll)
> > >       Video Capture: Frame #003 (epoll)
> > >       Video Capture: Frame #004 (epoll)
> > >       Video Capture: Frame #005 (epoll)
> > >       Video Capture: Frame #006 (epoll)
> > >       Video Capture: Frame #007 (epoll)
> > >       Video Capture: Frame #008 (epoll)
> > >       Video Capture: Frame #009 (epoll)
> > >       Video Capture: Frame #010 (epoll)
> > >       Video Capture: Frame #011 (epoll)
> > >       Video Capture: Frame #012 (epoll)
> > >       Video Capture: Frame #013 (epoll)
> > >       Video Capture: Frame #014 (epoll)
> > >       Video Capture: Frame #015 (epoll)
> > >       Video Capture: Frame #016 (epoll)
> > >       Video Capture: Frame #017 (epoll)
> > >       Video Capture: Frame #018 (epoll)
> > >       Video Capture: Frame #019 (epoll)
> > >       Video Capture: Frame #020 (epoll)
> > >       Video Capture: Frame #021 (epoll)
> > >       Video Capture: Frame #022 (epoll)
> > >       Video Capture: Frame #023 (epoll)
> > >       Video Capture: Frame #024 (epoll)
> > >       Video Capture: Frame #025 (epoll)
> > >       Video Capture: Frame #026 (epoll)
> > >       Video Capture: Frame #027 (epoll)
> > >       Video Capture: Frame #028 (epoll)
> > >       Video Capture: Frame #029 (epoll)
> > >       Video Capture: Frame #030 (epoll)
> > >       Video Capture: Frame #031 (epoll)
> > >       Video Capture: Frame #032 (epoll)
> > >       Video Capture: Frame #033 (epoll)
> > >       Video Capture: Frame #034 (epoll)
> > >       Video Capture: Frame #035 (epoll)
> > >       Video Capture: Frame #036 (epoll)
> > >       Video Capture: Frame #037 (epoll)
> > >       Video Capture: Frame #038 (epoll)
> > >       Video Capture: Frame #039 (epoll)
> > >       Video Capture: Frame #040 (epoll)
> > >       Video Capture: Frame #041 (epoll)
> > >       Video Capture: Frame #042 (epoll)
> > >       Video Capture: Frame #043 (epoll)
> > >       Video Capture: Frame #044 (epoll)
> > >       Video Capture: Frame #045 (epoll)
> > >       Video Capture: Frame #046 (epoll)
> > >       Video Capture: Frame #047 (epoll)
> > >       Video Capture: Frame #048 (epoll)
> > >       Video Capture: Frame #049 (epoll)
> > >       Video Capture: Frame #050 (epoll)
> > >       Video Capture: Frame #051 (epoll)
> > >       Video Capture: Frame #052 (epoll)
> > >       Video Capture: Frame #053 (epoll)
> > >       Video Capture: Frame #054 (epoll)
> > >       Video Capture: Frame #055 (epoll)
> > >       Video Capture: Frame #056 (epoll)
> > >       Video Capture: Frame #057 (epoll)
> > >       Video Capture: Frame #058 (epoll)
> > >       Video Capture: Frame #059 (epoll)
> > >
> > >       test MMAP (epoll, CREATE_BUFS): OK
> > >       test USERPTR (no poll): OK (Not Supported)
> > >       test USERPTR (select): OK (Not Supported)
> > >       test DMABUF (no poll): OK (Not Supported)
> > >       test DMABUF (select): OK (Not Supported)
> > >
> > > Total for uvcvideo device /dev/video0: 59, Succeeded: 58, Failed: 1, =
Warnings: 0
> > >
> > > ---
> > > Changes in v5:
> > > - Add DMA buffer alignment and padding for commands, responses, and t=
he event
> > >   buffer
> > > - Corrected styling of kernel-doc comments
> > > - Removed the configurable ``driver_name`` module parameter
> > > - Moved the protocol to ``include/uapi/linux/virtio_media.h``
> > > - Link to v4: https://lore.kernel.org/all/20260622204343.1994418-1-br=
iandaniels@google.com/
> > >
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
> > > Brian Daniels (5):
> > >   media: virtio: Add skeleton virtio-media driver
> > >   media: virtio: Add session management
> > >   media: virtio: Add scatterlist builder
> > >   media: virtio: Add ioctl operations and driver logic
> > >   media: virtio: Add USERPTR memory type support
> > >
> > >  MAINTAINERS                                |    8 +
> > >  drivers/media/Kconfig                      |   13 +
> > >  drivers/media/Makefile                     |    2 +
> > >  drivers/media/virtio/Makefile              |    7 +
> > >  drivers/media/virtio/scatterlist_builder.c |  579 +++++++++
> > >  drivers/media/virtio/scatterlist_builder.h |  112 ++
> > >  drivers/media/virtio/session.h             |  132 ++
> > >  drivers/media/virtio/virtio_media.h        |   97 ++
> > >  drivers/media/virtio/virtio_media_driver.c |  951 ++++++++++++++
> > >  drivers/media/virtio/virtio_media_ioctls.c | 1326 ++++++++++++++++++=
++
> > >  include/uapi/linux/virtio_media.h          |  287 +++++
> > >  11 files changed, 3514 insertions(+)
> > >  create mode 100644 drivers/media/virtio/Makefile
> > >  create mode 100644 drivers/media/virtio/scatterlist_builder.c
> > >  create mode 100644 drivers/media/virtio/scatterlist_builder.h
> > >  create mode 100644 drivers/media/virtio/session.h
> > >  create mode 100644 drivers/media/virtio/virtio_media.h
> > >  create mode 100644 drivers/media/virtio/virtio_media_driver.c
> > >  create mode 100644 drivers/media/virtio/virtio_media_ioctls.c
> > >  create mode 100644 include/uapi/linux/virtio_media.h
> > >
> > >
> > > base-commit: 06cb687a5132fcffe624c0070576ab852ac6b568
> > > --
> > > 2.55.0.229.g6434b31f56-goog
> >
>
