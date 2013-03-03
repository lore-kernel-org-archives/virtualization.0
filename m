From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Wrappers for vringh (was Re: [PATCHv2 vringh 1/3] remoteproc: Add
	support for vringh (Host vrings))
Date: Sun, 3 Mar 2013 07:54:51 +0200
Message-ID: <CAK=Wgbb5uy2tqwCG9jvzcw+-bPT=ALy7k9KPWWmxB04e+MtWSA@mail.gmail.com>
References: <CAJK669Zdw+F8F8EUc__6rHscFdP4tCa8dDB+6LZ_abx2efyMHA@mail.gmail.com>
	<87txoxceg1.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87txoxceg1.fsf@rustcorp.com.au>
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
Cc: Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization <virtualization@lists.linux-foundation.org>, Ido Yariv <ido@wizery.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 28, 2013 at 5:19 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> index 29b9104..ca257d8 100644
>> --- a/include/linux/virtio_config.h
>> +++ b/include/linux/virtio_config.h
>> @@ -53,0 +54,8 @@
>> + * @find_vrh: find the host vrings and instantiate them
>> + *     vdev: the virtio_device
>> + *     nhvrs: the number of host vrings to find
>> + *     hvrs: on success, includes new host vrings
>> + *     callbacks: array of driver callbacks, for each host vring
>> + *             include a NULL entry for vqs that do not need a callback
>> + *     Returns 0 on success or error status
>> + * @del_vrh: free the host vrings found by find_vrh().
>> @@ -55,0 +64 @@ typedef void vq_callback_t(struct virtqueue *);
>> +typedef void vrh_callback_t(struct virtio_device *, struct vringh *);
>> @@ -72,0 +82,4 @@ struct virtio_config_ops {
>> +       int (*find_vrh) (struct virtio_device *, unsigned nhvrs,
>> +                        struct vringh *vrhs[],
>> +                        vrh_callback_t *callbacks[]);
>> +       int (*del_vrhs)(struct virtio_device *);
>> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
>> index 4c4c918..78aecc9 100644
>> --- a/include/linux/vringh.h
>> +++ b/include/linux/vringh.h
>> @@ -52,0 +53,3 @@ struct vringh {
>> +
>> +       /* The function to call when buffers are available */
>> +       void (*notify)(struct vringh *);
>
> This will work for vhost, too, so no problems here.

Great, this looks good to me too.

Thanks!
Ohad.
