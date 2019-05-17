From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 2/8] vsock/virtio: free packets during the socket
	release
Date: Fri, 17 May 2019 10:26:53 +0200
Message-ID: <20190517082653.aymkhkqkj5yminfg__16020.679734514$1558081629$gmane$org@steredhat>
References: <20190510125843.95587-1-sgarzare@redhat.com>
	<20190510125843.95587-3-sgarzare@redhat.com>
	<20190516153218.GC29808@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190516153218.GC29808@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 16, 2019 at 04:32:18PM +0100, Stefan Hajnoczi wrote:
> On Fri, May 10, 2019 at 02:58:37PM +0200, Stefano Garzarella wrote:
> > When the socket is released, we should free all packets
> > queued in the per-socket list in order to avoid a memory
> > leak.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> Ouch, this would be nice as a separate patch that can be merged right
> away (with s/virtio_vsock_buf/virtio_vsock_pkt/).

Okay, I'll fix this patch following the David's comment and I'll send
as a separate patch using the virtio_vsock_pkt.

Thanks,
Stefano
