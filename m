From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v2 2/5] virtio-net: transmit napi
Date: Fri, 21 Apr 2017 14:10:06 -0400
Message-ID: <CAF=yD-KKhNLFY=qMkioYOBWnM8KC_+Fdrjd77AbCWaiD8uEtVA__48747.5938899026$1493077135$gmane$org@mail.gmail.com>
References: <20170418202108.61920-1-willemdebruijn.kernel@gmail.com>
	<20170418202108.61920-3-willemdebruijn.kernel@gmail.com>
	<9f57a790-9157-db4d-621d-cf359c8f0718@redhat.com>
	<CAF=yD-KzHo1jVugrZKq_CmyrsqCR1zmM4Jo12OjacreKm74P8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAF=yD-KzHo1jVugrZKq_CmyrsqCR1zmM4Jo12OjacreKm74P8w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>, Willem de Bruijn <willemb@google.com>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 20, 2017 at 12:02 PM, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>>>   static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>>>   {
>>>         struct virtio_net_hdr_mrg_rxbuf *hdr;
>>> @@ -1130,9 +1172,11 @@ static netdev_tx_t start_xmit(struct sk_buff *skb,
>>> struct net_device *dev)
>>>         int err;
>>>         struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>>>         bool kick = !skb->xmit_more;
>>> +       bool use_napi = sq->napi.weight;
>>>         /* Free up any pending old buffers before queueing new ones. */
>>> -       free_old_xmit_skbs(sq);
>>> +       if (!use_napi)
>>> +               free_old_xmit_skbs(sq);
>>
>>
>> I'm not sure this is best or even correct. Consider we clean xmit packets
>> speculatively in virtnet_poll_tx(), we need call free_old_xmit_skbs()
>> unconditionally. This can also help to reduce the possible of napi
>> rescheduling in virtnet_poll_tx().
>
> Because of the use of trylock there. Absolutely, thanks! Perhaps I should
> only use trylock in the opportunistic clean path from the rx softirq and
> full locking in the tx softirq.
>
> I previously observed that cleaning here would, counterintuitively,
> reduce efficiency. It reverted the improvements of cleaning transmit
> completions from the receive softirq. Going through my data, I did
> not observe this regression anymore on the latest patchset.
>
> Let me test again, with and without the new
> virtqueue_enable_cb_delayed patch. Perhaps that made a
> difference.

Neither cleaning in start_xmit nor converting the napi tx trylock to lock
shows a significant impact on loadtests, whether cpu affine or not.

I'll make both changes, as the first reduces patch size and code complexity
and the second is a more obviously correct codepath than than with trylock.

To be clear, the variant called from the rx napi handler will still
opportunistically use trylock.
