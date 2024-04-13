Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627C1B59A
	for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712987777; cv=none; b=WbBdtni0FPoWrXurJpFHFbUIFyMKwgZ+TpFFPSqAMZWTgMOYYSR9rwyilgxrGVrn16bagM3NWc4oxyY8klAKu54Id/paRDsB/5JNdY8kerEQZ2b8egQUd3IcfpoFMXU1y8Yjl376NJcXfDsQ4AuqzU9SYKEssEr1+k3oHhpe4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712987777; c=relaxed/simple;
	bh=tErfojSvBbAQ9C9BGwiOGtk1VeqNiLa2qQlL1JQGIu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf495fjYIaWk8N3W3Aue4VCNp2TAnJBVTbsehOEF39FJXEWx+cdwKfe2xQXQbWfpO3cnegwGdhy/dReWFaGlPiYiWk8Hl4QZMtjw2xCKkNTpBNwZgFklYprlyF0uSYNN+ol3rFpwrv+nZgoIq2462WgFkRMvmCOX6Ad2VyfSDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JCknuYU3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JCknuYU3"
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0D0083F5CF
	for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 05:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712987772;
	bh=6co6WqK46hAneJhs9iR9l95pDhdBJJcLR1uaJ+SJA+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=JCknuYU3bEoYeXBdrF0RA9I0O7nbpsnPZeJB5PnhK/TFkH5z1GUL/3/KvEnXwDGty
	 Rp0klvRZ8uu+rTx0SQdswEPwMWBd14wzSWkPgNXeq1eFq8nLid4N1zFDnsjyfJfHlT
	 8iTmS4iWRqzoHadKUepMYkbY0RFAlUbCEuOVsj++c2DP7arEKxbULZ58/32XEtD/it
	 tfL39NSY7VGm3DYC+hc8OfcJm3TPENdiaU5iH3GPo6Qe5e35jY6EV74gH40g3grNJJ
	 c3DOWogt9n8PzqRLIOUodTLrRpTCH5oGIeaZ8rvqy2IpzGyWKqQYrtEGQv5pTSSWHN
	 4lXrRlzlwmmiw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56e5309b4d6so957079a12.0
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 22:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712987771; x=1713592571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6co6WqK46hAneJhs9iR9l95pDhdBJJcLR1uaJ+SJA+4=;
        b=aWLvkkcXF9aD8wpegIMNyMtqTST1h5aqAhIGj4xfFWdeoo4NnKppFTjuPz6Tmp33+n
         V5EomyW48NA5xFgoJp2hROnJB/DV8GMFaXw3wa2QRxLy50IKfY0lJM1BTXVdmaQypAKA
         NdEBeTJb04hZZ/5vne04pAzdGr/9V0UAnJ+/r2/4mlFU+kMCIa3ji9tWMaAbNI58VvBe
         kD1R6L81Fn6S/Gi20/+2fe/l5sai/9o9yCoMdMqIwfbMNNou1bDTYK4MoZfSYsJNMqIr
         9YUmu2xgbPjjhPAizS1CRVvj+xPAsqGc8AhLNlpLRTy5Sk9mGR3LoV2HJ+fNj8hbD37M
         2EnA==
X-Gm-Message-State: AOJu0YzGAChg2f4em6FopZRo4gYvNZXgpUCGJYZ58zEescCqldgz9MfG
	vFxA2vl/Gm05H/Yv4jxWz1Qp9smFZx/7HDklmGIGEryBp6kZ1oRzZjmiGtXnCUsYBIu+3m3jztc
	P1aN7/5RBTAUreN8eHAKVXVkd241gDzD+Fd4GyaQsWQt45mJrPYw9f1ZF7f/u8PMLPi5ZLVIFO3
	3pTVP4
X-Received: by 2002:a50:8e17:0:b0:56e:dc5:e99 with SMTP id 23-20020a508e17000000b0056e0dc50e99mr2832419edw.24.1712987771062;
        Fri, 12 Apr 2024 22:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYVVe4i3c4R0w3v8yTkGiuwmtHQhRO2eHDY8jnw9RO2MnvJztJQMt2ADc3aKWv9EK+zK78Pw==
X-Received: by 2002:a50:8e17:0:b0:56e:dc5:e99 with SMTP id 23-20020a508e17000000b0056e0dc50e99mr2832404edw.24.1712987770279;
        Fri, 12 Apr 2024 22:56:10 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id a15-20020a50ff0f000000b0056fc72bb490sm2315475edu.61.2024.04.12.22.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 22:56:09 -0700 (PDT)
Date: Sat, 13 Apr 2024 07:56:09 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Ricardo Ribalda <ribalda@google.com>
Cc: virtualization@lists.linux.dev, stevensd@chromium.org,
	"mst@redhat.com" <mst@redhat.com>
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <Zhoeec0lfVEPmGj0@gpd>
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>

On Fri, Apr 12, 2024 at 11:43:22PM +0200, Ricardo Ribalda wrote:
> Hi

Hi Ricardo,

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

I'm wondering if it's a microvm-related issue...

Can you try to add --disable-microvm to your virtme command line and see
if it makes any difference?

Thanks,
-Andrea

> 
> Thanks!
> 
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
