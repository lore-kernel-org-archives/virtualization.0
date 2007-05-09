From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [patch 8/9] lguest: the block driver
Date: Wed, 9 May 2007 13:22:43 +0300
Message-ID: <84144f020705090322jc37884drc31b97879648d09@mail.gmail.com>
References: <200705090951.l499pdsc020409@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757330AbXEIKXE@vger.kernel.org>
In-Reply-To: <200705090951.l499pdsc020409@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, rusty@rustcorp.com.au, ak@suse.de, jens.axboe@oracle.com, Rene Herman <rene.herman@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 5/9/07, akpm@linux-foundation.org <akpm@linux-foundation.org> wrote:
> +/* Jens gave me this nice helper to end all chunks of a request. */
> +static void end_entire_request(struct request *req, int uptodate)
> +{
> +       if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
> +               BUG();
> +       add_disk_randomness(req->rq_disk);
> +       blkdev_dequeue_request(req);
> +       end_that_request_last(req, uptodate);
> +}

Again, I would prefer this went straight into block/ll_rw_blk.c. Rene
and I am using something similar in the new Mitsumi driver although
one of us has a bug already, we're using req->nr_sectors for this...
