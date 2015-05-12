From: Sudheer K <sudheer.kurichiyath@gmail.com>
Subject: KVM VHOST-BLK is not working
Date: Tue, 12 May 2015 11:15:58 +0530
Message-ID: <CADM6D_r0dB9eL1Z8irnEKzvDjHUPKs6+MNShG2Gy7-vraFU1Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2960512998902238802=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============2960512998902238802==
Content-Type: multipart/alternative; boundary=047d7bb03a564579c80515dc02e5

--047d7bb03a564579c80515dc02e5
Content-Type: text/plain; charset=UTF-8

Hi,

I am wondering if someone in this list who has used VHOST-BLK in the past
could help me.

I am experimenting with VHOST-BLK with the codes I got from:
QEMU - git://github.com/asias/qemu.git
KERNEL - git://github.com/asias/linux.git
The VM I am booting is compiled with MSIX config options.

I am seeing a failure in the QEMU function msix_enabled during the
initialization of the block device  While the first expression
(dev->cap_present & QEMU_PCI_CAP_MSIX)   is successful, the second one
(dev->config[dev->msix_cap + MSIX_CONTROL_OFFSET] &
         MSIX_ENABLE_MASK) is failing.

I could not see a msix_init function from hw/block/virtio-blk.c whereas
there is one for VHOST-NET from vmxnet3_init_msix.

I will appreciate if someone could point out what I am missing here.

Thanks and Regards

Sudheer

--047d7bb03a564579c80515dc02e5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hi,<br><br></div><div>I am wonder=
ing if someone in this list who has used VHOST-BLK in the past could help m=
e.<br></div><div><br></div>I am experimenting with VHOST-BLK with the codes=
 I got from:<br>QEMU - git://<a href=3D"http://github.com/asias/qemu.git" t=
arget=3D"_blank">github.com/asias/qemu.git</a><br></div>KERNEL - git://<a h=
ref=3D"http://github.com/asias/linux.git" target=3D"_blank">github.com/asia=
s/linux.git</a><br>The VM I am booting is compiled with MSIX config options=
. <br><br></div>I
 am seeing a failure in the QEMU function msix_enabled during the=20
initialization of the block device=C2=A0 While the first expression=20
(dev-&gt;cap_present &amp; QEMU_PCI_CAP_MSIX)=C2=A0=C2=A0 is successful, th=
e=20
second one (dev-&gt;config[dev-&gt;msix_cap + MSIX_CONTROL_OFFSET] &amp;<br=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MSIX_ENABLE_MASK) is fail=
ing.<br><br></div><div>I could not see a msix_init function from hw/block/v=
irtio-blk.c whereas there is one for VHOST-NET from vmxnet3_init_msix.<br><=
br></div><div>I will appreciate if someone could point out what I am missin=
g here. <br><br></div>Thanks and Regards<br><br></div>Sudheer<br></div>

--047d7bb03a564579c80515dc02e5--

--===============2960512998902238802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2960512998902238802==--
