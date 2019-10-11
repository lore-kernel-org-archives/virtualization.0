From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net 2/2] vhost/vsock: don't allow half-closed socket in
	the host
Date: Fri, 11 Oct 2019 16:39:30 +0200
Message-ID: <20191011143930.hs2pkz5i2bci7igs__35117.8402824857$1570805226$gmane$org@steredhat>
References: <20191011130758.22134-1-sgarzare@redhat.com>
	<20191011130758.22134-3-sgarzare@redhat.com>
	<20191011102246-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191011102246-mutt-send-email-mst@kernel.org>
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

On Fri, Oct 11, 2019 at 10:26:34AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 11, 2019 at 03:07:58PM +0200, Stefano Garzarella wrote:
> > vmci_transport never allowed half-closed socket on the host side.
> > In order to provide the same behaviour, we changed the
> > vhost_transport_stream_has_data() to return 0 (no data available)
> > if the peer (guest) closed the connection.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> I don't think we should copy bugs like this.
> Applications don't actually depend on this VMCI limitation, in fact
> it looks like a working application can get broken by this.
> 
> So this looks like a userspace visible ABI change
> which we can't really do.
> 
> If it turns out some application cares, it can always
> fully close the connection. Or add an ioctl so the application
> can find out whether half close works.
> 

I got your point.
Discard this patch.

Thanks,
Stefano
