From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Lguest32 print hex on bad reads and writes
Date: Wed, 04 Apr 2007 23:14:08 -0400
Message-ID: <1175742848.9371.33.camel@localhost.localdomain>
References: <1175714071.9371.31.camel@localhost.localdomain>
	 <1175742090.12230.630.camel@localhost.localdomain>
	 <72C854B9-1A7F-44C5-9D62-B6B63F3A6DE7@mac.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161095AbXDEDOS@vger.kernel.org>
In-Reply-To: <72C854B9-1A7F-44C5-9D62-B6B63F3A6DE7@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org, Glauber de Oliveira Costa <glommer@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-04-04 at 23:06 -0400, Kyle Moffett wrote:

> > (Erk, I wonder what I was thinking when I wrote that?) Can I ask  
> > for %#x (or 0x%x)?  I'm easily confused.
> 
> How about "%p" for pointers?

But that would require casting the numbers to pointers.

-- Steve
