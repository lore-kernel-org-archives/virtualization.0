From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Re: [patch 20/26] Xen-paravirt_ops: Core Xen
	implementation
Date: Sat, 17 Mar 2007 20:13:47 +1100
Message-ID: <1174122827.8897.18.camel@localhost.localdomain>
References: <20070301232443.195603797@goop.org>
	<20070301232528.812011702@goop.org>  <20070316091411.GF23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316091411.GF23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-03-16 at 10:14 +0100, Ingo Molnar wrote:
> > +unsigned long xen_pmd_val(pmd_t pmd)
> > +{
> > +	BUG();
> > +	return 0;
> > +}
> 
> make it noret.

OK, I missed this one.  How?

Wondering if I've missed a trick here...
Rusty.
