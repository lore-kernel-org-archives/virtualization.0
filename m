Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580325A2BF
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746078; cv=none; b=QGZ75/oD+iBhfEGApeEYgJCPIMXjw1N2xNRSfo/rloBU9temHYbYGhjTyqjPmSyOwLM967Y9m5y/GtezIRk8PLWDhu7I2AZ40NjjbIUhotcLoRPDhgTKKkZiQ/8TOXg3yVNvdRjJFl3xzgPx6fd8CET4EajHeO+LjLL8a/i4m1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746078; c=relaxed/simple;
	bh=O1cgqadLok6ov9kxBK67LS3x2DmvXH9M00f7yPr3dMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVTzCzz6ZeNi/ddQTaRc73Ppm/fiI7T42ZqfQCExutkX9avO+xNBktZYHFIgfp5EIUqD2LY9giJEeBGczA0b9iFed4VfzXQ07L/TUUyZXLWSY9ad4SnlQrXhb7NkBq/aaBxGO5G8yYRLjfVoK+iKeKM8F3HK598JZ4AKF5K1Ado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZqqrUmO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZqqrUmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752746075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZRfweznS7yMQDSd0o0wpXzXCE2YxQarW3HyWdcKfrs=;
	b=HZqqrUmOzwQWi01tfZ2UDgTV/tFvDal1hjCKdNfAXonWbs/aflpTNOU+QQSMB2mSUlrqKA
	FfyXeYpjskgwOUsJP6EGywGgG3P+xLkWbolecd+71ZGI3kxZRCQ0XCwBaNbCAGbbQOtN7F
	58ALWgbgFSVZuQQyRwt+tV1hZXlwvVc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480--k6DDa7rOXeFslUiqMXLIQ-1; Thu, 17 Jul 2025 05:54:31 -0400
X-MC-Unique: -k6DDa7rOXeFslUiqMXLIQ-1
X-Mimecast-MFC-AGG-ID: -k6DDa7rOXeFslUiqMXLIQ_1752746070
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so3869615e9.1
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 02:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752746070; x=1753350870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZRfweznS7yMQDSd0o0wpXzXCE2YxQarW3HyWdcKfrs=;
        b=uv8UfNEstPC9gsL0dQ05aOQfhktiUGRvsA9WEc08zfcPpAzL/Fwum3QFXdy1taQg6N
         3YKa9LjjLUX+jmwS9m5QpfxDhMzkqIB1f81YGWAhRnOpjePylCyFFLPQMnyQPmr2Tr3E
         ERes3U/EH23ZgqRh/9ZQZBblkpqybf01p82lrB+CJHS/OELe6LdCpjzUmIxitrEXvyrI
         VM5lVVgkzJOqI0UmBMV6aFIiM3erj8Nc6QSj/xdbAsST2rVDCudEvr08GBXcHG35f3I6
         5fabNRupBaASj/eCJSTusDgBMQ+IOhYT6gw5mWj2hoNbl7OXwIJCqIU8TKlORWq/On5M
         roCg==
X-Forwarded-Encrypted: i=1; AJvYcCVHkRC245QK/FZHEl5AVCpAwRMt51H3yXgWtqVcNYbsStMEbbmuEUZvUwdT5GEDFdHZds+AmbFfvmB+fRedfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPqTAY2+tu97+WoQqhW98c5JVFYKy2MNJFygiOOR3/XDcH1GlI
	6PPyNHVhkOBVtSxbTtz8f5M46dbEhslWTEz5YsAVxBgB60d0a34NI+OY0f68NzU/OvUm+WMp/ry
	Cmm4S9ry0E+JDw6Qos42YNXpaFQk4cAcUsdRwsSSrgwvc5W0/S1cxQmn5qohyBKauDQnj
X-Gm-Gg: ASbGnct/Y94NFS54fwvozd47c0bcU5xvG7qjlLLe+pSQyXkiXADMISQNmICdFjyuZ7b
	T7fV5j9jbDZV9RwlD6SepyHUvZXUh2brSSGI2WR+iTXSF9PsaHlpOAVhxvxc1iocoAqY4eZktVi
	hFUYt2fuBqQHiG12ePKGAWw+WS6e1E41otpU1XyWX/YLX6Rc+lqGC6o3pLI9M1cKJNMIPWdJqXt
	HEOjfu9Np8+3LfixJZ4H8TDszA0DdsBheFSGMeoFum1ukJk8K0EFMjsNlhYgNz/YLSe5lMC9O65
	KbW2ZqSGKIGaynOY85Ravmn83qT/PQgEYYP4e83yf72HPMphhnjKSj7Pn2Gk7ibuzXRQXtCTsbK
	5
X-Received: by 2002:a05:600c:45cd:b0:43e:bdf7:7975 with SMTP id 5b1f17b1804b1-4562e39b723mr54952815e9.32.1752746070345;
        Thu, 17 Jul 2025 02:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKTs+aDiZgCMhu1i/4GozMJF3wsJElPh33s6C2JLD4vLtS0U0c10KXmQnR7oMk09iqsCS4mQ==
X-Received: by 2002:a05:600c:45cd:b0:43e:bdf7:7975 with SMTP id 5b1f17b1804b1-4562e39b723mr54952455e9.32.1752746069847;
        Thu, 17 Jul 2025 02:54:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:5b4d:4594:545c:dd8? ([2a01:e0a:c:37e0:5b4d:4594:545c:dd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2d4fsm47154105e9.4.2025.07.17.02.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:54:29 -0700 (PDT)
Message-ID: <ab3ec7d1-b1ef-442a-aa0c-5ccc4504e318@redhat.com>
Date: Thu, 17 Jul 2025 11:54:28 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
To: Askar Safin <safinaskar@zohomail.com>
Cc: ryasuoka <ryasuoka@redhat.com>, airlied <airlied@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, kraxel <kraxel@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
 mripard <mripard@kernel.org>, simona <simona@ffwll.ch>,
 tzimmermann <tzimmermann@suse.de>,
 virtualization <virtualization@lists.linux.dev>
References: <20250613132023.106946-1-ryasuoka@redhat.com>
 <20250714000456.14-1-safinaskar@zohomail.com>
 <1961897d-cf42-4495-aec7-f4c20dfe7566@redhat.com>
 <1980fcccefe.10a7c92b36705.2744765212931179004@zohomail.com>
 <05c40a0a-d2b0-4f55-981f-6da3765eebb2@redhat.com>
 <1981535f461.11e01ca3b21091.7915707831085255756@zohomail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <1981535f461.11e01ca3b21091.7915707831085255756@zohomail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 490RxFmjuHejBQSMUS0prpMM6mutt-xu2mIWoAJzgBY_1752746070
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2025 23:48, Askar Safin wrote:
>   ---- On Wed, 16 Jul 2025 02:00:56 +0400  Jocelyn Falempe <jfalempe@redhat.com> wrote ---
>   > Yes, that's the default if you use a drm driver like bochs with fbdev
> 
> Thank you for answer! I just tried kernel from drm-tip with this config with drm_panic in qemu. And panic works.
> But I don't like result.
> When drm panic happens, messages printed to /dev/console disappear. Only kernel messages remain.

Yes, that's the expected behavior. DRM panic only prints the kernel 
messages, and don't mix that with console output.

> 
> Here are steps to reproduce. And then I will describe how this breaks my workflow.
> 
> Compile kernel from drm-tip ( https://gitlab.freedesktop.org/drm/tip ). I used commit b012f04b5be909a307ff629b297387e0ed55195a .
> It seems to include this bochs patch (i. e. "drm/bochs: Add support for drm_panic").
> Use this miniconfig:
> 
> $ cat mini
> CONFIG_64BIT=y
> 
> CONFIG_EXPERT=y
> 
> CONFIG_PRINTK=y
> CONFIG_PRINTK_TIME=y
> 
> CONFIG_PCI=y
> 
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_DRM=y
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_BOCHS=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PROC_FS=y
> 
> CONFIG_DRM_PANIC=y
> CONFIG_DRM_PANIC_SCREEN="kmsg"
> 
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_RD_GZIP=y
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_SCRIPT=y
> $ make KCONFIG_ALLCONFIG=mini allnoconfig
> 
> Create initramfs, which contains exactly these files:
> $ find /tmp/i -ls
>       2861      0 drwxrwxr-x   3 user     user           80 Jul 16 23:56 /tmp/i
>       2891      0 drwxrwxr-x   2 user     user           80 Jul 16 23:56 /tmp/i/bin
>       2893      0 lrwxrwxrwx   1 user     user            7 Jul 16 23:56 /tmp/i/bin/sh -> busybox
>       2892   1980 -rwxr-xr-x   1 user     user      2024544 Jul 16 23:56 /tmp/i/bin/busybox
>       2864      4 -rwxrwxr-x   1 user     user           43 Jul 16 23:18 /tmp/i/init
> 
> This is "init":
> ===
> #!/bin/sh
> 
> set -e
> 
> echo hello
> sleep 3
> exit 0
> ===
> 
> Now boot this in Qemu. I used this command:
> $ qemu-system-x86_64 -enable-kvm -m 1024  -kernel arch/x86/boot/bzImage -initrd /tmp/ini.cpio.gz
> 
> You will see word "hello", then after 3 seconds the system will fail into drm panic.
> 
> What I saw: word "hello" disappeared, when the system falled into panic
> What I expected to see: word "hello" should remain.

Even with fbcon, there is no guarantee that "hello" will remain visible, 
that depends on the screen size, and the amount of logs that the kernel 
panic will print.
> 
> Now let me describe how this breaks my workflow.
> 
> I often use hand-crafted shell scripts as PID 1. Both in Qemu and on real hardware.
> I use them to reproduce and bisect various kernel bugs.
> I always put "set -e" in the beginning of shell script. This means that script fails after first error.
> And thus system fails into kernel panic.
> I also sometimes put "set -x" to debug these scripts.
> Thus, when script fails and panic happens, then faulty shell command will be last thing printed on screen before panic stacktrace.
> But with drm_panic everything printed to /dev/console disappears.
> This breaks my workflow.
> 
> In Qemu I can easily workaround this by using serial console.
> 
> But I cannot do this on real hardware.
> 
> And yes, I experience fbcon panic problems on real hardware, too, this is why I'm interested in drm panic: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14658
> 
> (I have not yet tested whether drm_panic fixes that fbcon i915 panic problem, but I assume it does.)
> 
> I can workaround this by using efi fb with fb panic as opposed to i915. But this will not work if I attempting to catch bug in i915 itself.
> (And yes, I recently found another i915-related bug, and I'm trying to debug it using shell scripts running as PID 1.
> Here it is: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14598 .)
> 
> I can workaround this by logging everything to disk.
> But this will not work when everything is mounted read-only.
> And this is exactly what happens, when I try to catch that kexec-related bug:
> immediately before issuing "kexec -e" command I mount everything read-only.
> 
> The only remaining workaround is to redirect everything to /dev/kmsg.
> I. e. put "exec > /dev/kmsg 2>&1" to the script.
> This will work.
> But I still don't like this.

This is the workaround I would suggest, as DRM panic can only access the 
kmsg data, and has no knowledge of what fbcon was doing.

If the panic occurs because the PID 1 script exits, then the panic stack 
trace is not that relevant?

Another thing you can try, is to use DRM log instead of fbcon:

DRM_CLIENT_LOG=y
DRM_CLIENT_DEFAULT_LOG=y
DRM_FBDEV_EMULATION=n
DRM_CLIENT_DEFAULT="log"
DRM_PANIC=n

(and boot with console=drm_log)

drm-log doesn't scroll the whole screen, and use the non-blocking 
console API, so is less likely to make artifacts on the screen.

But in this case, you won't get the panic trace.

Best regards,

-- 

Jocelyn


> 
> --
> Askar Safin
> https://types.pl/@safinaskar
> 

