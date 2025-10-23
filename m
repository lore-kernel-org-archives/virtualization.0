Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59152DC77B
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206039; cv=none; b=t+EQBNRJ2KzMFIC5p0tKBC2hDx8fRbHr+5EU7JvncvvwOFOQF/FnAIUz721aU+uTOSrDCdn686TsB7H2M40r2BEuxqqIkbYlFJuuNPT+dAHX0zgvRxRVVuEJEA/YhMRe9skqxiwpHXyBngFQRYyPNimTeJ6NFKvoFisfAGpVYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206039; c=relaxed/simple;
	bh=CmUJnmDN5lrR0urFzrhJD3MHidheDBMN7LCKKraUoq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1XK7HylAcnCDqlHBxSKHaZTQ4cx53Y+OjybxJTDZlbTf1PNowZdUOeeyrdhQK36KvPOyDhca+E5gvYzlnoZQxlvlEe6ZtP0Pu1b65Clyte+ar3XqvJSNtzk1ChUK9wnJ+mW1i2B1SPz6VW7wBg/0mJhDjtxbKeh2HNYbjolD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zI7HOAxb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dd+EfS0N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1FsqPMaJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KYi9vLUX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zI7HOAxb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dd+EfS0N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1FsqPMaJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KYi9vLUX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E1921F770;
	Thu, 23 Oct 2025 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761206030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BlLHjAIU8aeeRy23Cw2AHcLGg/QAn/jnt8vlILcYmCI=;
	b=zI7HOAxbZK+w5V+1XPg8Wpub1jVgR9K7Zf7VxLTjsyMoJDfyA8LQqADG/J3RyWTH1zlH6C
	YLJuezowSEBmXorB64rINo2SOd017wc3YJEv2pS/dnQ4cwYqbIBAnom4GDL2jRgckjpn65
	BE2yFm3SEiUk9PbfnVwdacfZmrlxkfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761206030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BlLHjAIU8aeeRy23Cw2AHcLGg/QAn/jnt8vlILcYmCI=;
	b=dd+EfS0NmqKjf8tVJhg4mTYL7jA9Um9AoaqJdd/PXX4a2Z0Nm9f1YfgfJ/SjvGG6WUpOBJ
	crrm0ZI3Np7BgXDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761206026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BlLHjAIU8aeeRy23Cw2AHcLGg/QAn/jnt8vlILcYmCI=;
	b=1FsqPMaJGQaPhtW5DODXGDyasYKBOBE35Eps578lutJApsTQ9OGsgaE4CcfAiRP7ao8AK7
	FHGqVdTdXM2FfZotFa+psxIKt+Rlp5xk8C7jBSH+FF/M0ihVsudyqnIFIzcJVHqTldGs0B
	CzsWo51yIEJD8t9FZ/17krNQlarPM3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761206026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BlLHjAIU8aeeRy23Cw2AHcLGg/QAn/jnt8vlILcYmCI=;
	b=KYi9vLUXZeHjO3xHktnzbz13c56IToo0OX4p0Pk/Pd2AIMUAJ6Iy4D08qCfb6sk/BvtVCH
	/IFhDpGYjzb1pjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2644213285;
	Thu, 23 Oct 2025 07:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +oRTBwrf+Wj8YwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 23 Oct 2025 07:53:46 +0000
Message-ID: <6c9eb081-45ad-4fbd-90df-ac87f0b6223a@suse.de>
Date: Thu, 23 Oct 2025 09:53:45 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [drm/qxl] e485883c81:
 WARNING:at_drivers/gpu/drm/drm_vblank.c:#drm_wait_one_vblank
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Gerd Hoffmann <kraxel@redhat.com>,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
References: <202510221555.8c60c069-lkp@intel.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <202510221555.8c60c069-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,01.org:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi,

see  [1] for a workaround. Most likely, the vblank timeout is simply 
handled too late.

[1] 
https://lore.kernel.org/dri-devel/20251003032303.16518-1-chintanlike@gmail.com/

Best regards
Thomas


Am 23.10.25 um 04:29 schrieb kernel test robot:
>
> Hello,
>
> kernel test robot noticed "WARNING:at_drivers/gpu/drm/drm_vblank.c:#drm_wait_one_vblank" on:
>
> commit: e485883c815ee908de82547806d6edd65664b77b ("drm/qxl: Use vblank timer")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: trinity
> version:
> with following parameters:
>
> 	runtime: 300s
> 	group: group-01
> 	nr_groups: 5
>
>
>
> config: x86_64-dcg_x86_64_defconfig-tdx
> compiler: gcc-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
> we noticed the issue happens randomly. 6 times out of 50 runs as below.
> but the parent keeps clean.
>
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
>    vm-snb/trinity/yocto-x86_64-minimal-20190520.cgz/x86_64-dcg_x86_64_defconfig-tdx/gcc-14/300s/group-01/5
>
> 42dd66d377ccf786 e485883c815ee908de82547806d
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>             :50          12%           6:50    dmesg.RIP:drm_wait_one_vblank
>             :50          12%           6:50    dmesg.WARNING:at_drivers/gpu/drm/drm_vblank.c:#drm_wait_one_vblank
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202510221555.8c60c069-lkp@intel.com
>
>
> [  256.077310][  T135] ------------[ cut here ]------------
> [  256.078847][  T135] bochs-drm 0000:00:02.0: [drm] vblank wait timed out on crtc 0
> [  256.080802][  T135] WARNING: CPU: 0 PID: 135 at drivers/gpu/drm/drm_vblank.c:1320 drm_wait_one_vblank (drivers/gpu/drm/drm_vblank.c:1320 (discriminator 5))
> [  256.083260][  T135] Modules linked in: 8021q bridge stp llc nfc pppoe pppox ppp_generic slhc crypto_user ib_core nfnetlink scsi_transport_iscsi xfrm_user sctp ip6_udp_tunnel udp_tunnel uvesafb sr_mod cdrom intel_rapl_msr joydev ppdev ata_generic pata_acpi intel_rapl_common psmouse i2c_piix4 serio_raw bochs drm_shmem_helper ata_piix i2c_smbus parport_pc parport
> [  256.094913][  T135] CPU: 0 UID: 0 PID: 135 Comm: kworker/0:4 Not tainted 6.18.0-rc1-00240-ge485883c815e #1 PREEMPT(none)
> [  256.097761][  T135] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  256.100575][  T135] Workqueue: events drm_fb_helper_damage_work
> [  256.102578][  T135] RIP: 0010:drm_wait_one_vblank (drivers/gpu/drm/drm_vblank.c:1320 (discriminator 5))
> [  256.104543][  T135] Code: 00 4d 8b 75 50 4d 85 f6 0f 84 5e 01 00 00 4c 89 ef e8 8d eb 74 00 89 e9 4c 89 f2 48 c7 c7 60 0b c6 a2 48 89 c6 e8 e9 d1 e2 fd <0f> 0b e9 9a fe ff ff 48 85 db 74 23 48 b8 00 00 00 00 00 fc ff df
> All code
> ========
>     0:	00 4d 8b             	add    %cl,-0x75(%rbp)
>     3:	75 50                	jne    0x55
>     5:	4d 85 f6             	test   %r14,%r14
>     8:	0f 84 5e 01 00 00    	je     0x16c
>     e:	4c 89 ef             	mov    %r13,%rdi
>    11:	e8 8d eb 74 00       	call   0x74eba3
>    16:	89 e9                	mov    %ebp,%ecx
>    18:	4c 89 f2             	mov    %r14,%rdx
>    1b:	48 c7 c7 60 0b c6 a2 	mov    $0xffffffffa2c60b60,%rdi
>    22:	48 89 c6             	mov    %rax,%rsi
>    25:	e8 e9 d1 e2 fd       	call   0xfffffffffde2d213
>    2a:*	0f 0b                	ud2		<-- trapping instruction
>    2c:	e9 9a fe ff ff       	jmp    0xfffffffffffffecb
>    31:	48 85 db             	test   %rbx,%rbx
>    34:	74 23                	je     0x59
>    36:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>    3d:	fc ff df
>
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	e9 9a fe ff ff       	jmp    0xfffffffffffffea1
>     7:	48 85 db             	test   %rbx,%rbx
>     a:	74 23                	je     0x2f
>     c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>    13:	fc ff df
> [  256.109982][  T135] RSP: 0018:ffffc9000079fb78 EFLAGS: 00010282
> [  256.112311][  T135] RAX: 0000000000000000 RBX: ffff88815e2c0000 RCX: 0000000000000000
> [  256.114875][  T135] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
> [  256.117530][  T135] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff476a008
> [  256.120090][  T135] R10: 0000000000000003 R11: 0000000000000001 R12: 1ffff920000f3f70
> [  256.122749][  T135] R13: ffff88810fe460c8 R14: ffff88810be64d00 R15: ffff88815cfb2830
> [  256.125298][  T135] FS:  0000000000000000(0000) GS:ffff888408834000(0000) knlGS:0000000000000000
> [  256.131615][  T135] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  256.135805][  T135] CR2: 000000000109a850 CR3: 000000016d2a0000 CR4: 00000000000406f0
> [  256.137327][  T135] Call Trace:
> [  256.145896][  T135]  <TASK>
> [  256.147603][  T135]  ? __pfx_drm_wait_one_vblank (drivers/gpu/drm/drm_vblank.c:1301)
> [  256.149778][  T135]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [  256.153665][  T135]  ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 kernel/locking/spinlock_debug.c:101 kernel/locking/spinlock_debug.c:141)
> [  256.157616][  T135]  ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3))
> [  256.165734][  T135]  drm_client_modeset_wait_for_vblank (drivers/gpu/drm/drm_client_modeset.c:1331)
> [  256.172077][  T135]  drm_fb_helper_fb_dirty (drivers/gpu/drm/drm_fb_helper.c:373)
> [  256.177086][  T135]  ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
> [  256.181829][  T135]  ? __pfx_drm_fb_helper_fb_dirty (drivers/gpu/drm/drm_fb_helper.c:364)
> [  256.187127][  T135]  ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:114)
> [  256.192329][  T135]  process_one_work (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/workqueue.h:110 kernel/workqueue.c:3268)
> [  256.197045][  T135]  worker_thread (kernel/workqueue.c:3340 (discriminator 2) kernel/workqueue.c:3427 (discriminator 2))
> [  256.201991][  T135]  ? __kthread_parkme (arch/x86/include/asm/bitops.h:202 (discriminator 1) arch/x86/include/asm/bitops.h:232 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) kernel/kthread.c:290 (discriminator 1))
> [  256.206956][  T135]  ? __pfx_worker_thread (kernel/workqueue.c:3373)
> [  256.216519][  T135]  ? __pfx_worker_thread (kernel/workqueue.c:3373)
> [  256.220825][  T135]  kthread (kernel/kthread.c:463)
> [  256.224107][  T135]  ? __pfx_kthread (kernel/kthread.c:412)
> [  256.229092][  T135]  ? __pfx_kthread (kernel/kthread.c:412)
> [  256.233881][  T135]  ? __pfx_kthread (kernel/kthread.c:412)
> [  256.239125][  T135]  ret_from_fork (arch/x86/kernel/process.c:164)
> [  256.244094][  T135]  ? __pfx_kthread (kernel/kthread.c:412)
> [  256.248707][  T135]  ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
> [  256.254397][  T135]  </TASK>
> [  256.260599][  T135] ---[ end trace 0000000000000000 ]---
> [  349.555954][  T346] sh: can't kill pid 3589: No such process
> LKP: ttyS0: 304: LKP: rebooting forcely
> [  359.020039][  T304] sysrq: Emergency Sync
> [  359.022624][    T9] Emergency Sync complete
> [  359.032291][  T304] sysrq: Resetting
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251022/202510221555.8c60c069-lkp@intel.com
>
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


