From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 06/27] ia64/xen: define NET_SKB_NET to 18 if xen.
Date: Tue, 17 Jun 2008 16:45:23 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA3061C5C2E__1487.81245011396$1213746439$gmane$org@orsmsx505.amr.corp.intel.com>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
	<12130840432829-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12130840432829-git-send-email-yamahata@valinux.co.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Cc: "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "Dong, Eddie" <eddie.dong@intel.com>, Kouya SHIMURA <kouya@jp.fujitsu.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> Resolve it by increasing NET_SKB_NET from the default value 16 to 18.

Typo?  You mean NET_SKB_PAD here?

But in include/linux/skbuff.h it says: "It must be a power of 2".

Explain why 18 is ok.

-Tony
