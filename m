From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 0/4] vsock/virtio: several fixes in the .probe() and
	.remove()
Date: Thu, 27 Jun 2019 12:05:55 +0200
Message-ID: <20190627100555.pmnecffewzsopxyw__5898.61777132086$1561629970$gmane$org@steredhat.homenet.telecomitalia.it>
References: <20190528105623.27983-1-sgarzare@redhat.com>
	<20190610130945.GL14257@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190610130945.GL14257@stefanha-x1.localdomain>
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
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 10, 2019 at 02:09:45PM +0100, Stefan Hajnoczi wrote:
> On Tue, May 28, 2019 at 12:56:19PM +0200, Stefano Garzarella wrote:
> > During the review of "[PATCH] vsock/virtio: Initialize core virtio vsock
> > before registering the driver", Stefan pointed out some possible issues
> > in the .probe() and .remove() callbacks of the virtio-vsock driver.
> > 
> > This series tries to solve these issues:
> > - Patch 1 postpones the 'the_virtio_vsock' assignment at the end of the
> >   .probe() to avoid that some sockets queue works when the initialization
> >   is not finished.
> > - Patches 2 and 3 stop workers before to call vdev->config->reset(vdev) to
> >   be sure that no one is accessing the device, and adds another flush at the
> >   end of the .remove() to avoid use after free.
> > - Patch 4 free also used buffers in the virtqueues during the .remove().
> > 
> > Stefano Garzarella (4):
> >   vsock/virtio: fix locking around 'the_virtio_vsock'
> >   vsock/virtio: stop workers during the .remove()
> >   vsock/virtio: fix flush of works during the .remove()
> >   vsock/virtio: free used buffers during the .remove()
> > 
> >  net/vmw_vsock/virtio_transport.c | 105 ++++++++++++++++++++++++++-----
> >  1 file changed, 90 insertions(+), 15 deletions(-)
> 
> Looking forward to v2.  I took a look at the discussion and I'll review
> v2 from scratch.  Just keep in mind that the mutex is used more for
> mutual exclusion of the init/exit code than to protect the_virtio_vsock,
> so we'll still need protection of init/exit code even with RCU.

Thanks for the advice! I'll send the v2 ASAP.

Thanks,
Stefano
