From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: [patch 14/21] Xen-paravirt: Add XEN config options
	and disableunsupported config options.
Date: Fri, 16 Feb 2007 11:24:56 -0800
Message-ID: <45D60508.10000@goop.org>
References: <C1FBAFD7.99AB%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C1FBAFD7.99AB%keir@xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <keir@xensource.com>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Steven Hand <steven.hand@cl.cam.ac.uk>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Ian Pratt <Ian.Pratt@xensource.com>, Christian Limpach <Christian.Limpach@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> We can extend the Xen timer interface quite easily and get rid of this one
> too. In fact it doesn't *much* matter if the CONFIG_HZ differs from the Xen
> ticker rate -- we modified the Linux timer ISR to handle timer interrupts at
> arbitrary times already. The only drawback is that jiffies updates in burts
> if CONFIG_HZ is higher than the actual tick rate, and this can affect some
> calibration constants and cause Linux to print out some weird values at
> start-of-day.
>   

I was wondering what would happen if we tried that.  I guess its
equivalent to having stolen time between each Xen tick.

    J
