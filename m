From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/5] Collected vdso/vsyscall fixes for 3.1
Date: Wed, 27 Jul 2011 11:30:15 -0400
Message-ID: <20110727153015.GA16688__2331.61024884812$1311780676$gmane$org@dumpdata.com>
References: <cover.1311736366.git.luto@mit.edu>
	<20110727145745.GA11872@dumpdata.com>
	<CAObL_7FT8QLg-wihasBahhAtS=pA7+KeU8E=E9x8NPZ0+QJ5iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAObL_7FT8QLg-wihasBahhAtS=pA7+KeU8E=E9x8NPZ0+QJ5iQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: xen-devel@lists.xensource.com, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

> > Anyhow, removed the benchmark code and ran it on 64-bit:
> >
> > sh-4.1# /test_vsyscall =A0test
> > Testing gettimeofday...
> > [ =A0109.552261] test_vsyscall[2462] trap invalid opcode ip:400c8d sp:7=
fff84fab470 error:0 in test_vsyscall[400000+2000]
> > Illegal instruction
> > sh-4.1# /test_vsyscall =A0intcc
> > About to execute int 0xcc from RIP =3D 400959
> > [ =A0114.137150] test_vsyscall[2463] illegal int 0xcc (exploit attempt?=
) ip:400959 cs:e033 sp:7fff8b328310 ax:2c si:0 di:7fff8b3280f0
> > Caught SIGSEGV: Segmentation fault (Signal sent by the kernel [(nil)])R=
IP =3D 400959
> >
> > [This is on git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.gi=
t #testing, which
> > has todays linus/master and your patchset]
> >
> =

> I'll set up Xen.  Something's clearly still buggy.

You sure? This is what I get when I boot baremetal:

sh-4.1# =

sh-4.1# xen-detect =

Not running on Xen.
sh-4.1# /test_vsyscall test
Testing gettimeo[   84.442819] test_vsyscall[3175] trap invalid opcode ip:4=
00c8d sp:7fffa8a72dc0 error:0fday...
 in test_vsyscall[400000+2000]
Illegal instruction
sh-4.1# /test_vsyscall intcc
About to execute[   87.549820] test_vsyscall[3176] illegal int 0xcc (exploi=
t attempt?) ip:400959 cs:33 sp:7fff0ccddff0 ax:2c s^G^G^G^G^G^G^Gsh-4.1# =

sh-4.1# /test_vsyscall intcc
About to execute[   90.283817] test_vsyscall[3177] illegal int 0xcc (exploi=
t attempt?) ip:400959 cs:33 sp:7fffae8a8b40 ax:2c son fault (Signal sent by=
 the kernel [(nil)])RIP =3D 400959

Unless the whole paravirt kernel is buggy. Hadn't tried to boot non-paravir=
t.
