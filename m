From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 13/26] Xen-paravirt_ops: Consistently wrap
	paravirt ops callsites to make them patchable
Date: Fri, 16 Mar 2007 10:24:45 +0100
Message-ID: <20070316092445.GM23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232527.956565107@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232527.956565107@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Wrap a set of interesting paravirt_ops calls in a wrapper which makes 
> the callsites available for patching.  Unfortunately this is pretty 
> ugly because there's no way to get gcc to generate a function call, 
> but also wrap just the callsite itself with the necessary labels.
> 
> This patch supports functions with 0-4 arguments, and either void or 
> returning a value.  64-bit arguments must be split into a pair of 
> 32-bit arguments (lower word first).  Small structures are returned in 
> registers.

ugh. This is beyond ugly! Why dont we just compile two images, one for 
Xen and one for native, do two passes to get those two images and 
'merge' them into a single vmlinuz (so that we still have a 'single' 
kernel unit to deal with on the distro side). This way we avoid all this 
crazy, limited, fragile patchery business...

	Ingo
