From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [patch 8/9] lguest: the block driver
Date: Wed, 9 May 2007 12:29:33 +0200
Message-ID: <20070509102933.GR4163@kernel.dk>
References: <200705090951.l499pdsc020409@shell0.pdx.osdl.net> <84144f020705090322jc37884drc31b97879648d09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758028AbXEIKcl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <84144f020705090322jc37884drc31b97879648d09@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, rusty@rustcorp.com.au, ak@suse.de, Rene Herman <rene.herman@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 09 2007, Pekka Enberg wrote:
> On 5/9/07, akpm@linux-foundation.org <akpm@linux-foundation.org> wrote:
> >+/* Jens gave me this nice helper to end all chunks of a request. */
> >+static void end_entire_request(struct request *req, int uptodate)
> >+{
> >+       if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
> >+               BUG();
> >+       add_disk_randomness(req->rq_disk);
> >+       blkdev_dequeue_request(req);
> >+       end_that_request_last(req, uptodate);
> >+}
> 
> Again, I would prefer this went straight into block/ll_rw_blk.c. Rene
> and I am using something similar in the new Mitsumi driver although
> one of us has a bug already, we're using req->nr_sectors for this...

Lets do it after it is merged, as not to create a hold-up point for
lguest. Once it's in, I'll fix it up.

-- 
Jens Axboe
