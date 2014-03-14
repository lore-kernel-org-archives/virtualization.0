From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] virtio-blk: make the queue depth configurable
Date: Fri, 14 Mar 2014 10:38:40 -0700
Message-ID: <1394818720.3253.1.camel@joe-AO722>
References: <1394818263-29947-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1394818263-29947-1-git-send-email-tytso@mit.edu>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fes@google.com, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2014-03-14 at 13:31 -0400, Theodore Ts'o wrote:
> The current virtio block sets a queue depth of 64.  With a
> sufficiently fast device, using a queue depth of 256 can double the
> IOPS which can be sustained.  So make the queue depth something which
> can be set at module load time or via a kernel boot-time parameter.
[]
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
[]
> @@ -481,6 +481,9 @@ static struct blk_mq_ops virtio_mq_ops = {
>  	.free_hctx	= blk_mq_free_single_hw_queue,
>  };
>  
> +static int queue_depth = 64;
> +module_param(queue_depth, int, 444);

444?  Really Ted?

0444
