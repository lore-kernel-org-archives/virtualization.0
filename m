From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] macvlan: export macvlan mode through netlink
Date: Thu, 19 Nov 2009 15:47:03 +0100
Message-ID: <200911191547.03509.arnd__28183.6343616762$1258642106$gmane$org@arndb.de>
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<200911181059.45331.arnd@arndb.de> <4B05586C.5020308@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B05586C.5020308@trash.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Patrick McHardy <kaber@trash.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 19 November 2009, Patrick McHardy wrote:
> > +enum ifla_macvlan_mode {
> > +     MACVLAN_MODE_PRIVATE = 1, /* don't talk to other macvlans */
> > +     MACVLAN_MODE_VEPA    = 2, /* talk to other ports through ext bridge */
> > +     MACVLAN_MODE_BRIDGE  = 4, /* talk to bridge ports directly */
> > +};
> 
> Please also keep the enum named something without ifla_ since
> the mode values themselves are not netlink attributes. Just
> macvlan_mode seems fine.

Ok, good. I was unsure on the naming and also changed between MACVLAN_*
and MACVLAN_MODE_* a few times.

Thanks for the clarification,

	Arnd <><
