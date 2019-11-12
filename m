From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 01/13] compiler.h: Split {READ,WRITE}_ONCE definitions
	out into rwonce.h
Date: Tue, 12 Nov 2019 11:36:47 +0000
Message-ID: <20191112113646.GC17835__20868.1624078721$1573558624$gmane$org@willie-the-truck>
References: <20191108170120.22331-1-will@kernel.org>
	<20191108170120.22331-2-will@kernel.org>
	<CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com>
	<93f80017-d65e-7c3a-29b0-d9a568d08f58@de.ibm.com>
	<CAK8P3a21KdGKMDDPs3jc9XEg3=LbzFnGwVm+xDTB+EqGXiZorA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a21KdGKMDDPs3jc9XEg3=LbzFnGwVm+xDTB+EqGXiZorA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Josh Triplett <josh@joshtriplett.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SeongJae Park <sj38.park@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, alpha <linux-alpha@vger.kernel.org>, Joe Perches <joe@perches.com>, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, Yunjae Lee <lyj7694@gmail.com>, virtualization@lists.linux-foundation.org, Boqun Feng <boqun.feng@gmail.com>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 11, 2019 at 10:32:46AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 11, 2019 at 9:10 AM Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
> > On 08.11.19 20:57, Arnd Bergmann wrote:
> > > On Fri, Nov 8, 2019 at 6:01 PM Will Deacon <will@kernel.org> wrote:
> > >>
> > >> In preparation for allowing architectures to define their own
> > >> implementation of the 'READ_ONCE()' macro, move the generic
> > >> '{READ,WRITE}_ONCE()' definitions out of the unwieldy 'linux/compile=
r.h'
> > >> and into a new 'rwonce.h' header under 'asm-generic'.
> > >
> > > Adding Christian Borntr=E4ger to Cc, he originally added the
> > > READ_ONCE()/WRITE_ONCE()
> > > code.
> > >
> > > I wonder if it would be appropriate now to revert back to a much simp=
ler version
> > > of these helpers for any modern compiler. As I understand, only gcc-4=
.6 and
> > > gcc4.7 actually need the song-and-dance version with the union and sw=
itch/case,
> > > while for others, we can might be able back to a macro doing a volati=
le access.
> >
> > As far as I know this particular issue with  volatile access on aggrega=
te types
> > was fixed in gcc 4.8. On the other hand we know that the current constr=
uct will
> > work on all compilers. Not so sure about the orignal ACCESS_ONCE implem=
entation.
> =

> I've seen problems with clang on the current version, leading to unnecess=
ary
> temporaries being spilled to the stack in some cases, so I think it would=
 still
> help to simplify it.
> =

> We probably don't want the exact ACCESS_ONCE() implementation back
> that existed before, but rather something that implements the stricter
> READ_ONCE() and WRITE_ONCE(). I'd probably also want to avoid the
> __builtin_memcpy() exception for odd-sized accesses and instead have
> a separate way to do those.

If you have a patch, I'm happy to carry it at the end of the series to
avoid conflicts. It's not completely clear to me what you're after, so if
you need me to adjust anything here then please shout!

Will
