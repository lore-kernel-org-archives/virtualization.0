From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Mon, 10 Aug 2009 21:18:49 +0200
Message-ID: <200908102118.49253.arnd__18640.3651409366$1249932174$gmane$org@arndb.de>
References: <D2E118A1E7268F449C469EA2F301D92902BC39B2@exil.voltaire.com>
	<0199E0D51A61344794750DC57738F58E6D6AE99884@GVW1118EXC.americas.hpqcorp.net>
	<20090810095118.125fe966@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090810095118.125fe966@nehalam>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: "Fischer, Anna" <anna.fischer@hp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "evb@yahoogroups.com" <evb@yahoogroups.com>, Stephen Hemminger <shemminger@linux-foundation.org>, "adobriyan@gmail.com" <adobriyan@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 10 August 2009, Stephen Hemminger wrote:
> On Mon, 10 Aug 2009 16:32:01, "Fischer, Anna" <anna.fischer@hp.com> wrote:
> > How would this work though, if the OS inside the guest wants to register
> > to a particular multicast address? Is this propagated through the backend
> > drivers to the macvlan/macvtap interface?
> 
> Sure filtering is better, but multicast performance with large number
> of guests is really a corner case, not the real performance issue.

Well, right now, qemu does not care at all about this, it essentially
leaves the tun device in ALLMULTI state. I should check whether macvtap
at this stage can receive multicast frames at all, but if it does,
it will get them all ;-).

If we want to implement this with kvm, we would have to start with
the qemu virtio-net implementation, to move the receive filter into
the tap device. With tun/tap that will mean less copying to user
space, with macvtap (after implementing TUNSETTXFILTER) we get already
pretty far because we no longer need to have the external interface
in ALLMULTI state. Once that is in place, we can start thinking about
filtering per virtual device.

	Arnd <><
