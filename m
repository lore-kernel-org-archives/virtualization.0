From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest implementation for
 paravirt_ops interface
Date: Fri, 16 Feb 2007 13:13:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702161312460.28871@schroedinger.engr.sgi.com>
References: <20070216022449.739760547@goop.org>
 <Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
 <45D61C74.2000601@vmware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946245AbXBPVNp@vger.kernel.org>
In-Reply-To: <45D61C74.2000601@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 16 Feb 2007, Zachary Amsden wrote:

> For the most part, it doesn't disturb VMware or KVM.  Xen does need some
> additional functionality in paravirt-ops because they took a different design
> choice - direct page tables instead of shadow page tables.  This is where all
> the requirements for the new Xen paravirt-ops hooks come from.

It still seems to be implemented for Xen and not to support a variety of 
page table methods in paravirt ops.
