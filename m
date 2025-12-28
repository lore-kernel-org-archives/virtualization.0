Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06223875D
	for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766962148; cv=none; b=TQmnnFIG6zCVG728JByZlq+Eqb54CGT76wRLYw0ik7dzRuLRTxDMfqbmh48+NrjfXJol7UvtdJo8ORyLCn4JWgL74s6eQAkgUB2T4PhdhSx2yws6vfOoYnsNIztJYlRX3GLlhrAtOGUAQftZ/eoaImcMs+0M52RRqkZuUJM68Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766962148; c=relaxed/simple;
	bh=7xs7rBHCkEu0qSnjRBBkrDuWcff1dR9koDAyagfZn70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3r2T5Q3AlRKtegKGPOD4wwpodE4wtt7G0woh1dw95xBffFcg2o4fUsejlCPlnOSHAPwze5TbAxF88u4Vxfioz3c5UQQh0zOwTg4WkUSTYTKAT0/MHUtg7t99VMwnDNSuKAAzjDN7aT5vaDAKrDGgnl9PJ6DqQlzoGXFmmNjiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6RMlppH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6RMlppH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c902f6845so12133417a91.2
        for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 14:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766962145; x=1767566945; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnVxB8hHP+UEx+EyrlcIpTFAKkUEwNTCu8Of5uWFpkg=;
        b=X6RMlppHpx4mPjKFNcUHy+XtdMQuXAT8PZ6OdNlbFMEQfD3Eb4lo4VCQGjJy3Yv70p
         ayRo6Vg0jxhdHI3sYBdn2grx+rpyk3EWIXbE/DwEp89q378x4nF56Yfa8LXrMp0VbKAH
         JK4BBTAVCEaZHKGEHn4ZcdLZFkn3Lh0OqE8jf8IvrduXxvCaiBLfCKIdLssI+39CHfZC
         SOHtV+imfaFjRpnh0kIREmk967ZKfEYOKP/VL//xAGy/086WdruJUTKt95cVIU0Y0iZY
         RlrQzj74XNY4imU8t7pdwnJqWvALCjif3AfyrjJCNqECauKSY0tt+PurGvdIzt7R0FNh
         oYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766962145; x=1767566945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnVxB8hHP+UEx+EyrlcIpTFAKkUEwNTCu8Of5uWFpkg=;
        b=V+vwerWKwHVfdmcBwgzeg298vM+gOxnqnij2GL3tnlF29AosIor+JgJqNUd4eV37RA
         WAhGh8FnKaXxZQQnn3v1njHFvN3WhUNupdYLTQJd8Ag0ExG+1UFXFlFL3AyOH48LuyrD
         Krzze78tXDLzMmTZDiTp93yKjIttFLX57L1xXD6gbvk02qAq26OCTwsWFB94xKq4GCGf
         ZaCeKzw8xV0IT9jc5Lx0erriLCILqjOdgsrcdaPnmzzwppHjmLUQvm6Z6xyfZp4ykPWH
         PJenr2hl1XdcUuBvxZEURE8S8HBv67DQ/hm/WaygbGFmTrsHSH9btUdPXbfb0Nh6OeyQ
         l1hg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7eQ2RYo4PvCg3aj5hxLV+iRTUOrJblq5YmHyrF48TtXVIedrRD0JvjvqYUBwjDLdNZX+XREZ80t+854+yQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr4K0EkpZ5rIL0FY4WpL7H00ZdiVZA0zWNoGfqRF95sl9NTr2T
	dQg4vqdIGIZDndrZDUUMzD9bHE2h71nsM3ISPv5TjSzMxIuzDJxAUxmp
X-Gm-Gg: AY/fxX6OGMAtsFYNUAtH/TqfaQBFC1mAuYJYeTOjULAgcqZEjLVag2QvknKllTlYOMq
	Ixx8dXwjIyVbTbsxBHrnuix8kfogjjsDeKTnxQcWABJYHUDjwWh6JS4pqEckTJfJ4kAHABxsjkP
	Ok0FMT4xG636TEeXl+FP8n58O4BDAd/RFBjjJQ9atNscHQISdugoOq6wrxbmlomBH072pi1EIuf
	VxYP/CAVSrVGYXZ3MxTlGdfY85sGI5eEH8pScL09cOy6HcAMDPMEBdFSWRZmvHgb+zJ/OTatbkt
	A0urdh30lfW6ZZ/6mp9RTJ+e43+ONboVocPSdREES+/QcHvrpxDc2V66AYx5bptu5OPlTPGFdda
	Il5n5wbM+QMaDpD1Vtrya5wS0nahv8VOQLZW+DvCpz+aJ9DkJcP3mfldP1qvUeBnmwd03X/u/yI
	5sl4g/+e+Z2o8j72k0
X-Google-Smtp-Source: AGHT+IFrZ0jqqyfa4w9leqRMWpvEB4wvR96T1u2WwgRjWIQZDJOokmhOcBM1uE4s/VnzQJrZGEFtuA==
X-Received: by 2002:a05:7022:4284:b0:11b:9386:7ed3 with SMTP id a92af1059eb24-1217230b84amr31429073c88.48.1766962145520;
        Sun, 28 Dec 2025 14:49:05 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:79af:1f76:2f9:193d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm83886095c88.10.2025.12.28.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 14:49:04 -0800 (PST)
Date: Sun, 28 Dec 2025 14:49:03 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Cong Wang <cwang@multikernel.io>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [Patch net] vsock: fix DMA cacheline overlap warning using
 coherent memory
Message-ID: <aVGz39EoF5ScJfIP@pop-os.localdomain>
References: <20251228015451.1253271-1-xiyou.wangcong@gmail.com>
 <20251228104521-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228104521-mutt-send-email-mst@kernel.org>

On Sun, Dec 28, 2025 at 02:31:36PM -0500, Michael S. Tsirkin wrote:
> On Sat, Dec 27, 2025 at 05:54:51PM -0800, Cong Wang wrote:
> > From: Cong Wang <cwang@multikernel.io>
> > 
> > The virtio-vsock driver triggers a DMA debug warning during probe:
> > 
[...]
> > This occurs because event_list[8] contains 8 struct virtio_vsock_event
> > entries, each only 4 bytes (__le32 id). When virtio_vsock_event_fill()
> > creates DMA mappings for all 8 events via virtqueue_add_inbuf(), these
> > 32 bytes all fit within a single 64-byte cacheline.
> > 
> > The DMA debug subsystem warns about this because multiple DMA_FROM_DEVICE
> > mappings within the same cacheline can cause data corruption: if the CPU
> > writes to one event while the device is writing another event in the same
> > cacheline, the CPU cache writeback could overwrite device data.
> 
> But the CPU never writes into one of these, or did I miss anything?
> 
> The real issue is other data in the same cache line?

You are right, it is misleading.

The CPU never writes to the event buffers themselves, it only reads them
after the device writes. The problem is other struct fields in the same
cacheline.

I will update the commit message.

> 
> You want virtqueue_map_alloc_coherent/virtqueue_map_free_coherent
> methinks.
> 
> Then you can use normal inbuf/outbut and not muck around with premapped.
> 
> 
> I prefer keeping fancy premapped APIs for perf sensitive code,
> let virtio manage DMA API otherwise.

Yes, I was not aware of these API's, they are indeed better than using
DMA API's directly.

Thanks!
Cong
