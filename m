From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest
 implementation for paravirt_ops interface
Date: Wed, 21 Feb 2007 12:02:58 -0800
Message-ID: <45DCA572.9090704@goop.org>
References: <20070216022449.739760547@goop.org>
	<Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
	<45D61C74.2000601@vmware.com>
	<Pine.LNX.4.64.0702161312460.28871@schroedinger.engr.sgi.com>
	<45D626BB.20007@vmware.com>
	<Pine.LNX.4.64.0702161356380.29218@schroedinger.engr.sgi.com>
	<20070217135112.GA15102@muc.de>
	<Pine.LNX.4.64.0702211036060.24941@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <Pine.LNX.4.64.0702211036060.24941@schroedinger.engr.sgi.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Christoph Lameter wrote:
> And it seems that the hooks are not generic but bound to a particular 
> hypervisor. Should the Xen specific stuff not be in the binary blob?

Xen has no "binary blob".  It needs guests to cooperate with it by
making hypercalls; all that code is in the Xen implementation of the
paravirt_ops interface, which is just ordinary code which lives in the
kernel sources.

    J
