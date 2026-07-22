Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95C48A2CD
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710207; cv=none; b=GrydP8KjYkhY5D+zu/RSkPg4xVAU+xgyD59/rs2QBUsVIx7HC4R/TdDdV8/qGhmD5V/qCJV/v8OSKNwynQPbkKaTfi5+WogKEHuOJACwCd3gclB0VUbZYU83OgVi1SbQjvXtDehdof+B+2BvuYu1yafEwgmFmYXqorTGPgBq7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710207; c=relaxed/simple;
	bh=hWI47nnnLkHlMVvyL2MnKRqaXsns8x5e8GDQ2V3f+gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIxTURqloRqNK0kSYdSvoZFs49zAOzoJQZRkWQErzQ8nDyFMiMJxbG27IHjKBP0Hej5NZGagWvxketWXGuyIUWBi+j+Yn5TghOcUJ+n1wvFqjg3ItsEX2Km20husLjhx/L2X8BMPWzH9D/IkHHyK8hJ2pox3DgSQnmSs/KKuUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Isjc9bHx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Isjc9bHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784710202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAxBlzlV3S2sMufiWmwKi5rU+vJYhEH86YvIRSfIn/c=;
	b=Isjc9bHxjYZgCRNK8kVHCjDm5zWOxD50hb2FwzWGvUs8Gm0CKKUXDH8SLGDFrIurL5Iqr0
	OJ0gVCQH2/WS+1yYc3i9gkZIzT5y9QLsZyQ6SX4Uq86G2GEquM1wGvtTMS/7TfbiSOlY5X
	zdQSM7ZVVASOh/wC6bBqE3UTxz8Y7aY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-eTsjwax8N3KWQHVwo7AKbw-1; Wed, 22 Jul 2026 04:50:00 -0400
X-MC-Unique: eTsjwax8N3KWQHVwo7AKbw-1
X-Mimecast-MFC-AGG-ID: eTsjwax8N3KWQHVwo7AKbw_1784710200
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e735bcceaso163249627b3.3
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 01:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710200; x=1785315000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAxBlzlV3S2sMufiWmwKi5rU+vJYhEH86YvIRSfIn/c=;
        b=BCU8bH4j8vtCQQM+s9GCtQrQCu/lZtfQltsvUtVSr5yPBiezyj4OBUrV168WwnTwjr
         6l7YmQNjP1XE2zmsdwzNRrV0uahr9B5CH3SlKbA3nfmqrq00EyeS7wWwETcnqZyf/4+E
         NexO3gnQUfsWwqnrhTX5FupQaioNO0GRxseaNSQZMeozeKZvlS3NerMVznl4M9HhMB+l
         KHJ0aWi9u8CHO1bPw9EcViKJqwQfD7W8QvRXpBEnqe0qqffayoX4MOgGhs/ePF9wyVQ+
         ZOh0Q5kxaEDD0Ouazqy+/cjjO7ogINJkZimioxABvAMfZcSjAOAujNH6oSH3gW88dWhB
         N1tQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKbxZ4L4/jFNkMTSfqvysh7cKMaiN4u0rDFsgu6V+Q5MhbYMTRgpbFRFxoX3s0Ba0DSbUtXOUhNUmmShpxTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4q3GvkPxmrjkSHsAQpxpb7OREt0ux8QzZbl1wXba6xnMXo6jE
	zkjF7Nt5BI1CUi+3quvf4/sc8rWHTHUc81aVzJrax6jMYVQRIOVxaG2ujqKoNMAdw1G6p+SLEiy
	xdUN43+2/b6TvTnyxH9FSqHgByzZua5kkb0DNywOgm9lxytYbs8/cWX/sQA9oNGi8mqCMIsoTeA
	NgJYWMgd82ITe/J7XSi2H5XErPXT6U3ShJDt0IUxAKrFQ=
X-Gm-Gg: AR+sD126/ly7/pgvNpUfFsyEyG5mRqyA2GqiSXgT+JJv4UMZBIFciqE/5n/5uKD9w28
	mOxvlCsaw1oFz6Bm1tKGhEFO6g2OvIV2AacHgY13tYXRlTQVd5lIcy0OqtVw2SUxfClVZ4sIGz0
	JntGfV4b4dZBTMOt0hH7ngi3N/osVyQ2rjLetuqG/LhIsrOk9Cr7gRQuaRO4iYLl/zN9QAEeSrd
	CZeAj1Uj9ZQ4R5h+BH/2OlO3eapglLDo6F3A/nX94qGr9dqRLJZgUWTr0s=
X-Received: by 2002:a05:690c:6ac1:b0:80c:cad:c4e5 with SMTP id 00721157ae682-81ef240d4c6mr61847037b3.30.1784710200108;
        Wed, 22 Jul 2026 01:50:00 -0700 (PDT)
X-Received: by 2002:a05:690c:6ac1:b0:80c:cad:c4e5 with SMTP id
 00721157ae682-81ef240d4c6mr61846807b3.30.1784710199582; Wed, 22 Jul 2026
 01:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is> <tiiht3.22qk83rct1pd@pitsidianak.is>
In-Reply-To: <tiiht3.22qk83rct1pd@pitsidianak.is>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 Jul 2026 10:49:23 +0200
X-Gm-Features: AUfX_mzZ5VVntaqQTXkNA9ZyZBv7tskQ1O8PVS3GKD6wqTDYm43RPc2a0ZiSL7o
Message-ID: <CAJaqyWcSeXW_vdP03-oTXp5uO8vNBg224LDgyCn3QrXhuJ6tHw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: OJxe143PrLq0eARhuoxzUJ5NvrtE8RVCl-4h6656H14_1784710200
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 8:24=E2=80=AFAM Manos Pitsidianakis
<manos@pitsidianak.is> wrote:
>
> Ping.
>
> I have a different version of the series WIP with a virtio-rng instead
> of virtio-rtc, based on
> https://lore.kernel.org/lkml/20260529-rust-hw_random-virtio-rng-v1-0-b315=
3dd90311@pitsidianak.is/
> (which needs a v2 also)
>
> But since this series hasn't gotten any feedback on the virtio part, I'd
> like to ask if there is any before respinning.
>
> Thanks!
>

I also think this will be a great addition, but I have very little
knowledge of Rust. Is it easy to implement the simplest virtio-net
driver using Rust, without CVQ or extra features, so I can test it and
hopefully build features on top? Would it help?

Thanks!

> On Sun, 10 May 2026 16:38, Manos Pitsidianakis <manos@pitsidianak.is> wro=
te:
> >Hi all, this RFC series adds Rust bindings for Virtio drivers
> >(frontends in virtio parlance).
> >
> >As a PoC, it also adds a sample virtio-rtc driver which performs
> >capability discovery through the virtqueue without registering any clock=
.
> >
> >Before I send a cleaned-up non-RFC I would like some initial feedback
> >(i.e. is it something the upstream wants?)
> >
> >This was tested with the rust-vmm vhost-device-rtc device backend that I
> >wrote[^0]:
> >
> >[^0]: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rt=
c
> >
> >Instructions:
> >
> >  Run the daemon in a separate terminal:
> >
> >  $ cargo run --bin vhost-device-rtc -- -s /tmp/rtc.sock
> >
> >  Then run the VM:
> >
> >  $ qemu-system-aarch64 \
> >    -machine type=3Dvirt,virtualization=3Doff,acpi=3Don \
> >    -cpu host \
> >    -smp 8 \
> >    -accel kvm \
> >    -drive if=3Dvirtio,format=3Dqcow2,file=3D./debian-13-nocloud-arm64-d=
aily.qcow2 \
> >    -device virtio-net-pci,netdev=3Dunet \
> >    -device virtio-scsi-pci \
> >    -serial mon:stdio \
> >    -m 8192 \
> >    -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \
> >    -numa node,memdev=3Dmem \
> >    -display none \
> >    -vga none \
> >    -kernel /path/to/linux/build/arch/arm64/boot/Image \
> >    -device vhost-user-test-device,chardev=3Drtc,id=3Drtc,virtio-id=3D17=
,num_vqs=3D2,vq_size=3D1024 \
> >    -chardev socket,path=3D/tmp/rtc.sock,id=3Drtc \
> >    ...
> >
> >  Example output:
> >    [    1.105238] rust_virtio_rtc: Probe Rust virtio driver sample.
> >    [    1.105645] rust_virtio_rtc: Found 1 vqs.
> >    [    1.136050] rust_virtio_rtc: process_requestq got buf 16 bytes
> >    [    1.136125] rust_virtio_rtc: Got response! Ok(RespCfg { head: Req=
Head { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, num_clocks: Le16(=
3), reserved: [0, 0, 0, 0, 0, 0] })
> >    [    1.136701] rust_virtio_rtc: Got response! Ok(RespClockCap { head=
: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: =
3, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
> >    [    1.136724] rust_virtio_rtc virtio0: cannot expose clock 0 (type =
3, variant 0, flags 0) to userspace
> >    [    1.137259] rust_virtio_rtc: Got response! Ok(RespRead { head: Re=
qHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: L=
e64(1777890485031060388) })
> >    [    1.137277] rust_virtio_rtc: #0 clock reading =3D 177789048503106=
0388
> >    [    1.137749] rust_virtio_rtc: Got response! Ok(RespClockCap { head=
: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: =
1, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
> >    [    1.137769] rust_virtio_rtc virtio0: cannot expose clock 1 (type =
1, variant 0, flags 0) to userspace
> >    [    1.138247] rust_virtio_rtc: Got response! Ok(RespRead { head: Re=
qHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: L=
e64(1777890485032086075) })
> >    [    1.138264] rust_virtio_rtc: #1 clock reading =3D 177789048503208=
6075
> >    [    1.138730] rust_virtio_rtc: Got response! Ok(RespClockCap { head=
: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: =
2, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
> >    [    1.138751] rust_virtio_rtc virtio0: cannot expose clock 2 (type =
2, variant 0, flags 0) to userspace
> >    [    1.139253] rust_virtio_rtc: Got response! Ok(RespRead { head: Re=
qHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: L=
e64(338567896865557) })
> >    [    1.139270] rust_virtio_rtc: #2 clock reading =3D 338567896865557
> >
> >Concerns - Notes - TODOs
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >- Virtqueue lifetimes don't neatly apply to Rust as expected, so a lot
> >  of times we have to go through unsafe pointer dereferences (though
> >  which are guaranteed by Virtio subsystem to be valid, for example when
> >  a callback is called with the vq argument). There's a potential for
> >  misuse and definitely could use better thinking.
> >- `struct virtio_device` is not reference-counted like other implemented
> >  device types in rust/kernel. Maybe we need to change C API first to
> >  make them reference counted, assuming this doesn't break anything?
> >- The sample driver obviously conflicts with the C implementation, so
> >  this would either need to move out of samples/ or figure out some way
> >  to handle this in kbuild.
> >- kernel::virtio module and its types need a few rustdoc examples that I
> >  will add in followup series
> >- Note that the registration of RTC clocks etc in the sample driver is
> >  not done, I'm putting it off until I receive some feedback first. The
> >  sample driver otherwise does send and receive data from the virtqueue
> >  as a PoC.
> >
> >PS: No LLMs used so any mistakes and goofs are solely written by me.
> >
> >Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
> >---
> >Changes in v3:
> >- Removed unused methods from virtio API
> >- Clean up how scattergather lists are added to virtqueues by using
> >  owned SGTables only, and make the API safe(r)
> >- Add RAII cleanup for find_vqs return value that calls del_vqs
> >- Reset device after remove callback
> >- Significantly clean up sample driver as a result of the other cleanups
> >- Link to v2: https://lore.kernel.org/r/20260509-rust-virtio-v2-0-c1e30e=
c2bd21@pitsidianak.is
> >
> >Changes in v2:
> >- Move helper ifdefs to helper file (thanks Alice)
> >- Changed CONFIG checks to IS_ENABLED to allow for CONFIG_VIRTIO=3Dm
> >- Split all use imports to one item per line according to style guide
> >- Fixed wait_for_completion_interruptible*() rustdocs
> >- Use Jiffy type alias in wait_for_completion_interruptible_timeout()
> >- Pepper and salt #[inline]s wherever appropriate as per style guide
> >- Split probe() into probe() and init() to allow cleaning up if init
> >  fails
> >- Remove unnecessary Send and Sync unsafe impls for
> >  kernel::virtio::Device
> >- Remove unnecessary LeSize and BeSize
> >- Accept Option<_> for virtqueue callback when creating a VirtqueueInfo
> >- Made all vq buffer adding operations unsafe
> >- Use AtomicU16 instead of Cell<u16> for sample virtio driver
> >- Fix RespHead field types in sample virtio driver
> >- Fix response error checking in sample virtio driver
> >- Change some device contexts in method signatures
> >- Link to v1: https://lore.kernel.org/r/20260505-rust-virtio-v1-0-956338=
3909e4@pitsidianak.is
> >
> >---
> >Manos Pitsidianakis (6):
> >      rust/bindings: generate virtio bindings
> >      rust/helpers: add virtio.c
> >      rust/kernel/device: return parent at same context
> >      rust: add virtio module
> >      rust: impl interruptible waits for Completion
> >      samples/rust: Add sample virtio-rtc driver [WIP]
> >
> > MAINTAINERS                     |   9 +
> > rust/bindings/bindings_helper.h |   5 +
> > rust/helpers/helpers.c          |   1 +
> > rust/helpers/virtio.c           |  37 ++++
> > rust/kernel/device.rs           |   2 +-
> > rust/kernel/lib.rs              |   2 +
> > rust/kernel/sync/completion.rs  |  42 +++-
> > rust/kernel/virtio.rs           | 423 +++++++++++++++++++++++++++++++++=
+++++++
> > rust/kernel/virtio/utils.rs     |  57 ++++++
> > rust/kernel/virtio/virtqueue.rs | 314 +++++++++++++++++++++++++++++
> > samples/rust/Kconfig            |  15 ++
> > samples/rust/Makefile           |   1 +
> > samples/rust/rust_virtio_rtc.rs | 403 +++++++++++++++++++++++++++++++++=
+++++
> > 13 files changed, 1309 insertions(+), 2 deletions(-)
> >---
> >base-commit: 028ef9c96e96197026887c0f092424679298aae8
> >change-id: 20260504-rust-virtio-8523b01dfdc2
> >
> >Best regards,
> >--
> >Manos Pitsidianakis <manos@pitsidianak.is>
> >
>
>
> --
>
> foo
>

