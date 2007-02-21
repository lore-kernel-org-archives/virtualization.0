From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 05/24] Xen-paravirt_ops: Add pagetable
 accessors to pack and unpack pagetable entries
Date: Wed, 21 Feb 2007 14:20:56 -0800
Message-ID: <45DCC5C8.4090905@goop.org>
References: <20070221205254.169835700@goop.org>
	<20070221205322.869165491@goop.org> <200702212315.12883.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <200702212315.12883.ak@suse.de>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> Do you have some lmbench numbers before/after this change? 
> iirc at least fork and exit do a lot of pte accesses in various forms.
> If it's measurable it might be needed to patch those for the native case.
>   

I don't.  I think Rusty ran some numbers and found the pte accessors
became the most commonly used paravirt ops.

I'm working on revamping the pv_ops patching infrastructure at the
moment, so we should be able to deal with these fairly efficiently.

    J
