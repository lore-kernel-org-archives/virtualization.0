From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] hwrng: don't fetch rng from sources without init
Date: Wed, 2 Jul 2014 08:14:38 -0400
Message-ID: <20140702121438.GK23978__24197.2646363594$1404408080$gmane$org@titan.lakedaemon.net>
References: <cover.1404296679.git.amit.shah@redhat.com>
	<c911b7944f2d05f5c6f5cf5dc37b8dbb99fd0b14.1404296679.git.amit.shah@redhat.com>
	<20140702115823.GJ23978@titan.lakedaemon.net>
	<20140702121120.GB7505@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140702121120.GB7505@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, keescook@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 02, 2014 at 05:41:20PM +0530, Amit Shah wrote:
> On (Wed) 02 Jul 2014 [07:58:23], Jason Cooper wrote:
> > On Wed, Jul 02, 2014 at 03:58:15PM +0530, Amit Shah wrote:
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
> > > This commit makes the call to rng_get_data() depend on no init fn
> > > pointer being registered by the device.  If an init function is
> > > registered, this call isn't made.
> > > 
> > > CC: Kees Cook <keescook@chromium.org>
> > > CC: Jason Cooper <jason@lakedaemon.net>
> > > CC: Herbert Xu <herbert@gondor.apana.org.au>
> > > CC: <stable@vger.kernel.org> # For 3.15 only
> > 
> > # v3.15+ should be fine here.
> > 
> > > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > > ---
> > >  drivers/char/hw_random/core.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> > > index 334601c..3f3941d 100644
> > > --- a/drivers/char/hw_random/core.c
> > > +++ b/drivers/char/hw_random/core.c
> > > @@ -347,9 +347,11 @@ int hwrng_register(struct hwrng *rng)
> > >  	INIT_LIST_HEAD(&rng->list);
> > >  	list_add_tail(&rng->list, &rng_list);
> > >  
> > > -	bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
> > > -	if (bytes_read > 0)
> > > -		add_device_randomness(bytes, bytes_read);
> > > +	if (!rng->init) {
> > > +		bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
> > > +		if (bytes_read > 0)
> > > +			add_device_randomness(bytes, bytes_read);
> > > +	}
> > 
> > afaict, this is redundant at initialization time.  current_rng shouldn't
> > be set yet, so hwrng_init(rng) will get called at line 333.  Or, am I
> > missing something?
> 
> You're right -- the device will have been initialized if it's the
> first hwrng device to be registered.  And in that case, this device
> won't contribute to the initial pool (and that's the only case).
> 
> Can someone think of a better way to handle this for that case, then?

I'm cooking up something...

thx,

Jason.
