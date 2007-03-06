From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 01:07:31 -0800
Message-ID: <45ED2F53.2040101@goop.org>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070306081909.GA9331@elte.hu>
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
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> btw., while we have everyone on the phone and talking ;) Technologically =

> it would save us a whole lot of trouble in Linux if 'external' =

> hypervisors could standardize around a single ABI - such as VMI. Is =

> there any deep reason why Xen couldnt use VMI to talk to Linux? I =

> suspect a range of VMI vectors could be set aside for Xen's dom0 (and =

> other) APIs that have no current VMI equivalent - if there's broad =

> agreement on the current 60+ base VMI vectors that center around basic =

> x86 CPU capabilities - which make up the largest portion of our =

> paravirtualization complexity. Pipe dream?

Well, we went around this about six months ago, and decided the best way
forward is the current paravirt_ops approach. =


The Xen and VMI interfaces are quite different, and have different
design goals.  VMI is fairly low-level, and is approximately a software
implementation of VT/SVM with a couple of extra bits, whereas the Xen
interface is intended to be higher level, with the expectation that the
guest cooperates more with its virtualization.  They have similarities
by necessity, but they have some fairly basic differences.

You could come up with some shim layer which makes the two interfaces
appear similar, and you could spell the name of that shim "VMI".  Or you
could call it "paravirt_ops", which is the name we chose.  And you could
implement the interface to that layer as a binary ABI, or you could make
it a normal source-level Linux kernel interface, which is what we chose
to do.

Either way, its still one of native hardware, VMI/ESX, Xen or something
else under the interface layer, and you need to test for each case
regardless of what the interface looks like.


    J
