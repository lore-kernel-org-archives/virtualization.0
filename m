From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Date: Thu, 12 Dec 2019 18:18:32 +0100
Message-ID: <CAGxU2F5KYABXjATchcqw_rA13cyUzug0zrGX6TJX2CLqj9ZwGw__25981.5410756104$1576171132$gmane$org@mail.gmail.com>
References: <20191206143912.153583-1-sgarzare@redhat.com>
 <20191211110235-mutt-send-email-mst@kernel.org>
 <20191212123624.ahyhrny7u6ntn3xt@steredhat>
 <20191212075356-mutt-send-email-mst@kernel.org>
 <20191212131453.yocx6wckoluwofbb@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191212131453.yocx6wckoluwofbb@steredhat>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>
Cc: kvm <kvm@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 12, 2019 at 2:14 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> On Thu, Dec 12, 2019 at 07:56:26AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 12, 2019 at 01:36:24PM +0100, Stefano Garzarella wrote:
> > > On Wed, Dec 11, 2019 at 11:03:07AM -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Dec 06, 2019 at 03:39:12PM +0100, Stefano Garzarella wrote:
> > > > > When we receive a new packet from the guest, we check if the
> > > > > src_cid is correct, but we forgot to check the dst_cid.
> > > > >
> > > > > The host should accept only packets where dst_cid is
> > > > > equal to the host CID.
> > > > >
> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >
> > > > Stefano can you clarify the impact pls?
> > >
> > > Sure, I'm sorry I didn't do it earlier.
> > >
> > > > E.g. is this needed on stable? Etc.
> > >
> > > This is a better analysis (I hope) when there is a malformed guest
> > > that sends a packet with a wrong dst_cid:
> > > - before v5.4 we supported only one transport at runtime, so the sockets
> > >   in the host can only receive packets from guests. In this case, if
> > >   the dst_cid is wrong, maybe the only issue is that the getsockname()
> > >   returns an inconsistent address (the cid returned is the one received
> > >   from the guest)
> > >
> > > - from v5.4 we support multi-transport, so the L1 VM (e.g. L0 assigned
> > >   cid 5 to this VM) can have both Guest2Host and Host2Guest transports.
> > >   In this case, we have these possible issues:
> > >   - L2 (or L1) guest can use cid 0, 1, and 2 to reach L1 (or L0),
> > >     instead we should allow only CID_HOST (2) to reach the level below.
> > >     Note: this happens also with not malformed guest that runs Linux v5.4
> > >   - if a malformed L2 guest sends a packet with the wrong dst_cid, for example
> > >     instead of CID_HOST, it uses the cid assigned by L0 to L1 (5 in this
> > >     example), this packets can wrongly queued to a socket on L1 bound to cid 5,
> > >     that only expects connections from L0.
> >
> > Oh so a security issue?
> >
>
> It seems so, I'll try to see if I can get a real example,
> maybe I missed a few checks.

I was wrong!
Multi-transport will be released with v5.5, which will contain this patch.

Linux <= v5.4 are safe, with the exception of the potential wrong
address returned by getsockname().

In addition, trying Linux <= v5.4 (both guests and host), I found that
userspace applications can use any dst_cid to reach the host.

It is not a security issue but for sure a wrong semantics.
Maybe we should still consider to backport this patch on stables to get
the right semantics.

Thanks,
Stefano
