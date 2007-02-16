From: Gerd Hoffmann <kraxel@suse.de>
Subject: paravirt xen gpf
Date: Fri, 16 Feb 2007 11:09:41 +0100
Message-ID: <45D582E5.7020307@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

current paravirt patchqueue dies with ...

Checking if this processor honours the WP bit even in supervisor mode... Ok.
general protection fault: 0000 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0061:[<c01021a8>]    Not tainted VLI
EFLAGS: 00010013   (2.6.20-git8-default-hg770 #7)
EIP is at xen_evtchn_do_upcall+0x56/0x94
eax: ffffffff   ebx: 00000000   ecx: fbfb9000   edx: ffff8b04
esi: 00000001   edi: fffffffe   ebp: 00000000   esp: c03aff30
ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: e021
Process swapper (pid: 0, ti=3Dc03ae000 task=3Dc0377340 task.ti=3Dc03ae000)
Stack: fbfb9000 00000000 ffff8b04 0242764c 00000002 0486555f c0105b91
ffff8b04
       02432846 0000d02f 0242764c 00000002 0486555f 00000000 463ae021
c011e021
       000000d8 00000000 c0100620 0000e019 00000246 00000006 c02d20db
00000006
Call Trace:
 [<c0105b91>] xen_hypervisor_callback+0x25/0x2c
 [<c011e021>] do_wait+0x3e5/0x98d
 [<c0100620>] calibrate_delay+0xa0/0x260
 [<c02d20db>] mutex_lock+0xb/0x1a
 [<c03b5b6c>] start_kernel+0x2c1/0x44a
 [<c03baf50>] xen_start_kernel+0x0/0x1b9
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
