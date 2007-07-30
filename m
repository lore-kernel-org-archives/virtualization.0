From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: [PATCH] Make lguest compile with CONFIG_BLOCK=n and CONFIG_NET=n
Date: Mon, 30 Jul 2007 03:29:18 +0200
Message-ID: <46AD3EEE.8040007@googlemail.com>
References: <46ACAFBF.6060609@googlemail.com> <1185755123.12151.102.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965934AbXG3Bd6@vger.kernel.org>
In-Reply-To: <1185755123.12151.102.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Sun, 2007-07-29 at 17:18 +0200, Gabriel C wrote:
>> Hi Rusty,
>>
>> Lguest should depend on BLOCK too , without BLOCK set I get this error:
> 
> Hi Gabriel,
> 
> 	Thanks for the report!  It's probably better to fix this properly
> rather than hack it as I did for NET.
> 

You are welcome :)

Yes your solution is better :)


Gabriel
