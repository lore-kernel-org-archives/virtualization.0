From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 4/9] virtio-serial: Handle scatter-gather buffers for
	control messages
Date: Sat, 20 Mar 2010 09:40:50 +0200
Message-ID: <4BA47C02.3000105@redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-2-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-3-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-4-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-5-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268999926-29560-5-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: mst@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/19/2010 01:58 PM, Amit Shah wrote:
> Current control messages are small enough to not be split into multiple
> buffers but we could run into such a situation in the future or a
> malicious guest could cause such a situation.
>
> So handle the entire iov request for control messages.
>
> Also ensure the size of the control request is>= what we expect
> otherwise we risk accessing memory that we don't own.
>
> Signed-off-by: Amit Shah<amit.shah@redhat.com>
> CC: Avi Kivity<avi@redhat.com>
> Reported-by: Avi Kivity<avi@redhat.com>
> ---
>   hw/virtio-serial-bus.c |   43 ++++++++++++++++++++++++++++++++++++++++---
>   1 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio-serial-bus.c b/hw/virtio-serial-bus.c
> index 830eb75..d5887ab 100644
> --- a/hw/virtio-serial-bus.c
> +++ b/hw/virtio-serial-bus.c
> @@ -200,7 +200,7 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port)
>   }
>
>   /* Guest wants to notify us of some event */
> -static void handle_control_message(VirtIOSerial *vser, void *buf)
> +static void handle_control_message(VirtIOSerial *vser, void *buf, size_t len)
>   {
>       struct VirtIOSerialPort *port;
>       struct virtio_console_control cpkt, *gcpkt;
> @@ -208,6 +208,10 @@ static void handle_control_message(VirtIOSerial *vser, void *buf)
>       size_t buffer_len;
>
>       gcpkt = buf;
> +    if (len<  sizeof(cpkt)) {
> +        /* The guest sent an invalid control packet */
> +        return;
> +    }
>       port = find_port_by_id(vser, ldl_p(&gcpkt->id));
>       if (!port)
>           return;
> @@ -281,12 +285,45 @@ static void control_out(VirtIODevice *vdev, VirtQueue *vq)
>   {
>       VirtQueueElement elem;
>       VirtIOSerial *vser;
> +    uint8_t *buf;
> +    size_t len;
>
>       vser = DO_UPCAST(VirtIOSerial, vdev, vdev);
>
> +    len = 0;
> +    buf = NULL;
>       while (virtqueue_pop(vq,&elem)) {
> -        handle_control_message(vser, elem.out_sg[0].iov_base);
> -        virtqueue_push(vq,&elem, elem.out_sg[0].iov_len);
> +        unsigned int i;
> +        size_t cur_len, offset;
> +
> +        cur_len = 0;
> +        for (i = 0; i<  elem.out_num; i++) {
> +            cur_len += elem.out_sg[i].iov_len;
> +        }
> +        /*
> +         * Allocate a new buf only if we didn't have one previously or
> +         * if the size of the buf differs
> +         */
> +        if (cur_len != len) {
> +            if (len) {
> +                qemu_free(buf);
> +            }
> +            buf = qemu_malloc(cur_len);
> +        }
> +
> +        offset = 0;
> +        for (i = 0; i<  elem.out_num; i++) {
> +            memcpy(buf + offset, elem.out_sg[i].iov_base,
> +                   elem.out_sg[i].iov_len);
> +            offset += elem.out_sg[i].iov_len;
> +        }
> +        len = cur_len;
> +
> +        handle_control_message(vser, buf, len);
> +        virtqueue_push(vq,&elem, len);
> +    }
> +    if (len) {
> +        qemu_free(buf);
>       }
>       virtio_notify(vdev, vq);
>   }
>    

Isn't there some virtio function to linearize requests?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
