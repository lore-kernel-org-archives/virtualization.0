From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 5/6] vsock: use local transport when it is loaded
Date: Thu, 21 Nov 2019 11:01:56 +0100
Message-ID: <20191121100156.v4ehwmstlhujrviv__16991.4460320555$1574330536$gmane$org@steredhat>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191119110121.14480-6-sgarzare@redhat.com>
 <20191121094614.GC439743@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191121094614.GC439743@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 21, 2019 at 09:46:14AM +0000, Stefan Hajnoczi wrote:
> On Tue, Nov 19, 2019 at 12:01:20PM +0100, Stefano Garzarella wrote:
> > @@ -420,9 +436,10 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> >  		new_transport = transport_dgram;
> >  		break;
> >  	case SOCK_STREAM:
> > -		if (remote_cid <= VMADDR_CID_HOST ||
> > -		    (transport_g2h &&
> > -		     remote_cid == transport_g2h->get_local_cid()))
> > +		if (vsock_use_local_transport(remote_cid))
> > +			new_transport = transport_local;
> > +		else if (remote_cid == VMADDR_CID_HOST ||
> > +			 remote_cid == VMADDR_CID_HYPERVISOR)
> >  			new_transport = transport_g2h;
> >  		else
> >  			new_transport = transport_h2g;
> 
> We used to send VMADDR_CID_RESERVED to the host.  Now we send
> VMADDR_CID_RESERVED (LOCAL) to the guest when there is no
> transport_local loaded?
> 
> If this is correct, is there a justification for this change?  It seems
> safest to retain existing behavior.

You're right, I'll revert this change in v2.

Thanks,
Stefano
