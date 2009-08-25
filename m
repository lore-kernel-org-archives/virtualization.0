From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: vhost net: performance with ping benchmark
Date: Tue, 25 Aug 2009 14:34:41 +0200
Message-ID: <200908251434.41402.arnd__31692.4580409706$1251203788$gmane$org@arndb.de>
References: <20090824081240.GA3415@redhat.com>
	<4A934AF7.2090904@codemonkey.ws> <4A936525.5030300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A936525.5030300@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 25 August 2009, Avi Kivity wrote:
> On 08/25/2009 05:22 AM, Anthony Liguori wrote:
> >
> > I think 2.6.32 is pushing it. 
> 
> 2.6.32 is pushing it, but we need to push it.

Agreed.

> > I think some time is needed to flush out the userspace interface.  In 
> > particular, I don't think Mark's comments have been adequately 
> > addressed.  If a version were merged without GSO support, some 
> > mechanism to do feature detection would be needed in the userspace API. 
> 
> I don't see any point  in merging without gso (unless it beats userspace 
> with gso, which I don't think will happen).  In any case we'll need 
> feature negotiation.

The feature negotiation that Michael has put in seems sufficient for this.
If you care more about latency than bandwidth, the current driver is
an enormous improvement over the user space code, which I find is enough
reason to have it now.

> > I think this is likely going to be needed regardless.  I also think 
> > the tap compatibility suggestion would simplify the consumption of 
> > this in userspace.
> 
> What about veth pairs?

I think you are talking about different issues. Veth pairs let you connect
vhost to a bridge device like you do in the typical tun/tap setup, which
addresses one problem.

The other issue that came up is that raw sockets require root permissions,
so you have to start qemu as root or with an open file descriptor for the
socket (e.g. through libvirt). Permission handling on tap devices is ugly
as well, but is a solved problem. The solution is to be able to pass
a tap device (or a socket from a tap device) into vhost net. IMHO we
need this eventually, but it's not a show stopper for 2.6.32.

Along the same lines, I also think it should support TCP and UDP sockets
so we can offload 'qemu -net socket,mcast' and 'qemu -net socket,connect'
in addition to 'qemu -net socket,raw'.

	Arnd <><
