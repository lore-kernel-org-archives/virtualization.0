From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Sun, 10 May 2009 13:37:06 +0930
Message-ID: <200905101337.06836.rusty__42077.7297382758$1241928528$gmane$org@rustcorp.com.au>
References: <cover.1241700929.git.mst@redhat.com>
	<200905081637.09729.rusty@rustcorp.com.au>
	<20090508124821.GA3073@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090508124821.GA3073@redhat.com>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 8 May 2009 10:18:22 pm Michael S. Tsirkin wrote:
> On Fri, May 08, 2009 at 04:37:06PM +0930, Rusty Russell wrote:
> > On Thu, 7 May 2009 11:40:39 pm Michael S. Tsirkin wrote:
> > > This replaces find_vq/del_vq with find_vqs/del_vqs virtio operations,
> > > and updates all drivers. This is needed for MSI support, because MSI
> > > needs to know the total number of vectors upfront.
> >
> > Hmm, I have a similar need for a dev to vq mapping (debugging stats). 
> > How's this as a common basis?
>
> This helps. Should I redo mine on top of this?

Yep, it should make your smaller as well.

> >  void vring_del_virtqueue(struct virtqueue *vq)
> >  {
> > +	list_del(&vq->list);
> >  	kfree(to_vvq(vq));
> >  }
> >  EXPORT_SYMBOL_GPL(vring_del_virtqueue);
>
> I note lack of locking here. This is okay in practice as
> drivers don't really call find/del vq in parallel,
> but making this explicit with find_vqs will be best, yes?

Yes, and in fact a rough look at your patch reveals that we don't actually 
need del_vq: now we track them, we can just do that as part of vdev 
destruction, right?

If you agree, please do that patch first, then do the find_vqs change on top of 
that.

Thanks!
Rusty.
