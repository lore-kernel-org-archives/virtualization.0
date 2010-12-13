From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] tools/virtio: virtio_test tool
Date: Mon, 13 Dec 2010 18:58:28 +0200
Message-ID: <20101213165828.GA7182__15273.6185155392$1292259588$gmane$org@redhat.com>
References: <20101129170431.GA4027@redhat.com>
	<20101129171637.GC4027@redhat.com>
	<AANLkTinSia0yt3xmNusXezVsmembv9NKoymN+rrBn_pY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinSia0yt3xmNusXezVsmembv9NKoymN+rrBn_pY@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thiago Farina <tfransosi@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 06, 2010 at 02:37:05PM -0200, Thiago Farina wrote:
> On Mon, Nov 29, 2010 at 3:16 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > +#define container_of(ptr, type, member) ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 \
> > + =A0 =A0 =A0 const typeof( ((type *)0)->member ) *__mptr =3D (ptr); =
=A0 =A0\
> > + =A0 =A0 =A0 (type *)( (char *)__mptr - offsetof(type,member) );})
> > +
> > +#define uninitialized_var(x) x =3D x
> > +
> > +# ifndef likely
> > +# =A0define likely(x) =A0 =A0(__builtin_expect(!!(x), 1))
> > +# endif
> > +# ifndef unlikely
> > +# =A0define unlikely(x) =A0(__builtin_expect(!!(x), 0))
> > +# endif
> =

> It seems you are not using these macros. Do you really need them here?

They are used by virtio that I'm compiling in userspace here.

> Can't you include the right linux header files for these macros
> instead?

Far from trivial as linux headers aren't intended to
be built in userspace, if you try you get all kind of
conflicts with libc headers etc.

If you see a way to do this, pls send me a patch.

-- =

MST
