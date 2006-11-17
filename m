From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Fri, 17 Nov 2006 05:47:22 +0100
Message-ID: <200611170547.22192.ak@suse.de>
References: <20061027145650.GA37582@muc.de> <200611162046.04264.ak@suse.de>
	<20061116202429.GG1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061116202429.GG1397@sequoia.sous-sol.org>
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

On Thursday 16 November 2006 21:24, Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
> > > > Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `=
(void *) ph->
> > > > p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
> > =

> > I started some bisecting...
> <snip patch list>
> > it's already broken at more-generic-paravirtualization.  Surprised
> > me a little, i was suspecting the MMU changes.
> =

> Looks like the VDSO issue, paravirt is not compatible if COMPAT_VDSO.

So you're not planning to support old user land with paravirt? =

Wouldn't it be better to just disable the vDSO completely then? At least
all old binaries would work then.

> I expect you'll get the same if you disable COMPAT_VDSO on native build?

Yes. This is a older SUSE 9.0 image.

-Andi
