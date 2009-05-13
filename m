From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Wed, 13 May 2009 10:47:08 +0930
Message-ID: <200905131047.09416.rusty__24570.1439948336$1242177531$gmane$org@rustcorp.com.au>
References: <cover.1242080138.git.mst@redhat.com>
	<200905130000.03032.rusty@rustcorp.com.au>
	<20090512153330.GB26883@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090512153330.GB26883@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 13 May 2009 01:03:30 am Michael S. Tsirkin wrote:
> On Wed, May 13, 2009 at 12:00:02AM +0930, Rusty Russell wrote
> > and perhaps consider
> > varargs for the callbacks (or would that be too horrible at the
> > implementation end?)
> >
> > Thanks,
> > Rusty.
>
> Ugh ... I think it will be. And AFAIK gcc generates a lot of code
> for varargs - not something we want to do in each interrupt handler.

Err, no I mean for find_vqs:  eg.
	(block device)
	err = vdev->config->find_vqs(vdev, 1, &vblk->vq, blk_done);

	(net device)
	err = vdev->config->find_vqs(vdev, 3, vqs, skb_recv_done, skb_xmit_done, NULL);

A bit neater for for the single-queue case.

Cheers,
Rusty.
