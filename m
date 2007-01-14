From: Greg KH <greg@kroah.com>
Subject: Re: [patch 18/20] XEN-paravirt: Add Xen driver utility functions.
Date: Sat, 13 Jan 2007 23:41:25 -0800
Message-ID: <20070114074125.GB10585@kroah.com>
References: <20070113014539.408244126@goop.org> <20070113014649.046041214@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751151AbXANHxE@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070113014649.046041214@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>, Jan Beulich <JBeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 12, 2007 at 05:45:57PM -0800, Jeremy Fitzhardinge wrote:
> Allocate/destroy a 'vmalloc' VM area: alloc_vm_area and free_vm_area
> The alloc function ensures that page tables are constructed for the
> region of kernel virtual address space and mapped into init_mm.

Shouldn't these functions go into the core mm/ kernel code if they are
needed, instead of living in the xen directories?

thanks,

greg k-h
