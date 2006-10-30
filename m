From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Date: 31 Oct 2006 00:11:32 +0100
Message-ID: <20061030231132.GA98768@muc.de>
References: <20061029024504.760769000@sous-sol.org> <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de> <1162178936.9802.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161359AbWJ3XLj@vger.kernel.org>
Date: Tue, 31 Oct 2006 00:11:32 +0100
Content-Disposition: inline
In-Reply-To: <1162178936.9802.34.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Paravirtualization Kleenups

Thanks. 

Chris, can you please merge those into the original patchkit? 

I could do it myself, but then retransmits from Chris would be difficult
if anything else would need to be changed.

Also fixing that !-Os compile error in the original patches would be good.

-Andi
