From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 4/5] vhost/vsock: split packets to send using multiple
	buffers
Date: Fri, 19 Jul 2019 10:08:32 +0200
Message-ID: <20190719080832.7hoeus23zjyrx3cc__10883.6004322924$1563523748$gmane$org@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-5-sgarzare@redhat.com>
	<20190717105336-mutt-send-email-mst@kernel.org>
	<CAGxU2F45v40qAOHkm1Hk2E69gCS0UwVgS5NS+tDXXuzdF4EixA@mail.gmail.com>
	<20190718041234-mutt-send-email-mst@kernel.org>
	<CAGxU2F6oo7Cou7t9o=gG2=wxHMKX9xYQXNxVtDYeHq5fyEhJWg@mail.gmail.com>
	<20190718072741-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190718072741-mutt-send-email-mst@kernel.org>
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

On Thu, Jul 18, 2019 at 07:35:46AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 18, 2019 at 11:37:30AM +0200, Stefano Garzarella wrote:
> > On Thu, Jul 18, 2019 at 10:13 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Thu, Jul 18, 2019 at 09:50:14AM +0200, Stefano Garzarella wrote:
> > > > On Wed, Jul 17, 2019 at 4:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Wed, Jul 17, 2019 at 01:30:29PM +0200, Stefano Garzarella wrote:
> > > > > > If the packets to sent to the guest are bigger than the buffer
> > > > > > available, we can split them, using multiple buffers and fixing
> > > > > > the length in the packet header.
> > > > > > This is safe since virtio-vsock supports only stream sockets.
> > > > > >
> > > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > >
> > > > > So how does it work right now? If an app
> > > > > does sendmsg with a 64K buffer and the other
> > > > > side publishes 4K buffers - does it just stall?
> > > >
> > > > Before this series, the 64K (or bigger) user messages was split in 4K packets
> > > > (fixed in the code) and queued in an internal list for the TX worker.
> > > >
> > > > After this series, we will queue up to 64K packets and then it will be split in
> > > > the TX worker, depending on the size of the buffers available in the
> > > > vring. (The idea was to allow EWMA or a configuration of the buffers size, but
> > > > for now we postponed it)
> > >
> > > Got it. Using workers for xmit is IMHO a bad idea btw.
> > > Why is it done like this?
> > 
> > Honestly, I don't know the exact reasons for this design, but I suppose
> > that the idea was to have only one worker that uses the vring, and
> > multiple user threads that enqueue packets in the list.
> > This can simplify the code and we can put the user threads to sleep if
> > we don't have "credit" available (this means that the receiver doesn't
> > have space to receive the packet).
> 
> 
> I think you mean the reverse: even without credits you can copy from
> user and queue up data, then process it without waking up the user
> thread.

I checked the code better, but it doesn't seem to do that.
The .sendmsg callback of af_vsock, check if the transport has space
(virtio-vsock transport returns the credit available). If there is no
space, it put the thread to sleep on the 'sk_sleep(sk)' wait_queue.

When the transport receives an update of credit available on the other
peer, it calls 'sk->sk_write_space(sk)' that wakes up the thread
sleeping, that will queue the new packet.

So, in the current implementation, the TX worker doesn't check the
credit available, it only sends the packets.

> Does it help though? It certainly adds up work outside of
> user thread context which means it's not accounted for
> correctly.

I can try to xmit the packet directly in the user thread context, to see
the improvements.

> 
> Maybe we want more VQs. Would help improve parallelism. The question
> would then become how to map sockets to VQs. With a simple hash
> it's easy to create collisions ...

Yes, more VQs can help but the map question is not simple to answer.
Maybe we can do an hash on the (cid, port) or do some kind of estimation
of queue utilization and try to balance.
Should the mapping be unique?

> 
> 
> > 
> > What are the drawbacks in your opinion?
> > 
> > 
> > Thanks,
> > Stefano
> 
> - More pressure on scheduler
> - Increased latency
> 

Thanks,
Stefano
