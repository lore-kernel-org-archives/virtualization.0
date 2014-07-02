From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 1/2 v2] hwrng: Allow drivers to disable reading during
	probe
Date: Wed, 2 Jul 2014 21:28:02 +0530
Message-ID: <20140702155802.GB12962__21200.1532353044$1404316721$gmane$org@grmbl.mre>
References: <cover.1404296679.git.amit.shah@redhat.com>
	<1404306020-24916-1-git-send-email-jason@lakedaemon.net>
	<20140702132635.GD7505@grmbl.mre>
	<20140702134156.GL23978@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140702134156.GL23978@titan.lakedaemon.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 02 Jul 2014 [09:41:56], Jason Cooper wrote:
> On Wed, Jul 02, 2014 at 06:56:35PM +0530, Amit Shah wrote:
> > Hi Jason,
> > 
> > On (Wed) 02 Jul 2014 [13:00:19], Jason Cooper wrote:
> > > Commit d9e7972619334 "hwrng: add randomness to system from rng sources"
> > > added a call to rng_get_data() from the hwrng_register() function.
> > > However, some rng devices need initialization before data can be read
> > > from them.
> > > 
> > > Also, the virtio-rng device does not behave properly when this call is
> > > made in its probe() routine - the virtio core sets the DRIVER_OK status
> > > bit only on a successful probe, which means the host ignores all
> > > communication from the guest, and the guest insmod or boot process just
> > > sits there doing nothing.
> > > 
> > > [ jac: Modify the API to allow drivers to disable reading at probe, new
> > > patch, copied Amit's commit message. ]
> > > 
> > > CC: Kees Cook <keescook@chromium.org>
> > > CC: Jason Cooper <jason@lakedaemon.net>
> > > CC: Herbert Xu <herbert@gondor.apana.org.au>
> > > CC: <stable@vger.kernel.org> # v3.15+
> > > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > > ---
> > >  drivers/char/hw_random/core.c | 8 +++++---
> > >  include/linux/hw_random.h     | 4 ++++
> > >  2 files changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> > > index 334601cc81cf..b7b6c48ca682 100644
> > > --- a/drivers/char/hw_random/core.c
> > > +++ b/drivers/char/hw_random/core.c
> > > @@ -347,9 +347,11 @@ int hwrng_register(struct hwrng *rng)
> > >  	INIT_LIST_HEAD(&rng->list);
> > >  	list_add_tail(&rng->list, &rng_list);
> > >  
> > > -	bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
> > > -	if (bytes_read > 0)
> > > -		add_device_randomness(bytes, bytes_read);
> > > +	if (!(rng->flags & HWRNG_NO_READ_AT_PROBE)) {
> > > +		bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
> > > +		if (bytes_read > 0)
> > > +			add_device_randomness(bytes, bytes_read);
> > > +	}
> > 
> > But this has the inverse problem: if there are two hwrngs in the
> > system, one will be initialized and probed.  The other will not be
> > initialized, but still be probed.
> 
> That's a problem outside the scope of this patch.

No, not really.  What will happen in a 2 hwrng scenario is that the
first one that calls hwrng_register() will get its init() routine
called, and probed for data properly.

The second device to call hwrng_register() will not get its init
routine called, but still will be probed.  And that will result in
unpredictable behaviour, as the device wouldn't have been initialized
for reading of the data.  This bug was introduced by the original
patch, which was fixed by my series (by ensuring probe is only called
if init was called first.  But it missed one case where probe will not
be called even if init was called, as you pointed out).

>  You're basically
> saying the ->init() should be called unconditionally for each hwrng.  If
> that's what driver authors assumed, that's not what is happening if
> there is more than one driver in the system.

Either that, or that rng_get_data() should be called in hwrng_init(),
or not call rng_get_data() at all on that device.

> I think you should be changing the code a few lines up to make sure
> hwrng_init() is called once for each driver.
> 
> > My version was more conservative while this one keeps the bug from the
> > current kernels.
> 
> Huh?  What do you mean by "keeps the bug from the current kernels." ?

Sorry; hope the explanation above is clearer.

> Besides, you're second patch isn't actually doing any ->init to get the
> hwrng ready for reading...  If you had a real ->init function, and it
> was always called, would rng_get_data() work at probe time for your
> driver?

Right; that's the reason I didn't do it that way.

I think a combination of my patches and your flags approach will solve
the issues; I'll post a v2 tomorrow.


		Amit
