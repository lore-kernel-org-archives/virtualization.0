From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH net 0/7] virtio_net: Fix problems around XDP tx and napi_tx
Date: Fri, 18 Jan 2019 11:01:17 +0900
Message-ID: <ecf1bd12-7f11-781f-4ce8-ef87da53a885__35016.33156925$1547811588$gmane$org@lab.ntt.co.jp>
References: <1547724045-2726-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190117095243-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190117095243-mutt-send-email-mst@kernel.org>
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
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jesper Dangaard Brouer <brouer@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 2019/01/17 23:55, Michael S. Tsirkin wrote:
> On Thu, Jan 17, 2019 at 08:20:38PM +0900, Toshiaki Makita wrote:
>> While I'm looking into how to account standard tx counters on XDP tx
>> processing, I found several bugs around XDP tx and napi_tx.
>>
>> Patch1: Fix oops on error path. Patch2 depends on this.
>> Patch2: Fix memory corruption on freeing xdp_frames with napi_tx enabled.
>> Patch3: Minor fix patch5 depends on.
>> Patch4: Fix memory corruption on processing xdp_frames when XDP is disabled.
>>   Also patch5 depends on this.
>> Patch5: Fix memory corruption on processing xdp_frames while XDP is being
>>   disabled.
>> Patch6: Minor fix patch7 depends on.
>> Patch7: Fix memory corruption on freeing sk_buff or xdp_frames when a normal
>>   queue is reused for XDP and vise versa.
>>
>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> 
> Series:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks for the review.

> 
> I guess we need this stuff on stable?

I think so.

> I'm especially happy with Patch7 as it makes my BQL
> work a bit easier.
> 
>> Toshiaki Makita (7):
>>   virtio_net: Don't enable NAPI when interface is down
>>   virtio_net: Don't call free_old_xmit_skbs for xdp_frames
>>   virtio_net: Fix not restoring real_num_rx_queues
>>   virtio_net: Fix out of bounds access of sq
>>   virtio_net: Don't process redirected XDP frames when XDP is disabled
>>   virtio_net: Use xdp_return_frame to free xdp_frames on destroying vqs
>>   virtio_net: Differentiate sk_buff and xdp_frame on freeing
>>
>>  drivers/net/virtio_net.c | 154 +++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 109 insertions(+), 45 deletions(-)
>>
>> -- 
>> 1.8.3.1
>>
> 
> 

-- 
Toshiaki Makita
