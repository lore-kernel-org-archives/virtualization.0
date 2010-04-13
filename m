From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/6] virtio: virtqueue ops cleanup
Date: Tue, 13 Apr 2010 16:06:04 +0300
Message-ID: <20100413130604.GA25574@redhat.com>
References: <cover.1271078235.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1271078235.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 12, 2010 at 04:17:15PM +0300, Michael S. Tsirkin wrote:
> virtqueue ops were introduced in the hope that we'll
> have multiple implementations besides virtio_ring,
> but none have surfaced so far, and given that
> existing virtio ring is deployed in production
> we are likely stuck with it now, so this layer just
> adds complexity and overhead.
> Further, the need to pass vq twice to each call
> (as in dev->vq->vq_ops->kick(dev->vq) ) adds potential
> for cut and paste errors.
> 
> This patchset does the following:
> - add inline wrappers converting the above to virtqueue_kick(dev->vq)
> - convert all users to this API
> - remove vq_ops indirection, implementing virtqueue_xx directly
>   in virtio_ring
> 
> Note that if we ever want to add another vring implementation,
> we'll only need to revert the last patch in the series,
> devices won't have to change.

Looks like I missed virtio-rng and trans_virtio.
So the following are needed as well.

-- 
MST
