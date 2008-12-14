From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH] AF_VMCHANNEL address family for guest<->host
	communication.
Date: Sun, 14 Dec 2008 14:46:28 +0200
Message-ID: <20081214124628.GR5555__24359.9148969681$1229258857$gmane$org@redhat.com>
References: <20081214115054.4066.14557.stgit@dhcp-1-237.tlv.redhat.com>
	<20081214122320.GA32472@ioremap.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081214122320.GA32472@ioremap.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Evgeniy,

On Sun, Dec 14, 2008 at 03:23:20PM +0300, Evgeniy Polyakov wrote:
> On Sun, Dec 14, 2008 at 01:50:55PM +0200, Gleb Natapov (gleb@redhat.com) wrote:
> > There is a need for communication channel between host and various
> > agents that are running inside a VM guest. The channel will be used
> > for statistic gathering, logging, cut & paste, host screen resolution
> > changes notifications, guest configuration etc.
> > 
> > It is undesirable to use TCP/IP for this purpose since network
> > connectivity may not exist between host and guest and if it exists the
> > traffic can be not routable between host and guest for security reasons
> > or TCP/IP traffic can be firewalled (by mistake) by unsuspecting VM user.
> > 
> > This patch implement new address family AF_VMCHANNEL that is used
> > for communication between guest and host. Channels are created at VM
> > start time. Each channel has a name. Agent, that runs on a guest, can
> > send/receive data to/from a channel by creating AF_VMCHANNEL socket and
> > connecting to a channel using channels name as an address.
> > 
> > Only stream sockets are supported by this implementation. Also only
> > connect, sendmsg and recvmsg socket ops are implemented which is enough
> > to allow application running in a guest to connect to a channel created
> > by a host and read/write from/to the channel. This can be extended to
> > allow channel creation from inside a guest by creating listen socket and
> > accepting on it if the need will arise and thus even allow guest<->guest
> > communication in the future (but TCP/IP may be preferable for this).
> 
> Couple of comments on this.
> First, there is only single virtio device initialized at probe time,
> how this will work on the host system with multiple guests? Is it
> possible to have multiple virtual devices?
The module is loaded only inside a guest not host and it manages all
existing channels. What would be the value to have multiple vmchannel
PCI devices in a single guest?

> Second, each virtual device has an array of names, and each socket can
> be bound to one of them, but it is not allowed to have multiple sockets
> bound to the same name, so it looks like there is no possibility to have
> several sockets communicating via signel channel, was this intentional?
Yes, this is intentional as it matches our usage model. It is possible
to change this in the future if needed. All sockets bound to the same
channel will receive the same data.

> And third, tasklet callbacks do not use bh socket locking, and while it
> is not something bad, but rt folks want (dream) to replace it with
> process context, so this at least requires some note in comments.
> 
This is something I need to understand better. I though that socket
lock guards socket state change. The patch only access socket state
from bh context in the vmchannel_socket_recv() and even if state of the
socket will change after function validates it nothing bad can happen.
Is this the case? I it is I will add comment explaining this.

> Except that about questions, this patch looks good.
Thanks for the review.

--
			Gleb.
