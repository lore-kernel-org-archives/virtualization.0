From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
	allowed
Date: Mon, 8 Apr 2019 10:57:44 -0400
Message-ID: <20190408105619-mutt-send-email-mst__47411.3856254675$1554735478$gmane$org@kernel.org>
References: <20190404105838.101559-1-sgarzare@redhat.com>
	<20190404105838.101559-4-sgarzare@redhat.com>
	<20190405082447.GD25152@stefanha-x1.localdomain>
	<20190405100747.dbwi3sjaudp3d2wa@steredhat>
	<20190408093723.GP15001@stefanha-x1.localdomain>
	<20190408145531.yreyawkn5vjqj7sl@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190408145531.yreyawkn5vjqj7sl@steredhat>
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
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 08, 2019 at 04:55:31PM +0200, Stefano Garzarella wrote:
> > Anyway, any change to this behavior requires compatibility so new guest
> > drivers work with old vhost_vsock.ko.  Therefore we should probably just
> > leave the limit for now.
> 
> I understood your point of view and I completely agree with you.
> But, until we don't have a way to expose features/versions between guest
> and host,

Why not use the standard virtio feature negotiation mechanism for this?

> maybe is better to leave the limit in order to be compatible
> with old vhost_vsock.

-- 
MST
