Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57BF15217E
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712958222; cv=none; b=FNWoMrXGunFMvKws3vzZD9G2SQoaCxSBJBkRw4A2dbR2YtnsGmg4cFMQ1aH0BI6jK0ZwcqbGOi6CQ4LuMfvtLyNVddmr4FaBhT85oHd+P51quDaUE4wO9mRklzN6ch5tNduYyOp5Il6fcGBWNytJLSPh3F10iUUSmf7txDXUBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712958222; c=relaxed/simple;
	bh=9XMuEOGxbC7la/rgNVA78OMenQZ6rgGRMo+UGpCaVpM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UDNawMmQGec3z7cnx5IaoSr+ldxvpxnyAZ2bJA9SLUVtJrq5Vk+uXKjO4oHoQAVMW53+mKbi+Z/4koSczNCsrJY6IGcpKir0MbPV4hxZl2Uk9IKPRh//6gzapmcBwf6dk5oHdRoRZ2fQiETlGmjT3W56hkH2pS3uW6pQnRUeGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCHFD/b/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCHFD/b/"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4167fce0a41so13559005e9.0
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712958219; x=1713563019; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uKBwRx+nvrRXhPqQ3aS3B3r3U5t4JdlVE6xUhiuMl9w=;
        b=LCHFD/b/v3I8p5Woyz+y+2MC6Izpu8pXPE38MUNr+qRkNrZ1FBkHn3xbxwG/5aVIA3
         jLdRqaZGctwc58cQtkI20IzsRMxZZs1MH3h7/vR/OejIK7ZI/WAo+A3E9TFHtQY7CIyz
         NOZOYeiP4qe1EktEh7gsahTOfV6OPypFNGVhTtnFsuIE4DsyJqo+YAds9UQ9I8ef2QuI
         94McWFas2RXZxka0STGy5sBnVI09Om3Nlbzr4+io4l1bAzjX0YkuIHopiie8tawPOmcK
         sWppLpelnQe5p4Ngvagy8EjCPdRs7/SyOUpsQF1VrEH4yalv7e6nfGTvcpUJrkzUh1s4
         QrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712958219; x=1713563019;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKBwRx+nvrRXhPqQ3aS3B3r3U5t4JdlVE6xUhiuMl9w=;
        b=VhhDx/5dB8xhBQ1S5agfzmIXczM8HCpZWCYc1K78LfV6hm2h7pEcHjIWTClC3DZlzR
         2uB2jHIx6EgvfhcUfKjORWgjLJnIe6aFqQI7vDHE1w9ZnXzEIEtZSVaumxyJAX9qV1sN
         Z+9m8e9LlK3rND69jHz9nKV7/OtySRX+ZjVdnL/yDulSo0RMp53S7Gn2XAqkfG6+Fjao
         uVficARSZKiXr7cCIxxf2wh6bL1wOGS9+a4sb/mj19S9OCFXw3SWnTRafoy3gkjabeqa
         uQhaH8ZGNcU7CI4vsQW7PRVtRnHVMke5E+DL9I/rgcl3me0iiLHjyQW3inTWg1VLdd2/
         t8rw==
X-Forwarded-Encrypted: i=1; AJvYcCU7W6go/e7g0Zrt5qyjRTw8SynOpu5kmX2fXUXW2gqxcyvdhej6ToUhEziih8iP3KXHVVGDNW+919/PqUJp06wfVy4SithhznMx0QLQBvc=
X-Gm-Message-State: AOJu0Yxsz9XkzadNLPRQOCOo31EVqGduiLvlYZiZb/PpqDvSeezGR75C
	k9X6i1QdGVW2G5oNnaAa9qI8et1LswNRgnz6eEThrOAiJTPY8OJzIUv/kw2SQbq67JGiupvpjm/
	ZGMY72eOXABqsOryFQV2VqlW2XcKd8nC5/Pyl
X-Google-Smtp-Source: AGHT+IFix1BHXfjVf69uaj5K6NYpb3Hp/iOdFOz2ZHrud9ZigNbsWaZoDc0W6Hrn9gYYcN6XeGFNLOvIvudx10aLVWA=
X-Received: by 2002:a05:6000:9:b0:346:e047:66cf with SMTP id
 h9-20020a056000000900b00346e04766cfmr3563594wrx.5.1712958218857; Fri, 12 Apr
 2024 14:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Ricardo Ribalda <ribalda@google.com>
Date: Fri, 12 Apr 2024 23:43:22 +0200
Message-ID: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
Subject: ACPI timeouts when enabling KASAN
To: Andrea Righi <andrea.righi@canonical.com>, virtualization@lists.linux.dev
Cc: stevensd@chromium.org, "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi

I am using virtme to do some CI around linux-media.

Everything works as expected, but when I enable KASAN, I am starting
to get a lot of timeouts when the Method _PRT is executed. Eg:

[   56.335875] ACPI Error: Aborting method \_SB.PCI0._PRT due to
previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
[   56.529826] ACPI Error: Method execution failed \_SB.PCI0._PRT due
to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
[   56.532391] virtio-pci 0000:00:02.0: can't derive routing for PCI INT A
[   56.532823] virtio-pci 0000:00:02.0: PCI INT A: no GSI
[   86.877471] ACPI Error: Aborting method \_SB.PCI0._PRT due to
previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
[   87.073854] ACPI Error: Method execution failed \_SB.PCI0._PRT due
to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
[   87.075550] virtio-pci 0000:00:04.0: can't derive routing for PCI INT A
[   87.075810] virtio-pci 0000:00:04.0: PCI INT A: no GSI

0000:00:04.0 and 0000:00:02.0 are virtio devices (console and 9p-filesystem)

If I increase the timeout (ACPI_MAX_LOOP_TIMEOUT), then the Method is
always executed, but it is very annoying that I have to wait more than
5 minutes to start the vm.

Despite not having kvm enabled, the machine is quite decent, so I
would expect that it could run that method relatively fast.

Do you have any hint of what I should be looking at?

Thanks!

```
# virtme-ng --version
virtme-ng 1.23
# qemu-system-amd64 --version
QEMU emulator version 8.2.1 (Debian 1:8.2.1+ds-2)
Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
# git describe
v6.9-rc3-208-g586b5dfb51b96

# virtme-configkernel --defconfig --arch x86_64
# scripts/config -e KASAN
# make olddefconfig
# make all -j 256
# virtme-run --kdir . --mods=auto --show-command --show-boot-console
--verbose  --cpus 2 --memory 4G --script-sh "echo HelloWorld"
```



-- 
Ricardo Ribalda
Software Engineer
ribalda@google.com
