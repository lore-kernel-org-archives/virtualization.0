From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 04/16] virtio-blk: use virtqueue_start_buf on bio path
Date: Thu, 21 Feb 2013 16:53:14 +1030
Message-ID: <87d2vugp7x.fsf@rustcorp.com.au>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<1361260594-601-5-git-send-email-rusty@rustcorp.com.au>
	<51249510.4020505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51249510.4020505@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:

> On 02/19/2013 03:56 PM, Rusty Russell wrote:
>> (This is a respin of Paolo Bonzini's patch, but it calls
>> virtqueue_add_sgs() instead of his multi-part API).
...
> (This subject needs to be changed to reflect using of virtqueue_add_sgs)

Thanks, done.

>> -static inline int __virtblk_add_req(struct virtqueue *vq,
>> -			     struct virtblk_req *vbr,
>> -			     unsigned long out,
>> -			     unsigned long in)
>> +static int __virtblk_add_req(struct virtqueue *vq,
>> +			     struct virtblk_req *vbr)
>>  {
>> -	return virtqueue_add_buf(vq, vbr->sg, out, in, vbr, GFP_ATOMIC);
>> +	struct scatterlist hdr, tailer, *sgs[3];
>
> 'status' might be better than 'tailer'. We are using status in other
> places.

Indeed, done.

> Reviewed-by: Asias He <asias@redhat.com>

Thanks,
Rusty.
