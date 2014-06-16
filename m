From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH 2/2] block: virtio-blk: support multi virt queues per
	virtio-blk device
Date: Mon, 16 Jun 2014 22:17:05 +0930
Message-ID: <877g4hnhrq.fsf__2514.91835010729$1402965882$gmane$org@rustcorp.com.au>
References: <1402680562-8328-1-git-send-email-ming.lei@canonical.com>
	<1402680562-8328-3-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1402680562-8328-3-git-send-email-ming.lei@canonical.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-api@vger.kernel.org, Ming Lei <ming.lei@canonical.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Ming Lei <ming.lei@canonical.com> writes:
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_MQ))
> +		err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> +				   struct virtio_blk_config, num_queues,
> +				   &num_vqs);
> +	else
> +		num_vqs = 1;

This is redundant: virtio_cread_feature() checks the feature.

So, either:
        if (virtio_has_feature(vdev, VIRTIO_BLK_F_MQ))
                virtio_cread(vdev, struct virtio_blk_config, num_queues,
          		     &num_vqs);
        else
                num_vqs = 1;

Or:
	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
			   struct virtio_blk_config, num_queues,
			   &num_vqs);
        if (err)
                num_vqs = 1;

Otherwise, the patch looks pretty straight-forward.

Cheers,
Rusty.
