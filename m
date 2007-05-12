From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 19/28]xen: Add early printk support via hvc
	console
Date: Sat, 12 May 2007 12:57:36 -0700
Message-ID: <46461C30.8050108@goop.org>
References: <20070511000643.025196000@goop.org>	<20070511001204.948444000@goop.org>
	<20070512190813.GA17757@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070512190813.GA17757@wavehammer.waldi.eu.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Bastian Blank <bastian@waldi.eu.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Bastian Blank wrote:
> On Thu, May 10, 2007 at 05:07:02PM -0700, Jeremy Fitzhardinge wrote:
>   
>> +#ifdef CONFIG_XEN
>>     
>
> xenboot_console is only available with CONFIG_HVC_XEN.
>   

Good point.  I added CONFIG_HVC_XEN, but forgot to update this.

    J
