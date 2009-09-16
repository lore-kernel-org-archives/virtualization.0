From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost-net todo list
Date: Wed, 16 Sep 2009 18:19:22 +0300
Message-ID: <20090916151922.GD5513__28422.7885575548$1253114643$gmane$org@redhat.com>
References: <20090916100438.GA30036@redhat.com>
	<200909161652.40983.arnd@arndb.de>
	<20090916145801.GA5412@redhat.com>
	<200909161708.46412.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909161708.46412.arnd@arndb.de>
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

On Wed, Sep 16, 2009 at 05:08:46PM +0200, Arnd Bergmann wrote:
> On Wednesday 16 September 2009, Michael S. Tsirkin wrote:
> > On Wed, Sep 16, 2009 at 04:52:40PM +0200, Arnd Bergmann wrote:
> > > On Wednesday 16 September 2009, Michael S. Tsirkin wrote:
> > > > vhost-net driver projects
> > > 
> > > I still think that list should include
> > 
> > Yea, why not. Go wild.
> > 
> > > - UDP multicast socket support
> > > - TCP socket support
> > 
> > Switch to UDP unicast while we are at it?
> > tunneling raw packets over TCP looks wrong.
> 
> Well, TCP is what qemu supports right now, that's why
> I added it to the list. We could add UDP unicast as
> yet another protocol in both qemu and vhost_net if there
> is demand for it. The implementation should be trivial
> based on the existing code paths.
> 
> > > One thing I'm planning to work on is bridge support in macvlan,
> > > together with VEPA compliant operation, i.e. not sending back
> > > multicast frames to the origin.
> > 
> > is multicast filtering already there (i.e. only getting
> > frames for groups you want)?
> 
> No, I think this is less important, because the bridge code
> also doesn't do this.

True, but the reason might be that it is much harder in bridge (you have
to snoop multicast registrations). With macvlan you know which
multicasts does each device want.

> > > I'll also keep looking into macvtap, though that will be less
> > > important once you get the tap socket support running.
> > 
> > Not sure I see the connection. to get an equivalent to macvtap,
> > what you need is tso etc support in packet sockets. No?
> 
> I'm not worried about tso support here.
> 
> One of the problems that raw packet sockets have is the requirement
> for root permissions (e.g. through libvirt). Tap sockets and
> macvtap both don't have this limitation, so you can use them as
> a regular user without libvirt.

I don't see a huge difference here.
If you are happy with the user being able to bypass filters in host,
just give her CAP_NET_RAW capability.  It does not have to be root.

> 	Arnd <><
