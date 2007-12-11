From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [kvm-devel] [PATCH resent] virtio_net: Fix stalled inbound
 trafficon early packets
Date: Tue, 11 Dec 2007 14:57:17 +0200
Message-ID: <475E892D.9060400__49210.3668432266$1197378116$gmane$org@qumranet.com>
References: <200712111242.28843.borntraeger@de.ibm.com>
	<475E8716.2010500@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <475E8716.2010500@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This time I send in text so netdev list won't reject it; sorry.
Dor Laor wrote:
> Christian Borntraeger wrote:
>>
>> Hello Rusty,
>>
>> while implementing and testing virtio on s390 I found a problem in
>> virtio_net: The current virtio_net driver has a startup race, which
>> prevents any incoming traffic:
>>
>> If try_fill_recv submits buffers to the host system data might be
>> filled in and an interrupt is sent, before napi_enable finishes.
>> In that case the interrupt will kick skb_recv_done which will then
>> call netif_rx_schedule. netif_rx_schedule checks, if NAPI_STATE_SCHED
>> is set - which is not as we did not run napi_enable. No poll routine
>> is scheduled. Furthermore, skb_recv_done returns false, we disables
>> interrupts for this device.
>>
>> One solution is the enable napi before inbound buffer are available.
>>
> But then you might get recv interrupt without a buffer.
> The way other physical NICs doing it is by dis/en/abling interrupt 
> using registers (look at e1000).
> I suggest we can export add_status and use the original code but
> before enabling napi add a call to add_status(dev, 
> VIRTIO_CONFIG_DEV_OPEN).
> The host won't trigger an irq until it sees the above.
>
> BTW: Rusty is on vacation and that's probably the reason he didn't 
> respond.
> Regards,
> Dor.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  drivers/net/virtio_net.c |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> Index: kvm/drivers/net/virtio_net.c
>> ===================================================================
>> --- kvm.orig/drivers/net/virtio_net.c
>> +++ kvm/drivers/net/virtio_net.c
>> @@ -285,13 +285,15 @@ static int virtnet_open(struct net_devic
>>  {
>>         struct virtnet_info *vi = netdev_priv(dev);
>>
>> +       napi_enable(&vi->napi);
>>         try_fill_recv(vi);
>>
>>         /* If we didn't even get one input buffer, we're useless. */
>> -       if (vi->num == 0)
>> +       if (vi->num == 0) {
>> +               napi_disable(&vi->napi);
>>                 return -ENOMEM;
>> +       }
>>
>> -       napi_enable(&vi->napi);
>>         return 0;
>>  }
>>
>>
>> -------------------------------------------------------------------------
>> SF.Net email is sponsored by:
>> Check out the new SourceForge.net Marketplace.
>> It's the best place to buy or sell services for
>> just about anything Open Source.
>> http://sourceforge.net/services/buy/index.php
>> _______________________________________________
>> kvm-devel mailing list
>> kvm-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>>
>
