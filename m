From: Andi Kleen <ak@muc.de>
Subject: Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: 16 Feb 2007 10:18:43 +0100
Message-ID: <20070216091843.GB28196@muc.de>
References: <20070216022449.739760547@goop.org>
	<20070216022531.417300365@goop.org>
	<20070215224322.5c73d8e9.akpm@linux-foundation.org>
	<45D55852.9000103@goop.org>
	<20070215232447.5ee67f50.akpm@linux-foundation.org>
	<45D55DB1.7040002@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Date: Fri, 16 Feb 2007 10:18:43 +0100
Content-Disposition: inline
In-Reply-To: <45D55DB1.7040002@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

> It's for populating the pagetable in a vmalloc area.  There's magic in

If the lazy setup doesn't work for you you can always call vmalloc_sync()
early.

-Andi
