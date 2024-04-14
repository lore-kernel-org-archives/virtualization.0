Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4918AF4
	for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083853; cv=none; b=F6UnZLcXvNoUMrYHlny1Ipi9WcldVTj8RYcNKiXpV/Zzt2ZsRbaifZER9lQdArEV2WUeW4HHDYSqjG7YkYdEVsCko9jdwL9ojyYr5eTRPbmo2Kv0yxv3DAFXUx//63J3C48RMJUA6zmtMqUuokh50uhXSlKGjiIOLAzLNdyvFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083853; c=relaxed/simple;
	bh=yuFnvYtnvNNjnZNTCXgHUj4IvgWtR9BbExjVSI79/+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nZOgSZDW4WL3R/ETrADChtMH2VA+iOp+XqNYI7V5i+7KdPX8ADdWTdi8r5a8o2iZLuEpNLX0nOKKcs7vpjvPLjvrBA0Rqpl0xgcP8zii1qxHIpi4auIdFbCejK7eAkBTEkFHk1aBqENw0P22tX5mNMj1g+SNmTjLxaiOjblwf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDw0SeP2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDw0SeP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713083850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/i6krDV1g9AR8pbuTOJvAWUEXMFk0ywujV4a8O3nVY=;
	b=iDw0SeP26tRZQW2gNACuej0duWLIreT9lhZV1lFRei2n2tyNvQ/JQiMLwvWQsFpM1AV6OE
	0gdigxcTS4movupmxb06bfvBJmxZQnmIGuETCetMb86EXj8+69/XY+tXnfLr/o3QVvbU19
	a2L2BOPFSyrljpjcSbvmDFJhOAZeb0k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-W9q9uHUfOG-BatR5eUhXVg-1; Sun, 14 Apr 2024 04:37:29 -0400
X-MC-Unique: W9q9uHUfOG-BatR5eUhXVg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41663c713b7so15760335e9.0
        for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 01:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713083848; x=1713688648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/i6krDV1g9AR8pbuTOJvAWUEXMFk0ywujV4a8O3nVY=;
        b=sWuIBkLsyW9j5RQcZnNbP+ZcLGVoH2XhwnqP2+eQeZhGTenoD3dd0iKaGkoG7Xq8kt
         PMYFwWIxzKYvwqLI3SaL9lBcFd7W2th4uckCxjJ6LqUrRZOe8QqTb8h91Xw6iRVkaBYc
         XYf6ldQ5oBgmKiXe1SWDqp8BZXcRN3C0kBwLQU5kRzVlCj2Yt1p5l5GrMHHgHURhxzD/
         daFPXcETUtaoiaCxBm5DV3ARflNSfMWFv84bylFRhIrVD9i6t1FmDWLQ4zaWy5ikQD6l
         SShHuinrYNqHq5coEYyy1/nen6cCOnJTe4KY/H4BL/+JQu4u6ZpFu90HR2T+yELWi58Q
         B//w==
X-Forwarded-Encrypted: i=1; AJvYcCWRWxf4IiaO21JHGmlxxG+HqBztWkoSqjzwAvfrztvUjqfdB5TICnnaRtrhGKUL8rc/G8B8r1Gg+HzCrosWuuBPlptfVorHyPKcJtNr8D4=
X-Gm-Message-State: AOJu0YwsXcUPLxIJ8BzAmIpi4N/B8JKyWnOrtCeEFLbG3Yp35O/st9/4
	lIZQUoEGiwfeIlRvoSrx4x6rHeH1t+GfTqIaEQYf+9DhSvIr03/vUZz3ACs6ZIfC+2Nrzw9pGtX
	LEOTYD48cKvmAnRR1V2HLctByKNbG5WJoxr2HjBbOIAbFHi/UGfkodEP2CjO8S1HhMkVKXCny
X-Received: by 2002:a05:600c:5116:b0:418:42e2:f91e with SMTP id o22-20020a05600c511600b0041842e2f91emr893581wms.5.1713083847690;
        Sun, 14 Apr 2024 01:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHBRePobWjhSA4J5E9UMMqMx3oeXar185JqQ3RtQ9MjHZ5tg42MeVq6OUwgebYVh010dPfxA==
X-Received: by 2002:a05:600c:5116:b0:418:42e2:f91e with SMTP id o22-20020a05600c511600b0041842e2f91emr893564wms.5.1713083847184;
        Sun, 14 Apr 2024 01:37:27 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b004166a8ad81bsm14723278wmq.43.2024.04.14.01.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:37:26 -0700 (PDT)
Date: Sun, 14 Apr 2024 04:37:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ricardo Ribalda <ribalda@google.com>
Cc: Andrea Righi <andrea.righi@canonical.com>,
	virtualization@lists.linux.dev, stevensd@chromium.org,
	Igor Mammedov <imammedo@redhat.com>
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <20240414043707-mutt-send-email-mst@kernel.org>
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2024 at 11:43:22PM +0200, Ricardo Ribalda wrote:
> Hi
> 
> I am using virtme to do some CI around linux-media.
> 
> Everything works as expected, but when I enable KASAN, I am starting
> to get a lot of timeouts when the Method _PRT is executed. Eg:
> 
> [   56.335875] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> [   56.529826] ACPI Error: Method execution failed \_SB.PCI0._PRT due
> to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> [   56.532391] virtio-pci 0000:00:02.0: can't derive routing for PCI INT A
> [   56.532823] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> [   86.877471] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> [   87.073854] ACPI Error: Method execution failed \_SB.PCI0._PRT due
> to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> [   87.075550] virtio-pci 0000:00:04.0: can't derive routing for PCI INT A
> [   87.075810] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> 
> 0000:00:04.0 and 0000:00:02.0 are virtio devices (console and 9p-filesystem)
> 
> If I increase the timeout (ACPI_MAX_LOOP_TIMEOUT), then the Method is
> always executed, but it is very annoying that I have to wait more than
> 5 minutes to start the vm.
> 
> Despite not having kvm enabled, the machine is quite decent, so I
> would expect that it could run that method relatively fast.
> 
> Do you have any hint of what I should be looking at?
> 
> Thanks!


CC Igor.


> ```
> # virtme-ng --version
> virtme-ng 1.23
> # qemu-system-amd64 --version
> QEMU emulator version 8.2.1 (Debian 1:8.2.1+ds-2)
> Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
> # git describe
> v6.9-rc3-208-g586b5dfb51b96
> 
> # virtme-configkernel --defconfig --arch x86_64
> # scripts/config -e KASAN
> # make olddefconfig
> # make all -j 256
> # virtme-run --kdir . --mods=auto --show-command --show-boot-console
> --verbose  --cpus 2 --memory 4G --script-sh "echo HelloWorld"
> ```
> 
> 
> 
> -- 
> Ricardo Ribalda
> Software Engineer
> ribalda@google.com

