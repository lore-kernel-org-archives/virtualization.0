From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 13/26] Xen-paravirt_ops: Consistently wrap paravirt ops
 callsites to make them patchable
Date: Sun, 18 Mar 2007 10:29:10 -0700
Message-ID: <45FD76E6.4060907@goop.org>
References: <20070316.023331.59468179.davem@davemloft.net> <45FB005D.9060809@goop.org> <1174127638.8897.75.camel@localhost.localdomain> <20070318.003309.71088169.davem@davemloft.net> <20070318120814.GA45869@muc.de> <45FD619D.6030402@goop.org> <20070318170414.GB45869@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20070318170414.GB45869@muc.de>
Sender: netdev-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: David Miller <davem@davemloft.net>, rusty@rustcorp.com.au, mingo@elte.hu, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, chrisw@sous-sol.org, zach@vmware.com, anthony@codemonkey.ws, torvalds@linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> You could use the dwarf2 unwind tables. They have exact information
> what register has what. But it would likely get complicated.

Yes.  And would they be accurate for hand-written asm, which is where we
have this problem?

    J
