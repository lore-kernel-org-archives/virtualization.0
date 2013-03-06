From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjur@brendeland.net>
Subject: Re: [PATCH vringh] virtio: Introduce vringh wrappers in virtio_config
Date: Wed, 6 Mar 2013 11:50:45 +0100
Message-ID: <CANHm3Pg6tDMb9fM60sFdA2sQ856vUGe4S1TpK3_tUoyBd-882A@mail.gmail.com>
References: <1362491468-16681-1-git-send-email-sjur.brandeland@stericsson.com>
	<876215cf5f.fsf@rustcorp.com.au>
Reply-To: sjur@brendeland.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <876215cf5f.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 6, 2013 at 5:42 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
...
>> @@ -70,6 +80,9 @@ struct virtio_config_ops {
>>       void (*finalize_features)(struct virtio_device *vdev);
>>       const char *(*bus_name)(struct virtio_device *vdev);
>>       int (*set_vq_affinity)(struct virtqueue *vq, int cpu);
>> +     int (*find_vrhs)(struct virtio_device *vdev, unsigned nhvrs,
>> +                      struct vringh *vrhs[], vrh_callback_t *callbacks[]);
>> +     void (*del_vrhs)(struct virtio_device *vdev);
>>  };
>>
>>  /* If driver didn't advertise the feature, it will never appear. */
>
> It's weird that you conflate the host and guest ring sides in rpmsg, but
> that might make sense if they're really bound together.

The caif_virtio driver is using both host and guest ring sides, host side
rings in RX direction and guest side rings in TX direction. The reason
behind this is to enable zero-copy on the producer sides.
(For details see recent discussion with Ohad "Wrappers for vringh"
or the  initial blurb when first introducing caif virtio:
https://lkml.org/lkml/2012/10/31/677)

> ...  However, in
> general they are not: it's normal to be a guest or host, not both.
>
> This implies that you need a struct vringh_config, to put this in.

OK, should we move the definition of struct vringh_config into vringh.h
then, and add a vringh_config field in struct virtio_device?

>> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
>> index ab41185..8156f51 100644
>> --- a/include/linux/vringh.h
>> +++ b/include/linux/vringh.h
>> @@ -50,6 +50,12 @@ struct vringh {
>>
>>       /* The vring (note: it may contain user pointers!) */
>>       struct vring vring;
>> +
>> +     /* The function to call when buffers are available */
>> +     void (*notify)(struct vringh *);
>> +
>> +     /* A pointer for the vringh clients to use. */
>> +     void *priv;
>>  };
>
> Since the caller allocates the vringh, can it not use container_of()
> instead of a priv pointer?

Sure, no problem. I just need to add a new struct in remoteproc containing
both the vringh and a pointer to the internal ring data.

Regards,
Sjur
