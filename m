From: Andi Kleen <ak@suse.de>
Subject: Re: A proposal - binary
Date: Sat, 5 Aug 2006 00:52:36 +0200
Message-ID: <200608050052.36535.ak@suse.de>
References: <44D1CC7D.4010600@vmware.com> <200608050001.52535.ak@suse.de>
	<44D3CCA1.1040503@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <44D3CCA1.1040503@vmware.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xensource.com, Jack Lo <jlo@vmware.com>, Greg KH <greg@kroah.com>, Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, James.Bottomley@steeleye.com, pazke@donpac.ru
List-Id: virtualization@lists.linuxfoundation.org


> For privileged domains that have hardware privileges and need to send 
> IPIs or something it might make sense. 

Any SMP guest needs IPI support of some sort.

But it is hopefully independent of subarchitectures in the paravirtualized
case.


> doesn't stop Linux from using the provided primitives in any way is 
> sees fit.  So it doesn't top evolution in that sense.  What it does stop 
> is having the Linux hypervisor interface grow antlers and have new 
> hooves grafted onto it.  What it sorely needed in the interface is a way 
> to probe 

That's the direction the interface is evolving I think (see multiple
entry point discussion) 

> and detect optional features that allow it to grow independent 
> of one particular hypervisor vendor.

Ok maybe not with options and subsets so far, but one has to
start somewhere.

-Andi
