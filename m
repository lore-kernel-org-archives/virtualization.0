From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 07/13] vsock: handle buffer_size sockopts in the core
Date: Fri, 11 Oct 2019 10:51:58 +0200
Message-ID: <20191011085158.wiiv4av5fgipm4k7__19659.3729125865$1570784453$gmane$org@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-8-sgarzare@redhat.com>
	<20191009123026.GH5747@stefanha-x1.localdomain>
	<20191010093254.aluys4hpsfcepb42@steredhat>
	<20191011082714.GF12360@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191011082714.GF12360@stefanha-x1.localdomain>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 11, 2019 at 09:27:14AM +0100, Stefan Hajnoczi wrote:
> On Thu, Oct 10, 2019 at 11:32:54AM +0200, Stefano Garzarella wrote:
> > On Wed, Oct 09, 2019 at 01:30:26PM +0100, Stefan Hajnoczi wrote:
> > > On Fri, Sep 27, 2019 at 01:26:57PM +0200, Stefano Garzarella wrote:
> > > Another issue is that this patch drops the VIRTIO_VSOCK_MAX_BUF_SIZE
> > > limit that used to be enforced by virtio_transport_set_buffer_size().
> > > Now the limit is only applied at socket init time.  If the buffer size
> > > is changed later then VIRTIO_VSOCK_MAX_BUF_SIZE can be exceeded.  If
> > > that doesn't matter, why even bother with VIRTIO_VSOCK_MAX_BUF_SIZE
> > > here?
> > > 
> > 
> > The .notify_buffer_size() should avoid this issue, since it allows the
> > transport to limit the buffer size requested after the initialization.
> > 
> > But again the min set by the user can not be respected and in the
> > previous implementation we forced it to VIRTIO_VSOCK_MAX_BUF_SIZE.
> > 
> > Now we don't limit the min, but we guarantee only that vsk->buffer_size
> > is lower than VIRTIO_VSOCK_MAX_BUF_SIZE.
> > 
> > Can that be an acceptable compromise?
> 
> I think so.
> 
> Setting buffer sizes was never tested or used much by userspace
> applications that I'm aware of.  We should probably include tests for
> changing buffer sizes in the test suite.

Good idea! We should add a test to check if min/max are respected,
playing a bit with these sockopt.

I'll do it in the test series!

Thanks,
Stefano
