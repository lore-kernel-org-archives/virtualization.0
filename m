From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 7/8] lguest: trivial guest block driver
Date: Mon, 12 Feb 2007 16:01:25 +0100
Message-ID: <20070212150125.GM3999@kernel.dk>
References: <1171251965.10409.28.camel@localhost.localdomain> <1171252113.10409.30.camel@localhost.localdomain> <1171252219.10409.33.camel@localhost.localdomain> <1171252321.10409.36.camel@localhost.localdomain> <1171252405.10409.39.camel@localhost.localdomain> <1171252474.10409.42.camel@localhost.localdomain> <20070212044339.GJ3685@kernel.dk> <1171258034.10409.54.camel@localhost.localdomain> <20070212053204.GB3999@kernel.dk> <1171264167.10409.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964954AbXBLPBW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1171264167.10409.62.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 12 2007, Rusty Russell wrote:
> On Mon, 2007-02-12 at 06:32 +0100, Jens Axboe wrote:
> > On Mon, Feb 12 2007, Rusty Russell wrote:
> > > On Mon, 2007-02-12 at 05:43 +0100, Jens Axboe wrote:
> > > > Here you map the entire request (lets call that segment A..Z), but
> > > > end_request() only completes the first chunk of the request. So
> > > > elv_next_request() will retrieve the same request again, and you'll then
> > > > map B..Z and repeat that transfer. So unless I'm missing some other part
> > > > here (just read it over quickly), you are re-doing large parts of a
> > > > merged request several times.
> 
> virtbench before:
> 	Time to read from disk (256 kB): 18654562 nsec
> After:
> 	Time to read from disk (256 kB): 8018468 nsec
> 
> Thanks Jens!!

My pleasure, it's not often you get to make that big a performance
improvement with just a little few lines of change :-)

I guess you'll take changes to make this driver queuing as well? It's
pretty important for good guest io performance as well.

-- 
Jens Axboe
