From: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] virtio_console: allocate inbufs in add_port() only if
	it is needed
Date: Wed, 13 Nov 2019 17:37:34 +0100
Message-ID: <7bd34d61-146f-8edb-d82d-7285a83437b4__31699.2215624609$1573663077$gmane$org@redhat.com>
References: <20191113150056.9990-1-lvivier@redhat.com>
	<20191113101929-mutt-send-email-mst@kernel.org>
	<20191113102126-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191113102126-mutt-send-email-mst@kernel.org>
Content-Language: en-US
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
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 13/11/2019 16:22, Michael S. Tsirkin wrote:
> On Wed, Nov 13, 2019 at 10:21:11AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Nov 13, 2019 at 04:00:56PM +0100, Laurent Vivier wrote:
>>> When we hot unplug a virtserialport and then try to hot plug again,
>>> it fails:
>>>
>>> (qemu) chardev-add socket,id=serial0,path=/tmp/serial0,server,nowait
>>> (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
>>>                   chardev=serial0,id=serial0,name=serial0
>>> (qemu) device_del serial0
>>> (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
>>>                   chardev=serial0,id=serial0,name=serial0
>>> kernel error:
>>>   virtio-ports vport2p2: Error allocating inbufs
>>> qemu error:
>>>   virtio-serial-bus: Guest failure in adding port 2 for device \
>>>                      virtio-serial0.0
>>>
>>> This happens because buffers for the in_vq are allocated when the port is
>>> added but are not released when the port is unplugged.
>>>
>>> They are only released when virtconsole is removed (see a7a69ec0d8e4)
>>>
>>> To avoid the problem and to be symmetric, we could allocate all the buffers
>>> in init_vqs() as they are released in remove_vqs(), but it sounds like
>>> a waste of memory.
>>>
>>> Rather than that, this patch changes add_port() logic to ignore ENOSPC
>>> error in fill_queue(), which means queue has already been filled.
>>>
>>> Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
>>> Cc: mst@redhat.com
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>
>>> Notes:
>>>     v2: making fill_queue return int and testing return code for -ENOSPC
>>>
>>>  drivers/char/virtio_console.c | 24 +++++++++---------------
>>>  1 file changed, 9 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
>>> index 7270e7b69262..9e6534fd1aa4 100644
>>> --- a/drivers/char/virtio_console.c
>>> +++ b/drivers/char/virtio_console.c
>>> @@ -1325,24 +1325,24 @@ static void set_console_size(struct port *port, u16 rows, u16 cols)
>>>  	port->cons.ws.ws_col = cols;
>>>  }
>>>  
>>> -static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
>>> +static int fill_queue(struct virtqueue *vq, spinlock_t *lock)
>>>  {
>>>  	struct port_buffer *buf;
>>> -	unsigned int nr_added_bufs;
>>> +	int nr_added_bufs;
>>>  	int ret;
>>>  
>>>  	nr_added_bufs = 0;
>>>  	do {
>>>  		buf = alloc_buf(vq->vdev, PAGE_SIZE, 0);
>>>  		if (!buf)
>>> -			break;
>>> +			return -ENOMEM;
>>>  
>>>  		spin_lock_irq(lock);
>>>  		ret = add_inbuf(vq, buf);
>>>  		if (ret < 0) {
>>>  			spin_unlock_irq(lock);
>>>  			free_buf(buf, true);
>>> -			break;
>>> +			return ret;
>>>  		}
>>>  		nr_added_bufs++;
>>>  		spin_unlock_irq(lock);
> 
> So actually, how about handling ENOSPC specially here, and
> returning success? After all queue is full as requested ...

I think it's interesting to return -ENOSPC to manage it as a real error
in virtcons_probe() as in this function the queue should not be already
full (is this right?) and to return the real error code.

Thanks,
Laurent
