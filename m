From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost next 06/10] vdpa: Add means to communicate vq status
 on get_vq_state
Date: Thu, 16 Jul 2020 17:35:18 +0800
Message-ID: <296e6fcb-946c-f577-2e22-46528f78fda9@redhat.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-7-eli@mellanox.com>
 <cb9bced7-1a7e-150a-875c-1b75f77ee853@redhat.com>
 <20200716082116.GA182860@mtl-vdi-166.wap.labs.mlnx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716082116.GA182860@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eli Cohen <eli@mellanox.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, shahafs@mellanox.com, saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/16 下午4:21, Eli Cohen wrote:
> On Thu, Jul 16, 2020 at 04:11:00PM +0800, Jason Wang wrote:
>> On 2020/7/16 下午3:23, Eli Cohen wrote:
>>> Currently, get_vq_state() is used only to pass the available index value
>>> of a vq. Extend the struct to return status on the VQ to the caller.
>>> For now, define VQ_STATE_NOT_READY. In the future it will be extended to
>>> include other infomration.
>>>
>>> Modify current vdpa driver to update this field.
>>>
>>> Reviewed-by: Parav Pandit<parav@mellanox.com>
>>> Signed-off-by: Eli Cohen<eli@mellanox.com>
>> What's the difference between this and get_vq_ready()?
>>
>> Thanks
>>
> There is no difference. It is just a way to communicate a problem to
> with the state of the VQ back to the caller. This is not available now.
> I think an asynchronous is preferred but that is not available
> currently.


I still don't see the reason, maybe you can give me an example?

Thanks
