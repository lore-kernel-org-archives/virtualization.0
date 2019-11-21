From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 0/6] vsock: add local transport support
Date: Thu, 21 Nov 2019 16:13:55 +0100
Message-ID: <20191121151355.grgfbte6xniqe6xo__26488.7668936112$1574349257$gmane$org@steredhat>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <MWHPR05MB3376B8241546664BBCA6FC37DA4E0@MWHPR05MB3376.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <MWHPR05MB3376B8241546664BBCA6FC37DA4E0@MWHPR05MB3376.namprd05.prod.outlook.com>
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
To: Jorgen Hansen <jhansen@vmware.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 21, 2019 at 02:45:32PM +0000, Jorgen Hansen wrote:
> > From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> > Sent: Tuesday, November 19, 2019 12:01 PM
> > This series introduces a new transport (vsock_loopback) to handle
> > local communication.
> > This could be useful to test vsock core itself and to allow developers
> > to test their applications without launching a VM.
> > 
> > Before this series, vmci and virtio transports allowed this behavior,
> > but only in the guest.
> > We are moving the loopback handling in a new transport, because it
> > might be useful to provide this feature also in the host or when
> > no H2G/G2H transports (hyperv, virtio, vmci) are loaded.
> > 
> > The user can use the loopback with the new VMADDR_CID_LOCAL (that
> > replaces VMADDR_CID_RESERVED) in any condition.
> > Otherwise, if the G2H transport is loaded, it can also use the guest
> > local CID as previously supported by vmci and virtio transports.
> > If G2H transport is not loaded, the user can also use VMADDR_CID_HOST
> > for local communication.
> > 
> > Patch 1 is a cleanup to build virtio_transport_common without virtio
> > Patch 2 adds the new VMADDR_CID_LOCAL, replacing
> > VMADDR_CID_RESERVED
> > Patch 3 adds a new feature flag to register a loopback transport
> > Patch 4 adds the new vsock_loopback transport based on the loopback
> >         implementation of virtio_transport
> > Patch 5 implements the logic to use the local transport for loopback
> >         communication
> > Patch 6 removes the loopback from virtio_transport
> > 
> > @Jorgen: Do you think it might be a problem to replace
> > VMADDR_CID_RESERVED with VMADDR_CID_LOCAL?
> 
> No, that should be fine. It has never allowed for use with stream sockets in
> AF_VSOCK. The only potential use would be for datagram sockets, but that
> side appears to be unaffected by your changes, since loopback is only
> introduced for SOCK_STREAM.
> 

Yes, datagram sockets are not affected.

Thanks for the clarification,
Stefano
