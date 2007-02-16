From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 14/21] Xen-paravirt: Add XEN config
 options and disable unsupported config options.
Date: Fri, 16 Feb 2007 10:44:02 +0000
Message-ID: <C1FB3B72.98E5%keir@xensource.com>
References: <45D58531.4010808@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751916AbXBPKoH@vger.kernel.org>
In-Reply-To: <45D58531.4010808@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>, Keir Fraser <keir@xensource.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Dan Hecht <dhecht@vmware.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Steven Hand <steven.hand@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 10:19, "Zachary Amsden" <zach@vmware.com> wrote:

> Doesn't stop_machine_run already take care of getting you out of all
> kernel threads?  So you can only be sleeping, not preempted, in which
> case, this might not be an issue?

It ensures that no (non-stopmachine) threads are running on any of the other
CPUs, but it doesn't guarantee that all threads are at any form of quiescent
point. They can certainly have private references to machine addresses.

Otherwise, what would be the point of the process freezer? :-)

 -- Keir
