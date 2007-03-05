From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 05 Mar 2007 12:42:25 -0800
Message-ID: <45EC80B1.8030901@vmware.com>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<20070305143437.GF22829@bingen.suse.de>
	<45EC796D.5050705@vmware.com> <20070305201957.GA733@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070305201957.GA733@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> there's no need to disable the VDSO for old userspace ...
>   =


Well, apart from the obvious question to which nobody actually knows the =

answer, (how many people run old user space that required =

CONFIG_COMPAT_VDSO), what do you think of reversing the boot option?

vdso=3Denabled (default - turn on VDSO on normal boots)
vdso=3Ddisabled (turn off VDSO unconditionally)
[vdso=3Dcompat] (default for COMPAT_VDSO - keep VDSO only when mapped at =

compat location.  Note the option is not required to be implemented =

because it is logically implied from vdso=3Denabled && COMPAT_VDSO and the =

default boot behavior)
vdso=3Dforce (keep VDSO even when moved to a new location and COMPAT_VDSO =

is enabled).

In our case, installing VMware tools in the guest would then detect if =

userspace supports VDSO or if it requires COMPAT_VDSO and would then set =

boot parameters for the kernel appropriately.  And the native boot and =

kvm paravirt-ops boot are completely unaffected.

Zach
