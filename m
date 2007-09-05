From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fix preemptible lazy mode bug
Date: Thu, 06 Sep 2007 03:48:59 +1000
Message-ID: <1189014539.10802.177.camel@localhost.localdomain>
References: <46CE70C8.2030005@vmware.com> <46CE8069.9070404@goop.org>
	 <46CE81DC.90103@vmware.com>  <46D9D517.6010201@goop.org>
	 <1188850468.10802.66.camel@localhost.localdomain>
	 <46DD60A9.8080203@goop.org>
	 <1189010022.10802.161.camel@localhost.localdomain>
	 <1189011909.21516.1.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758393AbXIERuA@vger.kernel.org>
In-Reply-To: <1189011909.21516.1.camel@bodhitayantram.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Andi Kleen <ak@suse.de>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-09-05 at 10:05 -0700, Zachary Amsden wrote:
> On Thu, 2007-09-06 at 02:33 +1000, Rusty Russell wrote:

> > +	BUG_ON(get_lazy_mode() && !(mode == PARAVIRT_LAZY_NONE |
> > +				    | mode == PARAVIRT_LAZY_FLUSH));
> 
> That's a pretty strange line break.

Sorry, should have mentioned it's completely untested: too far from my
test machine 8(

Thanks,
Rusty.
