From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block
	device driver.
Date: Sun, 14 Jan 2007 13:24:12 +0200
Message-ID: <20070114112412.GA32719@rhun.haifa.ibm.com>
References: <20070113014539.408244126@goop.org>
	<20070113014649.256179743@goop.org>
	<Pine.LNX.4.61.0701141202050.26276@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701141202050.26276@yvahk01.tjqt.qr>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jan 14, 2007 at 12:05:13PM +0100, Jan Engelhardt wrote:

> >+	(void)xenbus_switch_state(info->xbdev, XenbusStateConnected);
> 
> Cast remove, if xenbus_switch_state does not have __must_check.
> Also elsewhere.

Hmm, why? this way you know that the programmer isn't checking the
return value *on purpose*. More information is good.

Cheers,
Muli
