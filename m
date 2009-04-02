From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Thu, 2 Apr 2009 23:04:51 +0200
Message-ID: <20090402210451.GA4076@elte.hu>
References: <200904011155.20751.a.miskiewicz@gmail.com>
	<200904020023.58363.rjw@sisk.pl>
	<20090401230637.GW18394@sequoia.sous-sol.org>
	<200904022300.01707.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <200904022300.01707.rjw@sisk.pl>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: xen-devel@lists.xensource.com, Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Yinghai Lu <yhlu.kernel@gmail.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Thursday 02 April 2009, Chris Wright wrote:
> > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > Sorry for the misunderstanding, I thought the breakage might be introduced
> > > between 15f7176eb1cccec0a332541285ee752b935c1c85 and
> > > 0a0c5168df270a50e3518e4f12bddb31f8f5f38f, so I thought it would be a good
> > > idea to verify if 0a0c5168df270a50e3518e4f12bddb31f8f5f38f fails too.
> > 
> > Ah, sure.  It fails too (both test_suspend=mem and regular suspend/resume).
> 
> Having looked at the commit the Arek's bisect turned up I don't 
> think it's likely to have caused this problem to appear.
> 
> It seems that the regression had been introduced before the PM and 
> PCI updates went it, so I bet it's one of the x86 changes.  Ingo, 
> are there any commits obviously worth testing?

i lost context - a list/range of commits to check would be nice.

	Ingo
