From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net 0/2] vsock: don't allow half-closed socket in the
	host transports
Date: Fri, 11 Oct 2019 10:19:13 -0400
Message-ID: <20191011101408-mutt-send-email-mst__29197.0654785231$1570804096$gmane$org@kernel.org>
References: <20191011130758.22134-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191011130758.22134-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Adit Ranadive <aditr@vmware.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 11, 2019 at 03:07:56PM +0200, Stefano Garzarella wrote:
> We are implementing a test suite for the VSOCK sockets and we discovered
> that vmci_transport never allowed half-closed socket on the host side.
> 
> As Jorgen explained [1] this is due to the implementation of VMCI.
> 
> Since we want to have the same behaviour across all transports, this
> series adds a section in the "Implementation notes" to exaplain this
> behaviour, and changes the vhost_transport to behave the same way.
> 
> [1] https://patchwork.ozlabs.org/cover/847998/#1831400

Half closed sockets are very useful, and lots of
applications use tricks to swap a vsock for a tcp socket,
which might as a result break.

If VMCI really cares it can implement an ioctl to
allow applications to detect that half closed sockets aren't supported.

It does not look like VMCI wants to bother (users do not read
kernel implementation notes) so it does not really care.
So why do we want to cripple other transports intentionally?



> Stefano Garzarella (2):
>   vsock: add half-closed socket details in the implementation notes
>   vhost/vsock: don't allow half-closed socket in the host
> 
>  drivers/vhost/vsock.c    | 17 ++++++++++++++++-
>  net/vmw_vsock/af_vsock.c |  4 ++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> -- 
> 2.21.0
