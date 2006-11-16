From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Thu, 16 Nov 2006 12:24:29 -0800
Message-ID: <20061116202429.GG1397@sequoia.sous-sol.org>
References: <20061027145650.GA37582@muc.de> <200611161416.45624.ak@suse.de>
	<20061116190334.GF1397@sequoia.sous-sol.org>
	<200611162046.04264.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200611162046.04264.ak@suse.de>
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
> > > Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(v=
oid *) ph->
> > > p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
> =

> I started some bisecting...
<snip patch list>
> it's already broken at more-generic-paravirtualization.  Surprised
> me a little, i was suspecting the MMU changes.

Looks like the VDSO issue, paravirt is not compatible if COMPAT_VDSO.
I expect you'll get the same if you disable COMPAT_VDSO on native build?

thanks,
-chris
