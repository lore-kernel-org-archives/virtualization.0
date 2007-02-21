From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest implementation for
 paravirt_ops interface
Date: Wed, 21 Feb 2007 10:37:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702211036060.24941@schroedinger.engr.sgi.com>
References: <20070216022449.739760547@goop.org>
 <Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
 <45D61C74.2000601@vmware.com> <Pine.LNX.4.64.0702161312460.28871@schroedinger.engr.sgi.com>
 <45D626BB.20007@vmware.com> <Pine.LNX.4.64.0702161356380.29218@schroedinger.engr.sgi.com>
 <20070217135112.GA15102@muc.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422790AbXBUShu@vger.kernel.org>
In-Reply-To: <20070217135112.GA15102@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 17 Feb 2007, Andi Kleen wrote:

> That was always its intention. It's not a direct interface to a hypervisor,
> but an somewhat abstracted interface to a "hypervisor driver" 

I thought that hypervisor driver was some binary blob that can be directly
accessed via paravirt_ops?

> But you're right that there are currently still quite a lot of hooks
> being added. I plan to be much more strict on that in the future.

And it seems that the hooks are not generic but bound to a particular 
hypervisor. Should the Xen specific stuff not be in the binary blob?
