From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: RE: [PATCH 06/27] ia64/xen: define NET_SKB_NET to 18 if xen.
Date: Thu, 19 Jun 2008 11:37:21 +0900
Message-ID: <13C8D1B5662635takebe_akio__32219.9365044527$1213843217$gmane$org@jp.fujitsu.com>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
	<12130840432829-git-send-email-yamahata@valinux.co.jp>
	<57C9024A16AD2D4C97DC78E552063EA3061C5C2E@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA3061C5C2E@orsmsx505.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Luck, Tony" <tony.luck@intel.com>, Isaku Yamahata <yamahata@valinux.co.jp>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Cc: "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "Dong, Eddie" <eddie.dong@intel.com>, Kouya SHIMURA <kouya@jp.fujitsu.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi, Tony

>> Resolve it by increasing NET_SKB_NET from the default value 16 to 18.
>
>Typo?  You mean NET_SKB_PAD here?
>
I think so. :-)

>But in include/linux/skbuff.h it says: "It must be a power of 2".
>
>Explain why 18 is ok.
It's supposed to add NET_IP_ALIGN when network driver allocs 
skb with netdev_alloc_skb(). For example, e1000 do like the below, too.

struct sk_buff *new_skb = netdev_alloc_skb(netdev, length + NET_IP_ALIGN);

In the case of xen, xen-frontend.c also uses __netdev_alloc_skb(),
so we need to add 16 + NET_IP_ALIGN for padding.
I think we use NET_SKB_PAD=16+NET_IP_ALIGN or
we add it to length of __netdev_alloc_skb().

The below is my patch being relative to this.
http://xenbits.xensource.com/xen-unstable.hg?cs=797430d25f1b

Best Regards,

Akio Takebe
