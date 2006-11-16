From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Thu, 16 Nov 2006 14:16:45 +0100
Message-ID: <200611161416.45624.ak@suse.de>
References: <20061027145650.GA37582@muc.de>
	<20061115210630.94bf8824.akpm@osdl.org>
	<20061116102846.GC1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061116102846.GC1397@sequoia.sous-sol.org>
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
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 16 November 2006 11:28, Chris Wright wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > wtf?  How come patches leave here in working order and keep arriving br=
oken?
> =

> I think the trees are in sync, and it's actually a bug that's .config
> dependent.  Basically, the STI_STRING and CLI_STRING are not useable
> the way they get used:

I merged everything together.  Synced out to ff now.

CONFIG_PARAVIRT=3Dn kernel runs now, but when I run a defconfig + CONFIG_PA=
RAVIRT=3Dy =

kernel on bare metal init still breaks with a long stream of =


INIT: Entering runlevel: 3
Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(void *)=
 ph->
p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(void *)=
 ph->
p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(void *)=
 ph->
p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(void *)=
 ph->
p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
...

before giving up. So it looks like something is still broken


-Andi
