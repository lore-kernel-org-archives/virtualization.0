From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Wed, 1 Apr 2009 15:14:33 -0700
Message-ID: <20090401221433.GV18394@sequoia.sous-sol.org>
References: <200904011155.20751.a.miskiewicz@gmail.com> <200904012329.21362.rjw@sisk.pl> <20090401213756.GU18394@sequoia.sous-sol.org> <200904012349.10919.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765160AbZDAWQU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200904012349.10919.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chris Wright <chrisw@sous-sol.org>, Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

* Rafael J. Wysocki (rjw@sisk.pl) wrote:
> On Wednesday 01 April 2009, Chris Wright wrote:
> > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > This may be caused by the recent PM changes.  Can you please test if commit
> > > 8efb8c76fcdccf5050c0ea059dac392789baaff2 is fine?
> > 
> > I just tested on my t400, it's not[1].  See same symptoms as Arkadiusz.
> > Seems as if it responds to initial apci event, I see some disk activity,
> > then nothing (as if it tried to wakeup, then went back to sleep).
> > 
> > [1] 15f7176eb1cccec0a332541285ee752b935c1c85 bad
> >     fae3e7fba4c664b3a15f2cf15ac439e8d754afc2 good(ish) (display stays blank)
> 
> Hmm, can you also test commit 0a0c5168df270a50e3518e4f12bddb31f8f5f38f, please?

Well, that's already included in 15f7176eb1cccec0a332541285ee752b935c1c85
