From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 4/5] vhost/vsock: split packets to send using multiple
	buffers
Date: Thu, 18 Jul 2019 11:37:30 +0200
Message-ID: <CAGxU2F6oo7Cou7t9o=gG2=wxHMKX9xYQXNxVtDYeHq5fyEhJWg__38231.6162040055$1563442684$gmane$org@mail.gmail.com>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-5-sgarzare@redhat.com>
	<20190717105336-mutt-send-email-mst@kernel.org>
	<CAGxU2F45v40qAOHkm1Hk2E69gCS0UwVgS5NS+tDXXuzdF4EixA@mail.gmail.com>
	<20190718041234-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190718041234-mutt-send-email-mst@kernel.org>
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

On Thu, Jul 18, 2019 at 10:13 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jul 18, 2019 at 09:50:14AM +0200, Stefano Garzarella wrote:
> > On Wed, Jul 17, 2019 at 4:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Wed, Jul 17, 2019 at 01:30:29PM +0200, Stefano Garzarella wrote:
> > > > If the packets to sent to the guest are bigger than the buffer
> > > > available, we can split them, using multiple buffers and fixing
> > > > the length in the packet header.
> > > > This is safe since virtio-vsock supports only stream sockets.
> > > >
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > So how does it work right now? If an app
> > > does sendmsg with a 64K buffer and the other
> > > side publishes 4K buffers - does it just stall?
> >
> > Before this series, the 64K (or bigger) user messages was split in 4K packets
> > (fixed in the code) and queued in an internal list for the TX worker.
> >
> > After this series, we will queue up to 64K packets and then it will be split in
> > the TX worker, depending on the size of the buffers available in the
> > vring. (The idea was to allow EWMA or a configuration of the buffers size, but
> > for now we postponed it)
>
> Got it. Using workers for xmit is IMHO a bad idea btw.
> Why is it done like this?

Honestly, I don't know the exact reasons for this design, but I suppose
that the idea was to have only one worker that uses the vring, and
multiple user threads that enqueue packets in the list.
This can simplify the code and we can put the user threads to sleep if
we don't have "credit" available (this means that the receiver doesn't
have space to receive the packet).

What are the drawbacks in your opinion?


Thanks,
Stefano
