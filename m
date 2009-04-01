From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Wed, 1 Apr 2009 23:29:19 +0200
Message-ID: <200904012329.21362.rjw@sisk.pl>
References: <200904011155.20751.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934525AbZDAV3c@vger.kernel.org>
In-Reply-To: <200904011155.20751.a.miskiewicz@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@xensource.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 01 April 2009, Arkadiusz Miskiewicz wrote:
> 
> Hi,
> 
> After some recent merge to Linus tree resume from ram on my thinkpad t400 
> stopped working. My latest test was done on today Linus git master tree.
> 
> I'm closing lid, it suspends according to "moon" led. When I open lid I see 
> that LCD backlight is on (not sure if it turns on when I open lid or maybe it 
> never turns off), black screen with cursor blinking in upper corner but... 
> "moon" led is on all the time. 
> 
> Now two things happen after, 1) lcd goes off, moon led still on; it looks like 
> it"suspend" done again or 2) lcd stays on, moon led still on, no further 
> changes.
> 
> I cannot wake up from this "second like-suspend" thing, I have to power off 
> notebook and power on.
> 
> I started bisecting with such data:
> 2d25ee36c84d5b2d6be8bfaf80256ecad69a06ca - bad
> d54b3538b0bfb31351d02d1669d4a978d2abfc5f - good
> 
> ended with bisect log/bad commit below. (I'm not sure if can fully trust the 
> this bisect anyway).
> 
> Note that the hang happens when t400 in integrated mode (intel) and also in 
> discrete mode (ati), so looks GPU unrelated.
> 
> Any ideas what's going on?

This may be caused by the recent PM changes.  Can you please test if commit
8efb8c76fcdccf5050c0ea059dac392789baaff2 is fine?

Rafael
