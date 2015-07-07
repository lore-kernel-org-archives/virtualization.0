From: Ganis Zulfa Santoso <ganis.zulfa@gmail.com>
Subject: I can read/write in virtio BLK Device,
	but I can't run a hello world program in it
Date: Tue, 7 Jul 2015 10:52:01 +0900
Message-ID: <C03726BC-3011-4295-9ED6-EF31E98EE7BD@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: multipart/mixed; boundary="===============2975056668100390920=="
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


--===============2975056668100390920==
Content-Type: multipart/alternative; boundary="Apple-Mail=_D15531F9-60CE-4634-BD7D-A16CBCFCB671"


--Apple-Mail=_D15531F9-60CE-4634-BD7D-A16CBCFCB671
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Linux Virtualization Mailing List Members,

I am trying to develop a driver for virtio blk device in guest. I can =
safely mount the virtual blk device with: mount /dev/vda /mnt/
in /mnt/ I can read & write the device. But when I run a simple hello =
world program in /mnt/root/, this error happens:

root@linux_guest:/mnt/root# ./helloworld_static=20
[   23.003459] CPU: 0 PID: 491 Comm: helloworld_stat Not tainted 3.19.1+ =
#101
[   23.007030] Hardware name: ARM-Versatile Express
[   23.010102] task: 970f2400 ti: 9184e000 task.ti: 9184e000
[   23.011645] PC is at 0x11d6a
[   23.012801] LR is at 0x89b3
[   23.013627] pc : [<00011d6a>]    lr : [<000089b3>]    psr: 80000030
[   23.013627] sp : 7e932c10  ip : 00008e45  fp : 00000000
[   23.017108] r10: 00000000  r9 : 00000000  r8 : 00000000
[   23.023165] r7 : 00000000  r6 : 00053794  r5 : 7e932dd4  r4 : =
0006a9b4
[   23.026854] r3 : 0000022c  r2 : 00000000  r1 : ffffffd0  r0 : =
00000021
[   23.031814] Flags: Nzcv  IRQs on  FIQs on  Mode USER_32  ISA Thumb  =
Segment user
[   23.036225] Control: 10c5387d  Table: 916f4059  DAC: 00000015
[   23.040885] CPU: 0 PID: 491 Comm: helloworld_stat Not tainted 3.19.1+ =
#101
[   23.043224] Hardware name: ARM-Versatile Express
[   23.045168] [<80012c68>] (unwind_backtrace) from [<80010dc8>] =
(show_stack+0x10/0x14)
[   23.050392] [<80010dc8>] (show_stack) from [<8030c9d0>] =
(__do_user_fault.isra.10+0x98/0xa8)
[   23.052687] [<8030c9d0>] (__do_user_fault.isra.10) from [<80017c6c>] =
(do_page_fault+0x35c/0x3b8)
[   23.055358] [<80017c6c>] (do_page_fault) from [<80008488>] =
(do_DataAbort+0x34/0x98)
[   23.057510] [<80008488>] (do_DataAbort) from [<80011a5c>] =
(__dabt_usr+0x3c/0x40)
[   23.065243] Exception stack(0x9184ffb0 to 0x9184fff8)
[   23.069425] ffa0:                                     00000021 =
ffffffd0 00000000 0000022c
[   23.073779] ffc0: 0006a9b4 7e932dd4 00053794 00000000 00000000 =
00000000 00000000 00000000
[   23.079985] ffe0: 00008e45 7e932c10 000089b3 00011d6a 80000030 =
ffffffff

Can you tell me what I could probably miss? Thank you very much, I =
forever in debt for your time and effort to read this. I am writing the =
BLK Device based on Lguest's code.

some information that may help:

root@linux_guest:/mnt/root# file helloworld_static=20
helloworld_static: ELF 32-bit LSB executable, ARM, version 1 (SYSV), =
statically linked, for GNU/Linux 2.6.31, =
BuildID[sha1]=3D0xc63622efd65f635f2b93c05caa8a1302d60a8caa, not stripped

root@linux_guest:/mnt/root# uname -a
Linux linux_guest 3.19.1+ #101 Tue Jul 7 09:35:23 KST 2015 armv7l =
GNU/Linux

root@linux_guest:/mnt/root# ls -l helloworld_static
-rwxr-xr-x    1 root     root        456218 Jul  7  2015 =
helloworld_static

during booting:

[    0.202185] brd: module loaded
[    0.262288] loop: module loaded
[    0.304868]  vda: unknown partition table
AtLFprofile: no performance counters
[    0.399451] oprofile: using timer interrupt.
CP: cubic registered
[    0.403361] NET: Registered protocol family 17
[    0.405039] Registering SWP/SWPB emulation handler
[    0.409375] RAMDISK: gzip image found at block 0
[    0.572643] EXT2-fs (ram0): warning: mounting unchecked fs, running =
e2fsck is recommended
[    0.620201] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    0.622113] devtmpfs: mounted
[    0.623328] Freeing unused kernel memory: 172K (80417000 - 80442000)

Starting logging: OK
Initializing random number generator...=20
[    0.691483] random: dd urandom read with 0 bits of entropy available
done.
Starting network...
Starting dropbear sshd: OK

linux_guest login:=

--Apple-Mail=_D15531F9-60CE-4634-BD7D-A16CBCFCB671
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hi Linux Virtualization Mailing List Members,<div =
class=3D""><br class=3D""></div><div class=3D"">I am trying to develop a =
driver for virtio blk device in guest. I can safely mount the virtual =
blk device with:&nbsp;<b class=3D"">mount /dev/vda /mnt/</b></div><div =
class=3D"">in <b class=3D"">/mnt/</b> I can read &amp; write the device. =
But when I run a simple hello world program in <b =
class=3D"">/mnt/root/</b>, this error happens:<br class=3D"">
<br class=3D""></div><div class=3D"">root@linux_guest:/mnt/root# <b =
class=3D"">./helloworld_static&nbsp;</b><br class=3D""></div><div =
class=3D"">[&nbsp;&nbsp;&nbsp;23.003459] CPU: 0 PID: 491 Comm: =
helloworld_stat Not tainted 3.19.1+ #101<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.007030] Hardware name: ARM-Versatile =
Express<br class=3D"">[&nbsp;&nbsp;&nbsp;23.010102] task: 970f2400 ti: =
9184e000 task.ti: 9184e000<br class=3D"">[&nbsp;&nbsp;&nbsp;23.011645] =
PC is at 0x11d6a<br class=3D"">[&nbsp;&nbsp;&nbsp;23.012801] LR is at =
0x89b3<br class=3D"">[&nbsp;&nbsp;&nbsp;23.013627] pc : =
[&lt;00011d6a&gt;]&nbsp; &nbsp;&nbsp;lr : [&lt;000089b3&gt;]&nbsp; =
&nbsp;&nbsp;psr: 80000030<br class=3D"">[&nbsp;&nbsp;&nbsp;23.013627] sp =
: 7e932c10&nbsp;&nbsp;ip : 00008e45&nbsp;&nbsp;fp : 00000000<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.017108] r10: 00000000&nbsp;&nbsp;r9 : =
00000000&nbsp;&nbsp;r8 : 00000000<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.023165] r7 : 00000000&nbsp;&nbsp;r6 : =
00053794&nbsp;&nbsp;r5 : 7e932dd4&nbsp;&nbsp;r4 : 0006a9b4<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.026854] r3 : 0000022c&nbsp;&nbsp;r2 : =
00000000&nbsp;&nbsp;r1 : ffffffd0&nbsp;&nbsp;r0 : 00000021<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.031814] Flags: Nzcv&nbsp;&nbsp;IRQs =
on&nbsp;&nbsp;FIQs on&nbsp;&nbsp;Mode USER_32&nbsp;&nbsp;ISA =
Thumb&nbsp;&nbsp;Segment user<br class=3D"">[&nbsp;&nbsp;&nbsp;23.036225] =
Control: 10c5387d&nbsp;&nbsp;Table: 916f4059&nbsp;&nbsp;DAC: 00000015<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.040885] CPU: 0 PID: 491 Comm: =
helloworld_stat Not tainted 3.19.1+ #101<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.043224] Hardware name: ARM-Versatile =
Express<br class=3D"">[&nbsp;&nbsp;&nbsp;23.045168] [&lt;80012c68&gt;] =
(unwind_backtrace) from [&lt;80010dc8&gt;] (show_stack+0x10/0x14)<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.050392] [&lt;80010dc8&gt;] (show_stack) =
from [&lt;8030c9d0&gt;] (__do_user_fault.isra.10+0x98/0xa8)<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.052687] [&lt;8030c9d0&gt;] =
(__do_user_fault.isra.10) from [&lt;80017c6c&gt;] =
(do_page_fault+0x35c/0x3b8)<br class=3D"">[&nbsp;&nbsp;&nbsp;23.055358] =
[&lt;80017c6c&gt;] (do_page_fault) from [&lt;80008488&gt;] =
(do_DataAbort+0x34/0x98)<br class=3D"">[&nbsp;&nbsp;&nbsp;23.057510] =
[&lt;80008488&gt;] (do_DataAbort) from [&lt;80011a5c&gt;] =
(__dabt_usr+0x3c/0x40)<br class=3D"">[&nbsp;&nbsp;&nbsp;23.065243] =
Exception stack(0x9184ffb0 to 0x9184fff8)<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.069425] ffa0:&nbsp;&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;00000021 ffffffd0 00000000 =
0000022c<br class=3D"">[&nbsp;&nbsp;&nbsp;23.073779] ffc0: 0006a9b4 =
7e932dd4 00053794 00000000 00000000 00000000 00000000 00000000<br =
class=3D"">[&nbsp;&nbsp;&nbsp;23.079985] ffe0: 00008e45 7e932c10 =
000089b3 00011d6a 80000030 ffffffff<br class=3D""><br =
class=3D""></div><div class=3D"">Can you tell me what I could probably =
miss? Thank you very much, I forever in debt for your time and effort to =
read this. I am writing the BLK Device based on Lguest's code.</div><div =
class=3D""><br class=3D""></div><div class=3D""><b class=3D"">some =
information that may help:</b></div><div class=3D""><br =
class=3D""></div><div class=3D"">root@linux_guest:/mnt/root# <b =
class=3D"">file helloworld_static&nbsp;</b><br =
class=3D"">helloworld_static: ELF 32-bit LSB executable, ARM, version 1 =
(SYSV), statically linked, for GNU/Linux =
2.6.31,&nbsp;BuildID[sha1]=3D0xc63622efd65f635f2b93c05caa8a1302d60a8caa, =
not stripped</div><div class=3D""><br class=3D""></div><div =
class=3D"">root@linux_guest:/mnt/root#<b class=3D""> uname =
-a</b></div>Linux&nbsp;linux_guest 3.19.1+ #101 Tue Jul 7 09:35:23 KST =
2015 armv7l GNU/Linux<div class=3D""><br class=3D""></div><div =
class=3D"">root@linux_guest:/mnt/root# <b class=3D"">ls -l =
helloworld_static</b></div>-rwxr-xr-x&nbsp; &nbsp;&nbsp;1 =
root&nbsp;&nbsp; &nbsp;&nbsp;root&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;456218 =
Jul&nbsp;&nbsp;7&nbsp;&nbsp;2015&nbsp;helloworld_static<div class=3D""><br=
 class=3D""></div><div class=3D""><b class=3D"">during =
booting:</b></div><div class=3D""><br class=3D""></div><div =
class=3D"">[&nbsp; &nbsp;&nbsp;0.202185] brd: module loaded<br =
class=3D"">[&nbsp; &nbsp;&nbsp;0.262288] loop: module loaded<br =
class=3D"">[&nbsp; &nbsp;&nbsp;0.304868]&nbsp;&nbsp;vda: unknown =
partition table<br class=3D"">AtLFprofile: no performance counters<br =
class=3D"">[&nbsp; &nbsp;&nbsp;0.399451] oprofile: using timer =
interrupt.<br class=3D"">CP: cubic registered<br class=3D"">[&nbsp; =
&nbsp;&nbsp;0.403361] NET: Registered protocol family 17<br =
class=3D"">[&nbsp; &nbsp;&nbsp;0.405039] Registering SWP/SWPB emulation =
handler<br class=3D"">[&nbsp; &nbsp;&nbsp;0.409375] RAMDISK: gzip image =
found at block 0<br class=3D"">[&nbsp; &nbsp;&nbsp;0.572643] EXT2-fs =
(ram0): warning: mounting unchecked fs, running e2fsck is recommended<br =
class=3D"">[&nbsp; &nbsp;&nbsp;0.620201] VFS: Mounted root (ext2 =
filesystem) on device 1:0.<br class=3D"">[&nbsp; &nbsp;&nbsp;0.622113] =
devtmpfs: mounted<br class=3D"">[&nbsp; &nbsp;&nbsp;0.623328] Freeing =
unused kernel memory: 172K (80417000 - 80442000)<br class=3D""><br =
class=3D"">Starting logging: OK<br class=3D"">Initializing random number =
generator...&nbsp;</div><div class=3D"">[&nbsp; &nbsp;&nbsp;0.691483] =
random: dd urandom read with 0 bits of entropy available<br =
class=3D"">done.<br class=3D"">Starting network...<br class=3D"">Starting =
dropbear sshd: OK<br class=3D""><br =
class=3D"">linux_guest&nbsp;login:</div></body></html>=

--Apple-Mail=_D15531F9-60CE-4634-BD7D-A16CBCFCB671--

--===============2975056668100390920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2975056668100390920==--
