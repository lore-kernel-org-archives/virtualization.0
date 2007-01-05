From: Karl Rister <kmr@us.ibm.com>
Subject: lhype guest oops
Date: Fri, 5 Jan 2007 16:14:30 -0600
Message-ID: <200701051614.31125.kmr@us.ibm.com>
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

I am trying to experiment with lhype on a 32bit Intel box and when I launch=
 a =

guest I get the following oops message:

-----------
invalid opcode: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0061:[<c0101223>]    Not tainted VLI
EFLAGS: 00010246   (2.6.20-rc2 #1)
EIP is at mwait_idle_with_hints+0x1e/0x3a
eax: c03c8008   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: c03c8008   ebp: 4c687970   esp: c03c9f74
ds: 007b   es: 007b   ss: 0069
Process swapper (pid: 0, ti=3Dc03c8000 task=3Dc039c420 task.ti=3Dc03c8000)
Stack: 00000000 c040102c c03fd120 c0101333 c03ca693 c0344d03 c03ca1b8 c03fd=
120
       c03fe320 c03d5b56 00000000 00000000 00401000 00000001 00000000 00000=
000
       c03fd120 c040102c 00000100 c040101c c03fd020 92000000 0000000f c039f=
ee0
Call Trace:
 [<c0101333>] cpu_idle+0x39/0x4e
 [<c03ca693>] start_kernel+0x2d9/0x2dd
 [<c03ca1b8>] unknown_bootoption+0x0/0x202
 [<c03d5b56>] lhype_init+0x35f/0x366
 [<c03d5b5d>] lhype_maybe_init+0x0/0x1a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 11 00 00 00 e8 13 0e 01 00 83 c4 0c c3 57 56 53 89 c6 89 d3 89 e0 25 =
00 =

e0 ff ff 8d 78 08 8b 40 08 a8 08 75 1e 31 c9 89 f8 89 ca <0f> 01 c8 89 e0 2=
5 =

00 e0 ff ff 8b 40 08 a8 08 75 07 89 f0 89 d9
EIP: [<c0101223>] mwait_idle_with_hints+0x1e/0x3a SS:ESP 0069:c03c9f74
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 lhype_add: CRASH: Attempted to kill the idle task!
-----------

The invocation of lhype_add that I made is:

./linux-2.6.20-rc2/drivers/lhype/lhype_add --verbose 64m =

0 /boot/vmlinux-2.6.20-rc2-lhype --tunnet=3D192.168.0.1 --block=3Dlinux-tes=
t/linux.img =

root=3D/dev/lhba

Can anyone point me in the direction of figuring this out?

Thanks.

-- =

Karl Rister
