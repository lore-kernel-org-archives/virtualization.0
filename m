From: Peng Tao <bergwolf@gmail.com>
Subject: Re: [PATCH 3/4] vsock: add pkt cancel capability
Date: Wed, 7 Dec 2016 22:46:40 +0800
Message-ID: <CA+a=Yy7cwuSG57bpzdV7zJBAbSH009OFaH9MP_+8-wkY53uVgg__3994.32685594565$1481136716$gmane$org@mail.gmail.com>
References: <1481104821-77294-1-git-send-email-bergwolf@gmail.com>
	<1481104821-77294-4-git-send-email-bergwolf@gmail.com>
	<20161207132206.GC31552@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161207132206.GC31552@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 7, 2016 at 9:22 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Wed, Dec 07, 2016 at 06:00:20PM +0800, Peng Tao wrote:
>> Signed-off-by: Peng Tao <bergwolf@gmail.com>
>> ---
>>  net/vmw_vsock/virtio_transport.c | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> index 936d7ee..f88b6ed 100644
>> --- a/net/vmw_vsock/virtio_transport.c
>> +++ b/net/vmw_vsock/virtio_transport.c
>> @@ -170,6 +170,41 @@ virtio_transport_send_pkt(struct virtio_vsock_pkt *pkt)
>>       return len;
>>  }
>>
>> +static int
>> +virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>> +{
>> +     struct virtio_vsock *vsock;
>> +     struct virtio_vsock_pkt *pkt, *n;
>> +     int cnt = 0;
>> +     LIST_HEAD(freeme);
>> +
>> +     vsock = virtio_vsock_get();
>> +     if (!vsock) {
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (pkt->reply)
>
> pkt is uninitialized.  I guess this if statement should be deleted, you
> already take care of counting reply packets below.
>
ah, sorry! I forgot to delete it after handling cnt below...

>> +             cnt++;
>> +
>> +     spin_lock_bh(&vsock->send_pkt_list_lock);
>> +     list_for_each_entry_safe(pkt, n, &vsock->send_pkt_list, list) {
>> +             if (pkt->vsk != vsk)
>> +                     continue;
>> +             list_move(&pkt->list, &freeme);
>> +     }
>> +     spin_unlock_bh(&vsock->send_pkt_list_lock);
>> +
>> +     list_for_each_entry_safe(pkt, n, &freeme, list) {
>> +             if (pkt->reply)
>> +                     cnt++;
>> +             list_del(&pkt->list);
>> +             virtio_transport_free_pkt(pkt);
>> +     }
>> +     atomic_sub(cnt, &vsock->queued_replies);
>
> If we stopped rx because there were too many replies in flight then we
> might be able to resume rx now:
>
> /* Do we now have resources to resume rx processing? */
> if (old_val >= virtqueue_get_vring_size(rx_vq) &&
>     new_val < virtqueue_get_vring_size(rx_vq))
>         queue_work(virtio_vsock_workqueue, &vsock->rx_work);
Thanks! I totally missed the resume part... I'll send an updated version later.

Cheers,
Tao
