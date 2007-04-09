From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/2] Clean up asm-x86_64/bugs.h
Date: Mon, 09 Apr 2007 08:49:06 -0700
Message-ID: <461A6072.9040207@goop.org>
References: <4617D339.3080801@goop.org> <20070409084557.28748317.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965907AbXDIPuV@vger.kernel.org>
In-Reply-To: <20070409084557.28748317.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:
> On Sat, 07 Apr 2007 10:22:01 -0700 Jeremy Fitzhardinge wrote:
>
>   
>> Most of asm-x86_64/bugs.h is code which should be in a C file, so put it there.
>>
>> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
>> Cc: Andi Kleen <ak@suse.de>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> ---
>>  arch/x86_64/kernel/Makefile      |    3 ++-
>>  arch/x86_64/kernel/bugs.c        |   28 ++++++++++++++++++++++++++++
>>  include/asm-x86_64/alternative.h |    1 +
>>  include/asm-x86_64/bugs.h        |   30 ++++--------------------------
>>  4 files changed, 35 insertions(+), 27 deletions(-)
>>
>> ===================================================================
>> --- /dev/null
>> +++ b/arch/x86_64/kernel/bugs.c
>> @@ -0,0 +1,28 @@
>> +/*
>> + *  arch/x86_64/kernel/bugs.c
>> + *
>> + *  Copyright (C) 1994  Linus Torvalds
>> + *  Copyright (C) 2000  SuSE
>> + *
>> + * This is included by init/main.c to check for architecture-dependent bugs.
>>     
>
> drop comment.

I'll edit it, but I won't remove the copyrights.

    J
