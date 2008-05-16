From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Virt RNG?
Date: Thu, 15 May 2008 21:07:51 -0300
Message-ID: <20080516000751.GC23721@khazad-dum.debian.net>
References: <482C8595.5030509@garzik.org> <200805160943.08788.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764017AbYEPAIM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200805160943.08788.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, jeremy@xensource.com, Herbert Xu <herbert@gondor.apana.org.au>, Avi Kivity <avi@qumranet.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 16 May 2008, Rusty Russell wrote:
> Yes, I prepared one earlier.  I was a little surprised to see that hwrng 
> drivers don't contribute in any way to the entropy pool though, but now
> reading the thread I find out about rngd (not installed on my Ubuntu system, 
> but available at least).

It would be easy to implement rng-tools as a kernel driver, as long as
proper in-kernel interfaces exist for it to work in an event-driven way.
I don't see what we would win over rng-tools in userspace, however.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
