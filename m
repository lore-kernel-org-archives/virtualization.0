From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] macvlan: add vepa and bridge mode
Date: Tue, 17 Nov 2009 23:56:41 +0100
Message-ID: <200911172356.41459.arnd__23597.449452109$1258498728$gmane$org@arndb.de>
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1258497551-25959-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Jens Osterkamp <jens@linux.vnet.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Sorry, I used the wrong address for the virtualization mailing list
at first. Please correct this to <virtualization@lists.linux-foundation.org>
when replying to the other mails.

For people only subscribed to virtualization, you can find the actual
patches at
http://patchwork.kernel.org/patch/60810/
http://patchwork.kernel.org/patch/60811/
http://patchwork.kernel.org/patch/60813/
http://patchwork.kernel.org/patch/60814/

	Arnd <><

On Tuesday 17 November 2009, Arnd Bergmann wrote:
> This is based on an earlier patch from Eric Biederman adding
> forwarding between macvlans. I extended his approach to
> allow the administrator to choose the mode for each macvlan,
> and to implement a functional VEPA between macvlan.
> 
> Still missing from this is support for communication between
> the lower device that the macvlans are based on. This would
> be extremely useful but as others have found out before me
> requires significant changes not only to macvlan but also
> to the common transmit path.
> 
> I've seen one panic during testing this that I still need
> to track down, but it generally does what is advertised.
> I've tested VEPA operation with the hairpin support
> added to the bridge driver by Anna Fischer.
> 
> My current plan is to submit this for inclusion in 2.6.33
> when people are happy with it and I tracked down any
> remaining bugs, and possibly to do the communication with
> the lower device one release later.
> 
> 	Arnd <><
> 
> ---
> 
> Arnd Bergmann (3):
>   macvlan: implement VEPA and private mode
>   macvlan: export macvlan mode through netlink
>   iplink: add macvlan options for bridge mode
> 
> Eric Biederman (1):
>   macvlan: Reflect macvlan packets meant for other macvlan devices
> 
>  linux/drivers/net/macvlan.c   |  170 +++++++++++++++++++++++++++++++++-----
>  linux/include/linux/if_link.h |   15 +++
>  2 files changed, 161 insertions(+), 24 deletions(-)
> 
>  iproute2/include/linux/if_link.h |   15 +++
>  iproute2/ip/Makefile             |    3 +-
>  iproute2/ip/iplink_macvlan.c     |   93 ++++++++++++++++++
>  3 files changed, 110 insertions(+), 1 deletions(-)
>  create mode 100644 ip/iplink_macvlan.c
> 
