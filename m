From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [PATCH] virtio_console: move early VQ enablement
Date: Mon, 20 Oct 2014 13:09:14 -0400
Message-ID: <CA+5PVA7QgM9PGExjyZG-TQGYZWrWOKM+7dQGh2RWnJCfZ3aw+A@mail.gmail.com>
References: <20141020133555.GA27111@redhat.com>
	<1413813529-11044-1-git-send-email-cornelia.huck@de.ibm.com>
	<20141020140508.GA11004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141020140508.GA11004@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Thomas Graf <tgraf@suug.ch>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 20, 2014 at 10:05 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Oct 20, 2014 at 03:58:49PM +0200, Cornelia Huck wrote:
>> Commit f5866db6 (virtio_console: enable VQs early) tried to make
>> sure that DRIVER_OK was set when virtio_console started using its
>> virtqueues. Doing this in add_port(), however, means that we try
>> to set DRIVER_OK again when when a port is dynamically added after
>> the probe function is done.
>>
>> Let's move virtio_device_ready() to the probe function just before
>> trying to use the virtqueues instead. This is fine as nothing can
>> fail inbetween.
>>
>> Reported-by: Thomas Graf <tgraf@suug.ch>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>
> Thanks!
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Michael S. Tsirkin <mst@redhat.com>

This fixed my KVM guest boot issue with 3.18-rc1.  Thanks for such a quick fix.

Tested-by: Josh Boyer <jwboyer@fedoraproject.org>

josh

>> ---
>>  drivers/char/virtio_console.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
>> index bfa6400..cf7a561 100644
>> --- a/drivers/char/virtio_console.c
>> +++ b/drivers/char/virtio_console.c
>> @@ -1449,8 +1449,6 @@ static int add_port(struct ports_device *portdev, u32 id)
>>       spin_lock_init(&port->outvq_lock);
>>       init_waitqueue_head(&port->waitqueue);
>>
>> -     virtio_device_ready(portdev->vdev);
>> -
>>       /* Fill the in_vq with buffers so the host can send us data. */
>>       nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
>>       if (!nr_added_bufs) {
>> @@ -2026,6 +2024,8 @@ static int virtcons_probe(struct virtio_device *vdev)
>>       spin_lock_init(&portdev->ports_lock);
>>       INIT_LIST_HEAD(&portdev->ports);
>>
>> +     virtio_device_ready(portdev->vdev);
>> +
>>       if (multiport) {
>>               unsigned int nr_added_bufs;
>>
>> --
>> 1.8.5.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
