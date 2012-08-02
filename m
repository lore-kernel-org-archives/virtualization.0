From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 3/4] virtio-blk: Add bio-based IO path for virtio-blk
Date: Fri, 3 Aug 2012 01:28:14 +0300
Message-ID: <20120802222814.GA5854@redhat.com>
References: <1343888757-25723-1-git-send-email-asias@redhat.com>
	<1343888757-25723-4-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1343888757-25723-4-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 02, 2012 at 02:25:55PM +0800, Asias He wrote:
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c0bbeb4..95cfeed 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -14,6 +14,9 @@
>  
>  #define PART_BITS 4
>  
> +static bool use_bio;
> +module_param(use_bio, bool, S_IRUGO);
> +
>  static int major;
>  static DEFINE_IDA(vd_index_ida);
>  

OK, but eventually, you plan to make this use a feature bit, yes?
