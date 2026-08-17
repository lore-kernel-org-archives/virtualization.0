Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34B390229
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969280; cv=none; b=nHxefkwCLGTuxcI/HeLZYobUD6uqRxzYcdIjriSBA4Gvx4rbCTiLC2W50ba8ZXw+YcJvhEHDonl1QE/0jBaRXSGY1SiFfEqyn+bRzM5e/0NEt1aruo/FS2V0DWHSrFf/Fxb4+zFOHwLKQnnoSCxd3BIa8k6xlX96QL9wWcP4Pas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969280; c=relaxed/simple;
	bh=WFPrLag9482u11+mk1JS7Fh0ynqOfEWYM/JOL//G+RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewYjCTBGlV4XhEjBXHtZHAFOU0h+2q5Sw0Gq5OEWQXh3Yud52y7vCcTaX1C/7swGhNNiSL2r3TpxePXf9SGZkb5F3ZuV0GHUTDZ/pHB6Wvq1BDnUQU2hTa29+UJ2p4x8JyronG1yyFranK8LUKSHiCpzrHeVi8IgFrlbEaRHAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=BQTdu1Nh; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="BQTdu1Nh"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67HBifTx071369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 17 Aug 2026 20:44:41 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=lPUNZG6ebfDXN3Bnz8ZUjlswPwbP+Dv8XgcC/jdD9FY=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1786967081; v=1;
        b=BQTdu1NhLrpTqEthG4vddOeuDZDU6eR+DR5NxuttTitagRXgcK5w7MF78mtpcs4d
         oLICXB0ko9V0gNAmkduYBm7VLaOxnfOVs//Kcvif52TVz7f+5II/54D2HHwNfcoo
         Y6PdSjZlo8inqW7mroTq6576KysePCRPtSBn829t+qfXeXaK4Dn2OgUfst9PKAhK
         /bvubIt0kBUNxjjso5ZrsZFozl0xpiyIIJTS7zKOAUR4ChN/JXWY0yGascMXk9t6
         MybV9CUyNE1G2EpilBYDDt3R0nntwIor6Gu1NwQlVodTZxJ+iU6GD2c9wZHUqkRb
         ERnr5Wx4KUsvNfUqHOl2qA==
Message-ID: <ea899a6b-0a59-4a9c-9e81-3ed70711da59@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 17 Aug 2026 20:44:40 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About new backend for GPU compute ROCm in qemu
To: "Huang, Honglei" <honghuan@amd.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
        Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/08/17 12:19, Huang, Honglei wrote:
> 
> Hi Michael, Alex, Dmitry, Akihiko,

Hi Honglei,

> 
> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm over 
> virtio
> implementation to virglrenderer nine months ago (MR !1568 [1]). The ROCm 
> side has
> been supportted by ROCm offical.
> 
> Current implementation is a virtio gpu context type capset handled inside
> virglrenderer, sharing the display path. That's an awkward fit, many
> compute GPUs have no display engine at all.

I think "sharing the display path" conflates several layers and makes 
the problem difficult to assess. It would help to identify the concrete 
constraint behind "awkward fit."

End-to-end, there are four relevant layers:

1. Host GPU stack: hardware, host kernel, and host userspace
2. Paravirtualization stack: virglrenderer and QEMU
3. Host/guest interface: virtio and the capset-specific command stream
4. Guest GPU stack: guest kernel and guest userspace

Orthogonally, acceleration is separate from display and scanout. A
physical device may provide both, but acceleration does not require a
display engine. Linux likewise exposes render and compute interfaces
separately from modesetting. The userspace interface virglrenderer uses 
is messy; there is Vulkan, EGL, OpenGL, and now you are adding ROCm. But 
there is one thing I must note is that acceleration and display is 
decoupled, and acceleration does not require display.

At the protocol layer, context command buffers are carried by 
VIRTIO_GPU_CMD_SUBMIT_3D. Scanout uses separate core virtio-gpu 
commands, and VIRTIO_GPU_CMD_GET_DISPLAY_INFO may report no enabled 
displays. At the implementation layer, QEMU handles scanout 
presentation. virgl_cmd_set_scanout() obtains resource information 
through virgl_renderer_resource_get_info() or 
virgl_renderer_resource_get_info_ext(). That does not make scanout a 
virglrenderer-owned display path.

Therefore, if "sharing the display path" means sharing the same device, 
control queue, and QEMU execution context, that identifies a possible 
source of contention. If it means that capsets or virglrenderer are 
inherently tied to display, I do not think that is accurate. Vulkan 
compute is already used through Venus with libkrun [2], and VCL proposes 
OpenCL support through virglrenderer [3].
> Beyond that, sharing the display path is increasingly painful:
> 
>    - Compute hammers the queues more than graphics, so sharing
>      virtio gpu's single control queue with display/virgl causes contention
>      and display stutter.

All non-cursor commands do share one control queue, but a fence avoids 
serialization.

There may still be implementation-level contention, and it is not
necessarily specific to compute. A sufficiently busy graphics workload
could expose the same bottlenecks. Possible contributors in current QEMU
include:

a) qemu_console_hw_gl_block() blocks the entire queue when QEMU only
    needs to fence scanout commands.

b) virtio_gpu_virgl_unmap_resource_blob() may also block the entire
    queue just to delay one command.

c) QEMU dispatches the control queue and calls into virglrenderer from
    its main-loop thread along with display work and many other things.
    Venus's render server can offload renderer work, but control-queue
    dispatch remains in QEMU's main loop.

In any case, I think you need to do some experiments to track down the 
real cause. a) is easy to check: just comment out all 
qemu_console_hw_gl_block() calls; it may corrupt display but removes the 
blocking. b) can also be tested by leaking the mappings instead of 
blocking the whole queue. Using a different display device like qxl 
tells whether c) is causing contention.

>    - Compute contexts need far more blob / shared memory than a display 
> one.

It is not a problem by itself. Frequent mapping and unmapping might 
amplify the second issue above, but that needs to be measured.

>    - Maybe needs a wider ROCm / compute stack, cause the render model 
> fits poorly:
>      rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth streams)
>      and ROCgdb (wave control, address watch, async exceptions an
>      out of band channel that must not block display).

virglrenderer does not impose a particular render model. That's why 
Vulkan Compute just works with Venus.

>    - Events, faults and GPU reset/SMI are async and don't map onto fences.>    - All of this is hard to extend cleanly inside a display capset.
Capset is not about display but determines the protocol of the 
VIRTIO_GPU_CMD_SUBMIT_3D command stream. You have described events, 
faults and GPU reset/SMI are async don't map onto fences that may be 
associated with VIRTIO_GPU_CMD_SUBMIT_3D which is dictated by capset. An 
additional feature may be necessary, and it may or may not be dictated 
by capset. The other things are irrelevant with the protocol capset 
represents; they are either behavioral or about different commands.

> 
> On the QEMU/host side, would something like this be OK? One step, two 
> parts:
> 
>    - a dedicated headless virtio gpu instance for compute.

A second device would isolate its virtqueues and device-wide
renderer_blocked state. That may be useful if measurements show that
these are the bottlenecks, but it is not yet clear that they are or that
a second device is the appropriate solution.

>    - that instance served by a separate ROCm backend library loaded
>      in-process by QEMU.

First, I think we need to establish why ROCm cannot or should not remain
in virglrenderer. The virglrenderer, Venus, and VCL maintainers are
likely better placed to advise on that boundary. Once the protocol
requirements and performance measurements are clear, we can assess the
appropriate QEMU integration.

[2] 
https://developers.redhat.com/articles/2025/06/05/how-we-improved-ai-inference-macos-podman-containers
[3] 
https://www.qualcomm.com/developer/blog/2024/10/vcl-virtio-gpu-opencl-driver

Regards,
Akihiko Odaki

> 
> That reuses the existing pluggable backend model, a second virtio gpu + a
> backend library. It doesn't add dedicated queues for debug/profiling 
> currently.
> 
> Waiting for reply and  happy to share more detail. Thanks!
> 
> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/ 
> merge_requests/1568
> 
> Regards,
> Honglei

