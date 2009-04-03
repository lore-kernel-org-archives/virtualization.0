From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Fri, 3 Apr 2009 10:45:40 -0700
Message-ID: <20090403174540.GB27148@sequoia.sous-sol.org>
References: <200904011155.20751.a.miskiewicz@gmail.com> <200904030222.57469.a.miskiewicz@gmail.com> <20090403003523.GK18394@sequoia.sous-sol.org> <200904030847.19674.a.miskiewicz@gmail.com> <20090403173631.GA27148@sequoia.sous-sol.org> <20090403173955.GD6295@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935418AbZDCRrx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090403173955.GD6295@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@sous-sol.org>, Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Chris Wright <chrisw@sous-sol.org> wrote:
> 
> > * Arkadiusz Miskiewicz (a.miskiewicz@gmail.com) wrote:
> > > On Friday 03 of April 2009, Chris Wright wrote:
> > > > * Arkadiusz Miskiewicz (a.miskiewicz@gmail.com) wrote:
> > > > > What about 9ea09af3bd3090e8349ca2899ca2011bd94cda85 ?
> > > > >
> > > > > stop_machine: introduce stop_machine_create/destroy.
> > > >
> > > > That is later fixed in a0e280e0f33f6c859a235fb69a875ed8f3420388.
> > > >
> > > > Can you please verify if 2.6.29 works for you? 
> > > 
> > > I think that the guilty part is 
> > > CONFIG_CC_STACKPROTECTOR_ALL=y
> > > CONFIG_CC_STACKPROTECTOR=y
> > 
> > Indeed, I think you're right.  In fact...this should fix it:
> 
> Note that i had to do a manual merge of the patch (it had 3 separate 
> patch corruptions) - the non-damaged version i applied is the one 
> below.

Indeed, I just discovered that ;-)

And, for the record...yes, that fixes it on my laptop.

Tested-by: Chris Wright <chrisw@sous-sol.org>
