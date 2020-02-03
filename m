From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [CRASH] crypto: virtio: crash when modprobing tcrypt on 5.5-rc7 / next-20200122
Date: Mon, 3 Feb 2020 23:01:57 +0000
Message-ID: <CAKv+Gu8zPK2R_3UbGJq=+g=exknY0g2cprKBgBUTMKAPXL=pOA@mail.gmail.com>
References: <20200123101000.GB24255@Red> <20200123065150-mutt-send-email-mst@kernel.org>
 <20200203205324.GA26330@Red>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200203205324.GA26330@Red>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe@baylibre.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, Gonglei <arei.gonglei@huawei.com>, Jason Wang <jasowang@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 3 Feb 2020 at 20:53, LABBE Corentin <clabbe@baylibre.com> wrote:
>
> On Thu, Jan 23, 2020 at 06:52:29AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 23, 2020 at 11:10:00AM +0100, LABBE Corentin wrote:
> > > Hello
> > >
> > > When modprobing tcrypt on qemu 4.1.0 I get a kernel panic on 5.5-rc7 =
and next-20200122
> > > qemu is started by:
> > > /usr/bin/qemu-system-x86_64 -cpu host -enable-kvm -nographic -net nic=
,model=3De1000,macaddr=3D52:54:00:12:34:58 -net tap -m 512 -monitor none -o=
bject cryptodev-backend-builtin,id=3Dcryptodev0 -device virtio-crypto-pci,i=
d=3Dcrypto0,cryptodev=3Dcryptodev0 -append 'console=3DttyS0 root=3D/dev/ram=
0 ip=3Ddhcp' -kernel /var/lib/lava/dispatcher/tmp/41332/deployimages-td1867=
5m/kernel/bzImage -initrd /var/lib/lava/dispatcher/tmp/41332/deployimages-t=
d18675m/ramdisk/rootfs.cpio.gz -drive format=3Dqcow2,file=3D/var/lib/lava/d=
ispatcher/tmp/41332/apply-overlay-guest-icy4k1ol/lava-guest.qcow2,media=3Dd=
isk,if=3Dide,id=3Dlavatest
> > >
> > > [  112.771925] general protection fault: 0000 [#1] SMP PTI
> > > [  112.772686] CPU: 0 PID: 126 Comm: virtio0-engine Not tainted 5.5.0=
-rc7+ #1
> > > [  112.773576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.org-2.fc31 04/01=
/2014

Interesting. So your QEMU was cross-built on an ARMv7 machine?? Or
just the guest firmware?


> > > [  112.775319] RIP: 0010:sg_next+0x0/0x20
> > > [  112.775821] Code: cc cc cc cc cc cc cc cc cc cc c7 47 10 00 00 00 =
00 89 57 0c 48 89 37 89 4f 08 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 =
00 <f6> 07 02 75 17 48 8b 57 20 48 8d 47 20 48 89 d1 48 83 e1 fc 83 e2
> > > [  112.778330] RSP: 0018:ffffa92440237d90 EFLAGS: 00010006
> > > [  112.779071] RAX: fefefefe00000000 RBX: 000000000000000a RCX: fefef=
efe00000000
> > > [  112.780081] RDX: 0000000000000001 RSI: ffff9b19da1a2180 RDI: fefef=
efe00000000
> > > [  112.781081] RBP: ffff9b19da1a2198 R08: ffff9b19dfb24ee8 R09: 00000=
00000000a20
> > > [  112.782079] R10: ffff9b19da125010 R11: 0000000000000000 R12: ffff9=
b19da1a21b8
> > > [  112.783079] R13: 0000000000000003 R14: ffff9b19da1a2180 R15: 00000=
00000000004
> > > [  112.784077] FS:  0000000000000000(0000) GS:ffff9b19de400000(0000) =
knlGS:0000000000000000
> > > [  112.785202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  112.786030] CR2: 00007f18a157b050 CR3: 000000001040a004 CR4: 00000=
00000060ef0
> > > [  112.787034] Call Trace:
> > > [  112.787393]  virtqueue_add_sgs+0x4c/0x90
> > > [  112.787998]  virtio_crypto_skcipher_crypt_req+0x310/0x3e0
> > > [  112.788817]  crypto_pump_work+0x10c/0x240
> > > [  112.789420]  ? __kthread_init_worker+0x50/0x50
> > > [  112.790082]  kthread_worker_fn+0x89/0x180
> > > [  112.790690]  kthread+0x10e/0x130
> > > [  112.791182]  ? kthread_park+0x80/0x80
> > > [  112.791736]  ret_from_fork+0x35/0x40
> > > [  112.792282] Modules linked in: cts lzo salsa20_generic camellia_x8=
6_64 camellia_generic fcrypt pcbc tgr192 anubis wp512 khazad tea michael_mi=
c arc4 cast6_generic cast5_generic cast_common deflate sha512_ssse3 sha512_=
generic cfb ofb serpent_sse2_x86_64 serpent_generic lrw twofish_x86_64_3way=
 twofish_x86_64 crypto_simd cryptd glue_helper twofish_generic twofish_comm=
on blowfish_x86_64 blowfish_generic blowfish_common md4 tcrypt(+)
> > > [  112.797652] ---[ end trace 4a8142d4a08c2518 ]---
> > > [  112.798320] RIP: 0010:sg_next+0x0/0x20
> > > [  112.798865] Code: cc cc cc cc cc cc cc cc cc cc c7 47 10 00 00 00 =
00 89 57 0c 48 89 37 89 4f 08 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 =
00 <f6> 07 02 75 17 48 8b 57 20 48 8d 47 20 48 89 d1 48 83 e1 fc 83 e2
> > > [  112.801452] RSP: 0018:ffffa92440237d90 EFLAGS: 00010006
> > > [  112.802189] RAX: fefefefe00000000 RBX: 000000000000000a RCX: fefef=
efe00000000
> > > [  112.803190] RDX: 0000000000000001 RSI: ffff9b19da1a2180 RDI: fefef=
efe00000000
> > > [  112.804192] RBP: ffff9b19da1a2198 R08: ffff9b19dfb24ee8 R09: 00000=
00000000a20
> > > [  112.805201] R10: ffff9b19da125010 R11: 0000000000000000 R12: ffff9=
b19da1a21b8
> > > [  112.806195] R13: 0000000000000003 R14: ffff9b19da1a2180 R15: 00000=
00000000004
> > > [  112.807222] FS:  0000000000000000(0000) GS:ffff9b19de400000(0000) =
knlGS:0000000000000000
> > > [  112.808352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  112.809169] CR2: 00007f18a157b050 CR3: 000000001040a004 CR4: 00000=
00000060ef0
> > >
> > > I have tested also 5.4.14
> > > and I got random freeze with:
> > > qemu-system-x86_64: virtio: zero sized buffers are not allowed
> > >
> > > Regards
> >
> > did any of previous versions work for you?
> > Any chance of a bisect?
> >
>
> Hello
>
> Bisecting lead to 500e6807ce93b1fdc7d5b827c5cc167cc35630db ("crypto: virt=
io - implement missing support for output IVs")
> Qemu 4.2.0 also fail like this but not 1:3.1+dfsg-8+deb10u2
>

That commit adds scatterwalk_map_and_copy() calls in two places, and
the only way I see that could cause corruption here is when
req->cryptlen < AES_BLOCK_SIZE.

Could you please try whether returning an error early in
__virtio_crypto_skcipher_do_req() if req->cryptlen < AES_BLOCK_SIZE
fixes the issue?
