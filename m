From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 06/25] xen: Core Xen implementation
Date: Wed, 25 Apr 2007 13:03:59 -0700
Message-ID: <462FB42F.5070503@goop.org>
References: <20070423215638.563901986@goop.org> <200704251112.45898.ak@suse.de> <462FAEE3.9090900@goop.org> <200704252143.48363.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2993031AbXDYUD2@vger.kernel.org>
In-Reply-To: <200704252143.48363.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Ian Pratt <ian.pratt@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> For me you don't need anymore, but possibly for others.
>   

Hm.  I'm not a fan of the great big monolithic patch myself, but on the
other hand I don't like the idea of patches which are not self-contained
steps from working->working state.  Xen-core.patch is currently the
(more or less) minimal set of stuff which needs to be in place to get
working Xen guest up, and so from that perspective I don't think there's
a good way of splitting it up.

> To summarize the outstanding issues are:
> - fixing sched_clock first
>   

What was the sched_clock problem?  I don't remember and outstanding
issues with it.  I noticed you didn't take paravirt-sched_clock.

> - hopefully more review of the core pieces by others
> - what i commented (minor stuff mostly)
>   

I just rebased onto your newest patches, so I'll address your comments
and repost.

> - review of xenbus and drivers

Yes, not much response there.

    J
