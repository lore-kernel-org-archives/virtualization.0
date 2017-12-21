From: weiping zhang <zwp10758@gmail.com>
Subject: Re: [PATCH v4 1/4] virtio: split device_register into
	device_initialize and device_add
Date: Thu, 21 Dec 2017 10:43:09 +0800
Message-ID: <CAA70yB6Ut_+1fOhXa3CFjRdPJ4gv8dvt52PSZ-x7B4vetDGOAw@mail.gmail.com>
References: <cover.1513700444.git.zhangweiping@didichuxing.com>
	<95ad7cb52d9e65b27f09a23c7f330128388502fa.1513700444.git.zhangweiping@didichuxing.com>
	<20171220165316.5545b24c.cohuck@redhat.com>
	<CAA70yB4e6Qp_2D+6-RCSVLKvSVxJ_vSeBi8Day7b1pCOzvfD_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAA70yB4e6Qp_2D+6-RCSVLKvSVxJ_vSeBi8Day7b1pCOzvfD_g@mail.gmail.com>
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
Cc: virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

2017-12-21 10:37 GMT+08:00 weiping zhang <zwp10758@gmail.com>:
> 2017-12-20 23:53 GMT+08:00 Cornelia Huck <cohuck@redhat.com>:
>> On Wed, 20 Dec 2017 12:26:25 +0800
>> weiping zhang <zwp10758@gmail.com> wrote:
>>
>> [you used a different mail address in your From: than in your s-o-b:;
>> same for the other patches]
a wrong setting of my email client, correct it next time, thanks.
>>> In order to make caller do a simple cleanup, we split device_register
>>> into device_initialize and device_add. device_initialize always sucess,
>>
>> s/success/succeeds/
>>
>>> the caller can always use put_device when fail to register virtio_device
>>
>> "so the caller can always use put_device when register_virtio_device
>> failed,"
>>
>>> no matter fail at ida_simple_get or at device_add.
>>
>> "no matter whether it failed..."
>>
>>> + *
>>> + * If an error occurs, the caller must use put_device, instead of kfree, because
>>> + * device_initialize and device_add will increase @dev->dev's reference count.
>>
>> That's not correct: It's not because of device_add increasing the
>> reference count (it releases it again on failure), but because another
>> code path may have obtained a reference.
>>
>> What about:
>>
>> "On error, the caller must call put_device on &@dev->dev (and not
>> kfree), as another code path may have obtained a reference to @dev."
>>
> It's good to understand, further more dev->name may has a bit mem leak.
> anyway, I'll correct all comments at V5. Thanks very much.
>>> + *
>>> + * Returns: 0 on suceess, -error on failure
>>> + */
>>>  int register_virtio_device(struct virtio_device *dev)
