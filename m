From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] virtio_console: link vq to port with a private pointer
	in struct virtqueue
Date: Wed, 18 Apr 2012 16:34:12 +0200
Message-ID: <4F8ED0E4.6000702@redhat.com>
References: <1334756013-11752-1-git-send-email-pbonzini@redhat.com>
	<20120418142146.GB11801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120418142146.GB11801@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 18/04/2012 16:21, Michael S. Tsirkin ha scritto:
>> @@ -1872,6 +1864,8 @@ static int virtcons_restore(struct virtio_device *vdev)
>>  	list_for_each_entry(port, &portdev->ports, list) {
>>  		port->in_vq = portdev->in_vqs[port->id];
>>  		port->out_vq = portdev->out_vqs[port->id];
>> +		port->in_vq->vdev_priv = port;
>> +		port->out_vq->vdev_priv = port;
>>  
>>  		fill_queue(port->in_vq, &port->inbuf_lock);
>>  
> 
> Let's add an API to set this pointer.
> Document that you must not set it after
> probe/restore returned.

Why?

> With an API we can actually have a BUG_ON that checks it's not modified
> after probe.
> 
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index c193ccf..6b39c1a 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -14,6 +14,7 @@
>>   * @callback: the function to call when buffers are consumed (can be NULL).
>>   * @name: the name of this virtqueue (mainly for debugging)
>>   * @vdev: the virtio device this queue was created for.
>> + * @vdev_priv: a pointer for the virtio device to use.
> 
> It's for the driver actually.

Right.  However...

>>   * @priv: a pointer for the virtqueue implementation to use.
>>   */
>>  struct virtqueue {
>> @@ -21,6 +22,7 @@ struct virtqueue {
>>  	void (*callback)(struct virtqueue *vq);
>>  	const char *name;
>>  	struct virtio_device *vdev;
>> +	void *vdev_priv;
>>  	void *priv;
> 
> The name is confusing: it seems to imply it's a device pointer.

... it's private to the driver that owns vdev, hence the name.

> Maybe we should rename priv to something like __priv and make
> priv useful for devices?

I wanted to go for the smallest possible changes.  Right now we have 1
user for each member (virtio-ring vs. virtio-console) so neither member
is really dominating.

Paolo
