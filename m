From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Date: Tue, 31 Oct 2006 00:46:01 +0100
Message-ID: <200610310046.01388.ak@suse.de>
References: <20061029024504.760769000@sous-sol.org> <20061030231132.GA98768@muc.de> <20061030234215.GA5881@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161556AbWJ3XqG@vger.kernel.org>
In-Reply-To: <20061030234215.GA5881@sequoia.sous-sol.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 31 October 2006 00:42, Chris Wright wrote:

> > I could do it myself, but then retransmits from Chris would be difficult
> > if anything else would need to be changed.
> > 
> > Also fixing that !-Os compile error in the original patches would be good.
> 
> Hmm, builds fine here.  If you have a .config and/or error message I'll
> fix it up.

I haven't tried it myself (my laptop was on battery all the time
and I didn't want to drain it with a full rebuild ;-), there was just a report
that it didn't work. Or maybe that was with an old patch. If it works it's fine.

-Andi
