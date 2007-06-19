From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 3/3] Virtio draft III: example block driver
Date: Tue, 19 Jun 2007 16:27:46 +1000
Message-ID: <1182234466.19064.51.camel__22190.8680316576$1182234554$gmane$org@localhost.localdomain>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181999552.6237.255.camel@localhost.localdomain>
	<1181999669.6237.257.camel@localhost.localdomain>
	<1181999825.6237.260.camel@localhost.localdomain>
	<1181999920.6237.263.camel@localhost.localdomain>
	<46754451.2010305@qumranet.com>
	<1182154095.19064.24.camel@localhost.localdomain>
	<46764BB5.6070704@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46764BB5.6070704@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Jens Axboe <jens.axboe@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-06-18 at 12:09 +0300, Avi Kivity wrote:
> Rusty Russell wrote:
> > On Sun, 2007-06-17 at 17:25 +0300, Avi Kivity wrote:
> >   
> >> Rusty Russell wrote:
> >>     
> >>> +	/* Set up for reply. */
> >>> +	vblk->sg[0].page = virt_to_page(&vbr->in_hdr);
> >>> +	vblk->sg[0].offset = offset_in_page(&vbr->in_hdr);
> >>> +	vblk->sg[0].length = sizeof(vbr->in_hdr);
> >>> +	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
> >>> +	vbr->out_hdr.id = vblk->vdev->ops->add_inbuf(vblk->vdev, vblk->sg,
> >>> +						     1+num, vbr);
> >>> +	if (IS_ERR_VALUE(vbr->out_hdr.id))
> >>> +		goto full;
> >>> +
> >>> +	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
> >>> +	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
> >>> +	vblk->sg[0].length = sizeof(vbr->out_hdr);
> >>> +
> >>> +	vbr->out_id = vblk->vdev->ops->add_outbuf(vblk->vdev, vblk->sg, 1,
> >>> +						  vbr);
> >>>       
> >> This strikes me as wasteful.  Why not set up a single descriptor which 
> >> contains both placement and the data itself?
> >>     
> >
> > We could actually do this for write, but not for read (where the length
> > & sector need to be sent to other end, and the data comes from other
> > end).
> 
> So you map the first sg entry for output, and the rest for input.
> 
> Less pretty, but more efficient.

At the moment there are two kinds of sgs: input and output.  You're
proposing instead that we have a single kind, and a flag on each segment
which indicates direction.  That may make block a little efficient,
depending on particular implementation of virtio.

Yet network really wants in and out separate.  I'm not even sure how
we'd implement a mixed-sg scheme efficiently for that case.  At the
moment it's very straightforward.

Of course, I'm carrying two implementations and two drivers, so it's
natural for me to try to resist changes 8)

Cheers,
Rusty.
