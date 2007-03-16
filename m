From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Re: [patch 21/26] Xen-paravirt_ops: Use the hvc
	console infrastructure for Xen console
Date: Fri, 16 Mar 2007 10:58:51 +0100
Message-ID: <20070316095851.GB301@elte.hu>
References: <20070316085451.GE23174@elte.hu> <C22013C9.B9E6%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <C22013C9.B9E6%keir@xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <Keir.Fraser@xensource.com>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Keir Fraser <Keir.Fraser@xensource.com> wrote:

> On 16/3/07 08:54, "Ingo Molnar" <mingo@elte.hu> wrote:
> 
> >> + prod = intf->in_prod;
> >> + mb();
> >> + BUG_ON((prod - cons) > sizeof(intf->in));
> > 
> > such mb()'s are typically a sign of "i have no clear idea what SMP
> > serialization rules apply here, but something is needed because
> > otherwise it breaks" ?
> 
> These mb()'s are pretty standard for lock-free producer/consumer 
> rings. Write descriptor /then/ write the updated producer. Read the 
> producer /then/ read any descriptors revealed by this new producer 
> value.

then use rmb()/wmb(). Rarely does a ring protocol truly need mb().

	Ingo
