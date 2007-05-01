From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 09/32] xen: xen configuration
Date: Tue, 1 May 2007 05:37:22 +0200
Message-ID: <20070501033722.GH25929@bingen.suse.de>
References: <20070429172835.284784000@goop.org> <20070429172912.297678000@goop.org> <46366F8A.1030302@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754504AbXEACjs@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46366F8A.1030302@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 30, 2007 at 03:36:58PM -0700, Zachary Amsden wrote:
> Jeremy Fitzhardinge wrote:
> >+config XEN
> >+	bool "Enable support for Xen hypervisor"
> >+	depends on PARAVIRT && !PREEMPT && !SMP
> >+	default y
> >+	help
> >+	  This is the Linux Xen port.  Enabling this will allow the
> >+	  kernel to boot in a paravirtualized environment under the
> >+	  Xen hypervisor.
> >
> >  
> 
> Since the default assumption of paravirt is to support running on 
> multiple hypervisors and backends are now defaulting to being on, make 
> the same true of VMI.

No I don't like it for Xen either. Jeremy, please remove it too.

-Andi
