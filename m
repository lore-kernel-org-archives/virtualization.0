From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 15/21] Xen-paravirt: Add Xen interface header files
Date: Thu, 15 Feb 2007 17:32:18 +0000
Message-ID: <20070215173218.GA6324@infradead.org>
References: <20070213221729.772002682@goop.org> <20070213221830.619562494@goop.org> <m1k5ykpiwv.fsf@ebiederm.dsl.xmission.com> <45D3A50A.9090303@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030338AbXBORcn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45D3A50A.9090303@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 14, 2007 at 04:10:50PM -0800, Jeremy Fitzhardinge wrote:
> Eric W. Biederman wrote:
> > Jeremy Fitzhardinge <jeremy@goop.org> writes:
> >
> >   
> >> Add Xen interface header files. These are taken fairly directly from
> >> the Xen tree and hence the style is not entirely in accordance with
> >> Linux guidelines. There is a tension between fitting with Linux coding
> >> rules and ease of maintenance.
> >>
> >> Define macros and inline functions for doing hypercalls into the
> >> hypervisor.
> >>
> >> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> >> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> >> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> >> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> >>
> >>
> >> --
> >>  include/asm-i386/hypercall.h          |  416 +++++++++++++++++++++++++++++
> >>  include/asm-i386/hypervisor.h         |   72 +++++
> >>     
> >
> > Are hypercall.h and hypervisor.h generic or are they Xen specific.
> > If they are Xen specific (as it appears) then are inappropriately
> > named.
> >   
> 
> Thanks for the reminder; I've been meaning to move/rename these.
> 
> >>  include/xen/interface/arch-x86_32.h   |  187 +++++++++++++
> >>     
> > Why isn't this file include-asm-i386/xen/arch-x86_32.h ?
> >   
> 
> Those files are more or less directly copied from the Xen tree, and its
> easier if they don't drift too far in name and directory structure.

Nack, we don't put per-arch crap there.  Either you'll have it in separate
places, or you clean up the utterly braindead scheme in the Xen tree
aswell.
