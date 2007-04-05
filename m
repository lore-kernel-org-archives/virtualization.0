From: Zachary Amsden <zach@vmware.com>
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Wed, 04 Apr 2007 22:00:45 -0700
Message-ID: <4614827D.9090805@vmware.com>
References: <461447F2.9010807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <461447F2.9010807@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> I have finally gotten off the pot and finished writing up my new =

> CPUID/MSR driver, which contains support for registers that need =

> arbitrary GPRs touched.  For i386 vs x86-64 compatibility, both use an =

> x86-64 register image (16 64-bit register fields); this allows 32-bit =

> userspace to access the full 64-bit image if the kernel is 64 bits.
>
> Anyway, this presumably requires new paravirtualization hooks.  The =

> patch is at:
>
> http://www.kernel.org/pub/linux/kernel/people/hpa/new-cpuid-msr.patch
>   =

The requested URL /pub/linux/kernel/people/hpa/new-cpuid-msr.patch was =

not found on this server.

> ... and a git tree is at ...
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/hpa/linux-2.6-cpuidmsr.git;a=
=3Dsummary
>
> I'm posting this here to give the paravirt maintainers an opportunity to =

> comment.  Presumably the functions that need to be paravirtualized are =

> the ones represented by the functions do_cpuid(), do_rdmsr() and
>   =


rdmsr / wrmsr can be dropped from paravirt-ops; at least for us (they =

will trap and emulate just fine, and this driver is not performance =

critical), and I think for the others as well.  CPUID, however, does =

require a hook.

Zach
