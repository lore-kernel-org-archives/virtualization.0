From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Fwd: [PATCH]: Fix crash in virtio_blk during modprobe ; rmmod ;
	modprobe]
Date: Fri, 23 May 2008 11:16:07 +1000
Message-ID: <200805231116.07773.rusty__8064.94702487743$1211505554$gmane$org@rustcorp.com.au>
References: <48341FC7.4060600@redhat.com>
	<200805222133.01686.rusty@rustcorp.com.au>
	<20080522113517.GC7712@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080522113517.GC7712@kernel.dk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 22 May 2008 21:35:19 Jens Axboe wrote:
> On Thu, May 22 2008, Rusty Russell wrote:
> > Thanks Chris, it seems reasonable and I'm sure it works (kinda hard to
> > test here, it's my root block dev).  Other drivers seem to do
> > blk_cleanup_queue() *after* del_gendisk: does it matter?
> >
> > Jens CC'd: he's gentle with my dumb questions...  Rusty.
>
> del_gendisk() can generate IO, so it would seem safer to do that
> _before_ putting the queue reference :-)

Thanks Jens.  Chris, I've fixed that up here.

Cheers,
Rusty.
