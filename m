From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 10:15:13 +0100
Message-ID: <45ED3121.8090308@suse.de>
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
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Gerd Hoffmann <kraxel@suse.de> wrote:
> =

>>> [using vmi rom]
>> IIRC there was some proof-of-concept at least for xen guests.
> =

> yes - but de-facto contradicted by the Xen paravirt_ops patches sent to =

> lkml ;)

Yep.  The fact that it is possible to do that doesn't imply that it is
the best solution.

Oh, and btw:  What was the reason why kvm paravirtualization doesn't use
the vmi interface?

>>> the QA matrix is gonna be a _mess_.
>> I fail to see how xen-via-vmirom instead of xen-via-paravirt_ops =

>> reduces the QA effort.  You still have 5 Hypervisors you have to test =

>> against.
> =

> yes, just like we have thousands of separate PC boards to support. But =

> as long as the basic ABI is the same, the QA effort on the Linux kernel =

> side is alot more focused.

xen and vmware are still two very different hypervisors from the memory
mangement point of view.  I doubt moving the abstraction line within the
linux kernel from paravirt_ops to vmi makes QA easier.

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
