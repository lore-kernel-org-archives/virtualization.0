From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible
Date: Mon, 20 Jan 2020 10:58:48 +0100
Message-ID: <20200120095848.hg4ywvocf5bcdun5@sirius.home.kraxel.org>
References: <20200113071939.rtqb7yw45zi63fqy@sirius.home.kraxel.org>
 <20200115003356.GL2507@mail-itl>
 <20200115100821.qcdraolkoki6e5tz@sirius.home.kraxel.org>
 <20200115134119.GP1314@mail-itl>
 <20200115141353.3kse3uj2mg6ik6k5@sirius.home.kraxel.org>
 <20200115142741.GM2507@mail-itl>
 <20200115161635.ekrnk5rmjqbxxu77@sirius.home.kraxel.org>
 <20200116025232.GN2507@mail-itl>
 <20200117125825.3in2t2m6nxbblsaf@sirius.home.kraxel.org>
 <20200117152211.GZ1314@mail-itl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200117152211.GZ1314@mail-itl>
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

On Fri, Jan 17, 2020 at 04:22:11PM +0100, Marek Marczykowski-G=F3recki wrot=
e:
> On Fri, Jan 17, 2020 at 01:58:25PM +0100, Gerd Hoffmann wrote:
> > > Should switching to bochsdrmfb be deferred until efifb gets properly
> > > destroyed? How?
> > =

> > Should be in do_remove_conflicting_framebuffers, everyone might run into
> > this.  So lets try wait for all (other) references went away:
> =

> Yes, this solves the problem. I guess the proper solution would be to
> replace it with some wait queue or such, right?

Not sure a wait queue would actually be better.

> Is there any guarantee that the process holding /dev/fb0 (plymouthd in
> this case) will eventually release it?

No.

So it'll probably makes sense to limit the time we are willing to wait
here.

Or maybe take a completely different path and make the reservation
failure in bochs-drm a warning not an error.

cheers,
  Gerd
