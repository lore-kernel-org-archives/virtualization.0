From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 04/25] xen: Add XEN config options
Date: Tue, 24 Apr 2007 01:00:30 +0200
Message-ID: <200704240100.31011.ak@suse.de>
References: <20070423215638.563901986@goop.org> <20070423215709.990824532@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754468AbXDWXCK@vger.kernel.org>
In-Reply-To: <20070423215709.990824532@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 23 April 2007 23:56:42 Jeremy Fitzhardinge wrote:
> The XEN config option enables the Xen paravirt_ops interface, which is
> installed when the kernel finds itself running under Xen.
> 
> Xen is no longer a sub-architecture, so the X86_XEN subarch config
> option has gone.
> 
> Xen is currently incompatible with PREEMPT, but this is fixed up later
> in the series.

Shouldn't this be after the change that adds arch/i386/xen/Kconfig?

Otherwise you break bisects

-Andi
