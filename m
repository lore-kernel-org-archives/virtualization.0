From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 07/21] Xen-paravirt: remove ctor for pgd
	cache
Date: Fri, 16 Feb 2007 15:33:09 -0800
Message-ID: <45D63F35.3000101@goop.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.047039320@goop.org>
	<Pine.LNX.4.64.0702161229360.26650@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <Pine.LNX.4.64.0702161229360.26650@schroedinger.engr.sgi.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Christoph Lameter wrote:
> On Thu, 15 Feb 2007, Jeremy Fitzhardinge wrote:
>
>   
>> Remove the ctor for the pgd cache.  There's no point in having the
>> cache machinery do this via an indirect call when all pgd are freed in
>> the one place anyway.
>>     
>
> Great. We finally get rid of this evil ..... 
>
> On second throughts:
>
> Are you sure that you understand what you are modifying? The ctor is not 
> called when you allocate an object but when the slab allocates it. Freeing 
> an object does not make the slab free it. It will hold it for the next
> kmalloc. So you may just have reduced performance somewhat by addiung 
> additional ctor processing and possibly disturbed the preservation of 
> cache hot pgds.
It's true I wrote this patch as a result of accidentally reading slob.c
rather than slab.c, which was mostly as a result of hopeful thinking (I
knew that there has been discussion about removing all the slab cache
stuff, and I assumed that it had already happened).  As a result I'm
withdrawing this patch for now, but with any luck it will be useful at
some point.

    J
