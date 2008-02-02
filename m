From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Updated dom0 for pvops: now boots on 32-bit!
Date: Fri, 01 Feb 2008 16:02:37 -0800
Message-ID: <47A3B31D.9070009@goop.org>
References: <1201899762.11365.10.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1201899762.11365.10.camel@sisko.scot.redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Mark McLoughlin <markmc@redhat.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Juan Quintela <quintela@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Stephen C. Tweedie wrote:
> Hi folks,
>
> I've finished off Xen dma support for pv_ops, and dom0 now boots!  
>   

Excellent!  That's fantastic progress.

> I've had an uptime of 40 minutes so far with it.  Under intensive disk
> load it locks up with a soft lockup, but still, this is good progress.

There's a open report of domU lockups due to lost events, so it could be 
a generic event problem.

    J
