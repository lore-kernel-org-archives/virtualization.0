From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 07/13] vhost: format-independent API for used buffers
Date: Thu, 4 Jun 2020 17:18:00 +0800
Message-ID: <b39e6fb8-a59a-2b3f-a1eb-1ccea2fe1b86@redhat.com>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-8-mst@redhat.com>
 <6d98f2cc-2084-cde0-c938-4ca01692adf9@redhat.com>
 <20200604050135-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200604050135-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/4 下午5:03, Michael S. Tsirkin wrote:
>>>    static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>>    {
>>>    	__u16 old, new;
>>> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>>> index a67bda9792ec..6c10e99ff334 100644
>>> --- a/drivers/vhost/vhost.h
>>> +++ b/drivers/vhost/vhost.h
>>> @@ -67,6 +67,13 @@ struct vhost_desc {
>>>    	u16 id;
>>>    };
>>> +struct vhost_buf {
>>> +	u32 out_len;
>>> +	u32 in_len;
>>> +	u16 descs;
>>> +	u16 id;
>>> +};
>> So it looks to me the struct vhost_buf can work for both split ring and
>> packed ring.
>>
>> If this is true, we'd better make struct vhost_desc work for both.
>>
>> Thanks
> Both vhost_desc and vhost_buf can work for split and packed.
>
> Do you mean we should add packed ring support based on this?
> For sure, this is one of the motivators for the patchset.
>

Somehow. But the reason I ask is that I see "split" suffix is used in 
patch 1 as:

peek_split_desc()
pop_split_desc()
push_split_desc()

But that suffix is not used for the new used ring API invented in this 
patch.

Thanks
