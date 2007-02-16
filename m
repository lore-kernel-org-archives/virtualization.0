From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options
 and disable unsupported config options.
Date: Fri, 16 Feb 2007 00:05:43 -0800
Message-ID: <45D565D7.5070303@goop.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.570154735@goop.org>
	<45D54BD5.8010707@vmware.com> <45D55784.1020000@goop.org>
	<45D562CC.8000405@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D562CC.8000405@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Dan Hecht <dhecht@vmware.com>
Cc: xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Dan Hecht wrote:
> On 02/15/2007 11:04 PM, Jeremy Fitzhardinge wrote:
>> HZ - I'm assuming dynticks will appear in the short term, and this will
>> become moot
>
> Doesn't Xen send any non-blocked domain a 100hz alarm implicitly,
> without anyway for the guest to disable it?  I guess you'll have to
> break kernel/hypervisor compatibility if you want dynticks? 

The timer VIRQ will generate events at a fixed 100Hz (which can be
masked, like any other event), but you can also ask for a timer event at
a particular time.  We do this already for tickless idle.

    J
