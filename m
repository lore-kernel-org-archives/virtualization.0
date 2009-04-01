From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Wed, 1 Apr 2009 23:49:09 +0200
Message-ID: <200904012349.10919.rjw@sisk.pl>
References: <200904011155.20751.a.miskiewicz@gmail.com> <200904012329.21362.rjw@sisk.pl> <20090401213756.GU18394@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757084AbZDAVt0@vger.kernel.org>
In-Reply-To: <20090401213756.GU18394@sequoia.sous-sol.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 01 April 2009, Chris Wright wrote:
> * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > This may be caused by the recent PM changes.  Can you please test if commit
> > 8efb8c76fcdccf5050c0ea059dac392789baaff2 is fine?
> 
> I just tested on my t400, it's not[1].  See same symptoms as Arkadiusz.
> Seems as if it responds to initial apci event, I see some disk activity,
> then nothing (as if it tried to wakeup, then went back to sleep).
> 
> [1] 15f7176eb1cccec0a332541285ee752b935c1c85 bad
>     fae3e7fba4c664b3a15f2cf15ac439e8d754afc2 good(ish) (display stays blank)

Hmm, can you also test commit 0a0c5168df270a50e3518e4f12bddb31f8f5f38f, please?

Rafael
