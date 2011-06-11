From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio_net: introduce VIRTIO_NET_HDR_F_DATA_VALID
Date: Sat, 11 Jun 2011 15:58:02 -0700 (PDT)
Message-ID: <20110611.155802.495936379311916892.davem__49496.077912818$1307833151$gmane$org@davemloft.net>
References: <1307703377-3798-1-git-send-email-jasowang@redhat.com>
	<20110610112828.GA21037@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110610112828.GA21037@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: yvugenfi@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, herbert@gondor.hengli.com.au
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 10 Jun 2011 14:28:28 +0300

> On Fri, Jun 10, 2011 at 06:56:17PM +0800, Jason Wang wrote:
>> There's no need for the guest to validate the checksum if it have been
>> validated by host nics. So this patch introduces a new flag -
>> VIRTIO_NET_HDR_F_DATA_VALID which is used to bypass the checksum
>> examing in guest. The backend (tap/macvtap) may set this flag when
>> met skbs with CHECKSUM_UNNECESSARY to save cpu utilization.
>> 
>> No feature negotiation is needed as old driver just ignore this flag.
> 
> This wasn't required by the spec, but maybe it should be.
> 
>> Iperf shows 12%-30% performance improvement for UDP traffic. For TCP,
>> when gro is on no difference as it produces skb with partial
>> checksum. But when gro is disabled, 20% or even higher improvement
>> could be measured by netperf.
>> 
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Applied to net-next-2.6
