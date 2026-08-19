Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532A3CC7CA
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130463; cv=none; b=JnQxzlyriFAbsSRAkMuVTNvfvgkMdQm1j0x6Mb9Xb2fRT8xt8yjDhZLQcUguwGir7bsyPvP3DZmGgtBwMDD3OqKPWPWBu09wlrN0LFvnmurCI2rIN9dYd582wBGv+SF7RkYjyUnUlddA9toppK9GinTiYxXpdL7jcWHhvvcG844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130463; c=relaxed/simple;
	bh=44RnieGb31sETghWfhYnhJASb5MTKZspETW5jfPDRRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3AwxhL+2WnZsMdv1Rb7aYpnTcJM9ml0YN/phLlMHhRLUAnBLYNQ2q9qUYceWfO+hxWkrKA9LQMBrRRTdJutSU+yFznsjgdOtg3dufAoH5R4Mo80pT8jNzqFf20tgzfH61wKhtQsrqDDwp4EIHSsFGPlkA0A/OiNwZndxSfI0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRM83HyA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRM83HyA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787130457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44RnieGb31sETghWfhYnhJASb5MTKZspETW5jfPDRRs=;
	b=FRM83HyALOh8dEpThWe6N4qffgSxTUAcMphzvszkFIya6NSnULmfdTq5g1FDmFWb1pkiiH
	gBZMZS3ocvw52X+Bxhpe9cZTGO9W2CTwxSI0F/z7l3wdH4sfrETFM29zIQ5H85I1gCmBNY
	hChN+dBt1uJ7b1bKwMOYOnTvHytej8E=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-cfHSZ-ugNMyKzviCMQcSEA-1; Wed, 19 Aug 2026 05:07:35 -0400
X-MC-Unique: cfHSZ-ugNMyKzviCMQcSEA-1
X-Mimecast-MFC-AGG-ID: cfHSZ-ugNMyKzviCMQcSEA_1787130455
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a4a7d0362eso968493b6e.0
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 02:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787130455; x=1787735255;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44RnieGb31sETghWfhYnhJASb5MTKZspETW5jfPDRRs=;
        b=KvMEUQunX6GYUMAx57Q5n96SLCMGYj4M0jCdaXINDl53wiTdRp+WwUPID2uxhx/493
         pNgF7ScquSZ2b1vSQorI9AiE8+aMNqwBCy1Qhtig9/2/Pzyk0IE3DwSh60+94FFcnkfx
         sLRCnyjguXnN9AGhNpTeeX/2JskVggqlIVe2PDWdzFkP+9vqzwG62TyphNpEDu5AjFf1
         qGamT+zjUwticTfSvJjemKNoiGX2hNPUExqK5KNktEYdPx9gsGOE4uSmbKEB9IJVJQM7
         1MfTb69a/I+ZD6dbc3Gl1L3eakdJyq5wbHFe9JNn5BRYv6iPUQ9E2cDOLypvHcX4vt/u
         jsEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqWRogNiH6J142yipWUwhfDE6z8vsai69g8kG0qMoMpSUkodvU4XEdwSjkq7Xbo3HmMGsuh4jn/xDiZju57uw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3XEBWSeiHqLDG5uAkTDoodKjlI3/aSddcQq/gQjy+7bBf9q0V
	/zf/940XHigEa3/UYNkL+RfzXnd0fclj+RcAxO9tS3EfzkoGTAF6WMR9bh+hUtkdS/AWbY8EQJh
	aP+fcXBWKgQe33Zafk7tIWCiqxKU8A0B2RpFKHRxSQqAW3ZBSfaBxCTxmtGPe/7kOU9j1lPr2Qc
	iPAtt9yju6wpJzgqIG8ye6zGhoM+PLlolqrKRQubJVXuc=
X-Gm-Gg: AR+sD11maIdNmMXCFLw+MZnXdq1CIYqOlxs2Vc4JwBzcyiSnEf9jUodoi1mYgOYa2+a
	opBXBpLn4IZgHtRrk5YilReFf9EcTjSUf91y7SesyEcdVzjKpO3VaJAxfHRNRRFZTvfnEMSvr5h
	9xSjgGvRNAUEmWW/61JoP95QHj6bkL1K1WYNb9AM6oJECxOhV/x7PvSDdwxtrRoI7C5AwL8wdxv
	gl1RCP/BrqQioSVdFRizOjQJZSF/fAHeh8AR5ytsvZuo5bB
X-Received: by 2002:a05:6808:c1d8:b0:497:d3d6:6a40 with SMTP id 5614622812f47-4b2bc8ea2a3mr2540308b6e.3.1787130454946;
        Wed, 19 Aug 2026 02:07:34 -0700 (PDT)
X-Received: by 2002:a05:6808:c1d8:b0:497:d3d6:6a40 with SMTP id
 5614622812f47-4b2bc8ea2a3mr2540257b6e.3.1787130454472; Wed, 19 Aug 2026
 02:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACzuRyy8_x2XW4hbWn6uzZZjj4LbxpMN_a81Tub-=WSop4anhg@mail.gmail.com>
 <CAD4i_GTB9Uk=Kd=zZPAdXNZv0Xjvb5i8oHJHLA-ieCxLJHbmzg@mail.gmail.com>
In-Reply-To: <CAD4i_GTB9Uk=Kd=zZPAdXNZv0Xjvb5i8oHJHLA-ieCxLJHbmzg@mail.gmail.com>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Wed, 19 Aug 2026 11:07:23 +0200
X-Gm-Features: AcwNN1VuMYUzwHyXshgKG4bENNzTtVl3AZDjms6xiRRyRcksX6wAR-vMczhIByA
Message-ID: <CACzuRyxRsUYVGv97vo9hsK=37=pcVjK+7=gF0JS3Ngx-SmiK7Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] media: add virtio-media driver
To: Brian Daniels <briandaniels@google.com>
Cc: acourbot@google.com, adelva@google.com, Albert Esteve <aesteve@redhat.com>, 
	changyeon@google.com, daniel.almeida@collabora.com, 
	Eugenio Perez Martin <eperezma@redhat.com>, gnurou@gmail.com, 
	Gurchetan Singh <gurchetansingh@google.com>, hverkuil@xs4all.nl, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, 
	Michael Tsirkin <mst@redhat.com>, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Q9HmQ_SiAlDNeOiF0DLHGjwRzhCQfRWw2MIYuh2S5M_1787130455
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> As far as I can tell, ``CPU_LITTLE_ENDIAN`` isn't specified for all
> architectures (importantly, it does't cover x86). Perhaps this could
> be made less restrictive with:
> + depends on VIRTIO && VIDEO_DEV && 64BIT && (x86 || CPU_LITTLE_ENDIAN)

Thanks for the fixes, Brian. The endianness point makes sense
and your Kconfig suggestion looks right to me.
I'll test v7 with libkrun.

BR,
Dorinda.


On Tue, Aug 11, 2026 at 8:34=E2=80=AFPM Brian Daniels <briandaniels@google.=
com> wrote:
>
> On Tue, Aug 11, 2026 at 4:43=E2=80=AFAM Dorinda Bassey <dbassey@redhat.co=
m> wrote:
> >
> > Hi Brian,
> >
> > I've been working on a vhost-user frontend for virtio-media
> > in libkrun[1] and tested this series with vhost-device-media[2].
> > A few things I noticed:
> >
> > 1. Wrong constant in vfl_dir detection in virtio_media_driver.c:
> > >
> > > + if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLA=
NE))
> > > + vd->vfl_dir =3D VFL_DIR_M2M;
> > > + else if (vd->device_caps &
> > > + (V4L2_CAP_VIDEO_OUTPUT | V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE))
> > > + vd->vfl_dir =3D VFL_DIR_TX;
> >
> > V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE is a buffer
> > type enum, not a capability flag. So it should be
> > V4L2_CAP_VIDEO_OUTPUT_MPLANE.
>
> Good catch! I've staged the fix in v7.
>
> > 2. Kconfig architecture support
> >
> > > + depends on VIRTIO && VIDEO_DEV && 64BIT && (X86 || (ARM && CPU_LITT=
LE_ENDIAN))
> >
> > ARM64 is missing here, so the driver cannot be selected on
> > aarch64. Also, CONFIG_ARM is 32-bit only, so 64BIT && ARM
> > can never be true; that branch is dead code.
>
> I was able to confirm that you can't build it for ARM64 as written in
> v6, I've updated it for v7 as you suggested, thanks!
>
> > Since the driver
> > has no platform specific code, this could just be:
> >
> > + depends on VIRTIO && VIDEO_DEV && 64BIT
> >
> > as it already covers x86_64, ARM64, and any other 64 bit
> > architecture without listing them individually.
>
> While it covers the 64 bit requirement, it does not cover the little
> endian requirement.
>
> The virtio spec states that the v4l2 structs transferred should be in
> little endian format (section 5.22.6.1.5) [1]. Currently, the driver
> does not do any translation on big endian guests, so for now the
> driver should be restricted to little endian guests.
>
> As far as I can tell, ``CPU_LITTLE_ENDIAN`` isn't specified for all
> architectures (importantly, it does't cover x86). Perhaps this could
> be made less restrictive with:
>
> + depends on VIRTIO && VIDEO_DEV && 64BIT && (x86 || CPU_LITTLE_ENDIAN)
>
> I'd lean on others' expertise here if they have suggestions.
>
> I should note this driver has only been tested on x86 and ARM64
> platforms, so I can't make any guarantees on compatibility :)
>
> > 3. Error sign convention:
> >
> > > + resp_header =3D sg_virt(sgs[out_sgs]);
> > > + if (resp_header->status)
> > > + /* Host returns a positive error code. */
> > > + return -resp_header->status;
> >
> > The comment in the driver and the protocol spec contradict
> > each other. The protocol.h describes the status field as
> > "one of the standard Linux error codes" without specifying
> > a sign. It's probably worth making the protocol spec explicit
> > that the host returns positive error codes to match the driver's
> > assumption.
>
> I'll update the comment in protocol.h to explicitly state the error
> code is positive in v7.
>
> > [1] https://github.com/libkrun/libkrun/pull/811
> > [2] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-med=
ia
> >
> > BR,
> > Dorinda.
>
> Thanks again for testing and for sending fixes!
>
> [1] https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-cs=
prd01-diff-from-v1.2-cs01.html#x1-8360005
>

