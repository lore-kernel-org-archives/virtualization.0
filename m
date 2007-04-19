From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 20/20] Add apply_to_page_range() which applies a function
 to a pte range.
Date: Thu, 19 Apr 2007 12:44:57 -0700
Message-ID: <4627C6B9.7000605@goop.org>
References: <20070404191151.009821039@goop.org> <20070404191206.675793431@goop.org> <20070405044133.GE4892@waste.org> <46149CC9.2070903@goop.org> <20070417205652.GM11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1766972AbXDSTpE@vger.kernel.org>
In-Reply-To: <20070417205652.GM11115@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>, Christoph Lameter <clameter@sgi.com>, Matt Mackall <mpm@waste.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Matt Mackall wrote:
> I think adding a flags field and an allocate flag to my callback
> struct would be sufficient here.
>   

Yes, probably.

What about something that wants to shatter superpages?

> The syntax is horrible, but I don't think we end up using the
> resultant type enough to justify the namespace pollution.
>   

Don't know that that's a huge concern.  The typedef namespace (*_t) is
pretty empty, and its not like we're talking about something that's
visible outside the kernel.  And the syntax is *really* ugly.

    J
