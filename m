From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: Updated dom0 for pvops: now boots on 32-bit!
Date: Tue, 05 Feb 2008 16:17:49 +0000
Message-ID: <1202228269.7172.8.camel@sisko.scot.redhat.com>
References: <1201899762.11365.10.camel@sisko.scot.redhat.com>
	<47A3B31D.9070009@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <47A3B31D.9070009@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Mark McLoughlin <markmc@redhat.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Juan Quintela <quintela@redhat.com>, Stephen Tweedie <sct@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On Fri, 2008-02-01 at 16:02 -0800, Jeremy Fitzhardinge wrote:

> > I've had an uptime of 40 minutes so far with it.  Under intensive disk
> > load it locks up with a soft lockup, but still, this is good progress.
> 
> There's a open report of domU lockups due to lost events, so it could be 
> a generic event problem.

That's quite possible --- there's no specific sign of anything dom0-
related in the lockup reports.

I'll see if I can reproduce in a domU environment.

--Stephen
