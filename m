From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 00/14] vsock: add multi-transports support
Date: Tue, 29 Oct 2019 17:27:12 +0100
Message-ID: <20191029162712.fn5rgxrwdrbxuehw__43324.6854737931$1572366461$gmane$org@steredhat>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191027080146.GA4472@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191027080146.GA4472@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>, Adit Ranadive <aditr@vmware.com>, Vishnu Dasa <vdasa@vmware.com>, Andy king <acking@vmware.com>, Aditya Sarwade <asarwade@vmware.com>, George Zhang <georgezhang@vmware.com>, Jorgen Hansen <jhansen@vmware.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 27, 2019 at 09:01:46AM +0100, Stefan Hajnoczi wrote:
> On Wed, Oct 23, 2019 at 11:55:40AM +0200, Stefano Garzarella wrote:
> > This series adds the multi-transports support to vsock, following
> > this proposal: https://www.spinics.net/lists/netdev/msg575792.html
> > 
> > With the multi-transports support, we can use VSOCK with nested VMs
> > (using also different hypervisors) loading both guest->host and
> > host->guest transports at the same time.
> > Before this series, vmci-transport supported this behavior but only
> > using VMware hypervisor on L0, L1, etc.
> > 
> > RFC: https://patchwork.ozlabs.org/cover/1168442/
> > RFC -> v1:
> > - Added R-b/A-b from Dexuan and Stefan
> > - Fixed comments and typos in several patches (Stefan)
> > - Patch 7: changed .notify_buffer_size return to void (Stefan)
> > - Added patch 8 to simplify the API exposed to the transports (Stefan)
> > - Patch 11:
> >   + documented VSOCK_TRANSPORT_F_* flags (Stefan)
> >   + fixed vsock_assign_transport() when the socket is already assigned
> >   + moved features outside of struct vsock_transport, and used as
> >     parameter of vsock_core_register() as a preparation of Patch 12
> > - Removed "vsock: add 'transport_hg' to handle g2h\h2g transports" patch
> > - Added patch 12 to register vmci_transport only when VMCI guest/host
> >   are active
> 
> Has there been feedback from Jorgen or someone else from VMware?  A
> Reviewed-by or Acked-by would be nice since this patch series affects
> VMCI AF_VSOCK.
> 

Unfortunately not for now, I'm adding to this thread some VMware guys that
reviewed latest vmci patches.

Would be nice to have your feedback for these changes.

Thanks in advance,
Stefano
