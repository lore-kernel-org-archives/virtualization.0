From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio: fix double free_irq
Date: Thu, 23 Jul 2009 13:20:52 +0300
Message-ID: <20090723102052.GC10860__31789.9218913682$1248344723$gmane$org@redhat.com>
References: <cover.1248181714.git.mst@redhat.com>
	<20090721155925.GC3306@redhat.com>
	<200907231410.32287.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200907231410.32287.rusty@rustcorp.com.au>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 23, 2009 at 02:10:31PM +0930, Rusty Russell wrote:
> On Wed, 22 Jul 2009 01:29:25 am Michael S. Tsirkin wrote:
> > -	if (info->vector != VIRTIO_MSI_NO_VECTOR)
> > +	if (info->vector != VIRTIO_MSI_NO_VECTOR) {
> >  		free_irq(vp_dev->msix_entries[info->vector].vector, vq);
> > +		--vp_dev->msix_used_vectors;
> > +	}
> >
> 
> This only works because the only current caller of vp_del_vq is vp_del_vqs, so 
> msix_used_vectors will be 0 after all the queues have been freed.
> 
> Make up your mind.  Either find_vq allocates and del_vq frees, or it's find_vqs 
> and del_vqs.  I suggest the former, and setting the value VIRTIO_MSI_NO_VECTOR  
> to indicate it's already freed.

Hmm, there's nowhere to set this value: del_vq does kfree on info.
But I think I see a solution. Cleaned up patch RSN.

> I think with some cleanups, that loop in vp_free_vectors might go away, too.

Hmm, I don't see how, yet.
It's there to free the common vectors: config and shared vq vector.

> Rusty.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
