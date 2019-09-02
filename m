From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Date: Mon, 2 Sep 2019 10:55:02 +0200
Message-ID: <20190902085502.jlfo36aoka7lwi2u__43800.764547062$1567414518$gmane$org@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-2-sgarzare@redhat.com>
	<20190729095956-mutt-send-email-mst@kernel.org>
	<20190830094059.c7qo5cxrp2nkrncd@steredhat>
	<20190901024525-mutt-send-email-mst@kernel.org>
	<20190902083912.GA9069@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190902083912.GA9069@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 02, 2019 at 09:39:12AM +0100, Stefan Hajnoczi wrote:
> On Sun, Sep 01, 2019 at 02:56:44AM -0400, Michael S. Tsirkin wrote:
> > 
> > OK let me try to clarify.  The idea is this:
> > 
> > Let's say we queue a buffer of 4K, and we copy if len < 128 bytes.  This
> > means that in the worst case (128 byte packets), each byte of credit in
> > the socket uses up 4K/128 = 16 bytes of kernel memory. In fact we need
> > to also account for the virtio_vsock_pkt since I think it's kept around
> > until userspace consumes it.
> > 
> > Thus given X buf alloc allowed in the socket, we should publish X/16
> > credits to the other side. This will ensure the other side does not send
> > more than X/16 bytes for a given socket and thus we won't need to
> > allocate more than X bytes to hold the data.
> > 
> > We can play with the copy break value to tweak this.

Thanks Michael, now it is perfectly clear. It seems an excellent solution and
easy to implement. I'll work on that.

> 
> This seems like a reasonable solution.  Hopefully the benchmark results
> will come out okay too.

Yes, as Michael suggested I'll play with the copy break value to see as
benchmark has affected.

Thank you very much,
Stefano
