From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: PATCH 7/8] lguest: the block driver
Date: Tue, 10 Apr 2007 14:36:05 +0300
Message-ID: <84144f020704100436y3405f104x8345c72556d961e9__463.726852513169$1176222623$gmane$org@mail.gmail.com>
References: <1176203068.26372.21.camel@localhost.localdomain>
	<1176203130.26372.23.camel@localhost.localdomain>
	<1176203176.26372.25.camel@localhost.localdomain>
	<1176203231.26372.27.camel@localhost.localdomain>
	<1176203285.26372.29.camel@localhost.localdomain>
	<1176203333.26372.31.camel@localhost.localdomain>
	<1176203475.26372.37.camel@localhost.localdomain>
	<1176203528.26372.40.camel@localhost.localdomain>
	<84144f020704100428r6e35e34cued8758c94728a6a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <84144f020704100428r6e35e34cued8758c94728a6a0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, jens.axboe@oracle.com, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 4/10/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > +/* Jens gave me this nice helper to end all chunks of a request. */
> > +static void end_entire_request(struct request *req, int uptodate)
> > +{
> > +       if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
> > +               BUG();
> > +       add_disk_randomness(req->rq_disk);
> > +       blkdev_dequeue_request(req);
> > +       end_that_request_last(req, uptodate);
> > +}

On 4/10/07, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Perhaps we should move this to generic code (i.e. block/ll_rw_blk.c)?

Uhm, I am bit confused now. Why don't you just use end_request() here?
