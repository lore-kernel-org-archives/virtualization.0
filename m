From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 09/32] xen: xen configuration
Date: Mon, 30 Apr 2007 15:36:58 -0700
Message-ID: <46366F8A.1030302@vmware.com>
References: <20070429172835.284784000@goop.org> <20070429172912.297678000@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060900000903010404040703"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422799AbXD3WjL@vger.kernel.org>
In-Reply-To: <20070429172912.297678000@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------060900000903010404040703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeremy Fitzhardinge wrote:
> +config XEN
> +	bool "Enable support for Xen hypervisor"
> +	depends on PARAVIRT && !PREEMPT && !SMP
> +	default y
> +	help
> +	  This is the Linux Xen port.  Enabling this will allow the
> +	  kernel to boot in a paravirtualized environment under the
> +	  Xen hypervisor.
>
>   

Since the default assumption of paravirt is to support running on 
multiple hypervisors and backends are now defaulting to being on, make 
the same true of VMI.

Zach

--------------060900000903010404040703
Content-Type: text/x-patch;
 name="make-vmi-default-to-on.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make-vmi-default-to-on.patch"

Since the default assumption of paravirt is to support all possible guest
backends, making VMI default to on when CONFIG_PARAVIRT is enabled.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 20882b709da4 arch/i386/Kconfig
--- a/arch/i386/Kconfig	Thu Apr 26 19:58:12 2007 -0700
+++ b/arch/i386/Kconfig	Mon Apr 30 15:32:34 2007 -0700
@@ -227,6 +227,7 @@ config VMI
 config VMI
 	bool "VMI Paravirt-ops support"
 	depends on PARAVIRT
+	default y
 	help
 	  VMI provides a paravirtualized interface to the VMware ESX server
 	  (it could be used by other hypervisors in theory too, but is not

--------------060900000903010404040703--
