From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Date: Tue, 3 Sep 2019 10:00:40 +0200
Message-ID: <20190903080040.pfsxrlhcny6xyfee__26772.4998573371$1576332171$gmane$org@steredhat>
References: <20190730163807-mutt-send-email-mst@kernel.org>
	<20190801104754.lb3ju5xjfmnxioii@steredhat>
	<20190801091106-mutt-send-email-mst@kernel.org>
	<20190801133616.sik5drn6ecesukbb@steredhat>
	<20190901025815-mutt-send-email-mst@kernel.org>
	<20190901061707-mutt-send-email-mst@kernel.org>
	<20190902095723.6vuvp73fdunmiogo@steredhat>
	<20190903003823-mutt-send-email-mst@kernel.org>
	<20190903074554.mq6spyivftuodahy@steredhat>
	<20190903034747-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190903034747-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 03, 2019 at 03:52:24AM -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 03, 2019 at 09:45:54AM +0200, Stefano Garzarella wrote:
> > On Tue, Sep 03, 2019 at 12:39:19AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Sep 02, 2019 at 11:57:23AM +0200, Stefano Garzarella wrote:
> > > > > 
> > > > > Assuming we miss nothing and buffers < 4K are broken,
> > > > > I think we need to add this to the spec, possibly with
> > > > > a feature bit to relax the requirement that all buffers
> > > > > are at least 4k in size.
> > > > > 
> > > > 
> > > > Okay, should I send a proposal to virtio-dev@lists.oasis-open.org?
> > > 
> > > How about we also fix the bug for now?
> > 
> > This series unintentionally fix the bug because we are introducing a way
> > to split the packet depending on the buffer size ([PATCH 4/5] vhost/vsock:
> > split packets to send using multiple buffers) and we removed the limit
> > to 4K buffers ([PATCH 5/5] vsock/virtio: change the maximum packet size
> > allowed).
> > 
> > I discovered that there was a bug while we discussed memory accounting.
> > 
> > Do you think it's enough while we introduce the feature bit in the spec?
> > 
> > Thanks,
> > Stefano
> 
> Well locking is also broken (patch 3/5).  It seems that 3/5 and 4/5 work
> by themselves, right?  So how about we ask Dave to send these to stable?

Yes, they work by themselves and I agree that should be send to stable.

> Also, how about 1/5? Also needed for stable?

I think so, without this patch if we flood the guest with 1-byte packets,
we can consume ~ 1 GB of guest memory per-socket.

Thanks,
Stefano
