From: weiping zhang <zwp10758@gmail.com>
Subject: Re: [PATCH v3 5/5] virtio: add comments for virtio_register_device
Date: Tue, 19 Dec 2017 23:23:10 +0800
Message-ID: <CAA70yB5e-dVLhLej5TyLA5mQkXjDehXwG195MkwvBMnQoK5feQ@mail.gmail.com>
References: <cover.1513517240.git.zhangweiping@didichuxing.com>
	<56d8ecc6f11b7580f3d38adcc0fd71ac60f72b02.1513517240.git.zhangweiping@didichuxing.com>
	<20171219121159.17b8c060.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171219121159.17b8c060.cohuck@redhat.com>
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

2017-12-19 19:11 GMT+08:00 Cornelia Huck <cohuck@redhat.com>:
> On Sun, 17 Dec 2017 21:48:05 +0800
> weiping zhang <zwp10758@gmail.com> wrote:
>
>> As mentioned at drivers/base/core.c:
>> /*
>> * NOTE: _Never_ directly free @dev after calling this function, even
>> * if it returned an error! Always use put_device() to give up the
>> * reference initialized in this function instead.
>> */
>> virtio_register_device may fail before/after call device_register, the
>> caller should do a proper cleanup. Caller cann't use kfree directly,
>> if virtio_register_device has already called device_register. Caller
>> cann't use put_device directly, if virtio_register_device has not yet
>> call device_register, because kobject_put may give a warning cause
>> dev->kobj has not been initialized.
>
> This comment makes me inclined to think that we should also rethink
> register_virtio_device(). On failure, we cannot do kfree() due to
> driver core interaction; but we cannot do a put_device() either, since
> the refcount may not yet have been initialized -- unless we check the
> device status, which triggers I/O (at least on s390).
>
> We really want to do the same cleanup on error in every case. What
> about splitting device_register() into device_initialize() and
> device_add()? If we move device_initialize() before getting an index,
> we should be fine with doing put_device() on error in every case.
>
Good idea (^_^), I''ll apply it at V4.
