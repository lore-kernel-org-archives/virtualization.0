From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Thu, 2 Apr 2009 23:00:00 +0200
Message-ID: <200904022300.01707.rjw@sisk.pl>
References: <200904011155.20751.a.miskiewicz@gmail.com> <200904020023.58363.rjw@sisk.pl> <20090401230637.GW18394@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761719AbZDBVAs@vger.kernel.org>
In-Reply-To: <20090401230637.GW18394@sequoia.sous-sol.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>
Cc: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 02 April 2009, Chris Wright wrote:
> * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > Sorry for the misunderstanding, I thought the breakage might be introduced
> > between 15f7176eb1cccec0a332541285ee752b935c1c85 and
> > 0a0c5168df270a50e3518e4f12bddb31f8f5f38f, so I thought it would be a good
> > idea to verify if 0a0c5168df270a50e3518e4f12bddb31f8f5f38f fails too.
> 
> Ah, sure.  It fails too (both test_suspend=mem and regular suspend/resume).

Having looked at the commit the Arek's bisect turned up I don't think it's
likely to have caused this problem to appear.

It seems that the regression had been introduced before the PM and PCI updates
went it, so I bet it's one of the x86 changes.  Ingo, are there any commits
obviously worth testing?

Rafael
