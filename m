From: "H. Peter Anvin" <hpa@zytor.com>
Subject: New CPUID/MSR driver; virtualization hooks
Date: Wed, 04 Apr 2007 17:50:58 -0700
Message-ID: <461447F2.9010807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

I have finally gotten off the pot and finished writing up my new =

CPUID/MSR driver, which contains support for registers that need =

arbitrary GPRs touched.  For i386 vs x86-64 compatibility, both use an =

x86-64 register image (16 64-bit register fields); this allows 32-bit =

userspace to access the full 64-bit image if the kernel is 64 bits.

Anyway, this presumably requires new paravirtualization hooks.  The =

patch is at:

http://www.kernel.org/pub/linux/kernel/people/hpa/new-cpuid-msr.patch

... and a git tree is at ...

http://git.kernel.org/?p=3Dlinux/kernel/git/hpa/linux-2.6-cpuidmsr.git;a=3D=
summary

I'm posting this here to give the paravirt maintainers an opportunity to =

comment.  Presumably the functions that need to be paravirtualized are =

the ones represented by the functions do_cpuid(), do_rdmsr() and =

do_wrmsr(): they take a cpu number, an input register image, and an =

output register image, and return either 0 or -EIO (in case of a trap.)

	-hpa
