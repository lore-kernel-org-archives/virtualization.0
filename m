From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 7/8] lguest: trivial guest block driver
Date: Tue, 13 Feb 2007 01:44:08 +0100
Message-ID: <20070213004408.GB3641@kernel.dk>
References: <1171252219.10409.33.camel@localhost.localdomain> <1171252321.10409.36.camel@localhost.localdomain> <1171252405.10409.39.camel@localhost.localdomain> <1171252474.10409.42.camel@localhost.localdomain> <20070212044339.GJ3685@kernel.dk> <1171258034.10409.54.camel@localhost.localdomain> <20070212053204.GB3999@kernel.dk> <1171264167.10409.62.camel@localhost.localdomain> <20070212150125.GM3999@kernel.dk> <1171326305.19842.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030601AbXBMAnt@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1171326305.19842.36.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 13 2007, Rusty Russell wrote:
> On Mon, 2007-02-12 at 16:01 +0100, Jens Axboe wrote:
> > On Mon, Feb 12 2007, Rusty Russell wrote:
> > > Thanks Jens!!
> > 
> > My pleasure, it's not often you get to make that big a performance
> > improvement with just a little few lines of change :-)
> 
> *cough* I deliberately leave these low hanging fruit in lguest to
> encourage people to hack on it.  Really.  *cough*

:-)

> > I guess you'll take changes to make this driver queuing as well? It's
> > pretty important for good guest io performance as well.
> 
> The question is whether the guest or host should queue.  If you have
> multiple guests sharing a disk in the hose, I would think that the host
> is better off queuing.  And this would seem to be the common case.

You want queuing in the host, since for queuing to make a performance
difference it needs to be propagated all the way down to the device. But
you can't get queuing at the host level if the guest device doesn't
allow it, you'd be serializing anyway. Well for writes you can, but not
synchronous requests.

Basically allow as much to be sent to the host as possible.

> On my todo list is:
> 1) Implement write barriers, (-> fsync in the host)
> 2) Make the host userspace program (lguest) async rather than blocking,
> 3) Allow multiple outstanding requests.
> 
> Then it should be useful for other hypervisors.

I completely agree with your prioritized list.

-- 
Jens Axboe
