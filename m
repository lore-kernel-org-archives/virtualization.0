From: Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: [PATCH] Translate asm version of ELFNOTE macro into
	preprocessor macro
Date: Wed, 23 Aug 2006 16:14:34 +0100
Message-ID: <1156346074.12949.129.camel@localhost.localdomain>
References: <1156333761.12949.35.camel@localhost.localdomain>
	 <44EC6B12.4060909@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964971AbWHWPOc@vger.kernel.org>
In-Reply-To: <44EC6B12.4060909@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Virtualization <virtualization@lists.osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-08-23 at 07:49 -0700, Jeremy Fitzhardinge wrote:
> Ian Campbell wrote:
> > The first is that older gas does not support :varargs in .macro
> > definitions (in my testing 2.17 does while 2.15 does not, I don't know
> > when it became supported). The Changes file says binutils >= 2.12 so I
> > think we need to avoid using it. There are no other uses in mainline or
> > -mm. Old gas appears to just ignore it so you get "too many arguments"
> > type errors.
> >   
> OK, seems reasonable.  Eric Biederman solved this by having NOTE/ENDNOTE 
> (or something like that) in his "bzImage with ELF header" patch, but I 
> don't remember it being used in any way which is incompatible with using 
> a CPP macro.

I can't find that patch, does NOTE/ENDNOTE just do the push/pop .note
section?

That would solve the problem with the first argument of the macro being
a string but the final argument could still be for .asciz note contents.

Ian.
