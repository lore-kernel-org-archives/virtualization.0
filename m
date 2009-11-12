From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver
Date: Thu, 12 Nov 2009 12:59:59 +1030
Message-ID: <200911121259.59540.rusty__49285.4491495111$1257993147$gmane$org@rustcorp.com.au>
References: <1257782838.2835.5.camel@aglitke>
	<200911111313.24226.rusty@rustcorp.com.au>
	<1257952114.2876.29.camel@aglitke>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257952114.2876.29.camel@aglitke>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Litke <agl@us.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, agl@linux.vnet.ibm.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 12 Nov 2009 01:38:34 am Adam Litke wrote:
> > But it raises the question: what stats are generally useful cross-OS?  Should
> > we be supplying numbers like "unused" (free) "instantly discardable" (ie.
> > clean), "discardable to disk" (ie. file-backed), "discardable to swap"
> > (ie. swap-backed) and "unswappable" instead?
> 
> While I see the virtue in presenting abstracted memory stats that seem
> more digestible in a virtualization context, I think we should keep the
> raw stats.  This concentrates the complexity in the host-side management
> daemon, and allows the host daemon to make better decisions (ie. by
> reacting to trends in individual statistics).  Different OSes (or
> different versions of the same OS), may also have different sets of
> statistics that will provide the answers that a management daemon needs.

OK, I see you made each one a separate feature bit, which does allow this
somewhat.  But you can't just change the meaning arbitrarily, all you can
do is refuse to supply some of them.  This is because virtio is an ABI,
but also it's plain sanity: run a new guest on an old host and get crazy
answers.

Two more questions:

I assume memtot should be equal to the initial memory granted to the guest
(perhaps reduced if the guest can't use all the memory for internal reasons)?

I'm not sure of the relevance to the host of the number of anonymous pages?
That's why I wondered if unswappable pages would be a better number to supply?

Thanks,
Rusty.
