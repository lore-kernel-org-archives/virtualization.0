From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 20/26] Xen-paravirt_ops: Core Xen
	implementation
Date: Fri, 16 Mar 2007 10:12:50 -0700
Message-ID: <20070316171250.GM10574@sequoia.sous-sol.org>
References: <20070301232443.195603797@goop.org>
	<20070301232528.812011702@goop.org>
	<20070316091411.GF23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
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
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

* Ingo Molnar (mingo@elte.hu) wrote:
> >  ENTRY(swapper_pg_dir)
> > +	.align PAGE_SIZE_asm
> >  	.fill 1024,4,0
> 
> does the native kernel lose memory here?

Not in my builds.
