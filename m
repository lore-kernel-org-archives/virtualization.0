From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/2] Clean up asm-x86_64/bugs.h
Date: Mon, 09 Apr 2007 08:48:29 -0700
Message-ID: <461A604D.7050903@goop.org>
References: <4617D339.3080801@goop.org>
	<20070409084557.28748317.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070409084557.28748317.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:
> On Sat, 07 Apr 2007 10:22:01 -0700 Jeremy Fitzhardinge wrote:
>
>   =

>> Most of asm-x86_64/bugs.h is code which should be in a C file, so put it=
 there.
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
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- /dev/null
>> +++ b/arch/x86_64/kernel/bugs.c
>> @@ -0,0 +1,28 @@
>> +/*
>> + *  arch/x86_64/kernel/bugs.c
>> + *
>> + *  Copyright (C) 1994  Linus Torvalds
>> + *  Copyright (C) 2000  SuSE
>> + *
>> + * This is included by init/main.c to check for architecture-dependent =
bugs.
>>     =

>
> drop comment.
>
> Are you going to tackle asm-i386/bugs.h also?

Yes, I'd already sent it out.  This was just the response to "please
make them consistent".

    J
