From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 1/2] virtio-net: disable guest csum during XDP set
Date: Fri, 23 Nov 2018 12:01:19 -0800 (PST)
Message-ID: <20181123.120119.2279234989819941118.davem__11582.8491900631$1543003165$gmane$org@davemloft.net>
References: <20181122063631.14452-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181122063631.14452-1-jasowang@redhat.com>
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
Cc: mst@redhat.com, netdev@vger.kernel.org, dsahern@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pashinho1990@gmail.com, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 Nov 2018 14:36:30 +0800

> We don't disable VIRTIO_NET_F_GUEST_CSUM if XDP was set. This means we
> can receive partial csumed packets with metadata kept in the
> vnet_hdr. This may have several side effects:
> 
> - It could be overridden by header adjustment, thus is might be not
>   correct after XDP processing.
> - There's no way to pass such metadata information through
>   XDP_REDIRECT to another driver.
> - XDP does not support checksum offload right now.
> 
> So simply disable guest csum if possible in this the case of XDP.
> 
> Fixes: 3f93522ffab2d ("virtio-net: switch off offloads on demand if possible on XDP set")
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Pavel Popa <pashinho1990@gmail.com>
> Cc: David Ahern <dsahern@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.

We really should have a way to use the checksum provided if the XDP
program returns XDP_PASS and does not modify the packet contents
or size.
