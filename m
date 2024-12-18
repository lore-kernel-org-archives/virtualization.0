Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5D198A17
	for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518467; cv=none; b=Moarg0zCGn5IdNU5vSwPsyBOh9z+cJg7EKn7mESMVOxE4YkJKKWzv2BBUuNh4naqOTLQwp0XyKapFY5j0M/od3DAIstoe3bhoiP++kLtYKf2LSN7Oj7tIJCh9ggnIcpRaFG5H8whT0D+ALKwobjtdMbuP9urMj1SxiuuV+Ejjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518467; c=relaxed/simple;
	bh=flh4IcwcQ5zG9u6w1tPjtoteBKHYwsTBLEZUy30H3pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdlQzGVyIllhr17qZXzwt9S2sOrXmtX+n2YGtis0T4vCyjBOKZOlP/cLf1LNYnvCZaPp0KtmuS+ON6AoN7G3Mjw7S/r9ncWdCw7WiO+eu3zS4fd9s7V27FTF4peVC3F3w9R9mLwlLxyD0YZfwI8He2RzxgUDsr8YwYfgUzpAzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=EHWXED0d; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EHWXED0d"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862b364538so337144f8f.1
        for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 02:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1734518464; x=1735123264; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe9+U77JJVuAGwYLkBxO9LE5lh/GQGdagTjj9pPlr70=;
        b=EHWXED0dLiOiD92Ps93Ke0bRaCrUL7LNgFo7zwsmokGCFoOcDqVA0lJIojQsLJLE1h
         8EoNC2nrzR28bXBEApDZwGbwx7gCs+GG2xhD0sYOdsMUtAnFrWB/bjJ4AdG/nfS6FdUw
         IQIJkYtEJJFXGa84WFrwuM/EbmInksh/REn1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734518464; x=1735123264;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pe9+U77JJVuAGwYLkBxO9LE5lh/GQGdagTjj9pPlr70=;
        b=qwwNF4oWR4FWbIOU3pAhBEneeRNdMbsx0kolFWv1/NfuA1ZEdPvAqXP/lqyk+56h3Z
         SfkOL8v8YheOB+ezg6OAVqXHGPc/TkteEQpoOs3M5aHU0tZhmKBpOS3kZl5EE5H6Qkkr
         7Uh2rJIwiAnagwMBsokwExzKuHdXUkYCUEVEmVf9DvTal9Orl/SIV0TJ91svtalZvZqP
         NWgo0vzAXGEOrTWccAL3ddHbiKvDDCOhlVtWyDB4BtSL2G3WW2LDmovUE9lcDjT+PEwx
         GdIOGmDlsaldgPwqv8CKJafBFU5zt9I6hgBjr9nXHuvgAq5KFpwobltXHWQ69xl2qYih
         2ARw==
X-Forwarded-Encrypted: i=1; AJvYcCXdIhGZxJzl6ln1bYObR08lKQI3Zn4D0rR2Z3I8/4mv1KwcH9t+skB1NVrQyS5mb9OnZEalD+Ul/7W5SEosNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRbuAIOesd90Cz0gsbjovwGUuD092F121jr6tTNKdHkLAbF05a
	FY7VhuJLInv6KsZ20WM0XFjYmMpWuLtT2ykSyLR3VBl3bk2r4DH27cPpMq/CjKY=
X-Gm-Gg: ASbGncuN+rJp87mgB5gtwTXrEXoNAjKiyCt+Ap5dMhWdxrHgah1iSK6XYVERok5CPTd
	9kRKcFtMDGzmVP0qoHBkND82FM+Wzc3fCzN8TiU9CYekp8D/hfDCAkIyKfImC+VlAt1DUTzSUjr
	WRBzXEtZ053W85rklyCEjcMF/ik1TJbCLmofy38OilvD0K/GEotFzWZirYI5oLxn0mKNQU/xIPI
	loe4RR5tZalyI4GcNcPJZy7b2ZpTRYP1GVrwBR8rFskH6vD4/Os5pEAyHnWEr0cw7EV
X-Google-Smtp-Source: AGHT+IEZvOsUYQjrwrE/oe95wj9YAPCDQ6F+SW4IHrOmGwe0jyn20QjwfCIG9upTPLksGjPgHIQPjA==
X-Received: by 2002:adf:a113:0:b0:386:42b1:d7e4 with SMTP id ffacd0b85a97d-388db275325mr5072145f8f.19.1734518463730;
        Wed, 18 Dec 2024 02:41:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c7fac5bbsm14134216f8f.0.2024.12.18.02.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 02:41:03 -0800 (PST)
Date: Wed, 18 Dec 2024 11:41:01 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
	Hans de Goede <hdegoede@redhat.com>, kraxel@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: a bochs-drm (?) oops on head
Message-ID: <Z2KmvZFRWT10fzhr@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Hans de Goede <hdegoede@redhat.com>, kraxel@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	dri-devel <dri-devel@lists.freedesktop.org>
References: <Z18dbfDAiFadsSdg@gallifrey>
 <b2e2a217-dced-472f-9084-9822f7e6803c@suse.de>
 <Z2AvS_8xgBhnF4CW@gallifrey>
 <51a183c7-de10-4419-b540-b7c2ab23520a@suse.de>
 <Z2Bk6-fxzw2dj5Eq@gallifrey>
 <30beb4da-50be-4e28-a19e-5d7f9680c7ea@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30beb4da-50be-4e28-a19e-5d7f9680c7ea@suse.de>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Tue, Dec 17, 2024 at 12:43:11PM +0100, Thomas Zimmermann wrote:
> (cc'ing Hans, who implemented deferred console takeover)
> 
> Hi
> 
> Am 16.12.24 um 18:35 schrieb Dr. David Alan Gilbert:
> > * Thomas Zimmermann (tzimmermann@suse.de) wrote:
> > > Hi
> > > 
> > > 
> > > Am 16.12.24 um 14:46 schrieb Dr. David Alan Gilbert:
> > > [...]
> > > > > The attached patch fixes the problem for me. Could you please test and
> > > > > report back the results.
> > > > That gets me a different oops; this was run with:
> > > > qemu-system-x86_64  -M pc -cpu host --enable-kvm -smp 4 -m 2G -kernel /discs/fast/kernel/arch/x86/boot/bzImage -append "console=tty0 console=ttyS0 root=/dev/vdb1 single" -drive if=virtio,file=/discs/more/images/debian12-64scan.qcow2
> > > > 
> > > > It looks to me if it made the mistake of trying to print something in the middle of being removed:
> > >  From the stack trace below, I'd say it is the one at [1]. But I fail to
> > > reproduce the problem.
> > > 
> > > Could you please send me the complete output of dmesg after the system
> > > finished booting?
> > Sure; this is as far as it gets until it hits the vga oops that stops it:
> 
> I was able to reproduce it a single time. My setup is
> 
> - CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
> - CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
> - startup with vgacon
> - 'quiet' on kernel command line (important!)
> 
> and then I got the segfault you report.
> 
> With the provided stack trace and log, I think I got some idea what is
> happened
> 
> > 
> > [    0.000000][    T0] Linux version 6.13.0-rc2+ (dg@dalek) (gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3), GNU ld version 2.43.1-4.fc41) #373 SMP PREEMPT_DYNAMIC Mon Dec 16 13:25:32 GMT 2024
> > [    0.000000][    T0] Command line: console=tty0 console=ttyS0 root=/dev/vdb1 single
> [...]
> > [   74.077481][    T1] SPI driver abt-y030xx067a has no spi_device_id for abt,y030xx067a
> > [   74.088805][    T1] SPI driver panel-ilitek-ili9322 has no spi_device_id for dlink,dir-685-panel
> > [   74.090492][    T1] SPI driver panel-ilitek-ili9322 has no spi_device_id for ilitek,ili9322
> > [   74.094556][    T1] SPI driver panel-innolux-ej030na has no spi_device_id for innolux,ej030na
> > [   74.106367][    T1] SPI driver nt39016 has no spi_device_id for kingdisplay,kd035g6-54nt
> > [   74.116623][    T1] SPI driver s6d27a1-panel has no spi_device_id for samsung,s6d27a1
> > [   74.120701][    T1] SPI driver panel-samsung-s6e63m0 has no spi_device_id for samsung,s6e63m0
> 
> > [   74.177273][    T1] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
> 
> This comes from the first iteration in really_probe() [1]. This is the bochs
> instance that will be removed. It should install fbcon, but that gets
> deferred.

I don't think that's correct, because ...

> [1] https://elixir.bootlin.com/linux/v6.12.5/source/drivers/base/dd.c#L631
> 
> > [   74.179388][    T1] [drm] Found bochs VGA, ID 0xb0c5.
> > [   74.180931][    T1] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
> > [   74.199314][    T1] [drm] Initialized bochs-drm 1.0.0 for 0000:00:02.0 on minor 2
> > [   74.265834][    T1] fbcon: bochs-drmdrmfb (fb1) is primary device
> > [   74.265882][    T1] fbcon: Remapping primary device, fb1, to tty 1-63

... the above line I think is only ever printed if we're not deferred
anymore:
- One such printk is in fbcon_remap_all(), but after checking for
  deferred_takeover and bailing out if that's set.
- The other is in do_fb_registered -> fbcon_select_primary (but only if
  CONFIG_FRAMEBUFFER_DETECT_PRIMARY is set), which is before we check for
  deferred_takeover. But if deferred_takeover is set that path should
  print

  		pr_info("fbcon: Deferring console take-over\n");

  which does not seem to be the case.

But then I have no idea why deferred fbcon could have any impact at all.
Really puzzling.
-Sima

> > [   79.736367][    T1] bochs-drm 0000:00:02.0: [drm] fb1: bochs-drmdrmfb frame buffer device
> 
> End of first bochs instance here..
> 
> > [   79.800872][    T1] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
> 
> The second instance of bochs starts here and tries to deactivate the console
> a second time. Notice that we didn't have any "Console is " or "Taking over
> console" messages.
> 
> > [   79.802400][    T1] BUG: kernel NULL pointer dereference, address: 000000000000020c
> 
> I've not been able to figure out what is a offset 0x20c (524 decimal). None
> of the structs involved appears to have any fields starting at this offset.
> The nearest case is vc_hi_font_mask, [2] which is at +520. Could be related
> to aligned memory access. get_color() would read that field. [3] vc_num at
> +512 is another candidate.
> 
> [2] https://elixir.bootlin.com/linux/v6.13-rc2/source/include/linux/console_struct.h#L124
> [3] https://elixir.bootlin.com/linux/v6.13-rc2/source/drivers/video/fbdev/core/fbcon.c#L302
> 
> > [   79.802448][    T1] #PF: supervisor write access in kernel mode
> > [   79.802498][    T1] #PF: error_code(0x0002) - not-present page
> > [   79.802545][    T1] PGD 0 P4D 0
> > [   79.802622][    T1] Oops: Oops: 0002 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
> > [   79.802669][    T1] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.13.0-rc2+ #373 5a5c0ce8f09b0b72067981f01985e201a0118bb6
> > [   79.802669][    T1] Tainted: [W]=WARN, [N]=TEST
> > [   79.802669][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> > [   79.802669][    T1] RIP: 0010:fbcon_cursor+0xa9/0x3c0
> > [   79.802669][    T1] Code: c0 05 00 00 66 89 44 24 06 e8 f3 35 2a fd 0f b7 bb c0 05 00 00 e8 27 b8 e9 fc 49 8d bc 24 0c 02 00 00 49 89 c7 e8 d7 3d 2a fd <45> 89 bc 24 0c 02 00 00 48 8d bd e0 05 00 00 e8 c3 3b 2a fd 44 8b
> > [   79.802669][    T1] RSP: 0018:ffffb70f800136c0 EFLAGS: 00010046
> > [   79.802669][    T1] RAX: 0000000000000000 RBX: ffff9d4fc10a8800 RCX: 0000000000000000
> > [   79.802669][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > [   79.802669][    T1] RBP: ffff9d4fc54ba800 R08: 0000000000000000 R09: 0000000000000000
> > [   79.802669][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > [   79.802669][    T1] R13: 0000000000000000 R14: ffff9d4fc54bade8 R15: 0000000000000032
> > [   79.802669][    T1] FS:  0000000000000000(0000) GS:ffff9d503d200000(0000) knlGS:0000000000000000
> > [   79.802669][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   79.802669][    T1] CR2: 000000000000020c CR3: 0000000056520000 CR4: 0000000000350ef0
> > [   79.802669][    T1] Call Trace:
> > [   79.802669][    T1]  <TASK>
> > [   79.802669][    T1]  ? __die+0x23/0x80
> > [   79.802669][    T1]  ? page_fault_oops+0x21c/0x240
> > [   79.802669][    T1]  ? do_user_addr_fault+0x893/0x1180
> > [   79.802669][    T1]  ? srso_return_thunk+0x5/0x7f
> > [   79.802669][    T1]  ? exc_page_fault+0x3f/0x180
> > [   79.802669][    T1]  ? exc_page_fault+0x87/0x180
> > [   79.802669][    T1]  ? asm_exc_page_fault+0x26/0x40
> 
> > [   79.802669][    T1]  ? fbcon_cursor+0xa9/0x3c0
> > [   79.802669][    T1]  hide_cursor+0x66/0x1c0
> > [   79.802669][    T1]  vt_console_print+0x9b1/0xa40
> 
> I think we get here via steps [4] to [8].
> 
> [4]
> https://elixir.bootlin.com/linux/v6.13-rc2/source/drivers/pci/vgaarb.c#L173
> [5]
> https://elixir.bootlin.com/linux/v6.13-rc2/source/drivers/tty/vt/vt.c#L3287
> [6]
> https://elixir.bootlin.com/linux/v6.13-rc2/source/drivers/tty/vt/vt.c#L861
> [7]
> https://elixir.bootlin.com/linux/v6.13-rc2/source/drivers/tty/vt/vt.c#L846
> [8] https://elixir.bootlin.com/linux/v6.13-rc2/source/drivers/video/fbdev/core/fbcon.c#L1322
> 
> When vt_console_print() invokes the call at [9], it apparently replaces the
> deferred console implementation (maybe ?) and
> then the next line [5] operates on a NULL pointer somewhere.
> 
> [9]
> https://elixir.bootlin.com/linux/v6.13-rc2/source/drivers/tty/vt/vt.c#L3286
> 
> Best regards
> Thomas
> 
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
