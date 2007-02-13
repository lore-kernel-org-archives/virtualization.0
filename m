From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options
 and disable unsupported config options.
Date: Tue, 13 Feb 2007 15:29:29 -0800
Message-ID: <45D249D9.80407@goop.org>
References: <20070213221729.772002682@goop.org>
	<20070213221830.542511707@goop.org> <45D24172.9020800@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D24172.9020800@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Dan Hecht <dhecht@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Dan Hecht wrote:
> I assume you plan to eventually get all this stuff working but just
> want to prevent configurations that the Xen paravirt-ops isn't ready
> for at the moment?
>
> Instead can you do it this way:
>
> config XEN
>     depends on PARAVIRT && !PREEMPT && HZ_100 && !DOUBLEFAULT && !KEXEC

That's a bit simpler code-wise, but it does make it pretty complex to
get everything just-so to even see the CONFIG_XEN option.

    J
