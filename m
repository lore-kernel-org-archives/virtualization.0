From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio-blk: add DISCARD support to
	virtio-blk driver
Date: Mon, 27 Mar 2017 13:34:17 +0200
Message-ID: <00d28fcc-446b-eff6-a5a3-6675216802b9__10429.6833313585$1490614476$gmane$org@redhat.com>
References: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Changpeng Liu <changpeng.liu@intel.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de
Cc: qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org



On 28/03/2017 10:39, Changpeng Liu wrote:
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> +		q->limits.discard_zeroes_data = 0;

Maybe you could use another feature bit to populate discard_zeroes_data.

Paolo

> +		q->limits.discard_alignment = blk_size;
> +		q->limits.discard_granularity = blk_size;
> +		blk_queue_max_discard_sectors(q, UINT_MAX);
> +		blk_queue_max_discard_segments(q, 1);
> +		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
> +	}
> +
