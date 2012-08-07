From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V5 4/4] virtio-blk: Add REQ_FLUSH and REQ_FUA support
	to bio path
Date: Tue, 07 Aug 2012 16:50:45 +0800
Message-ID: <5020D6E5.3060504@redhat.com>
References: <1343888757-25723-1-git-send-email-asias@redhat.com>
	<1343888757-25723-5-git-send-email-asias@redhat.com>
	<20120802062742.GA23573@lst.de> <501A2178.3000906@redhat.com>
	<20120806151731.GA23220@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120806151731.GA23220@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/06/2012 11:17 PM, Christoph Hellwig wrote:
> On Thu, Aug 02, 2012 at 02:43:04PM +0800, Asias He wrote:
>>> Even if it has a payload waiting is highly suboptimal and it should
>>> use a non-blocking sequencing like it is done in the request layer.
>>
>> So, for REQ_FLUSH, what we need is that send out the VIRTIO_BLK_T_FLUSH and
>> not to wait.
>
> If it's REQ_FLUSH without data a VIRTIO_BLK_T_FLUSH should be sent out only,
> if it's a REQ_FLUSH that has data a VIRTIO_BLK_T_FLUSH should be sent out,
> but instead of waiting for it to finish the I/O completion handler should
> then submit the actual write.
>
>> We still need to wait until the actual write is finished here?
>> Like,
>>
>> REQ_FUA is emulated by:
>> 1. Send the actual write
>> 2. Wait until the actual write is finished
>> 3. Send VIRTIO_BLK_T_FLUSH to device
>> 4. Signal the end of the write to upper layer
>
> Remove step 2 and run step 3 from the I/O completion handler.
>

Thanks for the explanation. V6 is in flight.

-- 
Asias
