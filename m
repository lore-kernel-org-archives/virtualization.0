From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible
Date: Wed, 15 Jan 2020 17:16:35 +0100
Message-ID: <20200115161635.ekrnk5rmjqbxxu77@sirius.home.kraxel.org>
References: <20200110163211.GB29736@mail-itl>
 <20200113071939.rtqb7yw45zi63fqy@sirius.home.kraxel.org>
 <20200115003356.GL2507@mail-itl>
 <20200115100821.qcdraolkoki6e5tz@sirius.home.kraxel.org>
 <20200115134119.GP1314@mail-itl>
 <20200115141353.3kse3uj2mg6ik6k5@sirius.home.kraxel.org>
 <20200115142741.GM2507@mail-itl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200115142741.GM2507@mail-itl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 15, 2020 at 03:27:41PM +0100, Marek Marczykowski-G=F3recki wrot=
e:
> On Wed, Jan 15, 2020 at 03:13:53PM +0100, Gerd Hoffmann wrote:
> >   Hi,
> > =

> > > > And "grep -A1 0000:00:02.0 /proc/iomem" ?
> > > =

> > >   c0000000-c0ffffff : 0000:00:02.0
> > >   c1000000-c103ffff : 0000:00:04.0
> > =

> > So no reservation left.  Whatever blocked the pci bar resource (efifb
> > probably) is gone now.
> > =

> > So the interesting question is why that reservation sticked long enough
> > to prevent bochs-drm from initializing.  In theory efifb de-init should
> > be completed when drm_fb_helper_remove_conflicting_pci_framebuffers()
> > returns.
> =

> Maybe the fact that switching to text mode plymouth help, gives some
> hint?

Maybe plymouth having a /dev/fb0 file handle open in gfx mode has
something to do with it.  But if that is the case I should be able to
reproduce it in theory.  Which is not the case though ...

cheers,
  Gerd
