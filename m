From: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH 3/3] macvlan: export macvlan mode through netlink
Date: Thu, 19 Nov 2009 15:38:36 +0100
Message-ID: <4B05586C.5020308__48698.972099419$1258641853$gmane$org@trash.net>
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<1258497551-25959-4-git-send-email-arnd@arndb.de>
	<4B0398D4.8030904@gmail.com> <200911181059.45331.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200911181059.45331.arnd@arndb.de>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> On Wednesday 18 November 2009, Eric Dumazet wrote:
>>> --- a/drivers/net/macvlan.c
>>> +++ b/drivers/net/macvlan.c
>>> @@ -33,12 +33,6 @@
>>>  
>>>  #define MACVLAN_HASH_SIZE    (1 << BITS_PER_BYTE)
>>>  
>>> -enum macvlan_type {
>>> -     MACVLAN_PRIVATE         = 1,
>>> -     MACVLAN_VEPA            = 2,
>>> -     MACVLAN_BRIDGE          = 4,
>>> -};
>> I realize you defined MACVLAN_PRIVATE in patch 2, but used MACVLAN_MODE_PRIVATE,
>> so patch 2 is not compilable and breaks bisection ?
>>
> 
> Hmm, right. I'll fix that up as well.

> +enum ifla_macvlan_mode {
> +	MACVLAN_MODE_PRIVATE = 1, /* don't talk to other macvlans */
> +	MACVLAN_MODE_VEPA    = 2, /* talk to other ports through ext bridge */
> +	MACVLAN_MODE_BRIDGE  = 4, /* talk to bridge ports directly */
> +};

Please also keep the enum named something without ifla_ since
the mode values themselves are not netlink attributes. Just
macvlan_mode seems fine.
