From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Date: Tue, 10 Dec 2019 15:32:51 +0100
Message-ID: <20191210143251.szkicty23b6pojxh__8838.47929523967$1575988394$gmane$org@steredhat>
References: <20191206143912.153583-1-sgarzare@redhat.com>
 <20191210090505-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191210090505-mutt-send-email-mst@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 10, 2019 at 09:05:58AM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 06, 2019 at 03:39:12PM +0100, Stefano Garzarella wrote:
> > When we receive a new packet from the guest, we check if the
> > src_cid is correct, but we forgot to check the dst_cid.
> > 
> > The host should accept only packets where dst_cid is
> > equal to the host CID.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> what's the implication of processing incorrect dst cid?
> I think mostly it's malformed guests, right?

Exaclty, as for the src_cid.

In both cases the packet may be delivered to the wrong socket in the
host, because in the virtio_transport_recv_pkt() we are using the
src_cid and dst_cid to look for the socket where to queue the packet.

> Everyone else just passes the known host cid ...

Yes, good guests should do it, and we do it :-)

Thanks,
Stefano
