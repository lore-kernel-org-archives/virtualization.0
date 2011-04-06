From: David Miller <davem@davemloft.net>
Subject: Re: Signed bit field; int have_hotplug_status_watch:1
Date: Wed, 06 Apr 2011 14:43:57 -0700 (PDT)
Message-ID: <20110406.144357.186323091.davem__23726.7777709805$1302126582$gmane$org@davemloft.net>
References: <20110403213241.GA25913@gallifrey>
	<1301905584.23887.49.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1301905584.23887.49.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian.Campbell@eu.citrix.com
Cc: Jeremy.Fitzhardinge@citrix.com, konrad.wilk@oracle.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

From: Ian Campbell <Ian.Campbell@eu.citrix.com>
Date: Mon, 4 Apr 2011 09:26:24 +0100

> Subject: [PATCH] xen: netback: use unsigned type for one-bit bitfield.
> 
> Fixes error from sparse:
>   CHECK   drivers/net/xen-netback/xenbus.c
> drivers/net/xen-netback/xenbus.c:29:40: error: dubious one-bit signed bitfield
> 
>         int have_hotplug_status_watch:1;
> 
> Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>

Applied to net-next-2.6, thanks.
