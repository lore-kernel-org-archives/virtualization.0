From: Adam Litke <agl@us.ibm.com>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver
Date: Wed, 11 Nov 2009 09:08:34 -0600
Message-ID: <1257952114.2876.29.camel__745.981935370032$1257952255$gmane$org@aglitke>
References: <1257782838.2835.5.camel@aglitke>
	<200911111032.14956.rusty@rustcorp.com.au>
	<4AFA005C.7020607@us.ibm.com>
	<200911111313.24226.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200911111313.24226.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, agl@linux.vnet.ibm.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2009-11-11 at 13:13 +1030, Rusty Russell wrote:
> > It's not laziness, it's consistency.  How is actual different than free 
> > memory or any other stat?
> 
> Because it's a COLLECTION of stats.  For example, swap in should be < swap
> out.  Now, the current Linux implementation of all_vm_events() is non-atomic
> anyway, so maybe we can just document this as best-effort.  I'm saying that
> if it *is* a problem, I think we need a vq.

I can't see why we would care about the atomicity of the collection of
statistics.  Best-effort is good enough.  Any variance within the stats
will be overshadowed by the latency of the host-side management daemon.

> But it raises the question: what stats are generally useful cross-OS?  Should
> we be supplying numbers like "unused" (free) "instantly discardable" (ie.
> clean), "discardable to disk" (ie. file-backed), "discardable to swap"
> (ie. swap-backed) and "unswappable" instead?

While I see the virtue in presenting abstracted memory stats that seem
more digestible in a virtualization context, I think we should keep the
raw stats.  This concentrates the complexity in the host-side management
daemon, and allows the host daemon to make better decisions (ie. by
reacting to trends in individual statistics).  Different OSes (or
different versions of the same OS), may also have different sets of
statistics that will provide the answers that a management daemon needs.


-- 
Thanks,
Adam
