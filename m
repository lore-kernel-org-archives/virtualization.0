From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH resent] virtio_net: Fix stalled inbound
	trafficon early packets
Date: Tue, 11 Dec 2007 14:16:12 +0100
Message-ID: <200712111416.12655.borntraeger__48079.5724237852$1197379135$gmane$org@de.ibm.com>
References: <200712111242.28843.borntraeger@de.ibm.com>
	<475E8716.2010500@qumranet.com> <475E892D.9060400@qumranet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3310583728326138818=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <475E892D.9060400@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============3310583728326138818==
Content-Type: multipart/alternative; boundary="Boundary-01=_c2oXHNwSHqi0wml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_c2oXHNwSHqi0wml
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

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

If I look at the current implementation (lguest) no interrupt is sent if
there is not buffer available, no?
On the other hand, if the host does send an interrupt when no buffer is
available, this is also no problem. Looking at virtnet_poll, it seems it
can cope with an empty ring. 

> The way other physical NICs doing it is by dis/en/abling interrupt 
> using registers (look at e1000).
> I suggest we can export add_status and use the original code but
> before enabling napi add a call to add_status(dev, 
> VIRTIO_CONFIG_DEV_OPEN).
> The host won't trigger an irq until it sees the above.

That would also work. We already have VRING_AVAIL_F_NO_INTERRUPT in
virtio_ring.c - maybe we can use that. Its hidden in callback and
restart handling, what about adding an explicit startup?
>
> BTW: Rusty is on vacation and that's probably the reason he didn't 
> respond.
> Regards,
> Dor.

Ok, didnt know that. At the moment I can live with my private patch
while we work on a final solution. Meanwhile I will try to debug virtio
on SMP guests - I still see some strange races on our test system. (But
block and net is now working on s390 and can cope with medium load. )

Christian



--Boundary-01=_c2oXHNwSHqi0wml
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:10pt;font-family:Courier New">
<p>Dor Laor wrote:</p>
<p>&gt; Christian Borntraeger wrote:</p>
<p>&gt;&gt;</p>
<p>&gt;&gt; Hello Rusty,</p>
<p>&gt;&gt;</p>
<p>&gt;&gt; while implementing and testing virtio on s390 I found a problem in</p>
<p>&gt;&gt; virtio_net: The current virtio_net driver has a startup race, which</p>
<p>&gt;&gt; prevents any incoming traffic:</p>
<p>&gt;&gt;</p>
<p>&gt;&gt; If try_fill_recv submits buffers to the host system data might be</p>
<p>&gt;&gt; filled in and an interrupt is sent, before napi_enable finishes.</p>
<p>&gt;&gt; In that case the interrupt will kick skb_recv_done which will then</p>
<p>&gt;&gt; call netif_rx_schedule. netif_rx_schedule checks, if NAPI_STATE_SCHED</p>
<p>&gt;&gt; is set - which is not as we did not run napi_enable. No poll routine</p>
<p>&gt;&gt; is scheduled. Furthermore, skb_recv_done returns false, we disables</p>
<p>&gt;&gt; interrupts for this device.</p>
<p>&gt;&gt;</p>
<p>&gt;&gt; One solution is the enable napi before inbound buffer are available.</p>
<p>&gt;&gt;</p>
<p>&gt; But then you might get recv interrupt without a buffer.</p>
<p></p>
<p>If I look at the current implementation (lguest) no interrupt is sent if</p>
<p>there is not buffer available, no?</p>
<p>On the other hand, if the host does send an interrupt when no buffer is</p>
<p>available, this is also no problem. Looking at virtnet_poll, it seems it</p>
<p>can cope with an empty ring. </p>
<p></p>
<p>&gt; The way other physical NICs doing it is by dis/en/abling interrupt </p>
<p>&gt; using registers (look at e1000).</p>
<p>&gt; I suggest we can export add_status and use the original code but</p>
<p>&gt; before enabling napi add a call to add_status(dev, </p>
<p>&gt; VIRTIO_CONFIG_DEV_OPEN).</p>
<p>&gt; The host won't trigger an irq until it sees the above.</p>
<p></p>
<p>That would also work. We already have VRING_AVAIL_F_NO_INTERRUPT in</p>
<p>virtio_ring.c - maybe we can use that. Its hidden in callback and</p>
<p>restart handling, what about adding an explicit startup?</p>
<p>&gt;</p>
<p>&gt; BTW: Rusty is on vacation and that's probably the reason he didn't </p>
<p>&gt; respond.</p>
<p>&gt; Regards,</p>
<p>&gt; Dor.</p>
<p></p>
<p>Ok, didnt know that. At the moment I can live with my private patch</p>
<p>while we work on a final solution. Meanwhile I will try to debug virtio</p>
<p>on SMP guests - I still see some strange races on our test system. (But</p>
<p>block and net is now working on s390 and can cope with medium load. )</p>
<p></p>
<p>Christian</p>
<p></p>
<p></p>
<p></p>
</body></html>
--Boundary-01=_c2oXHNwSHqi0wml--

--===============3310583728326138818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============3310583728326138818==--
