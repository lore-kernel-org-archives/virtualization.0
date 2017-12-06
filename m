From: weiping zhang <zwp10758@gmail.com>
Subject: Re: [PATCH v2 1/2] virtio_mmio: add cleanup for virtio_mmio_probe
Date: Wed, 6 Dec 2017 21:53:56 +0800
Message-ID: <CAA70yB5xA-UC0GqB5Eb1pGPwuQAsQ1v9=+ihnneFu+0WO_Qttw@mail.gmail.com>
References: <cover.1512445595.git.zhangweiping@didichuxing.com>
	<40b3946d54c4a08b2ce3741f4d27bff99ec2f6c8.1512445595.git.zhangweiping@didichuxing.com>
	<20171206121153.5f075096.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171206121153.5f075096.cohuck@redhat.com>
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
Cc: mst@redhat.com, weiping zhang <zhangweiping@didichuxing.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

2017-12-06 19:11 GMT+08:00 Cornelia Huck <cohuck@redhat.com>:
> On Tue, 5 Dec 2017 19:57:10 +0800
> weiping zhang <zhangweiping@didichuxing.com> wrote:
>
>> As mentioned at drivers/base/core.c:
>> /*
>>  * NOTE: _Never_ directly free @dev after calling this function, even
>>  * if it returned an error! Always use put_device() to give up the
>>  * reference initialized in this function instead.
>>  */
>>
>> Normal we do cleanup for @vm_dev by contianer_of(@dev), but in this case
>> we need release @mem resource from @pdev and vm_dev->base. It make
>> @pdev->vm_dev.dev.release() too complicated, so put_device just put the
>> reference of register_virtio_device->device_register->device_initialize
>> and release all resource in virtio_mmio_probe.
>
> Releasing the resources when unwinding on error can work, but I think
> there still are some issues (more below). This is all very tangly
> code :(
>
>>
>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>> ---
>>  drivers/virtio/virtio_mmio.c | 36 ++++++++++++++++++++++++++++--------
>>  1 file changed, 28 insertions(+), 8 deletions(-)
>>
>
>> @@ -573,7 +580,20 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>>
>>       platform_set_drvdata(pdev, vm_dev);
>>
>> -     return register_virtio_device(&vm_dev->vdev);
>> +     rc = register_virtio_device(&vm_dev->vdev);
>> +     if (rc)
>> +             goto put_dev;
>> +     return 0;
>> +put_dev:
>> +     put_device(&vm_dev->vdev.dev);
>
> Here you give up the extra reference from device_initialize(), which
> may or may not be the last reference (since you don't know if
> device_add() had already exposed the struct device to other code that
> might have acquired a reference). As the device has an empty release
> function, touching the device structure after that is not a real
> problem, but...
>
>> +unmap:
>> +     iounmap(vm_dev->base);
>> +free_mem:
>> +     devm_release_mem_region(&pdev->dev, mem->start,
>> +                     resource_size(mem));
>> +free_vmdev:
>> +     devm_kfree(&pdev->dev, vm_dev);
>
> ...unconditionally freeing the device here would be a problem if other
> code had acquired a reference above. (Unlikely, but we should try to
> get this right.)
>
that's true, so we don't free it until it's refer count decrease to 0 and
->release called.
>> +     return rc;
>>  }
>>
>>  static int virtio_mmio_remove(struct platform_device *pdev)
>
> So, I think there are basically two ways of doing that:
> - Move the cleanup into the currently empty release callback. Then, you
>   won't need to touch the remove function. The problem with that is
>   that you can't trigger a cleanup via put_device() if you did not call
>   register_virtio_device() yet.
> - Move just devm_kfree() into the release function. Cleanup the
>   resources here, do the put_device() last thing if had you called
>   register_virtio_device() before and devm_kfree() if you didn't.
>
I prefer go second way. I'll send v3 later.
> [Of course, I still might be missing some devm subtility, so other
> comments are welcome.]

--
Thanks very much
weiping
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
