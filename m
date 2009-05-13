From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Wed, 13 May 2009 21:03:51 +0930
Message-ID: <200905132103.52559.rusty__9606.19994807548$1242214815$gmane$org@rustcorp.com.au>
References: <cover.1242080138.git.mst@redhat.com>
	<200905131047.09416.rusty@rustcorp.com.au>
	<20090513071834.GC31139@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090513071834.GC31139@redhat.com>
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

On Wed, 13 May 2009 04:48:34 pm Michael S. Tsirkin wrote:
> Let's just add a helper function for the single vq case?
>
> static inline struct virtqueue *virtio_find_vq(struct virtio_devide *vdev,
> 					       vq_callback_t *c, const char *n)

virtio_find_single_vq() to emphasize the singular nature, and it looks good.

Thanks!
Rusty.
