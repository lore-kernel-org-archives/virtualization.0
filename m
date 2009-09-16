From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost-net todo list
Date: Wed, 16 Sep 2009 17:58:01 +0300
Message-ID: <20090916145801.GA5412__46676.4966412031$1253113245$gmane$org@redhat.com>
References: <20090916100438.GA30036@redhat.com>
	<200909161652.40983.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909161652.40983.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm@vger.kernel.org, anthony@codemonkey.ws, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 16, 2009 at 04:52:40PM +0200, Arnd Bergmann wrote:
> On Wednesday 16 September 2009, Michael S. Tsirkin wrote:
> > vhost-net driver projects
> 
> I still think that list should include

Yea, why not. Go wild.

> - UDP multicast socket support
> - TCP socket support

Switch to UDP unicast while we are at it?
tunneling raw packets over TCP looks wrong.

> - raw packet socket support for qemu (from Or Gerlitz)
> if we have those, plus the tap support that is already on
> your list, we can use vhost-net as a generic offload
> for the host networking in qemu.
> 
> > projects involing networking stack
> > - export socket from tap so vhost can use it - working on it now
> > - extend raw sockets to support GSO/checksum offloading,
> >   and teach vhost to use that capability
> >   [one way to do this: virtio net header support]
> >   will allow working with e.g. macvlan
> 
> One thing I'm planning to work on is bridge support in macvlan,
> together with VEPA compliant operation, i.e. not sending back
> multicast frames to the origin.

is multicast filtering already there (i.e. only getting
frames for groups you want)?

> I'll also keep looking into macvtap, though that will be less
> important once you get the tap socket support running.

Not sure I see the connection. to get an equivalent to macvtap,
what you need is tso etc support in packet sockets. No?

> 	Arnd <><
