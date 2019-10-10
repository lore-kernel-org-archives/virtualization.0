From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 08/13] vsock: move vsock_insert_unbound() in the
	vsock_create()
Date: Thu, 10 Oct 2019 11:52:50 +0200
Message-ID: <20191010095250.zmwmce7bgqgf3nv4__38700.6915452488$1570701188$gmane$org@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-9-sgarzare@redhat.com>
	<20191009123423.GI5747@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191009123423.GI5747@stefanha-x1.localdomain>
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

On Wed, Oct 09, 2019 at 01:34:23PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:26:58PM +0200, Stefano Garzarella wrote:
> > vsock_insert_unbound() was called only when 'sock' parameter of
> > __vsock_create() was not null. This only happened when
> > __vsock_create() was called by vsock_create().
> > 
> > In order to simplify the multi-transports support, this patch
> > moves vsock_insert_unbound() at the end of vsock_create().
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  net/vmw_vsock/af_vsock.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> Maybe transports shouldn't call __vsock_create() directly.  They always
> pass NULL as the parent socket, so we could have a more specific
> function that transports call without a parent sock argument.  This
> would eliminate any concern over moving vsock_insert_unbound() out of
> this function.  In any case, I've checked the code and this patch is
> correct.

Yes, I agree with you, I can add a new patch to do this cleaning.

> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks,
Stefano
