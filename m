From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 09/25] xen: Account for time stolen by Xen
Date: Wed, 25 Apr 2007 20:15:06 +0200
Message-ID: <200704252015.06269.ak@suse.de>
References: <20070423215638.563901986@goop.org> <200704251115.49966.ak@suse.de> <462F9A4E.5050905@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423361AbXDYSP3@vger.kernel.org>
In-Reply-To: <462F9A4E.5050905@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 25 April 2007 20:13:34 Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >> +
> >> +	do {
> >> +		state_time = state->state_entry_time;
> >> +		barrier();
> >>     
> >
> > Should be likely rmb
> 
> We discussed this, and decided that it wasn't necessary.  The state is
> always updated by the current CPU, so if it changes under our feet it
> will be because we were preempted, and so that should shoot down any
> speculated reads.

Then the barrier shouldn't be needed at all? 

Anyways needs comments

-Andi
