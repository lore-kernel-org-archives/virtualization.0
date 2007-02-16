From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 11/21] Xen-paravirt: Add
 apply_to_page_range() which applies a function to a pte range.
Date: Thu, 15 Feb 2007 23:06:45 -0800
Message-ID: <45D55805.908@goop.org>
References: <20070216022449.739760547@goop.org>	<20070216022531.344125142@goop.org>
	<20070215223727.6819f962.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070215223727.6819f962.akpm@linux-foundation.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Christoph Lameter <clameter@sgi.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Thu, 15 Feb 2007 18:25:00 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> Add a new mm function apply_to_page_range()[...]
> There was some discussion about this sort of thing last week.  The
> consensus was that it's better to run the callback against a whole pmd's
> worth of ptes, mainly to amortise the callback's cost (a lot).
>
> It was implemented in
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20/2.6.20-mm1/broken-out/smaps-extract-pmd-walker-from-smaps-code.patch

Yes I was looking at that and wondering what the upshot would be.  I'll
have a closer look, but it seems like it should be usable.

    J
