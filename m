From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virto_net: remove empty file 'virtio_net.'
Date: Fri, 17 Nov 2017 14:06:04 +0900 (KST)
Message-ID: <20171117.140604.708740089884294822.davem@davemloft.net>
References: <20171117024636.15515-1-joel@jms.id.au>
	<05f54295-af35-6105-69fd-065e6cd6e19c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <05f54295-af35-6105-69fd-065e6cd6e19c@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, joel@jms.id.au, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Nov 2017 10:55:44 +0800

> 
> 
> On 2017年11月17日 10:46, Joel Stanley wrote:
>> Looks like this was mistakenly added to the tree as part of
>> commit 186b3c998c50 ("virtio-net: support XDP_REDIRECT").
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   drivers/net/virtio_net. | 0
>>   1 file changed, 0 insertions(+), 0 deletions(-)
>>   delete mode 100644 drivers/net/virtio_net.
>>
>> diff --git a/drivers/net/virtio_net. b/drivers/net/virtio_net.
>> deleted file mode 100644
>> index e69de29bb2d1..000000000000
> 
> My bad, don't know what happens at that time.
> 
> This is for -net.
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

Applied, thanks everyone.
