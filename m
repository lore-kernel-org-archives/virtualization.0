From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Sat, 8 Aug 2009 11:22:28 +0200
Message-ID: <200908081122.28883.arnd__47569.2854066894$1249723855$gmane$org@arndb.de>
References: <D2E118A1E7268F449C469EA2F301D92902BC39B2@exil.voltaire.com>
	<0199E0D51A61344794750DC57738F58E6D6A6CD803@GVW1118EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0199E0D51A61344794750DC57738F58E6D6A6CD803@GVW1118EXC.americas.hpqcorp.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Fischer, Anna" <anna.fischer@hp.com>
Cc: Yaron Haviv <yaronh@voltaire.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "evb@yahoogroups.com" <evb@yahoogroups.com>, "shemminger@linux-foundation.org" <shemminger@linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 07 August 2009, Fischer, Anna wrote:
> If you do have a SRIOV NIC that supports VEPA, then I would think
> that you do not have QEMU or macvtap in the setup any more though.
> Simply because in that case the VM can directly access the VF on
> the physical device. That would be ideal.

There may be reasons why even with an SR-IOV adapter you may want
to use the macvtap setup, with some extensions. E.g. guest migration
becomes a lot simpler if you don't have to deal with PCI passthrough
devices. If we manage to add both TX and RX zero-copy (into the
guest) to the macvlan driver, we can treat an SR-IOV adapter like
a VMDq adapter and get the best of both.

> I do think that the macvtap driver is a good addition as a simple
> and fast virtual network I/O interface, in case you do not need
> full bridge functionality. It does seem to assume though that the
> virtualization software uses QEMU/tap interfaces. How would this
> work with a Xen para-virtualized network interface? I guess there
> would need to be yet another driver?

I'm not sure how Xen guest networking works, but if neither the
traditional macvlan driver nor the macvtap driver are able to
connect it to the external NIC, then you can probably add a third
macvlan backend to handle that.

	Arnd <><
