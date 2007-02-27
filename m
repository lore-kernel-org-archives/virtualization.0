From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 06/26] Xen-paravirt_ops: paravirt_ops:
 allocate a fixmap slot
Date: Tue, 27 Feb 2007 10:55:17 -0800
Message-ID: <45E47E95.2060803@goop.org>
References: <20070227081337.434798469@goop.org>
	<20070227081631.122933982@goop.org>
	<20070227101143.GC10827@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070227101143.GC10827@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> Allocate a fixmap slot for use by a paravirt_ops implementation.  Xen 
>> uses this to map the hypervisor's shared info page, which doesn't have 
>> a pseudo-physical page number, and therefore can't be mapped 
>> ordinarily.
>>     
>
> why not vmalloc it on the guest side? fixmaps are bad for this purpose 
> for a general paravirt implementation, it limits the size of the shared 
> info page, etc.

Yes.  vmalloc would have the annoying side-effect of actually allocating
some pages which would be shadowed by the remapping, but I guess
get_vm_area would do the job.  I'll give it a go.

    J
