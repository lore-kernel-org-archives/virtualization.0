From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: Possible unsafe usage of skb->cb in virtio-net
Date: Fri, 3 Nov 2017 13:57:03 +0900
Message-ID: <CAF=yD-LnrSPDFkg1fMcjY1tx90u11z2JTQk4YF647m4u9VaqmQ__43289.0285425403$1509685068$gmane$org@mail.gmail.com>
References: <VI1PR0501MB2734AAE4311FE84881F622A2D45C0@VI1PR0501MB2734.eurprd05.prod.outlook.com>
	<20171102142758-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171102142758-mutt-send-email-mst@kernel.org>
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
Cc: Network Development <netdev@vger.kernel.org>, Willem de Bruijn <willemb@google.com>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 2, 2017 at 10:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Nov 02, 2017 at 11:40:36AM +0000, Ilya Lesokhin wrote:
>> Hi,
>> I've noticed that the virtio-net uses skb->cb.
>>
>> I don't know all the detail by my understanding is it caused problem with the mlx5 driver
>> and was fixed here:
>> https://github.com/torvalds/linux/commit/34802a42b3528b0e18ea4517c8b23e1214a09332
>>
>> Thanks,
>> Ilya
>
> Thanks a lot for the pointer.
>
> I think this was in response to this:
> https://patchwork.ozlabs.org/patch/558324/
>
>> >
>> > +     skb_push(skb, skb->data - skb_data_orig);
>> >       sq->skb[pi] = skb;
>> >
>> >       MLX5E_TX_SKB_CB(skb)->num_wqebbs = DIV_ROUND_UP(ds_cnt,
>>
>> And in the middle of this we have:
>>
>>                 skb_pull_inline(skb, ihs);
>>
>> This is looks illegal.
>>
>> You must not modify the data pointers of any SKB that you receive for
>> sending via ->ndo_start_xmit() unless you know that absolutely you are
>> the one and only reference that exists to that SKB.
>>
>> And exactly for the case you are trying to "fix" here, you do not.  If
>> the SKB is cloned, or has an elevated users count, someone else can be
>> looking at it exactly at the same time you are messing with the data
>> pointers.
>>
>> I bet mlx4 has this bug too.
>>
>> You must fix this properly, by keeping track of an offset or similar
>> internally to your driver, rather than changing the SKB data pointers.
>
> What virtio does is this:
>
>         can_push = vi->any_header_sg &&
>                 !((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
>                 !skb_header_cloned(skb) && skb_headroom(skb) >= hdr_len;
>         /* Even if we can, don't push here yet as this would skew
>          * csum_start offset below. */
>         if (can_push)
>                 hdr = (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - hdr_len);
>         else
>                 hdr = skb_vnet_hdr(skb);
>
>
> This doesn't change the data pointers in a cloned skb but it does change the cb.
> Is it true that it's illegal to touch the cb in a cloned skb then?

I don't have all the context for this bug. But in general, clones do not share
the struct sk_buff, which holds the CB. So skb_push and skb_pull_inline
cannot affect the view of other clones. If an skb is shared, that's a different
story.
