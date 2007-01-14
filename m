From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 09/20] XEN-paravirt: dont export paravirt_ops
	structure, do individual functions
Date: Sun, 14 Jan 2007 11:57:56 +1100
Message-ID: <1168736276.8692.9.camel@localhost.localdomain>
References: <20070113014539.408244126@goop.org>
	<20070113014648.000988681@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070113014648.000988681@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-01-12 at 17:45 -0800, Jeremy Fitzhardinge wrote:
> Wrap the paravirt_ops members we want to export in wrapper functions.

Andrew, the removal of paravirt_ops export here will break kvm.  Feel
free to re-add "EXPORT_SYMBOL_GPL(paravirt_ops)" at the bottom of
arch/i386/kernel/paravirt.c; I'm working on a cleaner way for modules
like kvm / lguest (which want to use the native versions directly
anyway).

Thanks,
Rusty.
