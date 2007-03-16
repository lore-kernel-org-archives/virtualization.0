From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 16/26] Xen-paravirt_ops: Allocate and free
	vmalloc areas
Date: Fri, 16 Mar 2007 10:05:50 -0700
Message-ID: <45FACE6E.3000901@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232528.297902504@goop.org>
	<20070316091648.GI23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316091648.GI23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
>> +struct vm_struct *alloc_vm_area(unsigned long size)
>>     
>
> this should go into mm/vmalloc.c.

The trouble is that it calls the arch-dependent vmalloc_sync_all(),
which is important for Xen's use of this function.  And without that
it's just a pointless wrapper around get_vm_area.

    J
