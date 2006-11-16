From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Thu, 16 Nov 2006 11:03:34 -0800
Message-ID: <20061116190334.GF1397@sequoia.sous-sol.org>
References: <20061027145650.GA37582@muc.de>
	<20061115210630.94bf8824.akpm@osdl.org>
	<20061116102846.GC1397@sequoia.sous-sol.org>
	<200611161416.45624.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200611161416.45624.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Andi Kleen (ak@suse.de) wrote:
> I merged everything together.  Synced out to ff now.

OK, thanks.

> CONFIG_PARAVIRT=3Dn kernel runs now, but when I run a defconfig + CONFIG_=
PARAVIRT=3Dy =

> kernel on bare metal init still breaks with a long stream of =

> =

> INIT: Entering runlevel: 3
> Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(void =
*) ph->
> p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
> Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(void =
*) ph->
> p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
> Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(void =
*) ph->
> p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
> Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(void =
*) ph->
> p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
> ...
> =

> before giving up. So it looks like something is still broken

Another one that was working here.  I'll debug with your config.

thanks,
chris
