From: Kent Overstreet <kmo@daterainc.com>
Subject: Re: [PATCH-v3 1/4] idr: Percpu ida
Date: Wed, 28 Aug 2013 14:12:17 -0700
Message-ID: <20130828211217.GE1357@kmo-pixel>
References: <1376694549-20609-1-git-send-email-nab@linux-iscsi.org>
	<1376694549-20609-2-git-send-email-nab@linux-iscsi.org>
	<20130820143157.f91bf59d16352989b54e431e@linux-foundation.org>
	<20130828195317.GE8032@kmo-pixel>
	<20130828132332.6d5263ee9622235ae0fcc615@linux-foundation.org>
	<20130828204454.GC1357@kmo-pixel>
	<20130828135042.9e460b27699b52bb4eb53d9e@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130828135042.9e460b27699b52bb4eb53d9e@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andi Kleen <andi@firstfloor.org>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, lkml <linux-kernel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Christoph Lameter <cl@gentwo.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 28, 2013 at 01:50:42PM -0700, Andrew Morton wrote:
> On Wed, 28 Aug 2013 13:44:54 -0700 Kent Overstreet <kmo@daterainc.com> wrote:
> 
> > > > > What guarantees that this wait will terminate?
> > > > 
> > > > It seems fairly clear to me from the break statement a couple lines up;
> > > > if we were passed __GFP_WAIT we terminate iff we succesfully allocated a
> > > > tag. If we weren't passed __GFP_WAIT we never actually sleep.
> > > 
> > > OK ;)  Let me rephrase.  What guarantees that a tag will become available?
> > > 
> > > If what we have here is an open-coded __GFP_NOFAIL then that is
> > > potentially problematic.
> > 
> > It's the same semantics as a mempool, really - it'll succeed when a tag
> > gets freed.
> 
> OK, that's reasonable if the code is being used to generate IO tags -
> we expect the in-flight tags to eventually be returned.
> 
> But if a client of this code is using the allocator for something
> totally different, there is no guarantee that the act of waiting will
> result in any tags being returned.

Yeah, and I did wonder a bit whether the waiting mechanism belonged in
the percpu ida code; arguably (certainly just looking at this code, not
any of the users) if it belongs in this code it should be common to
regular ida, not specific to percpu ida.

For now I've just decided to punt on changing that for now, since all
the percpu ida users I've come across do want the waiting mechanism, but
none of the regular ida users that I've looked at want it. There's
probably a reason for that I haven't thought of yet.

> (These are core design principles/constraints which should be
> explicitly documented in a place where future readers will see them!)

*nod* I suppose it should be said explicitly that the gfp_t parameter
indicates whether or not to wait until a _tag_ is available, and not
some internal memory allocation or something.

How's this look?

diff --git a/lib/idr.c b/lib/idr.c
index 15c021c..a3f8e9a 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -1288,6 +1288,11 @@ static inline unsigned alloc_local_tag(struct percpu_ida *pool,
  * Safe to be called from interrupt context (assuming it isn't passed
  * __GFP_WAIT, of course).
  *
+ * @gfp indicates whether or not to wait until a free id is available (it's not
+ * used for internal memory allocations); thus if passed __GFP_WAIT we may sleep
+ * however long it takes until another thread frees an id (same semantics as a
+ * mempool).
+ *
  * Will not fail if passed __GFP_WAIT.
  */
 int percpu_ida_alloc(struct percpu_ida *pool, gfp_t gfp)
