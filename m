From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V3 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Mon, 30 Jul 2012 12:43:12 +0800
Message-ID: <501610E0.8000504@redhat.com>
References: <971756309.4742543.1343457753475.JavaMail.root@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <971756309.4742543.1343457753475.JavaMail.root@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 07/28/2012 02:42 PM, Paolo Bonzini wrote:
>>> I'm not sure what the correct behavior for bio & cacheflush is, if
>>> any.
>>
>> REQ_FLUSH is not supported in the bio path.
>
> Ouch, that's correct:
>
> @@ -414,7 +529,7 @@ static void virtblk_update_cache_mode(struct virtio_device *vdev)
>   	u8 writeback = virtblk_get_cache_mode(vdev);
>   	struct virtio_blk *vblk = vdev->priv;
>
> -	if (writeback)
> +	if (writeback && !use_bio)
>   		blk_queue_flush(vblk->disk->queue, REQ_FLUSH);
>   	else
>   		blk_queue_flush(vblk->disk->queue, 0);
>
> then it is not safe against power losses.

Yes. Something like this:

   qemu -drive file=foo.img,cache=writeback/unsafe

is not safe against power losses also?

I think we can add REQ_FLUSH & REQ_FUA support to bio path and that 
deserves another patch.

-- 
Asias
