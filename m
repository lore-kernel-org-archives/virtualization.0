From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Date: Mon, 30 Oct 2006 15:42:15 -0800
Message-ID: <20061030234215.GA5881@sequoia.sous-sol.org>
References: <20061029024504.760769000@sous-sol.org> <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de> <1162178936.9802.34.camel@localhost.localdomain> <20061030231132.GA98768@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161555AbWJ3XlQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061030231132.GA98768@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

* Andi Kleen (ak@muc.de) wrote:
> Chris, can you please merge those into the original patchkit? 

Sure, I'll fold those in.

> I could do it myself, but then retransmits from Chris would be difficult
> if anything else would need to be changed.
> 
> Also fixing that !-Os compile error in the original patches would be good.

Hmm, builds fine here.  If you have a .config and/or error message I'll
fix it up.

thanks,
-chris
