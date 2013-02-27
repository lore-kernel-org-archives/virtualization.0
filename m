From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 02/16] virtio_ring: virtqueue_add_sgs, to add multiple sgs.
Date: Wed, 27 Feb 2013 09:49:20 +0200
Message-ID: <20130227074920.GA11775@redhat.com>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<1361260594-601-3-git-send-email-rusty@rustcorp.com.au>
	<20130224221255.GA5300@redhat.com> <512C5E0E.5040305@redhat.com>
	<87obf6dxlm.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87obf6dxlm.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 27, 2013 at 05:58:37PM +1030, Rusty Russell wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> > Il 24/02/2013 23:12, Michael S. Tsirkin ha scritto:
> >> On Tue, Feb 19, 2013 at 06:26:20PM +1030, Rusty Russell wrote:
> >>> virtio_scsi can really use this, to avoid the current hack of copying
> >>> the whole sg array.  Some other things get slightly neater, too.
> >>>
> >>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> >> 
> >> Hmm, this makes add_buf a bit slower. virtio_test results
> >> (I'll send a patch to update the test shortly):
> >> 
> >> Before:
> >> 0.09user 0.01system 0:00.12elapsed 91%CPU (0avgtext+0avgdata 480maxresident)k
> >> 0inputs+0outputs (0major+145minor)pagefaults 0swaps
> >> 
> >> After:
> >> 0.11user 0.01system 0:00.13elapsed 90%CPU (0avgtext+0avgdata 480maxresident)k
> >> 0inputs+0outputs (0major+145minor)pagefaults 0swaps
> >
> > Not unexpected at all... :(
> >
> > Some of it can be recovered, but if it's 20% I doubt all of it.  So my
> > patches were not premature optimization; you really can take just two
> > among speed, flexibility, and having a nice API.
> 
> The error bars on this are far too large to say "20%".
> 
> Here are my numbers, using 50 runs of:
> time tools/virtio/vringh_test --indirect --eventidx --parallel and
> stats --trim-outliers:
> 
> Baseline (before add_sgs):
>         2.840000-3.040000(2.927292)user
> 
> After add_sgs:
>         2.970000-3.150000(3.053750)user
> 
> After simplifying add_buf a little:
>         2.950000-3.210000(3.081458)user
> 
> After inlining virtqueue_add/vring_add_indirect:
>         2.920000-3.150000(3.026875)user
> 
> After passing in iteration functions (chained vs unchained):
>         2.760000-2.970000(2.883542)user
> 
> After removing the now-unnecessary chain-cleaning in add_buf:
>         2.660000-2.830000(2.753542)user
> 
> Any questions?
> Rusty.

Sorry, so which patches are included in the last stage?
Something I didn't make clear: I tested 2/16 (the patch I replied to).

-- 
MST
