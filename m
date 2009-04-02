From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Thu, 2 Apr 2009 23:28:00 +0200
Message-ID: <200904022328.02088.rjw@sisk.pl>
References: <200904011155.20751.a.miskiewicz@gmail.com> <200904022300.01707.rjw@sisk.pl> <20090402210451.GA4076@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759093AbZDBV2V@vger.kernel.org>
In-Reply-To: <20090402210451.GA4076@elte.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@sous-sol.org>, Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 02 April 2009, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > On Thursday 02 April 2009, Chris Wright wrote:
> > > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > > Sorry for the misunderstanding, I thought the breakage might be introduced
> > > > between 15f7176eb1cccec0a332541285ee752b935c1c85 and
> > > > 0a0c5168df270a50e3518e4f12bddb31f8f5f38f, so I thought it would be a good
> > > > idea to verify if 0a0c5168df270a50e3518e4f12bddb31f8f5f38f fails too.
> > > 
> > > Ah, sure.  It fails too (both test_suspend=mem and regular suspend/resume).
> > 
> > Having looked at the commit the Arek's bisect turned up I don't 
> > think it's likely to have caused this problem to appear.
> > 
> > It seems that the regression had been introduced before the PM and 
> > PCI updates went it, so I bet it's one of the x86 changes.  Ingo, 
> > are there any commits obviously worth testing?
> 
> i lost context - a list/range of commits to check would be nice.

So far we know that d54b3538b0bfb31351d02d1669d4a978d2abfc5f is good
(according to Arek) and 0a0c5168df270a50e3518e4f12bddb31f8f5f38f (that doesn't
introduce functional changes) is already bad (according to Chris).

Thanks,
Rafael
