From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 06/13] vsock: add 'struct vsock_sock *' param to
	vsock_core_get_transport()
Date: Thu, 10 Oct 2019 10:50:20 +0200
Message-ID: <20191010085020.w5mbse7mnpzalhyr@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-7-sgarzare@redhat.com>
	<20191009115433.GG5747@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191009115433.GG5747@stefanha-x1.localdomain>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 09, 2019 at 12:54:33PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:26:56PM +0200, Stefano Garzarella wrote:
> > -const struct vsock_transport *vsock_core_get_transport(void)
> > +const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
> >  {
> >  	/* vsock_register_mutex not taken since only the transport uses this
> >  	 * function and only while registered.
> >  	 */
> > -	return transport_single;
> 
> This comment is about protecting transport_single.  It no longer applies
> when using vsk->transport.  Please drop it.

Right, dropped.

> 
> Otherwise:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks,
Stefano
