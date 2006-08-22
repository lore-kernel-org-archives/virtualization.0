From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 12:43:43 -0700
Message-ID: <44EB5E6F.5090001@vmware.com>
References: <1155202505.18420.5.camel@localhost.localdomain>	
	<44DB7596.6010503@goop.org>	
	<1156254965.27114.17.camel@localhost.localdomain>	
	<200608221544.26989.ak@muc.de> <44EB3BF0.3040805@vmware.com>	
	<1156271386.2976.102.camel@laptopd505.fenrus.org>	
	<1156275004.27114.34.camel@localhost.localdomain>	
	<44EB584A.5070505@vmware.com> <44EB5A76.9060402@vmware.com>
	<1156274983.2976.111.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1156274983.2976.111.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

Arjan van de Ven wrote:
>> That is a really nasty problem.  You need a synchronization primitive =

>> which guarantees a flat stack, so you can't do it in the interrupt =

>> handler as I have tried to do.  I'll bang my head on it awhile.  In the =

>> meantime, were there ever any solutions to the syscall patching problem =

>> that might lend me a clue as to what to do (or not to do, or impossible?=
).
>>     =

>
> yes we just disallowed it :)
>   =


Ok, I just took a cold shower.  Actually, this problem is much easier to =

solve for paravirt-ops, since they are short lived operations and don't =

block.  For syscall, it is much, much harder, since you have syscalls =

that can block forever, so you can't guarantee you'll exit all instances =

of the syscall you want to patch.

I think the paravirt-ops one is doable with exports already provided by =

Linux.

Zach
