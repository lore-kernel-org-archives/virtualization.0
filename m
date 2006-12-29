From: bert hubert <bert.hubert@netherlabs.nl>
Subject: Re: lhype on 2.6.20-rc2: Guest didn't handle trap 6 at c071b594
	(cr2=00000000, err=0)
Date: Fri, 29 Dec 2006 10:54:12 +0100
Message-ID: <20061229095412.GA16260@outpost.ds9a.nl>
References: <20061227132520.GA32685@outpost.ds9a.nl>
	<1167272613.30506.5.camel@localhost.localdomain>
	<20061228114542.GB18047@outpost.ds9a.nl>
	<1167348883.30506.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1167348883.30506.47.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 29, 2006 at 10:34:43AM +1100, Rusty Russell wrote:

> Here's the two-liner patch (already rolled into the lhype.patch, so you
> can simply update).

We're getting further, but no cigar yet!

I now get this:

[    0.760000] PCI: System does not support PCI
[    0.760000] PCI: System does not support PCI
lhype_add: Failed to get DMA buffer from 0xb7fff008: No such file or direct=
ory
lhype_add: network: no dma buffer!: No such file or directory
[    0.820000] NET: Registered protocol family 2
[    0.820000] invalid opcode: 0000 [#1]
[    0.820000] Modules linked in:
[    0.820000] CPU:    0
[    0.820000] EIP:    0061:[<c0101223>]    Not tainted VLI
[    0.820000] EFLAGS: 00010246   (2.6.20-rc2 #0)
[    0.820000] EIP is at mwait_idle_with_hints+0x1e/0x3a
[    0.820000] eax: c0704008   ebx: 00000000   ecx: 00000000   edx: 00000000
[    0.820000] esi: 00000000   edi: c0704008   ebp: 4c687970   esp: c0705f74
[    0.820000] ds: 007b   es: 007b   ss: 0069
[    0.820000] Process swapper (pid: 0, ti=3Dc0704000 task=3Dc066c420 task.=
ti=3Dc0704000)
[    0.820000] Stack: 00000000 c075502c c074a120 c0101333 c07066e1 c05d6677=
 c07061b8 c074a120 =

[    0.820000]        c074b320 c0715522 00000000 00000000 00755000 00000001=
 00000000 00000000 =

[    0.820000]        c074a120 c075502c 00000100 c075501c c074a020 92000000=
 0000000f c0670120 =

[    0.820000] Call Trace:
[    0.820000]  [<c0101333>] cpu_idle+0x39/0x4e
[    0.820000]  [<c07066e1>] start_kernel+0x327/0x32b
[    0.820000]  [<c07061b8>] unknown_bootoption+0x0/0x202
[    0.820000]  [<c0715522>] lhype_init+0x37d/0x384
[    0.820000]  [<c0715529>] lhype_maybe_init+0x0/0x1a
[    0.820000]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[    0.820000] Code: 11 00 00 00 e8 e3 8c 01 00 83 c4 0c c3 57 56 53 89 c6 =
89 d3 89 e0 25 00 e0 ff ff 8d 78 08 8b 40 08 a8 08 75 1e 31 c9 89 f8 89 ca =
<0f> 01 c8 89 e0 25 00 e0 ff ff 8b 40 08 a8 08 75 07 89 f0 89 d9 =

[    0.820000] EIP: [<c0101223>] mwait_idle_with_hints+0x1e/0x3a SS:ESP 006=
9:c0705f74
[    0.820000]  <0>Kernel panic - not syncing: Attempted to kill the idle t=
ask!
[    0.820000]  lhype_add: CRASH: Attempted to kill the idle task!

This appears to be this line:
        /* "monitor %eax,%ecx,%edx;" */
        asm volatile(
c010121d:       31 c9                   xor    %ecx,%ecx
c010121f:       89 f8                   mov    %edi,%eax
c0101221:       89 ca                   mov    %ecx,%edx
c0101223:       0f 01 c8                monitor %eax,%ecx,%edx

My *host* CPU certainly claims to have 'PNI', and thus I suspect 'monitor'.

I'll try to get this skipped so I can continue testing. Let me know if there
is anything I can do to help!

$ cat /proc/cpuinfo =

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 1
cpu MHz         : 3000.174
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_=
tsc pni monitor ds_cpl cid xtpr
bogomips        : 6003.91
clflush size    : 64


-- =

http://www.PowerDNS.com      Open source, database driven DNS Software =

http://netherlabs.nl              Open and Closed source services
