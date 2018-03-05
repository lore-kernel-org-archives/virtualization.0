From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V2] virtio-net: re enable XDP_REDIRECT for
	mergeable buffer
Date: Sun, 04 Mar 2018 22:16:51 -0500 (EST)
Message-ID: <20180304.221651.1758033941719841960.davem__5804.41718125275$1520219708$gmane$org@davemloft.net>
References: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
	<20180304.183811.344767417258525977.davem@davemloft.net>
	<986bd816-2452-9eca-ec8a-ce267ef49a2d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <986bd816-2452-9eca-ec8a-ce267ef49a2d@redhat.com>
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
Cc: mst@redhat.com, netdev@vger.kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Mar 2018 10:43:41 +0800

> 
> 
> On 2018年03月05日 07:38, David Miller wrote:
>> From: Jason Wang <jasowang@redhat.com>
>> Date: Fri,  2 Mar 2018 17:29:14 +0800
>>
>>> XDP_REDIRECT support for mergeable buffer was removed since commit
>>> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
>>> case"). This is because we don't reserve enough tailroom for struct
>>> skb_shared_info which breaks XDP assumption. So this patch fixes this
>>> by reserving enough tailroom and using fixed size of rx buffer.
>>>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>> Changes from V1:
>>> - do not add duplicated tracepoint when redirection fails
>> Applied to net-next, thanks Jason.
> 
> Hi David,
> 
> Consider the change is not large, any chance to make it for -net to
> keep XDP redirection work?

Ok, I'll apply this to 'net' too.
