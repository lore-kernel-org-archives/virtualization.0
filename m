From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [evb] Re: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Mon, 10 Aug 2009 17:23:10 +0200
Message-ID: <200908101723.10832.arnd__11317.1488781974$1249918596$gmane$org@arndb.de>
References: <0199E0D51A61344794750DC57738F58E67D2DCECBB@GVW1118EXC.americas.hpqcorp.net>
	<200908071329.44437.arnd@arndb.de>
	<005101ca1797$70dcf5b0$5296e110$@edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <005101ca1797$70dcf5b0$5296e110$@edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: evb@yahoogroups.com
Cc: "'Fischer, Anna'" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, adobriyan@gmail.com, 'Stephen Hemminger' <shemminger@linux-foundation.org>, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Friday 07 August 2009, Paul Congdon (UC Davis) wrote:
> 
> I don't think your scheme works too well because broadcast packet coming
> from other interfaces on br0 would get replicated and sent across the wire
> to ethB multiple times.

Right, that won't work. So the bridge patch for the hairpin turn
is still the best solution. Btw, how will that interact with
the bride-netfilter (ebtables) setup? Can you apply any filters
that work on current bridges also between two VEPA ports while
doing the hairpin turn?

	Arnd <><
