From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] virtio_net: Disable interrupts if
	napi_complete_done rescheduled napi
Date: Fri, 08 Dec 2017 13:19:23 -0500 (EST)
Message-ID: <20171208.131923.1211894626989773629.davem__30783.3777893849$1512757200$gmane$org@davemloft.net>
References: <1512620115-7569-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20171207070618-mutt-send-email-mst@kernel.org>
	<ffcf1aa3-403e-9ff0-bd51-c507d5a52991@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ffcf1aa3-403e-9ff0-bd51-c507d5a52991@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, edumazet@google.com, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2017 15:08:45 +0800

> 
> 
> On 2017年12月07日 13:09, Michael S. Tsirkin wrote:
>> On Thu, Dec 07, 2017 at 01:15:15PM +0900, Toshiaki Makita wrote:
>>> Since commit 39e6c8208d7b ("net: solve a NAPI race") napi has been
>>> able
>>> to be rescheduled within napi_complete_done() even in non-busypoll
>>> case,
>>> but virtnet_poll() always enabled interrupts before complete, and when
>>> napi was rescheduled within napi_complete_done() it did not disable
>>> interrupts.
>>> This caused more interrupts when event idx is disabled.
>>>
>>> According to commit cbdadbbf0c79 ("virtio_net: fix race in RX VQ
>>> processing") we cannot place virtqueue_enable_cb_prepare() after
>>> NAPI_STATE_SCHED is cleared, so disable interrupts again if
>>> napi_complete_done() returned false.
>>>
>>> Tested with vhost-user of OVS 2.7 on host, which does not have the
>>> event
>>> idx feature.
...
>>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> it might make sense in net and not -next since tx napi regressed
>> performance
>> in some configs, this might bring it back at least partially.
>> Jason - what do you think?
> 
> No sure, the regression I saw was tested with event idx on. And
> virtqueue_disable_cb() does almost nothing for event idx (or even a
> little bit slower).
> 
> The patch looks good.
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

I'm going to put this into net-next for now.
