Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287E188713
	for <virtualization@lists.linux.dev>; Sun,  7 Jun 2026 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780806682; cv=none; b=GSkFa5EoUiQs227Q1fuxaRfVoDCdUwC08gvmrKjrhqQMbPnmhW54sjA4SC0c/tJZTSy2m/j9DXFZ2vjtm3ZwkSacfGWr8UTBK8K6svqm+BCpDU5nm1lPTyrkJauu+pHh/bWkKMwkCUc5m/Vo/hfaZsujw698I/Nj7EMAd9V1Qgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780806682; c=relaxed/simple;
	bh=8jzVhLOMoN0t7LIcaRp/sbjhzrA0XKAjY6XAmkWRb4g=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=mVrRe8PRrKF7Ep6OKsScPvL/+N0kXpbOHo1FLpU2ZrOsbIsl1U9TW1hznkEYfnw3HJADd5+eGdXFX82H7Zp4MYWafNd4Zge9yrLYgfXToyS2jDAvonRrpjQ+MZ8L5lAFtJzg3SSwsepyF0X7T4TFJ4hA8YNftNtOP8l2KmfHUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9VoGdsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9VoGdsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780806679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=tJIc4lTQ5VEQdW4Bdd5ewfIILPKdPE/fkGdJi617v1s=;
	b=E9VoGdsvPG5dnyKUXwFXCP61ccAYBIjY+/37tqnhjMkx7eOsjP+03eVOxLlEcgFxjO/lZi
	4tYOSiY+FFsACDK2PmRASdVIylZ2J22EMIJgr9LHmNiQqIWUqcUQf2TL9B58Wt5wl/j6vM
	g0H5lwaQognJhueQJi6aJgg2ecyoidw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-6z5alpy6PmOcYmPBi8PC_g-1; Sun, 07 Jun 2026 00:31:16 -0400
X-MC-Unique: 6z5alpy6PmOcYmPBi8PC_g-1
X-Mimecast-MFC-AGG-ID: 6z5alpy6PmOcYmPBi8PC_g_1780806675
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c272e532so33844625ad.1
        for <virtualization@lists.linux.dev>; Sat, 06 Jun 2026 21:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780806675; x=1781411475;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/kn03nkG5UqdNCpQmwPSZkDa90XeYGbLCBrwibbaXb8=;
        b=YGfhliiA/PddsxC3+cwiBzELavewEWjx9UfMt1zYhLbFK7sOEeJqOTuJ+NOT2EP8ao
         B8pAqmIq+RHLAD4wnmND6HG/RV/IjpzLACOnWfLiprKqGmbb4piGHj8VUVoZfLMTuPJl
         RijXB0lZDusVgOfUKzQ9ecySDlfc0a9LEuJogOBWaMSWx6cUwPu6Cf//ot/Av/ycdk3R
         EvKgOEacKr2P6c685fQTLHFkmfoxAmGlNdQfJAYpgYEIymyxDhruME0ZdpJVhhXFUVVT
         MXcLo2zzosaX+JjlM2kvnEGlPI4wiIfilXz+sfnSz0WrkEm3m5cK0H5STPOGBGsPocyO
         QdYg==
X-Forwarded-Encrypted: i=1; AFNElJ/yP2PDWQYg+0ZNQaic5fWe7bqeGvoR7/tmd1XTvPupNuhMhjzlI5cNojEzelm6D9r+GpIZxJ2XshNSVabaEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX/7fJ6xbvKZSX7I2A+0OGy92y+MGrhoirfrVcd16D3sUyUIAb
	lJtPhgDXxwn16eBKH9K+bQEc5s8/06ZdmWavvoNhmLmHU9OHt+4j3Jr5wN4AwzS1TbHifCXibUF
	3ukuNp5HmdtgSnq6sfRkRwH04Gq69/MuNnyaYhCeOWc7/WUBcC7zOaZ6B+rfHORYc72M8
X-Gm-Gg: Acq92OHG26UrLO1RjbQkgfV24Fx3KqPEfP6yXyQ+VfdWwnJLniasulWRpNAhvJexTrk
	NjwO7puGUi1wAcMMexKDdzrVHPNVq2Omw278AsO/MeIODgx8bRPY/7zzegtTcl+OscPPkX3fSLj
	I88aNFMr9s/3Sy5h+fR2A4M2FaY9RPBHRjCnfY3UqHAHksUbb+9xneewNEmKvMUesbzFd34PLMZ
	XYMkNbziIIb3zwEdVHhZqYLGMoo9k842/C0JMl3H9t5jAWEiFd2qlaj+bdmhoX3QwoFfokbAmOM
	0qQEWSPLX0gW1SGJQHna1LWlARlPSVeiMdPOxMuY/IJSfg5MLgPBT3R59aD0h30Zyb8ksbrHNxI
	e4T3Y5k3DEakFjq6ooXdg+r4DrCRcXOzbS29iWhTJy7AUPZTl+xioL3phOPRNwIXhGGdugA==
X-Received: by 2002:a17:903:46c3:b0:2c1:13b5:6c24 with SMTP id d9443c01a7336-2c1e7f922a9mr110067925ad.20.1780806675121;
        Sat, 06 Jun 2026 21:31:15 -0700 (PDT)
X-Received: by 2002:a17:903:46c3:b0:2c1:13b5:6c24 with SMTP id d9443c01a7336-2c1e7f922a9mr110067705ad.20.1780806674565;
        Sat, 06 Jun 2026 21:31:14 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm189888395ad.17.2026.06.06.21.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 21:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, 
	"David Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>, 
	"Gurchetan Singh" <gurchetansingh@chromium.org>, 
	"Chia-I Wu" <olvaffe@gmail.com>
In-Reply-To: <20260604122743.13383-1-dmitry.osipenko@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/virtio: Fix driver removal with disabled KMS
Message-ID: <18b6b23ae1412a71.6d9db1e7acbb9813.37ad12b07518c586@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Sun, 7 Jun 2026 04:31:08 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gdATzNdKWki6fdh6U3pAitJs74lngxptIa4RIDmZ4Ys_1780806675
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry

On 04/06/2026 15:27, Dmitry Osipenko wrote:
> DRM atomic and modesetting aren't initialized if virtio-gpu driver built
> with disabled KMS, leading to access of uninitialized data on driver
> removal/unbinding and crashing kernel. Fix it by skipping shutting down
> atomic core with unavailable KMS.
>=20
> Fixes: 72122c69d717 ("drm/virtio: Add option to disable KMS support")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virti=
o/virtgpu_drv.c
> index f0fb784c0f6f..2aaa7cb08085 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -138,7 +138,10 @@ static void virtio_gpu_remove(struct virtio_device *=
vdev)
> =20
>  =09virtio_gpu_release_vqs(dev);
>  =09drm_dev_unplug(dev);
> -=09drm_atomic_helper_shutdown(dev);
> +
> +=09if (drm_core_check_feature(dev, DRIVER_ATOMIC))
> +=09=09drm_atomic_helper_shutdown(dev);
> +
>  =09virtio_gpu_deinit(dev);
>  =09drm_dev_put(dev);
>  }

The patch looks good to me at a glance. I haven't done a full, deep code
review yet, but I've tested it on my lab and everything works as
expected.

Tested-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

test info
base-commit: ce73a5db44e3d5f9c0c061f0868ae209b59605f1 (drm-misc)

Removing the virtio-gpu device by the following command, and the following
panic message can be observed.

# echo 1 > /sys/devices/pci0000\:00/0000\:00\:01.0/remove

[  330.048794] ------------[ cut here ]------------
[  330.050023] WARNING: drivers/gpu/drm/drm_modeset_lock.c:319 at drm_modes=
et_lock+0x118/0x120, CPU#5: bash/22216
[  330.052581] Modules linked in: rfkill nft_fib_inet nft_fib_ipv4 nft_fib_=
ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_c=
t nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables=
 sunrpc qrtr vfat snd_hda_codec_generic fat intel_rapl_msr intel_rapl_commo=
n snd_hda_intel snd_intel_dspcfg snd_hda_codec kvm_amd iTCO_wdt intel_pmc_b=
xt snd_hwdep kvm snd_hda_core snd_pcm i2c_i801 irqbypass i2c_smbus snd_time=
r snd lpc_ich soundcore virtio_balloon virtio_net net_failover failover joy=
dev dm_multipath loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_c=
ommon vmw_vsock_vmci_transport vmw_vmci zram lz4hc_compress vsock lz4_compr=
ess virtio_scsi virtio_gpu virtio_dma_buf serio_raw scsi_dh_rdac scsi_dh_em=
c scsi_dh_alua i2c_dev qemu_fw_cfg virtiofs fuse
[  330.067477] CPU: 5 UID: 0 PID: 22216 Comm: bash Not tainted 7.1.0-rc5 #9=
 PREEMPT(lazy)
[  330.069058] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk=
2-20251119-3.fc43 11/19/2025
[  330.070880] RIP: 0010:drm_modeset_lock+0x118/0x120
[  330.071858] Code: e8 ad e3 48 ff 85 c0 75 c7 b8 f0 ff ff ff eb c2 0f 0b =
e9 22 ff ff ff e8 06 82 5e 00 4c 8b 04 24 48 8b 4c 24 08 e9 40 ff ff ff <0f=
> 0b e9 4e ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[  330.075466] RSP: 0018:ffffd2f38ea6baf8 EFLAGS: 00010286
[  330.076522] RAX: 0000000000000000 RBX: ffffd2f38ea6bb78 RCX: ffffd2f38ea=
6bb78
[  330.077939] RDX: ffff8ea806fd8000 RSI: ffffd2f38ea6bb78 RDI: ffff8ea8016=
ce190
[  330.079362] RBP: ffffd2f38ea6bb78 R08: ffff8ea8016ce170 R09: 000000000fe=
6d5f1
[  330.080785] R10: fffff93844235700 R11: ffff8ea80004f800 R12: 00000000000=
00000
[  330.082410] R13: ffff8ea8016ce000 R14: 0000000000000090 R15: ffff8ea8017=
180d0
[  330.083787] FS:  00007f202225f780(0000) GS:ffff8ea9ecea0000(0000) knlGS:=
0000000000000000
[  330.085395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  330.086553] CR2: 00005567379b41a0 CR3: 00000001a100e000 CR4: 00000000007=
50ef0
[  330.087980] PKRU: 55555554
[  330.088556] Call Trace:
[  330.089041]  <TASK>
[  330.089480]  ? rcutree_enqueue.isra.0+0x1e/0xe0
[  330.090365]  drm_modeset_lock_all_ctx+0x29/0x3f0
[  330.091274]  ? mnt_get_count+0x4d/0xa0
[  330.091988]  ? __destroy_inode+0x8a/0x180
[  330.092799]  drm_atomic_helper_shutdown+0x7b/0x120
[  330.093779]  virtio_gpu_remove+0x57/0x70 [virtio_gpu]
[  330.094784]  virtio_dev_remove+0x3f/0x90
[  330.095595]  device_release_driver_internal+0x19e/0x200
[  330.096626]  bus_remove_device+0xe4/0x1c0
[  330.097425]  ? srso_alias_return_thunk+0x5/0xfbef5
[  330.098390]  ? device_remove_attrs+0xa1/0x100
[  330.099224]  device_del+0x160/0x3d0
[  330.099937]  ? srso_alias_return_thunk+0x5/0xfbef5
[  330.100881]  ? pci_bus_read_config_dword+0x4c/0x80
[  330.101842]  device_unregister+0x17/0x70
[  330.102629]  unregister_virtio_device+0x15/0x30
[  330.103555]  virtio_pci_remove+0x3f/0x80
[  330.104340]  pci_device_remove+0x4a/0xc0
[  330.105094]  device_release_driver_internal+0x19e/0x200
[  330.106142]  pci_stop_bus_device+0x63/0x80
[  330.106995]  pci_stop_and_remove_bus_device_locked+0x1a/0x30
[  330.108113]  remove_store+0x83/0xa0
[  330.108830]  kernfs_fop_write_iter+0x147/0x200
[  330.109773]  vfs_write+0x25d/0x480
[  330.110483]  ksys_write+0x73/0xf0
[  330.111140]  do_syscall_64+0xe2/0x560
[  330.112093]  ? srso_alias_return_thunk+0x5/0xfbef5
[  330.113066]  ? irqentry_exit+0x40/0x6c0
[  330.113858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  330.114800]  ? do_syscall_64+0x99/0x560
[  330.115551]  ? exc_page_fault+0x82/0x1d0
[  330.116318]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  330.117286] RIP: 0033:0x7f20222d0bbe
[  330.117969] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 =
00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9=
> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  330.121352] RSP: 002b:00007ffdb43331f0 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000001
[  330.122797] RAX: ffffffffffffffda RBX: 00007f202244c5c0 RCX: 00007f20222=
d0bbe
[  330.124122] RDX: 0000000000000002 RSI: 00005567379b41a0 RDI: 00000000000=
00001
[  330.125459] RBP: 00007ffdb4333200 R08: 0000000000000000 R09: 00000000000=
00000
[  330.126839] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[  330.128205] R13: 0000000000000002 R14: 00005567379b41a0 R15: 00005567379=
c3370
[  330.129605]  </TASK>
[  330.130073] ---[ end trace 0000000000000000 ]---
[  330.130987] BUG: kernel NULL pointer dereference, address: 0000000000000=
018
[  330.131963] #PF: supervisor write access in kernel mode
[  330.131963] #PF: error_code(0x0002) - not-present page
[  330.131963] PGD 0 P4D 0
[  330.131963] Oops: Oops: 0002 [#1] SMP NOPTI
[  330.131963] CPU: 5 UID: 0 PID: 22216 Comm: bash Tainted: G        W     =
      7.1.0-rc5 #9 PREEMPT(lazy)
[  330.131963] Tainted: [W]=3DWARN
[  330.131963] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk=
2-20251119-3.fc43 11/19/2025
[  330.131963] RIP: 0010:ww_mutex_lock+0x38/0x110
[  330.131963] Code: 89 f4 55 53 48 89 fb 48 83 ec 20 65 48 8b 2d 57 93 21 =
02 48 89 6c 24 18 31 ed 2e 2e 2e 31 c0 65 48 8b 15 53 93 21 02 48 89 e8 <f0=
> 48 0f b1 13 75 53 4d 85 e4 74 2a 48 8d 6c 24 08 41 83 44 24 10
[  330.131963] RSP: 0018:ffffd2f38ea6bae0 EFLAGS: 00010246
[  330.131963] RAX: 0000000000000000 RBX: 0000000000000018 RCX: ffffd2f38ea=
6bb78
[  330.131963] RDX: ffff8ea806fd8000 RSI: ffffd2f38ea6bb78 RDI: 00000000000=
00018
[  330.131963] RBP: 0000000000000000 R08: ffff8ea8016ce170 R09: 000000000fe=
6d5f1
[  330.131963] R10: fffff93844235700 R11: ffff8ea80004f800 R12: ffffd2f38ea=
6bb78
[  330.131963] R13: ffff8ea8016ce000 R14: 0000000000000000 R15: 00000000000=
00018
[  330.131963] FS:  00007f202225f780(0000) GS:ffff8ea9ecea0000(0000) knlGS:=
0000000000000000
[  330.131963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  330.131963] CR2: 0000000000000018 CR3: 00000001a100e000 CR4: 00000000007=
50ef0
[  330.131963] PKRU: 55555554
[  330.131963] Call Trace:
[  330.131963]  <TASK>
[  330.131963]  ? srso_alias_return_thunk+0x5/0xfbef5
[  330.131963]  ? drm_modeset_lock+0x92/0x120
[  330.131963]  drm_modeset_lock_all_ctx+0x8e/0x3f0
[  330.131963]  ? __destroy_inode+0x8a/0x180
[  330.131963]  drm_atomic_helper_shutdown+0x7b/0x120
[  330.131963]  virtio_gpu_remove+0x57/0x70 [virtio_gpu]
[  330.131963]  virtio_dev_remove+0x3f/0x90
[  330.131963]  device_release_driver_internal+0x19e/0x200
[  330.131963]  bus_remove_device+0xe4/0x1c0
[  330.131963]  ? srso_alias_return_thunk+0x5/0xfbef5
[  330.131963]  ? device_remove_attrs+0xa1/0x100
[  330.131963]  device_del+0x160/0x3d0
[  330.131963]  ? srso_alias_return_thunk+0x5/0xfbef5
[  330.131963]  ? pci_bus_read_config_dword+0x4c/0x80
[  330.131963]  device_unregister+0x17/0x70
[  330.131963]  unregister_virtio_device+0x15/0x30
[  330.131963]  virtio_pci_remove+0x3f/0x80
[  330.131963]  pci_device_remove+0x4a/0xc0
[  330.131963]  device_release_driver_internal+0x19e/0x200
[  330.131963]  pci_stop_bus_device+0x63/0x80
[  330.131963]  pci_stop_and_remove_bus_device_locked+0x1a/0x30
[  330.131963]  remove_store+0x83/0xa0
[  330.131963]  kernfs_fop_write_iter+0x147/0x200
[  330.131963]  vfs_write+0x25d/0x480
[  330.131963]  ksys_write+0x73/0xf0
[  330.131963]  do_syscall_64+0xe2/0x560
[  330.131963]  ? srso_alias_return_thunk+0x5/0xfbef5
[  330.131963]  ? irqentry_exit+0x40/0x6c0
[  330.131963]  ? srso_alias_return_thunk+0x5/0xfbef5
[  330.131963]  ? do_syscall_64+0x99/0x560
[  330.131963]  ? exc_page_fault+0x82/0x1d0
[  330.131963]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  330.131963] RIP: 0033:0x7f20222d0bbe
[  330.131963] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 =
00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9=
> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  330.131963] RSP: 002b:00007ffdb43331f0 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000001
[  330.131963] RAX: ffffffffffffffda RBX: 00007f202244c5c0 RCX: 00007f20222=
d0bbe
[  330.131963] RDX: 0000000000000002 RSI: 00005567379b41a0 RDI: 00000000000=
00001
[  330.131963] RBP: 00007ffdb4333200 R08: 0000000000000000 R09: 00000000000=
00000
[  330.131963] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[  330.131963] R13: 0000000000000002 R14: 00005567379b41a0 R15: 00005567379=
c3370
[  330.131963]  </TASK>
[  330.131963] Modules linked in: rfkill nft_fib_inet nft_fib_ipv4 nft_fib_=
ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_c=
t nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables=
 sunrpc qrtr vfat snd_hda_codec_generic fat intel_rapl_msr intel_rapl_commo=
n snd_hda_intel snd_intel_dspcfg snd_hda_codec kvm_amd iTCO_wdt intel_pmc_b=
xt snd_hwdep kvm snd_hda_core snd_pcm i2c_i801 irqbypass i2c_smbus snd_time=
r snd lpc_ich soundcore virtio_balloon virtio_net net_failover failover joy=
dev dm_multipath loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_c=
ommon vmw_vsock_vmci_transport vmw_vmci zram lz4hc_compress vsock lz4_compr=
ess virtio_scsi virtio_gpu virtio_dma_buf serio_raw scsi_dh_rdac scsi_dh_em=
c scsi_dh_alua i2c_dev qemu_fw_cfg virtiofs fuse
[  330.131963] CR2: 0000000000000018
[  330.131963] ---[ end trace 0000000000000000 ]---
[  330.131963] RIP: 0010:ww_mutex_lock+0x38/0x110
[  330.131963] Code: 89 f4 55 53 48 89 fb 48 83 ec 20 65 48 8b 2d 57 93 21 =
02 48 89 6c 24 18 31 ed 2e 2e 2e 31 c0 65 48 8b 15 53 93 21 02 48 89 e8 <f0=
> 48 0f b1 13 75 53 4d 85 e4 74 2a 48 8d 6c 24 08 41 83 44 24 10
[  330.131963] RSP: 0018:ffffd2f38ea6bae0 EFLAGS: 00010246
[  330.131963] RAX: 0000000000000000 RBX: 0000000000000018 RCX: ffffd2f38ea=
6bb78
[  330.131963] RDX: ffff8ea806fd8000 RSI: ffffd2f38ea6bb78 RDI: 00000000000=
00018
[  330.131963] RBP: 0000000000000000 R08: ffff8ea8016ce170 R09: 000000000fe=
6d5f1
[  330.131963] R10: fffff93844235700 R11: ffff8ea80004f800 R12: ffffd2f38ea=
6bb78
[  330.131963] R13: ffff8ea8016ce000 R14: 0000000000000000 R15: 00000000000=
00018
[  330.225288] FS:  00007f202225f780(0000) GS:ffff8ea9ecea0000(0000) knlGS:=
0000000000000000
[  330.225288] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  330.225288] CR2: 0000000000000018 CR3: 00000001a100e000 CR4: 00000000007=
50ef0
[  330.225288] PKRU: 55555554
[  330.225288] note: bash[22216] exited with irqs disabled

Best regards,
Ryosuke

