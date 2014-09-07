From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio_blk: merge S/G list entries by default
Date: Sun, 07 Sep 2014 12:18:41 +0200
Message-ID: <540C3101.40701@redhat.com>
References: <1410044994-14943-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410044994-14943-1-git-send-email-hch@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>, Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 07/09/2014 01:09, Christoph Hellwig ha scritto:
> Most virtio setups have a fairly limited number of ring entries available.

Are you disabling indirect descriptors?  With indirect descriptors entry
merging doesn't buy you any more space, so perhaps you can key the flag
off the availability of VIRTIO_RING_F_INDIRECT_DESC.

Paolo

> Enable S/G entry merging by default to fit into less of them.  This restores
> the behavior at time of the virtio-blk blk-mq conversion, which was changed
> by commit "block: add queue flag for disabling SG merging" which made the
> behavior optional, but didn't update the existing drivers to keep their
> previous behavior.
