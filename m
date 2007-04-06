From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Define EFLAGS_IF
Date: Thu, 05 Apr 2007 17:22:02 -0700
Message-ID: <461592AA.4060103@goop.org>
References: <1174533374.2713.104.camel@localhost.localdomain>
	<46159256.1040705@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46159256.1040705@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Rusty Russell wrote:
>   =

>> There is now more than one place where we use the fact that bit 9 of
>> eflags is the interrupt-enabled flag, so define EFLAGS_IF.  We make it
>> 512 so it can be used in asm, too.
>>     =

>
> How about defining all the other EFLAGS in one place?
>   =


That patch got dropped, and replaced by one which pulled all the flags
definitions out of <asm/processor.h>

    J
