From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest implementation for
 paravirt_ops interface
Date: Fri, 16 Feb 2007 12:49:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
References: <20070216022449.739760547@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946152AbXBPUts@vger.kernel.org>
In-Reply-To: <20070216022449.739760547@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Feb 2007, Jeremy Fitzhardinge wrote:

> This patch series implements the Linux Xen guest in terms of the
> paravirt-ops interface.  The features in implemented this patch series

I am thoroughly confused. Maybe that is because I have not been following 
this issue closely but it seems that you are using the paravirt interface 
as an API for Xen code in the guest? I thought the idea of paravirt was to 
have an API that is generic? This patchset seems to be mostly realizing 
Xen specific functionality? How does the code here interact with KVM, 
VMWare and other hypervisors?
