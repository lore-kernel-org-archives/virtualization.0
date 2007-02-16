From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Thu, 15 Feb 2007 23:08:02 -0800
Message-ID: <45D55852.9000103@goop.org>
References: <20070216022449.739760547@goop.org>	<20070216022531.417300365@goop.org>
	<20070215224322.5c73d8e9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070215224322.5c73d8e9.akpm@linux-foundation.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> This won't work when CONFIG_PREEMPT=y.  The pagefault handler will see
> in_atomic() and will scram.
>   

Is there some other way to get the pagetable populated for the address
range?

    J
