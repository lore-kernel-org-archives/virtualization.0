From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
	throughput
Date: Thu, 4 Apr 2019 17:44:34 +0200
Message-ID: <20190404154434.shaxqzfzacfqqyzx__41660.426421889$1555717884$gmane$org@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404141410.GA25152@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190404141410.GA25152@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 04, 2019 at 03:14:10PM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 04, 2019 at 12:58:34PM +0200, Stefano Garzarella wrote:
> > This series tries to increase the throughput of virtio-vsock with slight
> > changes:
> >  - patch 1/4: reduces the number of credit update messages sent to the
> >               transmitter
> >  - patch 2/4: allows the host to split packets on multiple buffers,
> >               in this way, we can remove the packet size limit to
> >               VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE
> >  - patch 3/4: uses VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max packet size
> >               allowed
> >  - patch 4/4: increases RX buffer size to 64 KiB (affects only host->guest)
> > 
> > RFC:
> >  - maybe patch 4 can be replaced with multiple queues with different
> >    buffer sizes or using EWMA to adapt the buffer size to the traffic
> > 
> >  - as Jason suggested in a previous thread [1] I'll evaluate to use
> >    virtio-net as transport, but I need to understand better how to
> >    interface with it, maybe introducing sk_buff in virtio-vsock.
> > 
> > Any suggestions?
> 
> Great performance results, nice job!

:)

> 
> Please include efficiency numbers (bandwidth / CPU utilization) in the
> future.  Due to the nature of these optimizations it's unlikely that
> efficiency has decreased, so I'm not too worried about it this time.

Thanks for the suggestion! I'll measure also the efficiency for future
optimizations.

Cheers,
Stefano
