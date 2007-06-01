From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Fri, 01 Jun 2007 14:47:15 -0700
Message-ID: <466093E3.4010701@goop.org>
References: <4656FB8F.4090604@goop.org> <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com> <466087CF.70708@goop.org> <4660924A.2070009@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764047AbXFAVrc@vger.kernel.org>
In-Reply-To: <4660924A.2070009@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
>> Do we care particularly? If 8 bytes is enough for the subarch, do we
>> care whether its a pointer or literal? After all, this is just a private
>> channel between the bootloader and some subarch-specific piece of code
>> in the kernel.
>>
>>     
>
> I see two options: either we make it a pointer *and a length* so that a
> loader can reshuffle it at will (that also implies no absolute pointers
> within the data), or it's an opaque cookie anyway.
>   

No, it has to be completely opaque.  It might be a pointer to some
special shared memory or something, and not movable.

    J
