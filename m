From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 03/26] Xen-paravirt_ops: use paravirt_nop to
	consistently mark no-op operations
Date: Fri, 16 Mar 2007 12:49:04 -0700
Message-ID: <20070316194904.GO10574@sequoia.sous-sol.org>
References: <20070301232443.195603797@goop.org>
	<20070301232526.261284776@goop.org>
	<20070316094432.GU23174@elte.hu> <45FAE560.10401@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <45FAE560.10401@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Ingo Molnar wrote:
> > but only as a cleanup of the current open-coded (void *) casts. My 
> > problem with this is that it loses the types. Not that there is much to 
> > check for, but still, this adds some assumptions about how function 
> > calls look like.
> 
> I agree.  I don't generally like this kind of hack, but having a single
> test for "func == paravirt_nop" to look for nop pv_ops in the patcher is
> what tipped the balance.

how about __paravirt_nop_start < func < __paravirt_nop_end  and preserve
the types?

thanks,
-chris
