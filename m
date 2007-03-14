From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [patch 28/34] Xen-pv_ops: Xen SMP guest support
Date: Wed, 14 Mar 2007 09:28:20 -0400
Message-ID: <20070314132820.GL6209@kvack.org>
References: <20070313233017.933601256@goop.org>
	<20070313233034.586018620@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070313233034.586018620@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 13, 2007 at 04:30:45PM -0700, Jeremy Fitzhardinge wrote:
> [ brcl, mingo: Would you mind having a close look at the code in
>   xen_exit_mm and drop_mm_ref? - Thanks ]

I see what you're doing here, and this comment seems to allude to the reasons 
behind it without spelling it out.

> +/*
> + * We aggressively remove defunct pgd from cr3. We execute unmap_vmas()
> + * *much* faster this way.
> + */

Are you switching mms in order to avoid all of the overhead associated with 
flushing an active mm during task exit?  If so, it makes much more sense to 
do this in the generic helper, as it should be a win on x86 and x86-64 
where switching to init_mm is relatively low cost given the support for 
global pages.  I'll run some tests on a couple of systems this evening and 
post the results.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <zyntrop@kvack.org>.
