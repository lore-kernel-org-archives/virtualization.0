From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_ring: Fix mem leak with vring_new_virtqueue()
Date: Wed, 26 Feb 2020 11:13:57 +0800
Message-ID: <1ce2bee4-64ed-f630-2695-8e8b9b8e27c1@redhat.com>
References: <20200224212643.30672-1-s-anna@ti.com>
 <b622c831-9adb-b9af-dd4a-21605bc124a8@redhat.com>
 <0ace3a3b-cf2f-7977-5337-f74f530afbe1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0ace3a3b-cf2f-7977-5337-f74f530afbe1@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/26 =E4=B8=8A=E5=8D=8812:51, Suman Anna wrote:
> Hi Jason,
>
> On 2/24/20 11:39 PM, Jason Wang wrote:
>> On 2020/2/25 =E4=B8=8A=E5=8D=885:26, Suman Anna wrote:
>>> The functions vring_new_virtqueue() and __vring_new_virtqueue() are u=
sed
>>> with split rings, and any allocations within these functions are mana=
ged
>>> outside of the .we_own_ring flag. The commit cbeedb72b97a ("virtio_ri=
ng:
>>> allocate desc state for split ring separately") allocates the desc st=
ate
>>> within the __vring_new_virtqueue() but frees it only when the
>>> .we_own_ring
>>> flag is set. This leads to a memory leak when freeing such allocated
>>> virtqueues with the vring_del_virtqueue() function.
>>>
>>> Fix this by moving the desc_state free code outside the flag and only
>>> for split rings. Issue was discovered during testing with remoteproc
>>> and virtio_rpmsg.
>>>
>>> Fixes: cbeedb72b97a ("virtio_ring: allocate desc state for split ring
>>> separately")
>>> Signed-off-by: Suman Anna<s-anna@ti.com>
>>> ---
>>>  =C2=A0 drivers/virtio/virtio_ring.c | 4 ++--
>>>  =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
>>> index 867c7ebd3f10..58b96baa8d48 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -2203,10 +2203,10 @@ void vring_del_virtqueue(struct virtqueue *_v=
q)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vq->split=
.queue_size_in_bytes,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vq->split=
.vring.desc,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vq->split=
.queue_dma_addr);
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k=
free(vq->split.desc_state);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!vq->packed_ring)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(vq->split.desc_stat=
e);
>> Nitpick, it looks to me it would be more clear if we just free
>> desc_state unconditionally here (and remove the kfree for packed above=
).
> OK, are you sure you want that to be folded into this patch? It looks t=
o
> me a separate cleanup/consolidation patch, and packed desc_state does
> not suffer this memleak, and need not be backported into stable kernels=
.
>
> regards
> Suman


Though it's just a small tweak, I'm fine for leaving it for future.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks
