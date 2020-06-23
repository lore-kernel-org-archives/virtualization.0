From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
Date: Tue, 23 Jun 2020 10:51:34 +0800
Message-ID: <c56cc86d-a420-79ca-8420-e99db91980fa@redhat.com>
References: <20200611113404.17810-1-mst@redhat.com>
 <20200611113404.17810-3-mst@redhat.com>
 <0332b0cf-cf00-9216-042c-e870efa33626@redhat.com>
 <20200622115946-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200622115946-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, eperezma@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/23 上午12:00, Michael S. Tsirkin wrote:
> On Wed, Jun 17, 2020 at 11:19:26AM +0800, Jason Wang wrote:
>> On 2020/6/11 下午7:34, Michael S. Tsirkin wrote:
>>>    static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
>>>    {
>>>    	kfree(vq->descs);
>>> @@ -394,6 +400,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
>>>    	for (i = 0; i < dev->nvqs; ++i) {
>>>    		vq = dev->vqs[i];
>>>    		vq->max_descs = dev->iov_limit;
>>> +		if (vhost_vq_num_batch_descs(vq) < 0) {
>>> +			return -EINVAL;
>>> +		}
>> This check breaks vdpa which set iov_limit to zero. Consider iov_limit is
>> meaningless to vDPA, I wonder we can skip the test when device doesn't use
>> worker.
>>
>> Thanks
> It doesn't need iovecs at all, right?
>
> -- MST


Yes, so we may choose to bypass the iovecs as well.

Thanks
