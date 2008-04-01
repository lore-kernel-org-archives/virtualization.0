From: Jes Sorensen <jes@sgi.com>
Subject: Re: [13/18] KVM:IA64: Add optimization for some virtulization faults
	V9
Date: Tue, 01 Apr 2008 17:14:27 +0200
Message-ID: <47F25153.2040004__24568.6862654567$1207062998$gmane$org@sgi.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC0104872C@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC0104872C@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhang, Xiantao" <xiantao.zhang@intel.com>
Cc: Carsten Otte <cotte@de.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org, "Xu,
	Anthony" <anthony.xu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Zhang, Xiantao wrote:
>>From 0d698efed15759b49e78adcef085feda0a14a175 Mon Sep 17 00:00:00 2001
> From: Xiantao Zhang <xiantao.zhang@intel.com>
> Date: Tue, 1 Apr 2008 14:57:09 +0800
> Subject: [PATCH] KVM:IA64: Add optimization for some virtulization
> faults
> 
> optvfault.S Add optimization for some performance-critical
> virtualization faults.
> Signed-off-by: Anthony Xu <anthony.xu@intel.com>
> Signed-off-by: Xiantao Zhang <xiantao.zhang@intel.com>
> ---
>  arch/ia64/kvm/optvfault.S |  918
> +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 918 insertions(+), 0 deletions(-)
>  create mode 100644 arch/ia64/kvm/optvfault.S

Hi Xiantao,

This one still suffers from the bad indentation.

Cheers,
Jes
