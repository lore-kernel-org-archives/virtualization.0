From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Date: Wed, 01 Nov 2006 21:25:41 +1100
Message-ID: <1162376741.23462.2.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946599AbWKAKZp@vger.kernel.org>
In-Reply-To: <20061030231132.GA98768@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-10-31 at 00:11 +0100, Andi Kleen wrote:
> > Subject: Paravirtualization Kleenups
> 
> Thanks. 
> 
> Chris, can you please merge those into the original patchkit? 
> 
> I could do it myself, but then retransmits from Chris would be difficult
> if anything else would need to be changed.
> 
> Also fixing that !-Os compile error in the original patches would be good.

That is "prep-for-paravirt-desch-clearer-parameter-names-fix.patch" in
rc4-mm1.

I'll follow with the updated series, although the cleanup patch was
pretty clear by itself...

Rusty.
