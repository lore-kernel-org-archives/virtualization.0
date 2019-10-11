From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net 0/2] vsock: don't allow half-closed socket in the
	host transports
Date: Fri, 11 Oct 2019 16:34:57 +0200
Message-ID: <20191011143457.4ujt3gg7oxco6gld__31461.4588672825$1570805218$gmane$org@steredhat>
References: <20191011130758.22134-1-sgarzare@redhat.com>
	<20191011101408-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191011101408-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Adit Ranadive <aditr@vmware.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 11, 2019 at 10:19:13AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 11, 2019 at 03:07:56PM +0200, Stefano Garzarella wrote:
> > We are implementing a test suite for the VSOCK sockets and we discovered
> > that vmci_transport never allowed half-closed socket on the host side.
> > 
> > As Jorgen explained [1] this is due to the implementation of VMCI.
> > 
> > Since we want to have the same behaviour across all transports, this
> > series adds a section in the "Implementation notes" to exaplain this
> > behaviour, and changes the vhost_transport to behave the same way.
> > 
> > [1] https://patchwork.ozlabs.org/cover/847998/#1831400
> 
> Half closed sockets are very useful, and lots of
> applications use tricks to swap a vsock for a tcp socket,
> which might as a result break.

Got it!

> 
> If VMCI really cares it can implement an ioctl to
> allow applications to detect that half closed sockets aren't supported.
> 
> It does not look like VMCI wants to bother (users do not read
> kernel implementation notes) so it does not really care.
> So why do we want to cripple other transports intentionally?

The main reason is that we are developing the test suite and we noticed
the miss match. Since we want to make sure that applications behave in
the same way on different transports, we thought we would solve it that
way.

But what you are saying (also in the reply of the patches) is actually
quite right. Not being publicized, applications do not expect this behavior,
so please discard this series.

My problem during the tests, was trying to figure out if half-closed
sockets were supported or not, so as you say adding an IOCTL or maybe
better a getsockopt() could solve the problem.

What do you think?

Thanks,
Stefano
