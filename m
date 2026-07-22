Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B248154425
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712754; cv=none; b=iFou5FQ3zjIVc+F5sKDwwvaxYS4WUU8XHtK3d3VPTcjEVKXkois3grdol9l+hdDtm11Zbs7kfOG/JNf/TQBHk4DqU5Mxn2O1WJDX4buqVTCUo+Xk80bTnlawGJzeSZPO2xfTc2qT7CcbW1B1U+Nxp4+Kj+8oyudY+Sx4VjfQxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712754; c=relaxed/simple;
	bh=uTEZI6DKdfsgsq32YJ+4UhlmIX+jZhcmjt9F9t0EVJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8TBoAl6dbTR4IZoMcemnrASEimoIAS82NvZ6M18xyDyVmAAcG6ZXns1c0cGwxB1LFqZKE50slU4XEst/rEL3WKwzZdt0Om2dY0J5rFtAb1pPKij8mXeaOLXmMMXKhm7Z9ooncGrIreDcEeJFNAXbeW3UK3LJTuJwGa+jjT5xPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oam0t2B3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oam0t2B3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784712751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=283jKDUw6tyTL18bbaH54DEIYdFHrTHWzqhLR5a8h6c=;
	b=Oam0t2B3EZ48thLEgfp01VBnAtuZ6QlNrVm/92x3uxWvLa1eB2QBMLER6fi+y6zBq1qg+8
	qW5VpJIF5LlNfZA/dNnKIF3UUS20L7//XyDp4CBYTcLfMxUFVAe5/l3C2/bM4/rjRmlhF9
	XKO8ulVQJViqweEbRwR/28M/BVB1dTE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-F53hxHhMMF-NMT3TXsoLCA-1; Wed, 22 Jul 2026 05:32:30 -0400
X-MC-Unique: F53hxHhMMF-NMT3TXsoLCA-1
X-Mimecast-MFC-AGG-ID: F53hxHhMMF-NMT3TXsoLCA_1784712749
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e68281f2eso176279947b3.1
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 02:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784712749; x=1785317549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=283jKDUw6tyTL18bbaH54DEIYdFHrTHWzqhLR5a8h6c=;
        b=W4t+WZwUEW3ZLQJz31J2SSUgYG2TJKQN1vo6HbYF73bjLkPW+yx504FLeSuZoWClpN
         LslfB+L9r+lqdrzovYOrNq6h8BLQ+pm8/PFla9z31k0GHssp6XeqVPe6uvB0V+qkFdlF
         bhSBr+KiPWkFFdVpzOsyaz2E85LKzlSp9PokaRGvIDL4CVwxtfDKC+tPEVF8x/6emlgl
         yCkTRtmhbF6l8CJglG8JnOUliibKROOfEe8GCQ3TGDK0c3HGWs9bA/y/pKpJ9GtX1KrC
         9uBDaTACW2yi3uIT4QXUGb+6ulk1AvQhijw/hZMpbajNs1grelWk+UONZBRXjZxvX634
         F/9A==
X-Forwarded-Encrypted: i=1; AHgh+RoipvDhk91pDZCMp3cmyCuu3ITzdtLiNShPJTdJIZJiNejyfkXnZv+yxK5Qpm6Zo21PFHwbhncEQC8+HhFU4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaiYI2hVfJUOvhU8GTx0a0/O24d5XVyEfBSNNpMM7UU4LODwEb
	F6H3Vz8Y7dqMU0KSkevfDi8UbhK5YtFprb/w8TwUg1z94s8EmZdFf+fJxn7oPrat1SeXuVvOU5L
	dOzp8lupvAC27XPN/cgAngSA/AGw4tJZTOdcdrZoE7muqVX6pKQoZ+vyFgE9T6kmPo+/BNjIN8G
	zoMkqQRT7fdZFv3wgFTCsvd+VsF/dC3Wue5ZFfA1WnwEg=
X-Gm-Gg: AR+sD11/jEbRMCzCuGDacRzs7W36+qQYJbkrxIWr0Kd0Bh0SmUTU6c75hP2Gx2aR1Le
	KuCfbNhyGlnWjogPY9n+XMSaeMaR7YltEyXfFmY8o6IyFYB8L6huk0qSTTrOxjD6MXUkAyWyqb0
	UmGsOiU7tZP9TNbZ5V9MNXiZz0Tu1U+12TKKCcXC5raAkTbAqqt8mteIMYSh7dG28iE4vwSDWEt
	PDR9PARymPCAZ9ZecYPcDxAu+tPCh+NEzj9J+tu81uXCsjqS2h9EW5UtHs=
X-Received: by 2002:a05:690c:600d:b0:80c:85b6:75b8 with SMTP id 00721157ae682-81ef286a9c8mr72955537b3.65.1784712749197;
        Wed, 22 Jul 2026 02:32:29 -0700 (PDT)
X-Received: by 2002:a05:690c:600d:b0:80c:85b6:75b8 with SMTP id
 00721157ae682-81ef286a9c8mr72955227b3.65.1784712748523; Wed, 22 Jul 2026
 02:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
 <tiiht3.22qk83rct1pd@pitsidianak.is> <CAJaqyWcSeXW_vdP03-oTXp5uO8vNBg224LDgyCn3QrXhuJ6tHw@mail.gmail.com>
 <tikjvp.3n7sct2j96lcx@pitsidianak.is>
In-Reply-To: <tikjvp.3n7sct2j96lcx@pitsidianak.is>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 Jul 2026 11:31:52 +0200
X-Gm-Features: AUfX_myFdSS5yFEbwkTE9E55Wpvvva6R-RIsA-LwClYyzwNu3ZAklY_mP7h86Pc
Message-ID: <CAJaqyWfq=tAdaAzqBtrkKt0fwiQL=SU6QYVydos1q4GhHy-JDg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/6] Add Rust virtio bindings and sample device
To: Manos Pitsidianakis <manos@pitsidianak.is>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
	Peter Hilber <peter.hilber@oss.qualcomm.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5PmKwVrzdOVcuf5u248dojEbe4v1OtqG4rOM0v_0xPM_1784712749
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:04=E2=80=AFAM Manos Pitsidianakis
<manos@pitsidianak.is> wrote:
>
> Hi Eugenio,
>
> On Wed, 22 Jul 2026 11:49, Eugenio Perez Martin <eperezma@redhat.com> wro=
te:
> >On Tue, Jul 21, 2026 at 8:24=E2=80=AFAM Manos Pitsidianakis
> ><manos@pitsidianak.is> wrote:
> >>
> >> Ping.
> >>
> >> I have a different version of the series WIP with a virtio-rng instead
> >> of virtio-rtc, based on
> >> https://lore.kernel.org/lkml/20260529-rust-hw_random-virtio-rng-v1-0-b=
3153dd90311@pitsidianak.is/
> >> (which needs a v2 also)
> >>
> >> But since this series hasn't gotten any feedback on the virtio part, I=
'd
> >> like to ask if there is any before respinning.
> >>
> >> Thanks!
> >>
> >
> >I also think this will be a great addition, but I have very little
> >knowledge of Rust. Is it easy to implement the simplest virtio-net
> >driver using Rust, without CVQ or extra features, so I can test it and
> >hopefully build features on top? Would it help?
>
> I think so, however it would not be upstreamable right away since (I
> think) there are no netdev Rust bindings and abstractions yet. I will
> take a look when I have the time...
>

How about starting even smaller? Just with the virtio-ring processing
that all virtio drivers share.

> (This is something I am also interested in because I'm working on a
> different kind of network device)
>
> You can definitely play with the sample driver included in this series
> however!
>
> Manos
>
>
> >
> >Thanks!
> >
> >> On Sun, 10 May 2026 16:38, Manos Pitsidianakis <manos@pitsidianak.is> =
wrote:
> >> >Hi all, this RFC series adds Rust bindings for Virtio drivers
> >> >(frontends in virtio parlance).
> >> >
> >> >As a PoC, it also adds a sample virtio-rtc driver which performs
> >> >capability discovery through the virtqueue without registering any cl=
ock.
> >> >
> >> >Before I send a cleaned-up non-RFC I would like some initial feedback
> >> >(i.e. is it something the upstream wants?)
> >> >
> >> >This was tested with the rust-vmm vhost-device-rtc device backend tha=
t I
> >> >wrote[^0]:
> >> >
> >> >[^0]: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device=
-rtc
> >> >
> >> >Instructions:
> >> >
> >> >  Run the daemon in a separate terminal:
> >> >
> >> >  $ cargo run --bin vhost-device-rtc -- -s /tmp/rtc.sock
> >> >
> >> >  Then run the VM:
> >> >
> >> >  $ qemu-system-aarch64 \
> >> >    -machine type=3Dvirt,virtualization=3Doff,acpi=3Don \
> >> >    -cpu host \
> >> >    -smp 8 \
> >> >    -accel kvm \
> >> >    -drive if=3Dvirtio,format=3Dqcow2,file=3D./debian-13-nocloud-arm6=
4-daily.qcow2 \
> >> >    -device virtio-net-pci,netdev=3Dunet \
> >> >    -device virtio-scsi-pci \
> >> >    -serial mon:stdio \
> >> >    -m 8192 \
> >> >    -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \
> >> >    -numa node,memdev=3Dmem \
> >> >    -display none \
> >> >    -vga none \
> >> >    -kernel /path/to/linux/build/arch/arm64/boot/Image \
> >> >    -device vhost-user-test-device,chardev=3Drtc,id=3Drtc,virtio-id=
=3D17,num_vqs=3D2,vq_size=3D1024 \
> >> >    -chardev socket,path=3D/tmp/rtc.sock,id=3Drtc \
> >> >    ...
> >> >
> >> >  Example output:
> >> >    [    1.105238] rust_virtio_rtc: Probe Rust virtio driver sample.
> >> >    [    1.105645] rust_virtio_rtc: Found 1 vqs.
> >> >    [    1.136050] rust_virtio_rtc: process_requestq got buf 16 bytes
> >> >    [    1.136125] rust_virtio_rtc: Got response! Ok(RespCfg { head: =
ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, num_clocks: Le=
16(3), reserved: [0, 0, 0, 0, 0, 0] })
> >> >    [    1.136701] rust_virtio_rtc: Got response! Ok(RespClockCap { h=
ead: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_typ=
e: 3, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
> >> >    [    1.136724] rust_virtio_rtc virtio0: cannot expose clock 0 (ty=
pe 3, variant 0, flags 0) to userspace
> >> >    [    1.137259] rust_virtio_rtc: Got response! Ok(RespRead { head:=
 ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading=
: Le64(1777890485031060388) })
> >> >    [    1.137277] rust_virtio_rtc: #0 clock reading =3D 177789048503=
1060388
> >> >    [    1.137749] rust_virtio_rtc: Got response! Ok(RespClockCap { h=
ead: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_typ=
e: 1, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
> >> >    [    1.137769] rust_virtio_rtc virtio0: cannot expose clock 1 (ty=
pe 1, variant 0, flags 0) to userspace
> >> >    [    1.138247] rust_virtio_rtc: Got response! Ok(RespRead { head:=
 ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading=
: Le64(1777890485032086075) })
> >> >    [    1.138264] rust_virtio_rtc: #1 clock reading =3D 177789048503=
2086075
> >> >    [    1.138730] rust_virtio_rtc: Got response! Ok(RespClockCap { h=
ead: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_typ=
e: 2, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
> >> >    [    1.138751] rust_virtio_rtc virtio0: cannot expose clock 2 (ty=
pe 2, variant 0, flags 0) to userspace
> >> >    [    1.139253] rust_virtio_rtc: Got response! Ok(RespRead { head:=
 ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading=
: Le64(338567896865557) })
> >> >    [    1.139270] rust_virtio_rtc: #2 clock reading =3D 338567896865=
557
> >> >
> >> >Concerns - Notes - TODOs
> >> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> >
> >> >- Virtqueue lifetimes don't neatly apply to Rust as expected, so a lo=
t
> >> >  of times we have to go through unsafe pointer dereferences (though
> >> >  which are guaranteed by Virtio subsystem to be valid, for example w=
hen
> >> >  a callback is called with the vq argument). There's a potential for
> >> >  misuse and definitely could use better thinking.
> >> >- `struct virtio_device` is not reference-counted like other implemen=
ted
> >> >  device types in rust/kernel. Maybe we need to change C API first to
> >> >  make them reference counted, assuming this doesn't break anything?
> >> >- The sample driver obviously conflicts with the C implementation, so
> >> >  this would either need to move out of samples/ or figure out some w=
ay
> >> >  to handle this in kbuild.
> >> >- kernel::virtio module and its types need a few rustdoc examples tha=
t I
> >> >  will add in followup series
> >> >- Note that the registration of RTC clocks etc in the sample driver i=
s
> >> >  not done, I'm putting it off until I receive some feedback first. T=
he
> >> >  sample driver otherwise does send and receive data from the virtque=
ue
> >> >  as a PoC.
> >> >
> >> >PS: No LLMs used so any mistakes and goofs are solely written by me.
> >> >
> >> >Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
> >> >---
> >> >Changes in v3:
> >> >- Removed unused methods from virtio API
> >> >- Clean up how scattergather lists are added to virtqueues by using
> >> >  owned SGTables only, and make the API safe(r)
> >> >- Add RAII cleanup for find_vqs return value that calls del_vqs
> >> >- Reset device after remove callback
> >> >- Significantly clean up sample driver as a result of the other clean=
ups
> >> >- Link to v2: https://lore.kernel.org/r/20260509-rust-virtio-v2-0-c1e=
30ec2bd21@pitsidianak.is
> >> >
> >> >Changes in v2:
> >> >- Move helper ifdefs to helper file (thanks Alice)
> >> >- Changed CONFIG checks to IS_ENABLED to allow for CONFIG_VIRTIO=3Dm
> >> >- Split all use imports to one item per line according to style guide
> >> >- Fixed wait_for_completion_interruptible*() rustdocs
> >> >- Use Jiffy type alias in wait_for_completion_interruptible_timeout()
> >> >- Pepper and salt #[inline]s wherever appropriate as per style guide
> >> >- Split probe() into probe() and init() to allow cleaning up if init
> >> >  fails
> >> >- Remove unnecessary Send and Sync unsafe impls for
> >> >  kernel::virtio::Device
> >> >- Remove unnecessary LeSize and BeSize
> >> >- Accept Option<_> for virtqueue callback when creating a VirtqueueIn=
fo
> >> >- Made all vq buffer adding operations unsafe
> >> >- Use AtomicU16 instead of Cell<u16> for sample virtio driver
> >> >- Fix RespHead field types in sample virtio driver
> >> >- Fix response error checking in sample virtio driver
> >> >- Change some device contexts in method signatures
> >> >- Link to v1: https://lore.kernel.org/r/20260505-rust-virtio-v1-0-956=
3383909e4@pitsidianak.is
> >> >
> >> >---
> >> >Manos Pitsidianakis (6):
> >> >      rust/bindings: generate virtio bindings
> >> >      rust/helpers: add virtio.c
> >> >      rust/kernel/device: return parent at same context
> >> >      rust: add virtio module
> >> >      rust: impl interruptible waits for Completion
> >> >      samples/rust: Add sample virtio-rtc driver [WIP]
> >> >
> >> > MAINTAINERS                     |   9 +
> >> > rust/bindings/bindings_helper.h |   5 +
> >> > rust/helpers/helpers.c          |   1 +
> >> > rust/helpers/virtio.c           |  37 ++++
> >> > rust/kernel/device.rs           |   2 +-
> >> > rust/kernel/lib.rs              |   2 +
> >> > rust/kernel/sync/completion.rs  |  42 +++-
> >> > rust/kernel/virtio.rs           | 423 ++++++++++++++++++++++++++++++=
++++++++++
> >> > rust/kernel/virtio/utils.rs     |  57 ++++++
> >> > rust/kernel/virtio/virtqueue.rs | 314 +++++++++++++++++++++++++++++
> >> > samples/rust/Kconfig            |  15 ++
> >> > samples/rust/Makefile           |   1 +
> >> > samples/rust/rust_virtio_rtc.rs | 403 ++++++++++++++++++++++++++++++=
++++++++
> >> > 13 files changed, 1309 insertions(+), 2 deletions(-)
> >> >---
> >> >base-commit: 028ef9c96e96197026887c0f092424679298aae8
> >> >change-id: 20260504-rust-virtio-8523b01dfdc2
> >> >
> >> >Best regards,
> >> >--
> >> >Manos Pitsidianakis <manos@pitsidianak.is>
> >> >
>

