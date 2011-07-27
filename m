From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: [PATCH 0/5] Collected vdso/vsyscall fixes for 3.1
Date: Wed, 27 Jul 2011 12:58:45 -0400
Message-ID: <20110727165844.GA8064@dumpdata.com>
References: <cover.1311736366.git.luto@mit.edu>
	<20110727145745.GA11872@dumpdata.com>
	<CAObL_7FT8QLg-wihasBahhAtS=pA7+KeU8E=E9x8NPZ0+QJ5iQ@mail.gmail.com>
	<20110727153015.GA16688@dumpdata.com>
	<CAObL_7GWGx4rYJFLpucEX=ozNpk+5ipyq0=vw16xcGetEXSuGQ@mail.gmail.com>
	<20110727154316.GA16909@dumpdata.com>
	<CAObL_7FncQ7DdNf2igFZW=ZzPFQLO3Vvp1c_y5EajA_KTt8iOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAObL_7FncQ7DdNf2igFZW=ZzPFQLO3Vvp1c_y5EajA_KTt8iOg@mail.gmail.com>
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

> >> $ test_vsyscall test
> >> Testing gettimeofday...
> >> =A0 vDSO offset =3D 0.000001s
> >> =A0 vsyscall offset =3D 0.000001s
> >>
> >> Testing time...
> >> =A0 vDSO offset =3D 0
> >> =A0 vsyscall offset =3D 0
> >> Testing getcpu...
> >> =A0 ok! =A0cpu=3D6 node=3D0

> I bet if you pull a new copy or remove -mavx from Makefile it will
> work.  I got a grossly hacked-up Xen domU booted and everything seems
> to work.

It did. Both Dom0 and DomU work on AMD and Intel.

In regards to the last pv-ops patch - is there no better way? The reason I =
am asking
is the pv-ops hook is just a bandaid for the problem. Is the Xen syscall su=
ppose to
be doingsomething extra with the stack perhaps?
