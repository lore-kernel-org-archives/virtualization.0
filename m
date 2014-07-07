From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio: rng: ensure reads happen after successful
	probe
Date: Mon, 7 Jul 2014 12:04:09 +0530
Message-ID: <20140707063409.GD27024@grmbl.mre>
References: <cover.1404538109.git.amit.shah@redhat.com>
	<f64852e0dd8a439193db4c7da1d3022d029cc85d.1404538109.git.amit.shah@redhat.com>
	<CAGXu5jK1wL9DCnH0RcqhantcCvyJhwZfkw+_L7VQi8wfY2Nt_g@mail.gmail.com>
	<20140707055049.GA27024@grmbl.mre>
	<CAGXu5jJ9-b-NycB4ESvVnVgiBXpeQvKAT_hDPoAzhWSpQQKreg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ9-b-NycB4ESvVnVgiBXpeQvKAT_hDPoAzhWSpQQKreg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, LKML <linux-kernel@vger.kernel.org>, "# 3.4.x" <stable@vger.kernel.org>, Virtualization List <virtualization@lists.linux-foundation.org>, Jason Cooper <jason@lakedaemon.net>
List-Id: virtualization@lists.linuxfoundation.org

On (Sun) 06 Jul 2014 [23:09:49], Kees Cook wrote:
> On Sun, Jul 6, 2014 at 10:51 PM, Amit Shah <amit.shah@redhat.com> wrote:
> > On (Sun) 06 Jul 2014 [21:38:36], Kees Cook wrote:
> >> On Fri, Jul 4, 2014 at 10:34 PM, Amit Shah <amit.shah@redhat.com> wrote:
> >> > The hwrng core asks for random data in the hwrng_register() call itself
> >> > from commit d9e7972619.  This doesn't play well with virtio -- the
> >> > DRIVER_OK bit is only set by virtio core on a successful probe, and
> >> > we're not yet out of our probe routine when this call is made.  This
> >> > causes the host to not acknowledge any requests we put in the virtqueue,
> >> > and the insmod or kernel boot process just waits for data to arrive from
> >> > the host, which never happens.
> >>
> >> Doesn't this mean that virtio-rng won't ever contribute entropy to the system?
> >
> > The initial randomness?  Yes.  But it'll start contributing entropy as
> > soon as it's used as the current source.
> 
> How does that happen? I don't see an init function defined for it?

I mean the regular usage; not the initial randomness patch that you
added.

Initial randomness from virtio-rng currently won't be sourced.  That's
no different from the way things were before your patch; and I can't
think of a way to make that happen for now.

virtio's probe() has to finish before communication with the host can
start.  If a virtio-rng device is the only hwrng in the system (very
likely in a guest), it's almost guaranteed that hwrng_init() won't be
called after hwrng_register() completes (as it would have already been
called and the virtio-rng device will have become the current_rng).

If the VM admin configured two virtio-rng sources, though, or
hotplugged one later, the early randomness will be obtained for the
second virtio-rng device.  But this is a scenario I don't expect to
ever arise -- it's just a theoretical possibility.


		Amit
