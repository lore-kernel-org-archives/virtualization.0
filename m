From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Lguest32 print hex on bad reads and writes
Date: Thu, 05 Apr 2007 13:01:30 +1000
Message-ID: <1175742090.12230.630.camel@localhost.localdomain>
References: <1175714071.9371.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161023AbXDEDBd@vger.kernel.org>
In-Reply-To: <1175714071.9371.31.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: virtualization@lists.osdl.org, Glauber de Oliveira Costa <glommer@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-04-04 at 15:14 -0400, Steven Rostedt wrote:
> Currently the lguest32 error messages from bad reads and writes prints a
> decimal integer for addresses. This is pretty annoying. So this patch
> changes those to be hex outputs.

(Erk, I wonder what I was thinking when I wrote that?)

Can I ask for %#x (or 0x%x)?  I'm easily confused.

Thanks!
Rusty.
