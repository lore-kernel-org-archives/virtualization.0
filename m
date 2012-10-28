From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjur@brendeland.net>
Subject: Re: [PATCHv7 4/4] virtio_console: Add support for remoteproc serial
Date: Sun, 28 Oct 2012 22:58:53 +0100
Message-ID: <CAJK669b4zSjS7g+r683bHKH6MjA=uA98MnVuw+=V-j26DethKg@mail.gmail.com>
References: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
	<1350287856-5284-5-git-send-email-sjur.brandeland@stericsson.com>
	<878vayhsca.fsf@rustcorp.com.au>
Reply-To: sjur@brendeland.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <878vayhsca.fsf@rustcorp.com.au>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

> The free-outside-interrupt issue is usually dealt with by offloading to
> a wq, but your variant works (and isn't too ugly).

Ok, thanks.

>> +static void reclaim_dma_bufs(void)
>> +{
>> +     unsigned long flags;
>> +     struct port_buffer *buf, *tmp;
>> +     LIST_HEAD(tmp_list);
>> +
>> +     if (list_empty(&pending_free_dma_bufs))
>> +             return;
...
> Looks like this should be an easy noop even if !is_rproc_serial.

Ok,  I'll drop the superfluous check before calling reclaim_dma_bufs().

>> @@ -1415,7 +1524,16 @@ static void remove_port_data(struct port *port)
>>
>>       /* Remove buffers we queued up for the Host to send us data in. */
>>       while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
>> -             free_buf(buf);
>> +             free_buf(buf, true);
>> +
>> +     /*
>> +      * Remove buffers from out queue for rproc-serial. We cannot afford
>> +      * to leak any DMA mem, so reclaim this memory even if this might be
>> +      * racy for the remote processor.
>> +      */
>> +     if (is_rproc_serial(port->portdev->vdev))
>> +             while ((buf = virtqueue_detach_unused_buf(port->out_vq)))
>> +                     free_buf(buf, true);
>>  }
>
> This seems wrong; either this is needed even if !is_rproc_serial(), or
> it's not necessary as the out_vq is empty.
>
> Every path I can see has the device reset (in which case the queues
> should not be active), or we got a VIRTIO_CONSOLE_PORT_REMOVE event (in
> which case, the same).
>
> I think we can have non-blocking writes which could leave buffers in
> out_vq: Amit?

Hm, the remote device could potentially freeze whenever. So I think we
should handle the situation where buffer are stuck in the out-queue for
the rproc_serial device. But I'll move this piece of code into a new
follow-up patch so we can handle this issue separately.

Thanks,
Sjur
