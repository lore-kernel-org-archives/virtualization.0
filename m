From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: [patch 14/21] Xen-paravirt: Add XEN config options
	and disableunsupported config options.
Date: Fri, 16 Feb 2007 09:46:03 -0800
Message-ID: <45D5EDDB.7050404@goop.org>
References: <C1FB3FEA.98F7%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C1FB3FEA.98F7%keir@xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <keir@xensource.com>
Cc: xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, Ian Pratt <Ian.Pratt@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Steven Hand <steven.hand@cl.cam.ac.uk>, Christian Limpach <Christian.Limpach@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> This initial patchset does not include save/restore support anyway, so in
> fact it would be consistent to have CONFIG_PREEMPT configurable. I'm sure
> that we are going to have some nasty bugs to fix up as a result, but we
> can't fix them until we find them! Then we can convert our save/restore code
> to use the freezer before submitting it for inclusion.
OK.  So that makes the only config restriction the 100Hz ticks.

    J
