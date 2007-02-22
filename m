From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 18/24] Xen-paravirt_ops: Some generic early
 printk & boot console fixups
Date: Wed, 21 Feb 2007 21:48:14 -0800
Message-ID: <45DD2E9E.5030601@goop.org>
References: <20070221205254.169835700@goop.org>	<20070221205323.842917348@goop.org>
	<20070221191047.8d21acaa.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070221191047.8d21acaa.akpm@linux-foundation.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> hm, this patch series seems to have gone out of its way to cause problems.
>
> This particular (pathetically changelogged) patch is already in my tree,
> only in a later, much more comprehensive form.  Similarly the HVC changes
> were already in Rusty's stuff and were supposed to be merged by Paulus, but
> haven't been yet.
>
> Can we just drop this one?  Does the Xen work actually depend on it?

Well, some form of the hvc patches is needed to get a console.  I'll
rationalize them with respect to Gerd and Rusty's latest patches, but I
did want to make the series stand on its own rather than have external
dependencies on unmerged patches.

    J
