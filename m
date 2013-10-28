From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH V2 RFC 1/9] virtio_ring: change host notification API
Date: Tue, 29 Oct 2013 09:43:24 +1030
Message-ID: <877gcxf0q3.fsf@rustcorp.com.au>
References: <1382956242-23459-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382956242-23459-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
> Rusty,
>
> here is just patch 1 (using bool as return value in notify API).
>
> Thanks.
>
> Heinz Graalfs (9):
>   virtio_ring: change host notification API
>   virtio_ring: let virtqueue_{kick()/notify()} return a bool
>   virtio_net: verify if virtqueue_kick() succeeded
>   virtio_test: verify if virtqueue_kick() succeeded
>   virtio_ring: add new function virtqueue_is_broken()
>   virtio_blk: verify if queue is broken after virtqueue_get_buf()
>   virtio_console: verify if queue is broken after virtqueue_get_buf()
>   virtio_net: verify if queue is broken after virtqueue_get_buf()
>   virtio_scsi: verify if queue is broken after virtqueue_get_buf()

Thanks, I've applied all of these.

Cheers,
Rusty.
