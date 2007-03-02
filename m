From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 12/26] Xen-paravirt_ops: Fix patch site clobbers to include
 return register
Date: Thu, 01 Mar 2007 16:58:56 -0800
Message-ID: <45E776D0.9020609@goop.org>
References: <20070301232443.195603797@goop.org> <20070301232527.755495278@goop.org> <45E7738D.5090607@vmware.com> <45E774AB.5090103@goop.org> <45E77569.9010602@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932503AbXCBA67@vger.kernel.org>
In-Reply-To: <45E77569.9010602@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
>>
>> Things like what?  Do you mean the %[foo] asm parameter syntax?  I think
>> those versions are no longer supported - Arjan posted a patch a few days
>> ago to convert a pile of asms to this form.  Or do you mean something
>> else?
>>   
>
> I meant having an output in the clobber list,

There's no output in the clobber list, just "memory" and "cc".  The
paravirt_clobber() is the stuff which gets put in the .parainstructions
section which tells the patcher what registers are expected to be
modified at that callsite (including both temp and output registers).


    J
