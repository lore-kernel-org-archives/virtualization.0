From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v3 0/2] hwrng, virtio-rng: init-time fixes
Date: Tue, 15 Jul 2014 12:45:56 +0800
Message-ID: <20140715044556.GA18469@gondor.apana.org.au>
References: <cover.1404987133.git.amit.shah@redhat.com>
	<20140714125006.GA9958@gondor.apana.org.au>
	<20140715044028.GA26186@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140715044028.GA26186@grmbl.mre>
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
Cc: jason@lakedaemon.net, linux-kernel@vger.kernel.org, keescook@chromium.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 15, 2014 at 10:10:28AM +0530, Amit Shah wrote:
> On (Mon) 14 Jul 2014 [20:50:06], Herbert Xu wrote:
> > On Thu, Jul 10, 2014 at 03:42:33PM +0530, Amit Shah wrote:
> > > v3:
> > >  - Kees Cook pointed out a weird side-effect: devices which have
> > >    ->init() registered get their randomness added to the system each
> > >    time they're switched in, but devices that don't have the init
> > >    callback don't contribute to system randomness more than once.  The
> > >    weirdness is resolved here by using the randomness each time
> > >    hwrng_init() is attempted, irrespective of the existence of the
> > >    device's ->init() callback.
> > 
> > All applied to crypto.  Thanks!
> 
> Thanks, Herbert.  I didn't mention it, but pls queue it up for 3.16.

Yes that's why it's in crypto as opposed to cryptodev.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
