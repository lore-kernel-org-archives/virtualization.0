From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: vhost-net todo list
Date: Wed, 16 Sep 2009 17:27:25 +0200
Message-ID: <200909161727.26153.arnd__33725.9302534678$1253115100$gmane$org@arndb.de>
References: <20090916100438.GA30036@redhat.com>
	<200909161708.46412.arnd@arndb.de>
	<20090916151922.GD5513@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090916151922.GD5513@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, anthony@codemonkey.ws, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 16 September 2009, Michael S. Tsirkin wrote:
> > 
> > No, I think this is less important, because the bridge code
> > also doesn't do this.
> 
> True, but the reason might be that it is much harder in bridge (you have
> to snoop multicast registrations). With macvlan you know which
> multicasts does each device want.

Right. It shouldn't be hard to do, and I'll probably get to
that after the other changes.

> > One of the problems that raw packet sockets have is the requirement
> > for root permissions (e.g. through libvirt). Tap sockets and
> > macvtap both don't have this limitation, so you can use them as
> > a regular user without libvirt.
> 
> I don't see a huge difference here.
> If you are happy with the user being able to bypass filters in host,
> just give her CAP_NET_RAW capability.  It does not have to be root.

Capabilities are nice in theory, but I've never seen them being used
effectively in practice, where it essentially comes down to some
SUID wrapper. Also, I might not want to allow the user to open a
random random raw socket, but only one on a specific downstream
port of a macvlan interface, so I can filter out the data from
that respective MAC address in an external switch.

That scenario is probably not so relevant for KVM, unless you
consider the guest taking over the qemu host process a valid
security threat.

	Arnd <><
