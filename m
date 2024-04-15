Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560217316F
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185522; cv=none; b=WD8sjNh4WXucrzjRxg/VnhVhgBY4ZNKGkBYzEAOzM6HFzZDduuAfbJ2EIL63VcbSCwls9deBm0zloySrb2inMGcTNzEWyT/3fmbVv+Dq2EX3s8TmdXCf73y6sUFlurPfKh3TTjZfd+7UZj5qwWd3jE8GH1cOSbYtctJRUKbh6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185522; c=relaxed/simple;
	bh=uBhtk2PNkujVTJkhh4LUNeiopkmqs4iSk9T9VhGppMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlbBqC3xm/KkTRlTJFg/P1PZ38XcaYS7CpCTd9DKzfcpeLA3KpS2CE4Dx8AnJXiko+GjCTaapDncDtM7eCSZIXiv8Yw3YZFke7UfZWPS8DezQ4Ppqg4wztXzn+YGPBJZLqWD3DSMmdRBvITwYrC35f4RIiBVBPsQKT4o1ePkrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+ThlEIR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+ThlEIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713185520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNqpjcWI6XxES6wRCT5jPkw73kjt7atfJr5XmbZuzoU=;
	b=b+ThlEIRqY9Ru/ipHdBqzU78K7BQz3Ay3Eo3wC8FnK9zUrxRAaxnRtWYkiqDKkUntHjH05
	fxXNYNGRFpgWNBeozmtlFt5MR2ZBu2qqFsT5QS7JVZsohjwYhq9qa9kbG20C/Nqa6FhN/d
	wP3a++ueugYq2c8vsKvKabDRJV3kRKg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-dtgw3vPbP-O0QiU7NpTPQw-1; Mon, 15 Apr 2024 08:51:56 -0400
X-MC-Unique: dtgw3vPbP-O0QiU7NpTPQw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d9e4438becso20806961fa.1
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 05:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185515; x=1713790315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNqpjcWI6XxES6wRCT5jPkw73kjt7atfJr5XmbZuzoU=;
        b=aRTHIRs2SlRyHpfW3u5h3UtuRFpI+nfdN0WgWjS3fHzrW4lll9fvS7hov+VFSd9KyX
         z7FPz9MnFsV9kGtcGpjf97J6Btf9I6F+SF3bI6IEmsnxwCbtrFIgMz0z0jqed1pPfJuo
         7e/hiHemOfNaM9LxdzRn33twOQu0dYCYr5NM8B2+I5yIKntPlXBNTJHdQlV9oZhRP14b
         ZJtg/qOYKQR/EpqA3KRSuq6BqQH62KSYpPF3qXPH0+tCLg5KJ/4LQ8nTE7xw6/nFq46P
         ZHG3kU9jpz2+gwoXvSwH+UPBeG67NtYMlnZFR3Hef0M79xZAFR6b2357ZHYGM/dtI9S/
         iFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTgRr8eWEPwB5iVotoecCrm0zW8zLWmtcrnDYntm0TBXCg3af+VPohcrB8Ur5Zv89Il8w8gzt5+6AkI2FLwA4qqDoaChS5Bny2NKi9Sj4=
X-Gm-Message-State: AOJu0Yy9r0QIfvwlCy+WHFwQSeNaJwfva8cWMehMBiK88AV+M5YKmJya
	SWJB0gMIBoqOqeOtzEcKq3JgrFMGsO98nihiVYl47/QITB8bn0ieOY+14TehRQoGqvuC3QmNmQV
	tzyB202Y7nJmcOrX6qiXICH071VlvZqMsG3c5kH92lmC+U1Cx8NvVo44jmz1/6rSN
X-Received: by 2002:a2e:be1a:0:b0:2d2:f5fa:f37e with SMTP id z26-20020a2ebe1a000000b002d2f5faf37emr8598936ljq.51.1713185515300;
        Mon, 15 Apr 2024 05:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMNat3wvo7qPBtu/QzC9hKx4REqbS88SaA0CaHEogDvD2FguqocrfFQCVjkFeHC0IVy3HpcA==
X-Received: by 2002:a2e:be1a:0:b0:2d2:f5fa:f37e with SMTP id z26-20020a2ebe1a000000b002d2f5faf37emr8598919ljq.51.1713185514879;
        Mon, 15 Apr 2024 05:51:54 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b0041880a0e8ecsm404064wms.43.2024.04.15.05.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:51:54 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:51:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ricardo Ribalda <ribalda@google.com>, Andrea Righi
 <andrea.righi@canonical.com>, virtualization@lists.linux.dev,
 stevensd@chromium.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <20240415145153.21075173@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240414043707-mutt-send-email-mst@kernel.org>
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
	<20240414043707-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Apr 2024 04:37:24 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Apr 12, 2024 at 11:43:22PM +0200, Ricardo Ribalda wrote:
> > Hi
> > 
> > I am using virtme to do some CI around linux-media.
> > 
> > Everything works as expected, but when I enable KASAN, I am starting
> > to get a lot of timeouts when the Method _PRT is executed. Eg:
> > 
> > [   56.335875] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > [   56.529826] ACPI Error: Method execution failed \_SB.PCI0._PRT due
> > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > [   56.532391] virtio-pci 0000:00:02.0: can't derive routing for PCI INT A
> > [   56.532823] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> > [   86.877471] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > [   87.073854] ACPI Error: Method execution failed \_SB.PCI0._PRT due
> > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > [   87.075550] virtio-pci 0000:00:04.0: can't derive routing for PCI INT A
> > [   87.075810] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> > 
> > 0000:00:04.0 and 0000:00:02.0 are virtio devices (console and 9p-filesystem)
> > 
> > If I increase the timeout (ACPI_MAX_LOOP_TIMEOUT), then the Method is
> > always executed, but it is very annoying that I have to wait more than
> > 5 minutes to start the vm.
> > 
> > Despite not having kvm enabled, the machine is quite decent, so I
> > would expect that it could run that method relatively fast.
> > 
> > Do you have any hint of what I should be looking at?

The way QEMU generates _PRT haven't been changed for ages,
it's not likely to be a culprit.

CCing Rafael who might have an idea why ACPI misbehaves.

Can you share kernel config and full QEMU CLI used,
for me to try to reproduce the issue locally?



> > Thanks!  
> 
> 
> CC Igor.
> 
> 
> > ```
> > # virtme-ng --version
> > virtme-ng 1.23
> > # qemu-system-amd64 --version
> > QEMU emulator version 8.2.1 (Debian 1:8.2.1+ds-2)
> > Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
> > # git describe
> > v6.9-rc3-208-g586b5dfb51b96
> > 
> > # virtme-configkernel --defconfig --arch x86_64
> > # scripts/config -e KASAN
> > # make olddefconfig
> > # make all -j 256
> > # virtme-run --kdir . --mods=auto --show-command --show-boot-console
> > --verbose  --cpus 2 --memory 4G --script-sh "echo HelloWorld"
> > ```
> > 
> > 
> > 
> > -- 
> > Ricardo Ribalda
> > Software Engineer
> > ribalda@google.com  
> 

