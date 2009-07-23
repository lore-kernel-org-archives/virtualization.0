From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] virtio: fix double free_irq
Date: Thu, 23 Jul 2009 14:10:31 +0930
Message-ID: <200907231410.32287.rusty__28701.1994202205$1248324085$gmane$org@rustcorp.com.au>
References: <cover.1248181714.git.mst@redhat.com>
	<20090721155925.GC3306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090721155925.GC3306@redhat.com>
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

On Wed, 22 Jul 2009 01:29:25 am Michael S. Tsirkin wrote:
> -	if (info->vector != VIRTIO_MSI_NO_VECTOR)
> +	if (info->vector != VIRTIO_MSI_NO_VECTOR) {
>  		free_irq(vp_dev->msix_entries[info->vector].vector, vq);
> +		--vp_dev->msix_used_vectors;
> +	}
>

This only works because the only current caller of vp_del_vq is vp_del_vqs, so 
msix_used_vectors will be 0 after all the queues have been freed.

Make up your mind.  Either find_vq allocates and del_vq frees, or it's find_vqs 
and del_vqs.  I suggest the former, and setting the value VIRTIO_MSI_NO_VECTOR  
to indicate it's already freed.  I think with some cleanups, that loop in 
vp_free_vectors might go away, too.

Rusty.
