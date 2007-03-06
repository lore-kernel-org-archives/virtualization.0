From: Zachary Amsden <zach@vmware.com>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 01:03:31 -0800
Message-ID: <45ED2E63.3070700@vmware.com>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de>
	<20070306085222.GA17002@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070306085222.GA17002@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: virtualization <virtualization@lists.osdl.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
>>> there are already 5 major hypervisors we are going to support (in =

>>> alphabetical order):
>>>
>>>  - KVM
>>>  - lguest
>>>  - Windows
>>>  - VMWare
>>>  - Xen
>>>
>>> the QA matrix is gonna be a _mess_.
>>>       =

>> I fail to see how xen-via-vmirom instead of xen-via-paravirt_ops =

>> reduces the QA effort.  You still have 5 Hypervisors you have to test =

>> against.
>>     =

>
> yes, just like we have thousands of separate PC boards to support. But =

> as long as the basic ABI is the same, the QA effort on the Linux kernel =

> side is alot more focused. (Distros still have 18446744073709551616 =

> total combinations to QA, and have to make an educated guess to reduce =

> that to a more manageable number.)
>   =


But hardware PC boards don't do anything as remotely complicate as =

changing the semantics required for correctness in you MMU =

implementation.  There might be some weird MTRR and caching things, =

which are a property of the architecture, and which all modern boards =

have in common.  You don't have completely diverse implementation =

properties like shadow vs direct vs native page tables.  Or hardware =

virtualization vs direct CPL raised execution.  You simply can't test =

this diversity by making an educated guess, because in this case, =

something will always be omitted.  The test matrix has to be raised, and =

if that is a problem, the burden of proper testing shifted onto the =

manufacturers, just as you would with some new PC board or new =

architecture that wanted to be Linux friendly but was radically =

different in some way.

Zach
