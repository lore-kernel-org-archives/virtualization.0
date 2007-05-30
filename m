From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Wed, 30 May 2007 16:16:55 -0700
Message-ID: <465E05E7.20409@goop.org>
References: <4656FB8F.4090604@goop.org> <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757879AbXE3XRd@vger.kernel.org>
In-Reply-To: <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> I think we should start there and be prepared to munge the ELF
> magic number if there are problems.  Placing ELF notes is going
> to require a little work but mostly it should be a matter of
> copying the from vmlinux.
>   

Do you have a semi-current ELF bzImage patch on hand I can start playing
with?

    J
