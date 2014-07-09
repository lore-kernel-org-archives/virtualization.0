From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v2 1/2] hwrng: fetch randomness only after device init
Date: Wed, 9 Jul 2014 18:38:22 +0530
Message-ID: <20140709130822.GA4553@grmbl.mre>
References: <cover.1404538109.git.amit.shah@redhat.com>
	<515a12ecc5fca5452bf0bfda4d54546d8fb5829c.1404538109.git.amit.shah@redhat.com>
	<20140709115317.GM13433@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140709115317.GM13433@titan.lakedaemon.net>
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
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, keescook@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 09 Jul 2014 [07:53:17], Jason Cooper wrote:
> On Sat, Jul 05, 2014 at 11:04:52AM +0530, Amit Shah wrote:
> > Commit d9e7972619334 "hwrng: add randomness to system from rng sources"
> > added a call to rng_get_data() from the hwrng_register() function.
> > However, some rng devices need initialization before data can be read
> > from them.
> > 
> > This commit makes the call to rng_get_data() depend on no init fn
> > pointer being registered by the device.  If an init function is
> > registered, this call is made after device init.
> > 
> > CC: Kees Cook <keescook@chromium.org>
> > CC: Jason Cooper <jason@lakedaemon.net>
> > CC: Herbert Xu <herbert@gondor.apana.org.au>
> > CC: <stable@vger.kernel.org> # For v3.15+
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > ---
> >  drivers/char/hw_random/core.c | 31 +++++++++++++++++++++++++------
> >  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> Thanks for cleaning this up!

Thanks!

Any thoughts on the follow-up patch posted later that resolves some of
the weirdness in init?

		Amit
