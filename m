Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624378;
	b=qn3Hmvtm+ggy1v2eMAjIOa6T+lppyvDUofI34VHab98+kFaYVpfaS2VBFF8+D9xmAU6K
	 OToyEE3hhCpje+v/5GwUippm0bpQT9HiUWmhMV1Zwa7TmVUK6+lor2SXULliIaZnwV0SX
	 Vu/RTebJ6zwoQ7bNV+U3WyhS5+5Bu9UnYZgGl4CObgUKyhAlL/XSnqpOKxkwtn32l9Da5
	 r+aRAEccLHaXTsGMgWCmzFDYjkvQppCkxViGH161YRjMGavbJnkZajyWNF05NZ1XJtH2X
	 wCjsmr4SyfkZ3rhDhxupKyN0DlNcBxZ/hX58f+AUFmXL8G+8SmIlzFjNFBevep8xO0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624378;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=0QU938YZmI+90ta4rBgGtrqwO0xO5MqL3TKangYRrrc=;
	b=U/x/SIJWUrEh4rZEmCsaE3i5hOzngdk73G4fUSPnzH5YAoXS8UTXUPkvY7vJhMdgWNke
	 R+kd037g9MLV59pm9rb4YU4VwQelvUHnmpgh361TklNICo9FW3mUmPZ+5inAmWkJNzO1B
	 x+EGFxF3KQkcwPHK2GgaKZ87Makiy6Tfa9EHVereP+r11FPMml41h9f8VzIElk9bOXvjH
	 ztXJckeVmRRDBYQJAdTTX0ClhbXFxhB8BFc/2KOhcvq8Rg2rhzA5GSes8G2Btls2pDikg
	 dpceuWqHYDvadsXHgJRSHZeiLA7xn3lmyyCYBa61nf9+Bb0pF5mv3v2auYJTMGCgIIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LPRwauEu;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8201A606A326
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 12:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8201A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LPRwauEu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793624376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0QU938YZmI+90ta4rBgGtrqwO0xO5MqL3TKangYRrrc=;
	b=LPRwauEuzRlS4gQKnvwQJBFGoaEZTcQb9/XGnN/inlVZhHnLyUKtkm7BsBj/ozDzNsubwC
	MBBGBGsS9VTkobQULKBP7AFuJTVPVhAUJrJ751g4fW41+447FCpp3QVSHbXUYBzVfWrfbv
	IQtKSLZv3qd+XMu8a0vO7cwS79Dw6lk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-sB94qpAaOjKlEx1tNMKZFA-1; Mon, 02 Nov 2026 07:59:35 -0500
X-MC-Unique: sB94qpAaOjKlEx1tNMKZFA-1
X-Mimecast-MFC-AGG-ID: sB94qpAaOjKlEx1tNMKZFA_1793624374
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48df02b91f9so2833163f8f.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 04:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624374; x=1794229174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QU938YZmI+90ta4rBgGtrqwO0xO5MqL3TKangYRrrc=;
        b=vrYH+1nuc33U0M9RGyW1BvxIUmpKQ2z1PzQ05PFFaaxWEB29saSyEzyXgcGg/VtPmC
         9uoUNL+Xz25Rt05ohl3+Sk/E7zAHc8mXqBscABn1/NGiljDY5LNtm3l/7hLFViD/7hpl
         QMwWGvmzfdnAhSFXWQc01nuKEfTF566f8zXI54er8bl5D8BZnQwB3YXpra4Ph3QRQV0j
         hh7/80hGAk+OmN3SdUqj/T6IQstT7MIr3Sl1QY6bw22YetDVjSN6yISAuibQ9HTFMrqA
         kRC0kpQzaCOqdFfYJnbUZV6NCyTgwUIh19nDuuKF51yXjtm9KJf6OLl2On10lVp2imlA
         lMfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzs2sJ0FT456o0o7qmsgKsYuwwq553AwM2TIw88tBzx+adKjv0wIzDF8AgJpAJsOCf6n5aJ+V1AgGRkf3vTBA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/CqhjGThEeknJTxM5N/9sp8KFVVpWVsJekcCoF3wj9GWWRkJnG
	uETG5ybEnuXxGNoGjUcSqNe7rKvu3LY4RyGcMUZBTZwKzCQDMl1QDA/T+UbYldUkXnrixfSgRRA
	Rh17sgwORdBRWTfsn2wur3EQUwOOSROD6y0ZjGgy6tCKHq5ybw5hQLhVMvG1nOhvX+5tu
X-Gm-Gg: AYBFou2Dq5d5yQouMV4IaHVvbfGXnLiBhpcx81nQGthdB9FTteaSHyWIWgCXJAH+Hpo
	LuZVKBn0x+bNfCu80dwz6SA2/Hqz8t1h0NBm8JGLDc4hRepYI5tzt5Rb1Epch4GH8JD1FhFzrXU
	O1HeHaj5LFt2tBS7pkkhR6/kiGBjqbcAyaqp0xdI8yGbhpeB/OHISx2Y7ZC/8qm0m2ww3PSJ9vX
	D5d1KjO04VkerDfyv+99x7VmYmLaxyd9csAI+hK8RMjltw15u2tv2W0b9mvitknhNtib7lGa6hE
	mGOHqn4tSsRJ8reV1j4l4rycFdbewxttkNhuJQQrW00x33FJbZYRTTQIw6gwpDJHIHmGcHlyIuQ
	oWTDIXOYE0b7izPJB636TpRWy4Rjwx++DyAXvR9DSew==
X-Received: by 2002:a05:6000:4010:b0:48e:55bd:9cdf with SMTP id ffacd0b85a97d-48e6e2dd3a4mr25444607f8f.21.1793624373966;
        Mon, 02 Nov 2026 04:59:33 -0800 (PST)
X-Received: by 2002:a05:6000:4010:b0:48e:55bd:9cdf with SMTP id ffacd0b85a97d-48e6e2dd3a4mr25444547f8f.21.1793624373259;
        Mon, 02 Nov 2026 04:59:33 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7270asm20090543f8f.11.2026.11.02.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:59:32 -0800 (PST)
Date: Mon, 2 Nov 2026 07:59:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stjepan Poljak <stjepan.poljak@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_blk: fit requests to virtqueues without
 indirect descriptors
Message-ID: <20261102075830-mutt-send-email-mst@kernel.org>
References: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t5uQCjVyO9smpNOECzdnXWYxLKlmqr7q4gpBGW7jqr4_1793624374
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 01, 2026 at 05:53:05PM +0100, Stjepan Poljak wrote:
> A virtio-blk device without VIRTIO_RING_F_INDIRECT_DESC needs one ring
> descriptor per segment of a request, plus one for the header and one for
> the status. virtio_blk takes max_segments from the device's seg_max
> without checking that against the size of the virtqueues, so a device
> that offers a seg_max above its queue size minus two gets requests that
> can never be added to the ring. virtqueue_add_split() warns, returns
> -ENOSPC, and the request waits for ring space forever. A virtqueue with
> fewer than three descriptors cannot hold any request, and depending on
> the queue depth the probe then either fails without saying why or hangs
> on the first I/O.


Thanks, I applied
    Message-ID: <20260918135120.1261150-1-sergiiushakov@google.com>
to fix this, as it seemed like a more comprehensive fix.



> I ran into this while writing the virtio-blk device of Hearth, a small
> KVM-based VMM, with queue sizes and seg_max values like these:
> 
>   virtqueue  seg_max  queue_depth  before                    after
>   ---------  -------  -----------  ------------------------  -------------------
>   128        126      default      boots                     boots
>   128        127      default      WARN, hangs loading init  boots, 126 segments
>   128        254      default      WARN, hangs loading init  boots, 126 segments
>   1          -        default      -EINVAL, no reason given  -EINVAL, message
>   1          -        128          WARN, hangs on first I/O  -EINVAL, message
> 
> where the message is "virtqueue size 1 is too small for a request". A
> virtqueue of 2 is rejected the same way, with either queue depth.
> 
> Patch 1 checks the virtqueue sizes in virtblk_probe(), before the queue
> depth is derived from them, and fails the probe with a reason when one
> is too small for a request, whatever the queue depth: the last two rows
> and the virtqueue of 2. Patch 2 then clamps max_segments to the smallest
> virtqueue minus two when indirect descriptors are not negotiated: the
> seg_max rows.
> 
> The seg_max case also reproduces with QEMU, which with seg-max-adjust=off
> offers seg_max 126 whatever the queue size:
> 
>   -device virtio-blk-pci,drive=d0,indirect_desc=off,queue-size=64,seg-max-adjust=off
> 
> Before the series this warns and hangs loading init, after it the guest
> boots with 62 segments. With QEMU's defaults nothing changes.
> 
> The seg_max cases were tested by booting a busybox guest that reads its
> disk with O_DIRECT in 1 MiB blocks, the others by looking at the probe
> messages, on v7.3-19954-gcbbddb6b08cc, x86_64.
> 
> These patches were written with the help of an AI assistant, as the
> Assisted-by tags say. I reviewed and tested them, and I can answer for
> every line.
> 
> Stjepan Poljak (2):
>   virtio_blk: fail the probe when a virtqueue is too small for a request
>   virtio_blk: fit max_segments to the virtqueue without indirect
>     descriptors
> 
>  drivers/block/virtio_blk.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> -- 
> 2.53.0

