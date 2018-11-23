From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 2/2] virtio-net: fail XDP set if guest csum is
	negotiated
Date: Fri, 23 Nov 2018 12:01:32 -0800 (PST)
Message-ID: <20181123.120132.2137332799436496001.davem__23439.1588056043$1543003194$gmane$org@davemloft.net>
References: <20181122063631.14452-1-jasowang@redhat.com>
	<20181122063631.14452-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181122063631.14452-2-jasowang@redhat.com>
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
Date: Thu, 22 Nov 2018 14:36:31 +0800

> We don't support partial csumed packet since its metadata will be lost
> or incorrect during XDP processing. So fail the XDP set if guest_csum
> feature is negotiated.
> 
> Fixes: f600b6905015 ("virtio_net: Add XDP support")
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Pavel Popa <pashinho1990@gmail.com>
> Cc: David Ahern <dsahern@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.

Same comments as for patch #1.
