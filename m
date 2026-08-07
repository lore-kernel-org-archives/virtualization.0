Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFDF397958
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113060; cv=none; b=YpHUQKe2qez/gNky8wpGhZD1ZJ1GGcgmAYRU6C/KMVtUNsEMnyMGy43/tGZUhckwiAF3yU24nXmUw8f9ykzSfNJBQnSxPEjnVcCsDG+OhdCzM1BQO+YHtHu21VRbmDCuNTmzOCGf0bMvcFuPcUWyeb5zWE1ZZSetZQi6jn4RdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113060; c=relaxed/simple;
	bh=tVuSkY0xPbMMsGFxv/7unewREw1TqcSDwzB4R9zosBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NaYh+uUcdpjlx3KxQ62Z/uEgbdfH5+n4/0VYI77J/gQNDkAI9G5cbGRNQIJTdvH3iVUTpB0O2iFhGwLb8tKCVFM7t86DwncGxIuFfKxPvuRFuvmyhE7TiI1QqJj+Pp4KbrLsQK6+X1vIGvQ55BDhF/MplMMXubiPutGAtfAQ9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JY0ZwKPB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JY0ZwKPB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786113057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMjryR7yNkqYmQYfty4PMZSrSilWhqUJMkwdU7e559U=;
	b=JY0ZwKPBu9yuxC78OWXJAsaDMT7nRMslUzGiBLxHhkTmxfy9Z8qG4OlEfItcWVrPXCQu0X
	T1pUau7t5OKRsN2xcO6XR4feexGPnnC87WbvwGopMauJh6QWYxDjSEwdyCrqGsBJvYbq24
	2LpDt+ZOEb3NJuB757gsRLzx0lPRqOk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-9vkpy-cbNp-itM9M_JemsQ-1; Fri, 07 Aug 2026 10:30:51 -0400
X-MC-Unique: 9vkpy-cbNp-itM9M_JemsQ-1
X-Mimecast-MFC-AGG-ID: 9vkpy-cbNp-itM9M_JemsQ_1786113050
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so24135815e9.2
        for <virtualization@lists.linux.dev>; Fri, 07 Aug 2026 07:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113050; x=1786717850;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMjryR7yNkqYmQYfty4PMZSrSilWhqUJMkwdU7e559U=;
        b=eREuqZ462NeBwIhGujBk6F2UpQ0PAB8Q5dSS6WoxzDKaQrv0DexZYHeLgdTQ7ruqBc
         PFlts8YbymGmqlG6uAfkPDiHimFvKk8+zIjcqDxIq9bDrv0p5UDRmWyy7Eg03yUUNVwZ
         ZIy2mpUtbaIbi2/RQ0DZCZiIDZkFdXZYfmSOZYEju9GSHO5/yTYRvvxF0Wh6NGUfYD13
         ss/6LUax3qIb6zJHI9tlIMU3NZuiQWeB35zP+juSDCDtr2WaxC3bitr5kYhxK7HkvIR8
         nnBFWAOfpES7TKOQH0w6m3Qhze2VUMR6aOlYjydjWb8vE1rJ7jrOHyG2+ypqQj2fsFCk
         XuYw==
X-Forwarded-Encrypted: i=1; AHgh+Rox2HK2fjgIOXPCHVfAxyXLU+MCuuXXtc/VVxYfbKvlF1l61p2e97MubruDKIMNzQNerg6/J3KhlHrY0U9lTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwA1K1yhggh0KqFJnDcRnVmgBJ4n4fIifzGIIF95SZ0kIfSAoa2
	MLnSogmj7Rr5o+Ske1aPeqZ57YHKYray8T80CuAU4Q55UhXOPsEumDjvF7vzzlAUp1gmDZP7l/0
	/e3fOwpcCi25q9k8qksJjOILCG6rrF4NU4XEAg/hz6EfO73MmRnDxaZWp+yNguI1kIHIa
X-Gm-Gg: AR+sD136TY5cycqY3+lf1E7zRNnjaDA7c3dK5JodLk8mUCI6aBbc/skdei13Tde4803
	du0eIMgCHZMf9pr5yqQCx+sBcHWpn7OF552/GVEwjQlIHvWY3BrgqWjVtH2jPH4Q7HDcMfrrotH
	ymeoHlI47DtGPwr5puIahQh8gAC5DbBzJKDphCJ9Ydq0FLdGQtanzajVHJpsVXOvk8QBG9oE82I
	/TfFBi3lhOEnSg8ALNYTZLIN7ngJedwDCb6sim/0aXI1HCpNGkiZ4cHi0wOBq8+J93+FyGLOQ9B
	c2N2clMX3w0i8TN+GpwKx11orvmVfFup8nEuOFTa5H23MkPcMkujgk+dA0IjKUZI1arVj94LYK7
	vZA==
X-Received: by 2002:a05:600c:242:b0:493:c845:bc20 with SMTP id 5b1f17b1804b1-49959e0174cmr108314565e9.4.1786113049547;
        Fri, 07 Aug 2026 07:30:49 -0700 (PDT)
X-Received: by 2002:a05:600c:242:b0:493:c845:bc20 with SMTP id 5b1f17b1804b1-49959e0174cmr108313685e9.4.1786113048985;
        Fri, 07 Aug 2026 07:30:48 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.96.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995d85254asm26377695e9.1.2026.08.07.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:30:47 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:30:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Manos Pitsidianakis <manos@pitsidianak.is>, 
	Matteo Giugni <m.giugni1@studenti.unipi.it>, German Maglione <gmaglione@redhat.com>, 
	Leonardo Giovannoni <leonardo.giovannoni@ing.unipi.it>, Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
Cc: Miguel Ojeda <ojeda@kernel.org>, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Peter Hilber <peter.hilber@oss.qualcomm.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/6] Add Rust virtio bindings and sample device
Message-ID: <anXnRcX65PnfMe9W@sgarzare-redhat>
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EnjkU4uUqWr5XlId37m0dfTL9UxVuQA62EUBFskNElU_1786113050
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, May 10, 2026 at 04:38:13PM +0300, Manos Pitsidianakis wrote:
>Hi all, this RFC series adds Rust bindings for Virtio drivers
>(frontends in virtio parlance).
>
>As a PoC, it also adds a sample virtio-rtc driver which performs
>capability discovery through the virtqueue without registering any clock.
>
>Before I send a cleaned-up non-RFC I would like some initial feedback
>(i.e. is it something the upstream wants?)

I had a quick look, I commented something, but maybe you already planned 
to fix some of them in the final version.

That said, overall it seems a great starting point, and I can help with 
the effort of maintaining it.

I had some issues building the rust virtio rtc driver, it seems bindgen 
0.71.1 I had installed have some issues with clang 22, upgrading bindgen 
to 0.72 fixed all the issues.

>
>This was tested with the rust-vmm vhost-device-rtc device backend that I
>wrote[^0]:
>
>[^0]: 
>https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rtc
>
>Instructions:
>
>  Run the daemon in a separate terminal:
>
>  $ cargo run --bin vhost-device-rtc -- -s /tmp/rtc.sock
>
>  Then run the VM:
>
>  $ qemu-system-aarch64 \
>    -machine type=virt,virtualization=off,acpi=on \
>    -cpu host \
>    -smp 8 \
>    -accel kvm \
>    -drive if=virtio,format=qcow2,file=./debian-13-nocloud-arm64-daily.qcow2 \
>    -device virtio-net-pci,netdev=unet \
>    -device virtio-scsi-pci \
>    -serial mon:stdio \
>    -m 8192 \
>    -object memory-backend-memfd,id=mem,size=8G,share=on \
>    -numa node,memdev=mem \
>    -display none \
>    -vga none \
>    -kernel /path/to/linux/build/arch/arm64/boot/Image \
>    -device vhost-user-test-device,chardev=rtc,id=rtc,virtio-id=17,num_vqs=2,vq_size=1024 \
>    -chardev socket,path=/tmp/rtc.sock,id=rtc \
>    ...
>
>  Example output:
>    [    1.105238] rust_virtio_rtc: Probe Rust virtio driver sample.
>    [    1.105645] rust_virtio_rtc: Found 1 vqs.
>    [    1.136050] rust_virtio_rtc: process_requestq got buf 16 bytes
>    [    1.136125] rust_virtio_rtc: Got response! Ok(RespCfg { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, num_clocks: Le16(3), reserved: [0, 0, 0, 0, 0, 0] })
>    [    1.136701] rust_virtio_rtc: Got response! Ok(RespClockCap { 
>    head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, 
>    clock_type: 3, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 
>    0, 0, 0] })
>    [    1.136724] rust_virtio_rtc virtio0: cannot expose clock 0 (type 3, variant 0, flags 0) to userspace
>    [    1.137259] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(1777890485031060388) })
>    [    1.137277] rust_virtio_rtc: #0 clock reading = 
>    1777890485031060388
>    [    1.137749] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 1, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
>    [    1.137769] rust_virtio_rtc virtio0: cannot expose clock 1 (type 1, variant 0, flags 0) to userspace
>    [    1.138247] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(1777890485032086075) })
>    [    1.138264] rust_virtio_rtc: #1 clock reading = 1777890485032086075
>    [    1.138730] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 2, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
>    [    1.138751] rust_virtio_rtc virtio0: cannot expose clock 2 (type 2, variant 0, flags 0) to userspace
>    [    1.139253] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(338567896865557) })
>    [    1.139270] rust_virtio_rtc: #2 clock reading = 338567896865557
>
>Concerns - Notes - TODOs
>========================
>
>- Virtqueue lifetimes don't neatly apply to Rust as expected, so a lot
>  of times we have to go through unsafe pointer dereferences (though
>  which are guaranteed by Virtio subsystem to be valid, for example 
>  when
>  a callback is called with the vq argument). There's a potential for
>  misuse and definitely could use better thinking.

Yeah, I see, I guess we can work on this as next step.
I'm CCing Matteo, German, Giuseppe, and Leonardo.

We are mentoring Matteo who is working on his Master thesis at University 
of Pisa. His main effort is to provide crates for virtio drivers (e.g.  
virtqueue, driver-specific request/reply processing, etc.) that can be 
generic enough to be used in different OSes, providing the right 
abstraction.

We pointed out to this series and he would like to collaborate.
Matteo and others can add more on this of course :-)

Feel free to continue in-list or off-list for sync.

>- `struct virtio_device` is not reference-counted like other implemented
>  device types in rust/kernel. Maybe we need to change C API first to
>  make them reference counted, assuming this doesn't break anything?

Good point.

>- The sample driver obviously conflicts with the C implementation, so
>  this would either need to move out of samples/ or figure out some way
>  to handle this in kbuild.

I think we need to discuss this with MST, but IMO we should try the path 
of replacing the C version with this (when we feel confident).

>- kernel::virtio module and its types need a few rustdoc examples that I
>  will add in followup series

Agree.

Thanks,
Stefano

