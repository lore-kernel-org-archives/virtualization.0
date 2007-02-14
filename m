From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 10/21] Xen-paravirt: Name: dont export
	paravirt_ops structure, do individual functions
Date: Wed, 14 Feb 2007 16:51:20 +1100
Message-ID: <1171432280.19842.113.camel@localhost.localdomain>
References: <20070213221729.772002682@goop.org>
	<20070213221830.238235953@goop.org>  <45D260A2.4010200@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D260A2.4010200@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-02-13 at 17:06 -0800, Zachary Amsden wrote:
> Jeremy Fitzhardinge wrote:
> > Wrap the paravirt_ops members we want to export in wrapper functions.
> > Since we binary-patch the critical ones, this doesn't make a speed
> > impact.
> 
> This turned out really hideous looking to me.  Can't we split the struct 
> into GPL'd and non-GPL'd functions instead?  We still have the same 
> granularity, and none of this function call to an indirect function call 
> nonsense.

This patch, indeed, should not have been pushed in this series.  But not
for that reason: I actually prefer explicit exports.

KVM and lguest need more symbols, so the real patch will make them use
native_XXX versions explicitly...

Cheers,
Rusty.
