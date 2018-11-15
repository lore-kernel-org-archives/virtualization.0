From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] Discuss about an new idea "Vsock over Virtio-net"
Date: Thu, 15 Nov 2018 02:04:52 -0500
Message-ID: <20181115015547-mutt-send-email-mst__32501.3736649$1542265376$gmane$org@kernel.org>
References: <5BECEE53.7090408@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5BECEE53.7090408@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 15, 2018 at 11:56:03AM +0800, jiangyiwen wrote:
> Hi Stefan, Michael, Jason and everyone,
> 
> Several days ago, I discussed with jason about "Vsock over Virtio-net".
> This idea has two advantages:
> First, it can use many great features of virtio-net, like batching,
> mergeable rx buffer and multiqueue, etc.
> Second, it can reduce many duplicate codes and make it easy to be
> maintained.

I'm not sure I get the motivation. Which features of
virtio net are relevant to vsock? The ones that you mention
all seem to be mostly of use to the networking stack.


> Before the implement, I want to discuss with everyone again, and
> want to know everyone's suggestions.
> 
> After the discussion, based on this point I will try to implement
> this idea, but I am not familiar with the virtio-net, that is a
> pity. :(
>
> -------------------------Simple idea------------------------------
> 
> 1. The packet layout will become as follows:
> 
> +---------------------------------+
> |        Virtio-net header        |
> |(struct virtio_net_hdr_mrg_rxbuf)|

Which fields in virtio_net_hdr_mrg_rxbuf are of interest to vsock?

> +---------------------------------+
> |          Vsock header           |
> |    (struct virtio_vsock_hdr)    |
> +---------------------------------+
> |             payload             |
> |      (until end of packet)      |
> +---------------------------------+

Thanks,
-- 
MST
