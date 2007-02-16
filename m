From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 11/21] Xen-paravirt: Add
 apply_to_page_range() which applies a function to a pte range.
Date: Thu, 15 Feb 2007 23:23:35 -0800
Message-ID: <45D55BF7.30704@goop.org>
References: <20070216022449.739760547@goop.org>	<20070216022531.344125142@goop.org>	<20070215223727.6819f962.akpm@linux-foundation.org>	<45D55805.908@goop.org>
	<20070215231936.073fadd3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070215231936.073fadd3.akpm@linux-foundation.org>
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
> I guess your pte-at-a-time walker could be quite simply implemented underneath
> the smaps pmd-at-a-time walker.
>   

Yes, converting should be pretty simple.  There aren't many users in
Xen, but they are moderately performance critical (fork, exec and exit),
so using batching would be good.

    J
