From: Keir Fraser <keir@xensource.com>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options and
 disableunsupported config options.
Date: Fri, 16 Feb 2007 11:03:06 +0000
Message-ID: <C1FB3FEA.98F7%keir__40315.8746230931$1171623826$gmane$org@xensource.com>
References: <20070216025452.d25e3545.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932244AbXBPLDM@vger.kernel.org>
In-Reply-To: <20070216025452.d25e3545.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, Ian Pratt <Ian.Pratt@xensource.com>, virtualization@lists.osdl.org, Steven Hand <steven.hand@cl.cam.ac.uk>, Christian Limpach <Christian.Limpach@xensource.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 10:54, "Andrew Morton" <akpm@linux-foundation.org> wrote:

> OK, you're screwed.  I agree that the process freezer is the way out of that
> one.
> 
> Ingo said that he's clocked the freezer at a few milliseconds.  But if it's
> any higher than that it'll need to get sped up once we convert cpu hotplug
> to use it.

A few milliseconds is acceptable. Presumably that is under some stress
workload? What we'd really like is to be able to gang-hotplug CPUs to
amortise the freezer overhead.

This initial patchset does not include save/restore support anyway, so in
fact it would be consistent to have CONFIG_PREEMPT configurable. I'm sure
that we are going to have some nasty bugs to fix up as a result, but we
can't fix them until we find them! Then we can convert our save/restore code
to use the freezer before submitting it for inclusion.

 -- Keir
