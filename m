From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v2 0/4] virtio-rng: contribute to early randomness requests
Date: Tue, 22 Jul 2014 20:38:15 +0530
Message-ID: <20140722150815.GF32103@grmbl.mre>
References: <cover.1405942162.git.amit.shah@redhat.com>
	<20140722114623.GC18750@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140722114623.GC18750@titan.lakedaemon.net>
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
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, keescook@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 22 Jul 2014 [07:46:23], Jason Cooper wrote:
> On Mon, Jul 21, 2014 at 05:15:48PM +0530, Amit Shah wrote:
> > v2:
> >  - update patch 3 to store the hwrng_register_done bool per-device
> >    rather than global
> >  - add patch 2 that re-arranges struct elems for better packing.
> > 
> > Hi,
> > 
> > This series enables virtio-rng to service the early randomness
> > requests made by the hwrng core (patch 3), with Herbert's idea of
> > using the scan routine.
> > 
> > Patch 4 reverts the previous restriction, which no longer applies, to
> > not send read requests to the host before successful probe.
> > 
> > Patches 1 and 2 are minor cleanups.
> > 
> > Please review and apply,
> > 
> > Amit Shah (4):
> >   virtio: rng: remove unused struct element
> >   virtio: rng: re-arrange struct elements for better packing
> >   virtio: rng: delay hwrng_register() till driver is ready
> >   Revert "hwrng: virtio - ensure reads happen after successful probe"
> > 
> >  drivers/char/hw_random/core.c       |  6 ------
> >  drivers/char/hw_random/virtio-rng.c | 39 ++++++++++++++++---------------------
> >  2 files changed, 17 insertions(+), 28 deletions(-)
> 
> fwiw,
> 
> Reviewed-by: Jason Cooper <jason@lakedaemon.net>
> 
> Thanks for putting this together Amit!

Thanks, Jason!

		Amit
