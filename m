From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Xen-devel] new barrier type for paravirt (was Re: [PATCH]
	virtio_ring: use smp_store_mb)
Date: Sun, 20 Dec 2015 20:59:44 +0100
Message-ID: <20151220195944.GT6344@twins.programming.kicks-ass.net>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
	<20151217105238.GA6375@twins.programming.kicks-ass.net>
	<20151217131554-mutt-send-email-mst@redhat.com>
	<20151217135726.GA6344@twins.programming.kicks-ass.net>
	<20151217161124-mutt-send-email-mst@redhat.com>
	<20151217143910.GD6344@twins.programming.kicks-ass.net>
	<20151220105146-mutt-send-email-mst@redhat.com>
	<5676E047.3010808@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5676E047.3010808@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, qemu-devel@nongnu.org, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Dec 20, 2015 at 05:07:19PM +0000, Andrew Cooper wrote:
> 
> Very much +1 for fixing this.
> 
> Those names would be fine, but they do add yet another set of options in
> an already-complicated area.
> 
> An alternative might be to have the regular smp_{w,r,}mb() not revert
> back to nops if CONFIG_PARAVIRT, or perhaps if pvops have detected a
> non-native environment.  (I don't know how feasible this suggestion is,
> however.)

So a regular SMP kernel emits the LOCK prefix and will patch it out with
a DS prefix (iirc) when it finds but a single CPU. So for those you
could easily do this.

However an UP kernel will not emit the LOCK and do no patching.

So if you're willing to make CONFIG_PARAVIRT depend on CONFIG_SMP or
similar, this is doable.

I don't see people going to allow emitting the LOCK prefix (and growing
the kernel text size) for UP kernels.
