From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 05/26] Xen-paravirt_ops: paravirt_ops: hooks
	to set up initial pagetable
Date: Sat, 17 Mar 2007 20:47:29 +1100
Message-ID: <1174124849.8897.43.camel@localhost.localdomain>
References: <20070301232443.195603797@goop.org>
	<20070301232526.611972133@goop.org> <20070316093348.GS23174@elte.hu>
	<45FAE46F.7080009@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45FAE46F.7080009@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-03-16 at 11:39 -0700, Jeremy Fitzhardinge wrote:
> Ingo Molnar wrote:
> >> +	/* Make sure kernel address space is empty so that a pagetable
> >> +	   will be allocated for it. */
> >>     
> >
> > comment style.
> >   
> 
> As you've noticed its a comment style I use quite often.

Me too, and Ingo and I have had this argument before.  These days I try
hard to fit simple comments in a single line 8)

Rusty.
