From: "Dong, Eddie" <eddie.dong@intel.com>
Subject: Xen common code across architecture
Date: Thu, 20 Mar 2008 17:13:43 +0800
Message-ID: <10EA09EFD8728347A513008B6B0DA77A02EF8C3A__45666.2996592515$1206004759$gmane$org@pdsmsx411.ccr.corp.intel.com>
References: <12047411453864-git-send-email-yamahata@valinux.co.jp>
	<12047411473158-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <12047411473158-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Jeremy & all:
	Current xen kernel codes are in arch/x86/xen, but xen dynamic
irqchip (events.c) are common for other architectures such as IA64. We
are in progress with enabling pv_ops for IA64 now and want to reuse same
code, do we need to move the code to some place common? suggestions?
	Thanks, eddie
