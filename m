From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] tracing/events: Add bounce tracing to swiotbl-xen
Date: Wed, 4 Sep 2013 16:35:03 -0400
Message-ID: <20130904203502.GA8726@phenom.dumpdata.com>
References: <1377208048-8963-1-git-send-email-zoltan.kiss@citrix.com>
	<20130823125533.GC14306@konrad-lan.dumpdata.com>
	<5224D0D6.40908@citrix.com>
	<20130903124237.GB9870@konrad-lan.dumpdata.com>
	<522793CA.3060002@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <522793CA.3060002@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zoltan Kiss <zoltan.kiss@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 04, 2013 at 09:10:50PM +0100, Zoltan Kiss wrote:
> On 03/09/13 13:42, Konrad Rzeszutek Wilk wrote:
> >Correct. The double buffering code is being run in lib/swiotlb.c not the
> >xen-swiotlb.c. Hence the question of why not move the tracing in there.
> I've put the trace to both locations before swiotlb_tbl_map_single
> is called, so the same tracer will be hit both with classic and Xen
> SWIOTLB. I used 2 different place instead of calling from
> swiotlb_tbl_map_single because I want to print out dev_addr, and
> it's calculated differently.
> 
> >Yes. And please (if it adds a benefit) also for unmap/sync which can trigger
> >the bounce buffer.
> >
> >Or if it makes sense just for the bounce buffer copying - then just
> >leave it at that. Thanks.
> For me the relevant event was to see when we start to do bounce
> buffering. When does it end, or when syncing happens is a different
> thing. If someone is interested, they can easily extend this patch
> with that.
> 
> However one question bothers me: why ftrace doesn't trace these
> functions? They are not inlined, static, or marked as notrace.

They are usually part of the dma_ops structure. That might be the reason.
> 
> Regards,
> 
> Zoli
