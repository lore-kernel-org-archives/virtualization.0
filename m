From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Mon, 10 Aug 2009 09:51:18 -0700
Message-ID: <20090810095118.125fe966__47473.8499302932$1249923212$gmane$org@nehalam>
References: <D2E118A1E7268F449C469EA2F301D92902BC39B2@exil.voltaire.com>
	<4A7EB0AC.2030104@Voltaire.com> <20090810082037.17b352c2@nehalam>
	<200908101728.15649.arnd@arndb.de>
	<0199E0D51A61344794750DC57738F58E6D6AE99884@GVW1118EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0199E0D51A61344794750DC57738F58E6D6AE99884@GVW1118EXC.americas.hpqcorp.net>
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
Cc: "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "evb@yahoogroups.com" <evb@yahoogroups.com>, Arnd Bergmann <arnd@arndb.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 10 Aug 2009 16:32:01 +0000
"Fischer, Anna" <anna.fischer@hp.com> wrote:

> > Subject: Re: [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA support
> > 
> > On Monday 10 August 2009, Stephen Hemminger wrote:
> > > On Sun, 09 Aug 2009 14:19:08 +0300, Or Gerlitz
> > <ogerlitz@voltaire.com> wrote:
> > > > Looking in macvlan_set_multicast_list() it acts in a similar manner
> > to
> > > > macvlan_set_mac_address() in the sense that it calls dev_mc_sync().
> > I
> > > > assume what's left is to add macvlan_hash_xxx multicast logic to
> > > > map/unmap multicast groups to what macvlan devices want to receive
> > them
> > > > and this way the flooding can be removed, correct?
> > >
> > > The device can just flood all multicast packets, since the filtering
> > > is done on the receive path anyway.
> 
> Is this handled by one of the additional patches? In the current kernel tree
> macvlan code it looks as if multicast filtering is only handled by the
> physical device driver, but not on particular macvlan devices.
>  
> 
> > But we'd still have to copy the frames to user space (for both
> > macvtap and raw packet sockets) and exit from the guest to inject
> > it into its stack, right?
> 
> I think it would be nice if you can implement what Or describes for 
> macvlan and avoid flooding, and it doesn't sound too hard to do. 
> 
> I guess one advantage for macvlan (over the bridge) is that you can 
> program in all information you have for the ports attached to it, e.g. 
> MAC addresses and multicast addresses. So you could take advantage of
> that whereas the bridge always floods multicast frames to all ports.
>  
> How would this work though, if the OS inside the guest wants to register
> to a particular multicast address? Is this propagated through the backend
> drivers to the macvlan/macvtap interface?

Sure filtering is better, but multicast performance with large number
of guests is really a corner case, not the real performance issue.
