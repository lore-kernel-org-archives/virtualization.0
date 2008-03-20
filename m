From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Xen common code across architecture
Date: Thu, 20 Mar 2008 07:23:04 -0700
Message-ID: <47E27348.5090705__57.9169056893036$1206023554$gmane$org@goop.org>
References: <12047411453864-git-send-email-yamahata@valinux.co.jp>	<12047411473158-git-send-email-yamahata@valinux.co.jp>
	<10EA09EFD8728347A513008B6B0DA77A02EF8C3A@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <10EA09EFD8728347A513008B6B0DA77A02EF8C3A@pdsmsx411.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Dong, Eddie" <eddie.dong@intel.com>
Cc: linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Dong, Eddie wrote:
> 	Current xen kernel codes are in arch/x86/xen, but xen dynamic
> irqchip (events.c) are common for other architectures such as IA64. We
> are in progress with enabling pv_ops for IA64 now and want to reuse same
> code, do we need to move the code to some place common? suggestions?

I'm fine with moving common stuff like that to drivers/xen/.

    J
