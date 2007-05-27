From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Sat, 26 May 2007 17:14:40 -0700
Message-ID: <4658CD70.2080702@zytor.com>
References: <4656FB8F.4090604@goop.org> <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com> <4658C704.2050405@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756873AbXE0AO7@vger.kernel.org>
In-Reply-To: <4658C704.2050405@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> 
> I'd really prefer to keep an intact embedded ELF file rather than have a
> semi-ELF file.  That way it would be easier to simply load the image and
> point the normal ELF machinery at some offset into the file rather than
> having to have a special handler for "\x7fBZE" or whatever.
> 

Pardon me for saying it, but it's hardly a hardship to add support for a
single additional constant in existing code.  I'm starting to think this
argument is approaching not just the silly, but downright ridiculous.

Another option is to have the ELF header at a nonzero offset.

	-hpa
