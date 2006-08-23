From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Translate asm version of ELFNOTE macro into	preprocessor
 macro
Date: Wed, 23 Aug 2006 08:23:31 -0700
Message-ID: <44EC72F3.70505@goop.org>
References: <1156333761.12949.35.camel@localhost.localdomain>	 <44EC6B12.4060909@goop.org> <1156346074.12949.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964980AbWHWPXd@vger.kernel.org>
In-Reply-To: <1156346074.12949.129.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Campbell <Ian.Campbell@XenSource.com>
Cc: Andrew Morton <akpm@osdl.org>, Virtualization <virtualization@lists.osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Ian Campbell wrote:
>> OK, seems reasonable.  Eric Biederman solved this by having NOTE/ENDNOTE 
>> (or something like that) in his "bzImage with ELF header" patch, but I 
>> don't remember it being used in any way which is incompatible with using 
>> a CPP macro.
>>     
>
> I can't find that patch, does NOTE/ENDNOTE just do the push/pop .note
> section?
>
> That would solve the problem with the first argument of the macro being
> a string but the final argument could still be for .asciz note contents.
>   

It looks like:

.macro note name, type
      .balign 4
      .int    2f - 1f            # n_namesz
      .int    4f - 3f            # n_descsz
      .int    \type            # n_type
      .balign 4
1:    .asciz "\name"
2:    .balign 4
3:
.endm
.macro enote
4:    .balign 4
.endm


so it allows you to put arbitrary stuff in the desc part of the note.  
The downside is that its a little more cumbersome syntactically for the 
common case.

    J
