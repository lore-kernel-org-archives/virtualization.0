From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for
	paravirtualizing critical operations
Date: Thu, 02 Nov 2006 10:32:51 +1100
Message-ID: <1162423971.6848.1.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
	 <1162377928.23744.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752568AbWKAXc5@vger.kernel.org>
In-Reply-To: <1162377928.23744.4.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@muc.de>, Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-11-01 at 11:45 +0100, Arjan van de Ven wrote:
> On Wed, 2006-11-01 at 21:27 +1100, Rusty Russell wrote:
> > Create a paravirt.h header for all the critical operations which need
> > to be replaced with hypervisor calls, and include that instead of
> > defining native operations, when CONFIG_PARAVIRT.
> this is a lot of infrastructure... do we have more than 1 user of this
> yet that wants to get merged in mainline?

Yep.  Xen and VMI both have patches on top of this pending merge.  I
also have a toy hypervisor "lhype" based on this, but it's not ready for
mainline.  (It seems people expect consoles to do *input* as well as
output).

Cheers,
Rusty.
