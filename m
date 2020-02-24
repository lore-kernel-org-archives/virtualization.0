From: LABBE Corentin <clabbe@baylibre.com>
Subject: Re: [CRASH] crypto: virtio: crash when modprobing tcrypt on 5.5-rc7
 / next-20200122
Date: Mon, 24 Feb 2020 20:13:20 +0100
Message-ID: <20200224191320.GA11690@Red>
References: <20200123101000.GB24255@Red>
 <20200204041419-mutt-send-email-mst@kernel.org>
 <20200220191553.GA30549@Red>
 <33183CC9F5247A488A2544077AF19020DF4B2ED4@dggeml511-mbx.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DF4B2ED4@dggeml511-mbx.china.huawei.com>
Sender: linux-crypto-owner@vger.kernel.org
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "Liujinsong (Paul)" <liu.jinsong@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Feb 23, 2020 at 03:06:00PM +0000, Gonglei (Arei) wrote:
> 
> > -----Original Message-----
> > From: LABBE Corentin [mailto:clabbe@baylibre.com]
> > Sent: Friday, February 21, 2020 3:16 AM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: jasowang@redhat.com; herbert@gondor.apana.org.au;
> > davem@davemloft.net; virtualization@lists.linux-foundation.org;
> > linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; mst@redhat.com
> > Subject: Re: [CRASH] crypto: virtio: crash when modprobing tcrypt on 5.5-rc7 /
> > next-20200122
> > 
> > On Tue, Feb 04, 2020 at 04:15:22AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Jan 23, 2020 at 11:10:00AM +0100, LABBE Corentin wrote:
> > > > Hello
> > > >
> > > > When modprobing tcrypt on qemu 4.1.0 I get a kernel panic on 5.5-rc7
> > > > and next-20200122 qemu is started by:
> > > > /usr/bin/qemu-system-x86_64 -cpu host -enable-kvm -nographic -net
> > > > nic,model=e1000,macaddr=52:54:00:12:34:58 -net tap -m 512 -monitor
> > > > none -object cryptodev-backend-builtin,id=cryptodev0 -device
> > > > virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 -append
> > > > 'console=ttyS0 root=/dev/ram0 ip=dhcp' -kernel
> > > > /var/lib/lava/dispatcher/tmp/41332/deployimages-td18675m/kernel/bzIm
> > > > age -initrd
> > > > /var/lib/lava/dispatcher/tmp/41332/deployimages-td18675m/ramdisk/roo
> > > > tfs.cpio.gz -drive
> > > > format=qcow2,file=/var/lib/lava/dispatcher/tmp/41332/apply-overlay-g
> > > > uest-icy4k1ol/lava-guest.qcow2,media=disk,if=ide,id=lavatest
> > > >
> > > > [  112.771925] general protection fault: 0000 [#1] SMP PTI [
> > > > 112.772686] CPU: 0 PID: 126 Comm: virtio0-engine Not tainted
> > > > 5.5.0-rc7+ #1 [  112.773576] Hardware name: QEMU Standard PC (i440FX
> > > > + PIIX, 1996), BIOS
> > > > ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.org-2.fc31
> > > > 04/01/2014 [  112.775319] RIP: 0010:sg_next+0x0/0x20 [  112.775821]
> > > > Code: cc cc cc cc cc cc cc cc cc cc c7 47 10 00 00 00 00 89 57 0c 48
> > > > 89 37 89 4f 08 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 <f6>
> > > > 07 02 75 17 48 8b 57 20 48 8d 47 20 48 89 d1 48 83 e1 fc 83 e2 [
> > > > 112.778330] RSP: 0018:ffffa92440237d90 EFLAGS: 00010006 [
> > > > 112.779071] RAX: fefefefe00000000 RBX: 000000000000000a RCX:
> > > > fefefefe00000000 [  112.780081] RDX: 0000000000000001 RSI:
> > > > ffff9b19da1a2180 RDI: fefefefe00000000 [  112.781081] RBP:
> > > > ffff9b19da1a2198 R08: ffff9b19dfb24ee8 R09: 0000000000000a20 [
> > > > 112.782079] R10: ffff9b19da125010 R11: 0000000000000000 R12:
> > ffff9b19da1a21b8 [  112.783079] R13: 0000000000000003 R14:
> > ffff9b19da1a2180 R15: 0000000000000004 [  112.784077] FS:
> > 0000000000000000(0000) GS:ffff9b19de400000(0000)
> > knlGS:0000000000000000 [  112.785202] CS:  0010 DS: 0000 ES: 0000 CR0:
> > 0000000080050033 [  112.786030] CR2: 00007f18a157b050 CR3:
> > 000000001040a004 CR4: 0000000000060ef0 [  112.787034] Call Trace:
> > > > [  112.787393]  virtqueue_add_sgs+0x4c/0x90 [  112.787998]
> > > > virtio_crypto_skcipher_crypt_req+0x310/0x3e0
> > > > [  112.788817]  crypto_pump_work+0x10c/0x240 [  112.789420]  ?
> > > > __kthread_init_worker+0x50/0x50 [  112.790082]
> > > > kthread_worker_fn+0x89/0x180 [  112.790690]  kthread+0x10e/0x130 [
> > > > 112.791182]  ? kthread_park+0x80/0x80 [  112.791736]
> > > > ret_from_fork+0x35/0x40 [  112.792282] Modules linked in: cts lzo
> > > > salsa20_generic camellia_x86_64 camellia_generic fcrypt pcbc tgr192
> > > > anubis wp512 khazad tea michael_mic arc4 cast6_generic cast5_generic
> > > > cast_common deflate sha512_ssse3 sha512_generic cfb ofb
> > > > serpent_sse2_x86_64 serpent_generic lrw twofish_x86_64_3way
> > > > twofish_x86_64 crypto_simd cryptd glue_helper twofish_generic
> > > > twofish_common blowfish_x86_64 blowfish_generic blowfish_common md4
> > > > tcrypt(+) [  112.797652] ---[ end trace 4a8142d4a08c2518 ]--- [
> > > > 112.798320] RIP: 0010:sg_next+0x0/0x20 [  112.798865] Code: cc cc cc
> > > > cc cc cc cc cc cc cc c7 47 10 00 00 00 00 89 57 0c 48 89 37 89 4f 08
> > > > c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 <f6> 07 02 75 17 48
> > > > 8b 57 20 48 8d 47 20 48 89 d1 48 83 e1 fc 83 e2 [  112.801452] RSP:
> > > > 0018:ffffa92440237d90 EFLAGS: 00010006 [  112.802189] RAX:
> > > > fefefefe00000000 RBX: 000000000000000a RCX: fefefefe00000000 [
> > > > 112.803190] RDX: 0000000000000001 RSI: ffff9b19da1a2180 RDI:
> > > > fefefefe00000000 [  112.804192] RBP: ffff9b19da1a2198 R08:
> > > > ffff9b19dfb24ee8 R09: 0000000000000a20 [  112.805201] R10:
> > > > ffff9b19da125010 R11: 0000000000000000 R12: ffff9b19da1a21b8 [
> > > > 112.806195] R13: 0000000000000003 R14: ffff9b19da1a2180 R15:
> > > > 0000000000000004 [  112.807222] FS:  0000000000000000(0000)
> > > > GS:ffff9b19de400000(0000) knlGS:0000000000000000 [  112.808352] CS:
> > > > 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  112.809169] CR2:
> > > > 00007f18a157b050 CR3: 000000001040a004 CR4: 0000000000060ef0
> > > >
> > > > I have tested also 5.4.14
> > > > and I got random freeze with:
> > > > qemu-system-x86_64: virtio: zero sized buffers are not allowed
> > > >
> > > > Regards
> > >
> > > Cc: Gonglei <arei.gonglei@huawei.com>
> > >
> > 
> > Hello Gonglei
> > 
> > Any plan to fix the driver ? It is broken since its introduction.
> > 
> Thanks for your report firstly.
> I've been busy launching new products recently, so I don't have much time
> to invest in the open source community. 
> 
> I spent some time investigating the BUG this weekend, 
> and IMO I found the root cause. The following patch, please help test it, thanks!
> 
> [PATCH] virtio-crypto: fix src/dst scatterlist calculation
> 
> Usually the next entry of one sg will be @sg@ + 1, but if this sg element
> is part of a chained scatterlist, it could jump to the start of a new
> scatterlist array. Let's fix it by sg_next() on calculation of src/dst
> scatterlist.
> 
> BTW I add a check for sg_nents_for_len() its return value since
> sg_nents_for_len() function could fail.
> 

Hello, I have tested this patch and this bring to a new crash
[  124.921098] BUG: unable to handle page fault for address: ffffffffffffffa0
[  124.922206] #PF: supervisor read access in kernel mode
[  124.926469] #PF: error_code(0x0000) - not-present page
[  124.928393] PGD 3340d067 P4D 3340d067 PUD 3340f067 PMD 0 
[  124.930202] Oops: 0000 [#1] SMP PTI
[  124.930743] CPU: 0 PID: 2494 Comm: cryptomgr_test Not tainted 5.6.0-rc2-next-20200224+ #71
[  124.931992] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.org-2.fc31 04/01/2014
[  124.933926] RIP: 0010:hmac_setkey+0xda/0x1c0
[  124.934574] Code: 29 ea 4c 89 e8 80 34 02 36 80 30 5c 48 83 c0 01 48 39 c1 75 f0 48 8b 04 24 f6 40 08 01 0f 85 d1 00 00 00 48 8b 40 18 48 89 e7 <48> 8b 40 a0 e8 bd 03 a7 00 85 c0 74 3c 48 8b 9c 24 78 01 00 00 65
[  124.937299] RSP: 0018:ffff94cbc026f6a0 EFLAGS: 00010246
[  124.938083] RAX: 0000000000000000 RBX: 0000000000000014 RCX: ffff8c033f90e0c0
[  124.939139] RDX: ffffffffffffffa0 RSI: ffff8c033f90e060 RDI: ffff94cbc026f6a0
[  124.940205] RBP: ffff8c033f90e020 R08: 0000000000000008 R09: ffff8c033f90e034
[  124.941260] R10: ffff94cbc026fb58 R11: ffffb5d440e69082 R12: 0000000000000040
[  124.942323] R13: ffff8c033f90e080 R14: 0000000000000014 R15: 0000000000000014
[  124.943381] FS:  0000000000000000(0000) GS:ffff8c033dc00000(0000) knlGS:0000000000000000
[  124.944570] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.945426] CR2: ffffffffffffffa0 CR3: 0000000039902005 CR4: 0000000000060ef0
[  124.946479] Call Trace:
[  124.946879]  ? virtqueue_add+0x824/0xa40
[  124.947488]  ? __switch_to_asm+0x40/0x70
[  124.948090]  ? __switch_to_asm+0x34/0x70
[  124.948687]  ? __switch_to_asm+0x40/0x70
[  124.949284]  ? __switch_to_asm+0x34/0x70
[  124.949881]  ? __switch_to_asm+0x40/0x70
[  124.950428]  ? __switch_to_asm+0x34/0x70
[  124.950955]  ? __switch_to_asm+0x40/0x70
[  124.951472]  ? __switch_to_asm+0x34/0x70
[  124.952008]  ? __switch_to_asm+0x40/0x70
[  124.952527]  ? __switch_to_asm+0x34/0x70
[  124.953051]  ? __switch_to_asm+0x40/0x70
[  124.953584]  ? __switch_to_asm+0x34/0x70
[  124.954169]  ? __switch_to_asm+0x40/0x70
[  124.954758]  ? __switch_to_asm+0x34/0x70
[  124.955328]  ? __switch_to_asm+0x40/0x70
[  124.955906]  ? __switch_to_asm+0x34/0x70
[  124.956714]  ? __switch_to_asm+0x40/0x70
[  124.957326]  ? __switch_to_asm+0x34/0x70
[  124.957910]  ? __switch_to_asm+0x40/0x70
[  124.958499]  ? __switch_to_asm+0x34/0x70
[  124.959087]  ? __switch_to_asm+0x40/0x70
[  124.959652]  ? __switch_to_asm+0x34/0x70
[  124.960221]  ? __switch_to_asm+0x40/0x70
[  124.960793]  ? __switch_to_asm+0x34/0x70
[  124.961392]  ? __switch_to_asm+0x40/0x70
[  124.961982]  ? __switch_to_asm+0x34/0x70
[  124.962545]  ? __switch_to_asm+0x40/0x70
[  124.963127]  ? __switch_to_asm+0x34/0x70
[  124.963708]  ? __switch_to_asm+0x40/0x70
[  124.964293]  ? __switch_to_asm+0x34/0x70
[  124.964856]  ? __switch_to_asm+0x40/0x70
[  124.965424]  ? __switch_to_asm+0x34/0x70
[  124.965996]  ? __schedule+0x27a/0x5b0
[  124.966522]  ? __switch_to_asm+0x40/0x70
[  124.967110]  crypto_shash_setkey+0x2d/0xd0
[  124.967723]  crypto_ahash_setkey+0x2d/0xc0
[  124.968336]  crypto_authenc_setkey+0x62/0xe0
[  124.968978]  crypto_aead_setkey+0x29/0xc0
[  124.969568]  test_aead_vec_cfg+0x4a4/0x8b0
[  124.970168]  ? vsnprintf+0x368/0x4f0
[  124.970711]  ? sprintf+0x56/0x70
[  124.971191]  ? test_aead_vec+0x7c/0x130
[  124.971743]  test_aead_vec+0x7c/0x130
[  124.972280]  ? _cond_resched+0x10/0x20
[  124.972842]  ? __kmalloc+0x1f6/0x200
[  124.973387]  ? crypto_mod_get+0x10/0x60
[  124.973961]  ? get_page_from_freelist+0x6f3/0xfc0
[  124.974642]  ? crypto_skcipher_exit_tfm+0x20/0x20
[  124.975341]  ? efi_earlycon_write+0x2b0/0x2b0
[  124.975978]  ? __alloc_pages_nodemask+0x167/0x2b0
[  124.976660]  ? __get_free_pages+0x8/0x30
[  124.977236]  ? __testmgr_alloc_buf+0x19/0x80
[  124.977855]  alg_test_aead+0xbb/0x3a0
[  124.978389]  ? __switch_to_asm+0x34/0x70
[  124.978954]  ? __switch_to_asm+0x40/0x70
[  124.979521]  ? __switch_to_asm+0x34/0x70
[  124.980108]  alg_test.part.0+0x9e/0x2b0
[  124.980680]  ? syscall_return_via_sysret+0x1f/0x7f
[  124.981373]  ? __switch_to_asm+0x40/0x70
[  124.982094]  ? __switch_to_asm+0x34/0x70
[  124.982661]  ? __switch_to_asm+0x40/0x70
[  124.983260]  ? __switch_to_asm+0x34/0x70
[  124.983843]  ? __switch_to_asm+0x40/0x70
[  124.984431]  ? __switch_to_asm+0x34/0x70
[  124.985017]  ? __schedule+0x27a/0x5b0
[  124.985548]  cryptomgr_test+0x22/0x40
[  124.986091]  kthread+0xf6/0x130
[  124.986571]  ? crypto_acomp_scomp_free_ctx+0x20/0x20
[  124.987335]  ? kthread_park+0x80/0x80
[  124.987883]  ret_from_fork+0x35/0x40
[  124.988437] Modules linked in: vmac xcbc streebog_generic sm3_generic sha3_generic crct10dif_generic crct10dif_common seed rmd320 rmd256 rmd160 rmd128 cts lzo salsa20_generic camellia_x86_64 camellia_generic fcrypt pcbc tgr192 anubis wp512 khazad tea michael_mic arc4 cast6_generic cast5_generic cast_common deflate cfb ofb serpent_sse2_x86_64 serpent_generic lrw twofish_x86_64_3way twofish_x86_64 crypto_simd cryptd glue_helper twofish_generic twofish_common blowfish_x86_64 blowfish_generic blowfish_common md4 tcrypt(+)
[  124.994926] CR2: ffffffffffffffa0
[  124.995423] ---[ end trace 2c75df75ecf0f59e ]---
[  124.996099] RIP: 0010:hmac_setkey+0xda/0x1c0
[  124.996718] Code: 29 ea 4c 89 e8 80 34 02 36 80 30 5c 48 83 c0 01 48 39 c1 75 f0 48 8b 04 24 f6 40 08 01 0f 85 d1 00 00 00 48 8b 40 18 48 89 e7 <48> 8b 40 a0 e8 bd 03 a7 00 85 c0 74 3c 48 8b 9c 24 78 01 00 00 65
[  124.999370] RSP: 0018:ffff94cbc026f6a0 EFLAGS: 00010246
[  125.000134] RAX: 0000000000000000 RBX: 0000000000000014 RCX: ffff8c033f90e0c0
[  125.001141] RDX: ffffffffffffffa0 RSI: ffff8c033f90e060 RDI: ffff94cbc026f6a0
[  125.002175] RBP: ffff8c033f90e020 R08: 0000000000000008 R09: ffff8c033f90e034
[  125.003202] R10: ffff94cbc026fb58 R11: ffffb5d440e69082 R12: 0000000000000040
[  125.004212] R13: ffff8c033f90e080 R14: 0000000000000014 R15: 0000000000000014
[  125.005253] FS:  0000000000000000(0000) GS:ffff8c033dc00000(0000) knlGS:0000000000000000
[  125.006396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  125.007219] CR2: ffffffffffffffa0 CR3: 0000000039902005 CR4: 0000000000060ef0
