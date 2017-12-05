From: weiping zhang <zwp10758@gmail.com>
Subject: Re: [PATCH] virtio: release virtio index when fail to device_register
Date: Tue, 5 Dec 2017 09:30:41 +0800
Message-ID: <CAA70yB56O4cTdORgV9QKFRGtWe8N6Tr4WzTD2EoW6RQnWosekQ@mail.gmail.com>
References: <20171129012301.GA6637@localhost.didichuxing.com>
	<20171129105044.3a4b0ab3.cohuck@redhat.com>
	<20171201165539.GA11865@localhost.didichuxing.com>
	<20171204103842.3d8709a8.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171204103842.3d8709a8.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

2017-12-04 17:38 GMT+08:00 Cornelia Huck <cohuck@redhat.com>:
> On Sat, 2 Dec 2017 00:55:39 +0800
> weiping zhang <zwp10758@gmail.com> wrote:
>
>> On Wed, Nov 29, 2017 at 10:50:44AM +0100, Cornelia Huck wrote:
>
>> > We hold an extra reference to the struct device, even after a failed
>> > register, and it is the responsibility of the caller to give up that
>> > reference once no longer needed. As callers toregister_virtio_device()
>> > embed the struct virtio_device, it needs to be their responsibility.
>> > Looking at the existing callers,
>> >
>> > - ccw does a put_device
>> > - pci, mmio and remoteproc do nothing, causing a leak
>> > - vop does a free on the embedding structure, which is a big no-no
>> >
>> > Thoughts?
>> Sorry to relay late and thanks for your review.
>> Do you mean the "extra reference to the struct device" caused by the
>> following code?
>>
>> err = device_register(&dev->dev);
>>       device_add(dev)
>>               get_device(dev)
>> If I'm understand right, I think there is no extra reference if we fail
>> virtio_register_device, because if device_register we don't get a
>> reference.
>
> The device_initialize() already gives you a reference. If device_add()
> fails, it has cleaned up any additional reference it might have
> obtained, but the initial reference is still there and needs to be
> released by the caller.

Thanks your clarify, I also notice the comments at device_register,
device_initialize, device_add,

 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up the
 * reference initialized in this function instead.

--
Thanks
weiping
