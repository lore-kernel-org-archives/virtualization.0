Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C63397343
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711090; cv=none; b=ucNrsvAeCe6+LhDFqOCKWpXvzt9ARKF7L4qhHWspR/D4yYKrwpJ/vZAV9zU6TTkXremqECI2v8fm4Gj+BxP1/7NmaOBWEkuWx8OvdY2yX6sEt/3N+97H74jmzGb/QumgDImnDt+ppuURxKIHFH57/wN5xfTSclBIBPhZWTAPQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711090; c=relaxed/simple;
	bh=nLONFvR+hxddFQZ/FVj8V6OR3cXh5kdwnHjhpOXWcvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PH0wZ2RQ0y+qOrK7v8Oh3/16aMrRfFAIGI02v+ylGEwt04xAhWE/QDrbac+hHwtcRHyhO8BMCCBZdSCUl0E3B1E/kebERANVg6dwqUuYYd6VvFqhsyYbn5blhkXAbpGrgivCLepFkBkdbYUO4T0h/Q36Gi8hqG5y3rF4ol1EJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=sz9NSR/i; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="sz9NSR/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1784711078;
	bh=nLONFvR+hxddFQZ/FVj8V6OR3cXh5kdwnHjhpOXWcvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
	b=sz9NSR/i+NOilUL0upXbf1ZeMum/0hNILnqoQICHbxSyD8FZID9bLsEUmbHCxYIRi
	 79RKfQZwo8DtkIcawo2akDduhkXuDvUnPpEK6SPSlyJNr9ZeTv+KQRW9Xr30/rll++
	 lS79qEp3gg6qLiHslV92FLWovie83D7nRM8/CN6GJfJg+t4ZCz+OmhVUP8YAFh9vSm
	 YEuXdOn0X6O0rfk3yqfY7MVdv2NIgjf94TcUbRXrAFkEdWYF18gPrLs1u9Ufjamr0e
	 pWrozlj5YjU/bUIOfb69ov0qZCTn/67iphEvdd4foX0pnZbSZ8NIOTswpwX/rClRO+
	 b3odD/2uXCyD8TbZoOKrSx3Kf8xucAVYpyzwmf7XYjdcaTB4HUEfNBusS3Un7i6G3w
	 ndJogMUYpFOowTx7mkL95kMNEUvg0s1LGq7TIh4gH+ECyQAJbz4XsQqar6LpFi3h7/
	 5FDkaqHk0ZZX8LNekBsm112kiegRLjnAod4AGvZWxJWl0ZkSt33BH3rG2JcAlSdI0k
	 R6UVJ4ZW/h6jReIBtqA0P3VKwFKcWAsmQP8onOsXCxU47p5sAJ+QcFXHj9zJe7G9Yj
	 walefsGfJeyy4vcU2BjNosn+NX4hw8EFJtfMt89YhZ/OTgg/8jmWPXEfFOlOMfoB9R
	 52tiMLSeGBlqr0JRmxqM5/Tc=
Date: Wed, 22 Jul 2026 11:55:57 +0300
From: Manos Pitsidianakis <manos@pitsidianak.is>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Peter Hilber <peter.hilber@oss.qualcomm.com>, Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Bj=?UTF-8?B?w7Zybg==?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/6] Add Rust virtio bindings and sample device
User-Agent: meli/0.8.13
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is> <tiiht3.22qk83rct1pd@pitsidianak.is> <CAJaqyWcSeXW_vdP03-oTXp5uO8vNBg224LDgyCn3QrXhuJ6tHw@mail.gmail.com>
In-Reply-To: <CAJaqyWcSeXW_vdP03-oTXp5uO8vNBg224LDgyCn3QrXhuJ6tHw@mail.gmail.com>
Message-ID: <tikjvp.3n7sct2j96lcx@pitsidianak.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

Hi Eugenio,

On Wed, 22 Jul 2026 11:49, Eugenio Perez Martin <eperezma@redhat.com> wrote:
>On Tue, Jul 21, 2026 at 8:24 AM Manos Pitsidianakis
><manos@pitsidianak.is> wrote:
>>
>> Ping.
>>
>> I have a different version of the series WIP with a virtio-rng instead
>> of virtio-rtc, based on
>> https://lore.kernel.org/lkml/20260529-rust-hw_random-virtio-rng-v1-0-b3153dd90311@pitsidianak.is/
>> (which needs a v2 also)
>>
>> But since this series hasn't gotten any feedback on the virtio part, I'd
>> like to ask if there is any before respinning.
>>
>> Thanks!
>>
>
>I also think this will be a great addition, but I have very little
>knowledge of Rust. Is it easy to implement the simplest virtio-net
>driver using Rust, without CVQ or extra features, so I can test it and
>hopefully build features on top? Would it help?

I think so, however it would not be upstreamable right away since (I 
think) there are no netdev Rust bindings and abstractions yet. I will 
take a look when I have the time...

(This is something I am also interested in because I'm working on a 
different kind of network device)

You can definitely play with the sample driver included in this series 
however!

Manos


>
>Thanks!
>
>> On Sun, 10 May 2026 16:38, Manos Pitsidianakis <manos@pitsidianak.is> wrote:
>> >Hi all, this RFC series adds Rust bindings for Virtio drivers
>> >(frontends in virtio parlance).
>> >
>> >As a PoC, it also adds a sample virtio-rtc driver which performs
>> >capability discovery through the virtqueue without registering any clock.
>> >
>> >Before I send a cleaned-up non-RFC I would like some initial feedback
>> >(i.e. is it something the upstream wants?)
>> >
>> >This was tested with the rust-vmm vhost-device-rtc device backend that I
>> >wrote[^0]:
>> >
>> >[^0]: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rtc
>> >
>> >Instructions:
>> >
>> >  Run the daemon in a separate terminal:
>> >
>> >  $ cargo run --bin vhost-device-rtc -- -s /tmp/rtc.sock
>> >
>> >  Then run the VM:
>> >
>> >  $ qemu-system-aarch64 \
>> >    -machine type=virt,virtualization=off,acpi=on \
>> >    -cpu host \
>> >    -smp 8 \
>> >    -accel kvm \
>> >    -drive if=virtio,format=qcow2,file=./debian-13-nocloud-arm64-daily.qcow2 \
>> >    -device virtio-net-pci,netdev=unet \
>> >    -device virtio-scsi-pci \
>> >    -serial mon:stdio \
>> >    -m 8192 \
>> >    -object memory-backend-memfd,id=mem,size=8G,share=on \
>> >    -numa node,memdev=mem \
>> >    -display none \
>> >    -vga none \
>> >    -kernel /path/to/linux/build/arch/arm64/boot/Image \
>> >    -device vhost-user-test-device,chardev=rtc,id=rtc,virtio-id=17,num_vqs=2,vq_size=1024 \
>> >    -chardev socket,path=/tmp/rtc.sock,id=rtc \
>> >    ...
>> >
>> >  Example output:
>> >    [    1.105238] rust_virtio_rtc: Probe Rust virtio driver sample.
>> >    [    1.105645] rust_virtio_rtc: Found 1 vqs.
>> >    [    1.136050] rust_virtio_rtc: process_requestq got buf 16 bytes
>> >    [    1.136125] rust_virtio_rtc: Got response! Ok(RespCfg { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, num_clocks: Le16(3), reserved: [0, 0, 0, 0, 0, 0] })
>> >    [    1.136701] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 3, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
>> >    [    1.136724] rust_virtio_rtc virtio0: cannot expose clock 0 (type 3, variant 0, flags 0) to userspace
>> >    [    1.137259] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(1777890485031060388) })
>> >    [    1.137277] rust_virtio_rtc: #0 clock reading = 1777890485031060388
>> >    [    1.137749] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 1, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
>> >    [    1.137769] rust_virtio_rtc virtio0: cannot expose clock 1 (type 1, variant 0, flags 0) to userspace
>> >    [    1.138247] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(1777890485032086075) })
>> >    [    1.138264] rust_virtio_rtc: #1 clock reading = 1777890485032086075
>> >    [    1.138730] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 2, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
>> >    [    1.138751] rust_virtio_rtc virtio0: cannot expose clock 2 (type 2, variant 0, flags 0) to userspace
>> >    [    1.139253] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(338567896865557) })
>> >    [    1.139270] rust_virtio_rtc: #2 clock reading = 338567896865557
>> >
>> >Concerns - Notes - TODOs
>> >========================
>> >
>> >- Virtqueue lifetimes don't neatly apply to Rust as expected, so a lot
>> >  of times we have to go through unsafe pointer dereferences (though
>> >  which are guaranteed by Virtio subsystem to be valid, for example when
>> >  a callback is called with the vq argument). There's a potential for
>> >  misuse and definitely could use better thinking.
>> >- `struct virtio_device` is not reference-counted like other implemented
>> >  device types in rust/kernel. Maybe we need to change C API first to
>> >  make them reference counted, assuming this doesn't break anything?
>> >- The sample driver obviously conflicts with the C implementation, so
>> >  this would either need to move out of samples/ or figure out some way
>> >  to handle this in kbuild.
>> >- kernel::virtio module and its types need a few rustdoc examples that I
>> >  will add in followup series
>> >- Note that the registration of RTC clocks etc in the sample driver is
>> >  not done, I'm putting it off until I receive some feedback first. The
>> >  sample driver otherwise does send and receive data from the virtqueue
>> >  as a PoC.
>> >
>> >PS: No LLMs used so any mistakes and goofs are solely written by me.
>> >
>> >Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
>> >---
>> >Changes in v3:
>> >- Removed unused methods from virtio API
>> >- Clean up how scattergather lists are added to virtqueues by using
>> >  owned SGTables only, and make the API safe(r)
>> >- Add RAII cleanup for find_vqs return value that calls del_vqs
>> >- Reset device after remove callback
>> >- Significantly clean up sample driver as a result of the other cleanups
>> >- Link to v2: https://lore.kernel.org/r/20260509-rust-virtio-v2-0-c1e30ec2bd21@pitsidianak.is
>> >
>> >Changes in v2:
>> >- Move helper ifdefs to helper file (thanks Alice)
>> >- Changed CONFIG checks to IS_ENABLED to allow for CONFIG_VIRTIO=m
>> >- Split all use imports to one item per line according to style guide
>> >- Fixed wait_for_completion_interruptible*() rustdocs
>> >- Use Jiffy type alias in wait_for_completion_interruptible_timeout()
>> >- Pepper and salt #[inline]s wherever appropriate as per style guide
>> >- Split probe() into probe() and init() to allow cleaning up if init
>> >  fails
>> >- Remove unnecessary Send and Sync unsafe impls for
>> >  kernel::virtio::Device
>> >- Remove unnecessary LeSize and BeSize
>> >- Accept Option<_> for virtqueue callback when creating a VirtqueueInfo
>> >- Made all vq buffer adding operations unsafe
>> >- Use AtomicU16 instead of Cell<u16> for sample virtio driver
>> >- Fix RespHead field types in sample virtio driver
>> >- Fix response error checking in sample virtio driver
>> >- Change some device contexts in method signatures
>> >- Link to v1: https://lore.kernel.org/r/20260505-rust-virtio-v1-0-9563383909e4@pitsidianak.is
>> >
>> >---
>> >Manos Pitsidianakis (6):
>> >      rust/bindings: generate virtio bindings
>> >      rust/helpers: add virtio.c
>> >      rust/kernel/device: return parent at same context
>> >      rust: add virtio module
>> >      rust: impl interruptible waits for Completion
>> >      samples/rust: Add sample virtio-rtc driver [WIP]
>> >
>> > MAINTAINERS                     |   9 +
>> > rust/bindings/bindings_helper.h |   5 +
>> > rust/helpers/helpers.c          |   1 +
>> > rust/helpers/virtio.c           |  37 ++++
>> > rust/kernel/device.rs           |   2 +-
>> > rust/kernel/lib.rs              |   2 +
>> > rust/kernel/sync/completion.rs  |  42 +++-
>> > rust/kernel/virtio.rs           | 423 ++++++++++++++++++++++++++++++++++++++++
>> > rust/kernel/virtio/utils.rs     |  57 ++++++
>> > rust/kernel/virtio/virtqueue.rs | 314 +++++++++++++++++++++++++++++
>> > samples/rust/Kconfig            |  15 ++
>> > samples/rust/Makefile           |   1 +
>> > samples/rust/rust_virtio_rtc.rs | 403 ++++++++++++++++++++++++++++++++++++++
>> > 13 files changed, 1309 insertions(+), 2 deletions(-)
>> >---
>> >base-commit: 028ef9c96e96197026887c0f092424679298aae8
>> >change-id: 20260504-rust-virtio-8523b01dfdc2
>> >
>> >Best regards,
>> >--
>> >Manos Pitsidianakis <manos@pitsidianak.is>
>> >
