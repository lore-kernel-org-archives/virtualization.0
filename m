From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 08/27] ia64/xen: define helper functions for xen
	hypercalls.
Date: Tue, 17 Jun 2008 16:57:55 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA3061C5C5D__29062.7969814979$1213747192$gmane$org@orsmsx505.amr.corp.intel.com>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
	<12130840431025-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12130840431025-git-send-email-yamahata@valinux.co.jp>
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
Cc: "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "Dong, Eddie" <eddie.dong@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


+/*
+ * Hypercalls without parameter.
+ */
+#define __HCALL0(name,hcall)           \
+       GLOBAL_ENTRY(name);             \
+       break   hcall;                  \

Should Linux code be made aware of the "break" numbers that
are being used for hypercalls (so it doesn't try to re-use
them for something else?)  include/asm-ia64/break.h should be
updated with the appropriate stuff (just with a base value
and a comment for how many you are using ... you can still
define all the HYPERPRIVOP_* defines in a separate file).

-Tony
