From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 1/2] virtio: fix double free_irq on device removal
Date: Fri, 24 Jul 2009 21:54:26 +0930
Message-ID: <200907242154.26665.rusty__35136.281423229$1248438462$gmane$org@rustcorp.com.au>
References: <cover.1248350116.git.mst@redhat.com>
	<20090723115731.GB12293@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090723115731.GB12293@redhat.com>
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

On Thu, 23 Jul 2009 09:27:31 pm Michael S. Tsirkin wrote:
> msix_user_vectors counted both per-vq and shared/config vectors.
> This causes BUG_ON when device is removed, as
> free_vectors tries to free per-vq vectors.

OK, I looked at this patch, then looked at this code (after it was applied).

I'm still very confused.

Looking at the call site for vp_find_vq:

	for (i = 0; i < nvqs; ++i) {
		if (!callbacks[i])
			vector = per_vq_vector = VIRTIO_MSI_NO_VECTOR;
		else if (vp_dev->msix_used_vectors < vp_dev->msix_vectors)
			per_vq_vector = vector = allocated_vectors++;
		else {
			vector = VP_MSIX_VQ_VECTOR;
			per_vq_vector = VIRTIO_MSI_NO_VECTOR;
		}

Now, I can't find where msix_used_vectors is set, only once where it's
incremented.  It seems completely redundant and confusing now?  And
this "< vp_dev->msix_vectors" test is wrong?

AFAICT there are three cases:
1) We don't have MSI, so we use a normal interrupt for all vqs (old style).
    This request_irq is done in  vp_request_vectors.
2) We get some, but not enough for one per queue.  We then use 2: one for
   changes, and one for all vqs.  Requested in vp_request_vectors.
3) We get enough.  Use one for changes, one per vq.  Each vq
   requests in vp_find_vq.

I suggest you be explicit, and don't do any request in vp_find_vq().  Do the
per-vq request (case 3) in the find_vqs() loop, so vp_find_vq doesn't need
to know anything except to do the iowrite16 if vector != VIRTIO_MSI_NO_VECTOR.

Maybe an explicit "bool per_vq_vectors" would make it clearer, too.

Note: this is partially my fault for not reviewing this code when it went in.
I know Anthony is disclaiming virtio_pci :)

Thanks,
Rusty.
