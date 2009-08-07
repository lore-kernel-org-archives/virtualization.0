From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Fri, 7 Aug 2009 13:29:44 +0200
Message-ID: <200908071329.44437.arnd__8722.39517416364$1249644765$gmane$org@arndb.de>
References: <0199E0D51A61344794750DC57738F58E67D2DCECBB@GVW1118EXC.americas.hpqcorp.net>
	<20090806210002.75beb7c6@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090806210002.75beb7c6@nehalam>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: "Fischer, Anna" <anna.fischer@hp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "evb@yahoogroups.com" <evb@yahoogroups.com>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 07 August 2009, Stephen Hemminger wrote:
> So instead of adding more stuff to existing bridge code, why not
> have a new driver for just VEPA. You could
> do it with a simple version of macvlan type driver.

The current macvlan driver already does the downstream side of
VEPA and only needs a connection to KVM et al, either using
Or's qemu packet socket interface, or using the macvtap driver
I posted.

Now Anna's patch also addresses the upstream side of VEPA, by
making it possible for the bridge code to send frames back
in the bridge code that they were received from, if that port
is marked as a hairpin mode port.

Is your suggestion to do that part also with a macvlan type driver?
I've thought about this before, and I guess that would mean
basically the same as the macvlan driver, except hashing the
source MAC address instead of the destination MAC address for
inbound frames. That way you should be able to do something
like:

            Host A                             Host B

      /- nalvcam0 -\                   /- macvlan0 - 192.168.1.1
br0 -|              |- ethA === ethB -|
      \- nalvcam1 -/                   \- macvlan1 - 192.168.1.2
  
Now assuming that macvlan0 and macvlan1 are in different
network namespaces or belong to different KVM guests, these
guests would be able to communicate with each other through
the bridge on host A, which can set the policy (using ebtables)
for this communication and get interface statistics on its
nalvcam interfaces. Also, instead of having the br0, Host A could
assign an IP addresses to the two nalvcam interfaces that host
B has, and use IP forwarding between the guests of host B.

	Arnd <><
