From: bert hubert <bert.hubert@netherlabs.nl>
Subject: lhype on 2.6.20-rc2: Guest didn't handle trap 6 at c071b594
	(cr2=00000000, err=0)
Date: Wed, 27 Dec 2006 14:25:20 +0100
Message-ID: <20061227132520.GA32685@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Hi everybody,

Attracted by the puppies, I'm trying to run lhype. The patch applies cleanly
to 2.6.20-rc2, my .config is in accord with lhype.txt, but when I try to
launch an instance, I get this:

$ sudo drivers/lhype/lhype_add 64m 0 vmlinux --tunnet=3D192.168.19.1 --bloc=
k=3Dlinux.img root=3D/dev/lhba
lhype_add: Failed to get DMA buffer from 0xb7fff008: No such file or direct=
ory
lhype_add: network: no dma buffer!: No such file or directory
lhype_add: Running guest failed: No such file or directory

When I subsequently retry, I get the same, but third and following tries
only give:

lhype_add: Running guest failed: No such file or directory

$ dmesg | tail
lhype: mapped hypervisor at ffc00000
(...)
Guest didn't handle trap 6 at c071b594 (cr2=3D00000000,err=3D0)
Guest 0 dead drivers/lhype/init.c:424

$ file linux.img
linux.img: x86 boot sector, LInux i386 boot LOader

$ file vmlinux
vmlinux: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statical=
ly linked, not stripped

Any clues? I think I've followed lhype.txt to the letter.

Thanks!

-- =

http://www.PowerDNS.com      Open source, database driven DNS Software =

http://netherlabs.nl              Open and Closed source services
