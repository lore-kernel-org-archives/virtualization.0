Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A11204681
	for <virtualization@lists.linux.dev>; Tue, 25 Mar 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890491; cv=none; b=M3kXHyza4MjFhhKJOn/lY0IEI5GDK4rFU7CVCJvg/2L8j05uT4MuShF36nC0p6rTYBIWaG8L3dm/ykrA/lpT4Ez6e4Wv7JiA+qTzBzLF793FNaCYFvpOKDmjcW7s0IK10JWooDSgMs2v69d0c260bBJ6fc589dWgulGuEYyTv8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890491; c=relaxed/simple;
	bh=ltivJF64SSk4I6uvhklyPDUN85qLH92F3LeDnTLLN7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k5WDtZzqbPqbcIydVM34ZFnHdRCBd+l+LK4ZwKo6ApJDUVIQBNbgooeZDpw1jD+O07YpWuodVZ+Z1csLUYSSWYjB/MSC3YOE+e4y134xzo8UvAM+G+50qk1rjrb60zEPOhOtnDy/ZOllo9rN1dyeLPJNPjHDerD/KBGI5VN0n3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkwSXaA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkwSXaA3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742890488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziIO7gqQIRwTQc7WQaTagZxoA1eVxh2k/2C5JLipzwk=;
	b=PkwSXaA3IwnVNyNLXCWCTFEdYnucv4KIhmYbuvw9gSfZJtp54z+xN/H66wVo6XzcNonFmT
	nMhPHzxeppQ4RqTTY79W4T1MYAfYAcGBZVUQ7G+7QQAxgFu/lF+lc+aGJowVa1w7nHqhBl
	VfHddHDBSIMhiyhw0mD+H3JiXHHM20w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-0lvpisj5NMqiQ_qD2V2j0A-1; Tue, 25 Mar 2025 04:14:42 -0400
X-MC-Unique: 0lvpisj5NMqiQ_qD2V2j0A-1
X-Mimecast-MFC-AGG-ID: 0lvpisj5NMqiQ_qD2V2j0A_1742890481
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254e500a73so65316265ad.0
        for <virtualization@lists.linux.dev>; Tue, 25 Mar 2025 01:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742890481; x=1743495281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziIO7gqQIRwTQc7WQaTagZxoA1eVxh2k/2C5JLipzwk=;
        b=REgpV6ECSEMt7f+KnzQC/UZ4pMXEzmq+9l8Glq5cvUPO2pQE2Vtg8vQldJHwo6aq1S
         EXoA2YM8LA7Ggwyny9NuI6ar94U7Slq0x6LpneHVe63kS0ivoHF6y5edMdU7zaD+lfhJ
         ONRLmfvg7N2qMLeYf/F8M6fRH/5oi3aj2mqMYLt42llh3N8D7rS9gGl5rGTEtmJiXYGA
         Vvzo5GgXz0xUsB8ah65zasmPyzYXm0S8DN1Rh9VVVTAOxqx+lqBDil2s61xXagJLWlF5
         jSz7RCGbmgzbMbbtzOxv/GY2d0GsH855Xxyv5dcNINkh52uD+PZ6h0xAZr1kSAIrES8q
         /oUA==
X-Forwarded-Encrypted: i=1; AJvYcCWlJQmEZZmJ6mZYAVB0FayftJGJqqmhq9VbzgQcd43VOJ9ePCTQ/LM8O4T8PUyhCVY6pG+1yR10c2HKwWjElw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1hZAFWhLbM2BKSOXRDPhbe9UJkwJuDmGL/3B6/NixhSk4Mqk3
	b2PWcBOVVXJN/wft+TbWi68qj+hEAqSo47/yEF423QHkQBLNjalPMBe+WH+WaiywbrDWXs9rygD
	KGExdPaHaVGb61ABUtxnOQRYdadxLKZcsqWEsB2NmO23H+PoN+eAb7byCVr5KhTZK
X-Gm-Gg: ASbGnctIif+oyCHq895A2JTmHPx5OjY13/Crfalu0RZHz0Zvh1OD95OC36Q9+FXtaYy
	uTGbcZTeDFU6++VogopRkQlTNtH/GsuFzmnJdIklGmJVRa/hWiebzNUHCROi28Bjxi2qQnGIWed
	i/3zf32kshlzpFwy9J1x8Ftts3O/q2SIMkMOKgmZnPMVeRTnL8viyRLamWNs65MUST3emK7Yftn
	XubW16bQttcf1DfYgVwfhn3lytpm5MJDY0bWTzezaC+aAd6ZHFmfag7cp454iKTF5xEzkM17iYv
	oL5mepg=
X-Received: by 2002:a17:902:e786:b0:224:fa0:36d2 with SMTP id d9443c01a7336-227a5222abfmr149756595ad.26.1742890480838;
        Tue, 25 Mar 2025 01:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHrwEmK2v1Nu8SZcLQeKU8/uA4mow3l3buGiwqqoQFXJ/XEgO6oVtaXIKW8/K2cVHkviIYcw==
X-Received: by 2002:a17:902:e786:b0:224:fa0:36d2 with SMTP id d9443c01a7336-227a5222abfmr149756175ad.26.1742890480351;
        Tue, 25 Mar 2025 01:14:40 -0700 (PDT)
Received: from redhat.com ([101.100.166.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4c4easm84134515ad.84.2025.03.25.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:14:39 -0700 (PDT)
Date: Tue, 25 Mar 2025 04:14:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	pasic@linux.ibm.com, amit@kernel.org, schnelle@linux.ibm.com,
	Kusanagi Kouichi <slash@ac.auone-net.jp>
Subject: Re: [PATCH] virtio_console: fix order of fields cols and rows
Message-ID: <20250325041411-mutt-send-email-mst@kernel.org>
References: <20250324144300.905535-1-maxbr@linux.ibm.com>
 <CABVzXAn1iNHP_8h-sj1mTJDuu9dxOBhwi+nbhhr9d27NTo-6wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CABVzXAn1iNHP_8h-sj1mTJDuu9dxOBhwi+nbhhr9d27NTo-6wg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -SQlbatO-Dm8LlHbeLuBxFszLcOhl1e3eNlqdlha34s_1742890481
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 24, 2025 at 12:53:29PM -0700, Daniel Verkamp wrote:
> On Mon, Mar 24, 2025 at 7:43 AM Maximilian Immanuel Brandtner
> <maxbr@linux.ibm.com> wrote:
> >
> > According to section 5.3.6.2 (Multiport Device Operation) of the virtio
> > spec(version 1.2) a control buffer with the event VIRTIO_CONSOLE_RESIZE
> > is followed by a virtio_console_resize struct containing cols then rows.
> > The kernel implements this the wrong way around (rows then cols) resulting
> > in the two values being swapped.
> >
> > Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> > ---
> >  drivers/char/virtio_console.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 21de774996ad..38af3029da39 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1579,8 +1579,8 @@ static void handle_control_message(struct virtio_device *vdev,
> >                 break;
> >         case VIRTIO_CONSOLE_RESIZE: {
> >                 struct {
> > -                       __virtio16 rows;
> >                         __virtio16 cols;
> > +                       __virtio16 rows;
> >                 } size;
> 
> The order of the fields after the patch matches the spec, so from that
> perspective, looks fine:
> Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
> 
> Since the driver code has been using the wrong order since support for
> this message was added in 2010, but there is no support for sending
> this message in the current qemu device implementation, I wondered
> what device code was used to test this when it was originally added. I
> dug up what I assume is the corresponding qemu device change from the
> same era, which sends the VIRTIO_CONSOLE_RESIZE message using the
> rows, cols order that matches the kernel driver (and differs from the
> spec):
> 
> https://lore.kernel.org/qemu-devel/1273092505-22783-1-git-send-email-amit.shah@redhat.com/
> ("[Qemu-devel] [PATCH] virtio-serial: Send per-console port resize
> notifications to guest", May 6, 2010)
> 
> However, I don't believe that patch ever made it into an actual qemu
> release, so it's probably not a compatibility concern. (If there are
> any other device implementations that use the kernel driver order
> rather than the spec order, then maybe this would need more
> consideration, but I don't personally know of any.)
> 
> Thanks,
> -- Daniel

I agree. Cc author of the qemu patch for confirmation.

-- 
MST

