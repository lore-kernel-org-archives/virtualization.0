From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH RFC 3/3] Virtio draft III: example block driver
Date: Sun, 17 Jun 2007 17:25:21 +0300
Message-ID: <46754451.2010305__30905.1004973755$1182090385$gmane$org@qumranet.com>
References: <1181217762.14054.192.camel@localhost.localdomain>	<1181999552.6237.255.camel@localhost.localdomain>	<1181999669.6237.257.camel@localhost.localdomain>	<1181999825.6237.260.camel@localhost.localdomain>
	<1181999920.6237.263.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181999920.6237.263.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Jens Axboe <jens.axboe@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> +static bool do_read(request_queue_t *q, struct virtio_blk *vblk,
> +		    struct virtblk_req *vbr)
> +{
> +	unsigned long num;
> +
> +	vbr->out_hdr.type |= VIRTIO_BLK_T_READ;
> +
> +	/* Set up for reply. */
> +	vblk->sg[0].page = virt_to_page(&vbr->in_hdr);
> +	vblk->sg[0].offset = offset_in_page(&vbr->in_hdr);
> +	vblk->sg[0].length = sizeof(vbr->in_hdr);
> +	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
> +	vbr->out_hdr.id = vblk->vdev->ops->add_inbuf(vblk->vdev, vblk->sg,
> +						     1+num, vbr);
> +	if (IS_ERR_VALUE(vbr->out_hdr.id))
> +		goto full;
> +
> +	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
> +	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
> +	vblk->sg[0].length = sizeof(vbr->out_hdr);
> +
> +	vbr->out_id = vblk->vdev->ops->add_outbuf(vblk->vdev, vblk->sg, 1,
> +						  vbr);
>   

This strikes me as wasteful.  Why not set up a single descriptor which 
contains both placement and the data itself?

-- 
error compiling committee.c: too many arguments to function
