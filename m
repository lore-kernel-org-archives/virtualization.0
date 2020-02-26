From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3] virtio: Work around frames incorrectly marked as gso
Date: Wed, 26 Feb 2020 11:09:22 -0800 (PST)
Message-ID: <20200226.110922.2164858284509225676.davem@davemloft.net>
References: <20200224132550.2083-1-anton.ivanov@cambridgegreys.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200224132550.2083-1-anton.ivanov@cambridgegreys.com>
Sender: netdev-owner@vger.kernel.org
To: anton.ivanov@cambridgegreys.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-um@lists.infradead.org, mst@redhat.com, jasowang@redhat.com, eric.dumazet@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: anton.ivanov@cambridgegreys.com
Date: Mon, 24 Feb 2020 13:25:50 +0000

> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Some of the locally generated frames marked as GSO which
> arrive at virtio_net_hdr_from_skb() have no GSO_TYPE, no
> fragments (data_len = 0) and length significantly shorter
> than the MTU (752 in my experiments).
> 
> This is observed on raw sockets reading off vEth interfaces
> in all 4.x and 5.x kernels. The frames are reported as
> invalid, while they are in fact gso-less frames.
> 
> The easiest way to reproduce is to connect a User Mode
> Linux instance to the host using the vector raw transport
> and a vEth interface. Vector raw uses recvmmsg/sendmmsg
> with virtio headers on af_packet sockets. When running iperf
> between the UML and the host, UML regularly complains about
> EINVAL return from recvmmsg.
> 
> This patch marks the vnet header as non-GSO instead of
> reporting it as invalid.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

I don't feel comfortable applying this until we know where these
weird frames are coming from and how they are created.

Please respin this patch once you know this information and make
sure to mention it in the commit log.

Thank you.
