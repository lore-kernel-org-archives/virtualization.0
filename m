From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [patch 8/9] lguest: the block driver
Date: Fri, 11 May 2007 14:09:55 +0200
Message-ID: <20070511120955.GZ4629@kernel.dk>
References: <200705090951.l499pdsc020409@shell0.pdx.osdl.net> <84144f020705090322jc37884drc31b97879648d09@mail.gmail.com> <46434378.1020900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760667AbXEKMKp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46434378.1020900@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, rusty@rustcorp.com.au, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 10 2007, Rene Herman wrote:
> On 05/09/2007 12:22 PM, Pekka Enberg wrote:
> 
> >>+static void end_entire_request(struct request *req, int uptodate)
> >>+{
> >>+       if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
> >>+               BUG();
> >>+       add_disk_randomness(req->rq_disk);
> >>+       blkdev_dequeue_request(req);
> >>+       end_that_request_last(req, uptodate);
> >>+}
> >
> >Again, I would prefer this went straight into block/ll_rw_blk.c. Rene
> >and I am using something similar in the new Mitsumi driver although
> >one of us has a bug already, we're using req->nr_sectors for this...
> 
> The req->hard_nr_sectors is specifically marked block layer internal and 
> since nr_sectors is what we're requesting and reading (we can't deal with 
> partial transfers anyway since the drive won't tell us where it failed as 
> far as I've been able to see and we do want to make read requests for as 
> many sectors as possible at a time for speed) I believe that in our case 
> the nr_sectors is fine.

Using ->nr_sectors is fine, IFF you don't modify ->nr_sectors in the
driver. The generic helper will use ->hard_nr_sectors.

-- 
Jens Axboe
