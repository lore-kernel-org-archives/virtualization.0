From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 11/25] xen: Xen SMP guest support
Date: Fri, 27 Apr 2007 11:10:34 +0200
Message-ID: <200704271110.34373.ak@suse.de>
References: <20070423215638.563901986@goop.org> <200704251124.48445.ak@suse.de> <46319C3B.2010300@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755548AbXD0KAw@vger.kernel.org>
In-Reply-To: <46319C3B.2010300@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Benjamin LaHaise <bcrl@kvack.org>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 27 April 2007 08:46:19 Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >> +/* VCPUs are single-cored, and have no siblings */
> >> +static void set_cpu_sibling_map(int cpu)
> >>     
> >
> > Can you put this somewhere generic and use it everywhere? Don't want
> > duplication of this code.
> >   
> 
> Are there any other users?  This is a very cutdown version of the code
> in kernel/smpboot.c; under Xen all CPUs are considered to be
> single-cored and single-threaded, so there's not a lot to do here.

I would like to have a single place to set that up, with xen calling
it with single arguments and the normal code with complex ones

-Andi
