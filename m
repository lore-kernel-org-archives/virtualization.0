From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 06/25] xen: Core Xen implementation
Date: Wed, 25 Apr 2007 22:17:06 +0200
Message-ID: <200704252217.06381.ak@suse.de>
References: <20070423215638.563901986@goop.org> <200704252143.48363.ak@suse.de> <462FB42F.5070503@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2993074AbXDYURM@vger.kernel.org>
In-Reply-To: <462FB42F.5070503@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ian Pratt <ian.pratt@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


> > To summarize the outstanding issues are:
> > - fixing sched_clock first
> >   
> 
> What was the sched_clock problem?  I don't remember and outstanding
> issues with it.  I noticed you didn't take paravirt-sched_clock.

The major problem was that it didn't compile on x86-64.
And a few uglities in there so I was not too unhappy to drop.

-Andi
