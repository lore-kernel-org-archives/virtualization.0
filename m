From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Fri, 01 Jun 2007 17:42:32 -0700
Message-ID: <4660BCF8.7000208@zytor.com>
References: <4656FB8F.4090604@goop.org> <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com> <466087CF.70708@goop.org> <4660924A.2070009@zytor.com> <466093E3.4010701@goop.org> <46609636.4050208@zytor.com> <4660BBDF.1040007@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762709AbXFBAnV@vger.kernel.org>
In-Reply-To: <4660BBDF.1040007@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> 
> Well, I think we can safely say that its something that's only
> meaningful in 32/64-bit mode, so we aren't constrained by the real-mode
> address space.
> 
> One of my goals in this project is to make the boot image, in some way,
> completely define which memory it needs it get started.  That means that
> the boot loader can either place things knowing they'll avoid the boot
> image and/or definitively know that the image is unloadable.
> 
> So I don't think its strictly necessary to pre-define what memory this
> object can use, since I think it can be safely determined dynamically.
> 

That's a method of defining the memory space.

I think the current definition is suitable for entering at the 16-bit
entry point.

	-hpa
