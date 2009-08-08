From: Benny Amorsen <benny+usenet@amorsen.dk>
Subject: Re: [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Sat, 08 Aug 2009 10:50:10 +0200
Message-ID: <m3d476hepp.fsf__12363.2360170179$1249920761$gmane$org@ursa.amorsen.dk>
References: <D2E118A1E7268F449C469EA2F301D92902BC39B2@exil.voltaire.com>
	<0199E0D51A61344794750DC57738F58E6D6A6CD803__29862.6656564467$1249679159$gmane$org@GVW1118EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0199E0D51A61344794750DC57738F58E6D6A6CD803__29862.6656564467$1249679159$gmane$org@GVW1118EXC.americas.hpqcorp.net>
	(Anna Fischer's message of "Fri\, 7 Aug 2009 21\:00\:54 +0000")
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
Cc: "arnd@arndb.de" <arnd@arndb.de>, Yaron Haviv <yaronh@voltaire.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "evb@yahoogroups.com" <evb@yahoogroups.com>, "shemminger@linux-foundation.org" <shemminger@linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

"Fischer, Anna" <anna.fischer@hp.com> writes:

> If you do have a SRIOV NIC that supports VEPA, then I would think that
> you do not have QEMU or macvtap in the setup any more though. Simply
> because in that case the VM can directly access the VF on the physical
> device. That would be ideal.

I'm just trying to understand how this all works, so I'm probably asking
a stupid question:

Would a SRIOV NIC with VEPA support show up as multiple devices? I.e.
would I get e.g. eth0-eth7 for a NIC with support for 8 virtual
interfaces? Would they have different MAC addresses?


/Benny
