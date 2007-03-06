From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 22:11:05 +0100
Message-ID: <20070306211105.GD26348@elte.hu>
References: <45ED82D9.6050204@codemonkey.ws>
	<8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>
	<20070306203712.GC21736@elte.hu> <45EDD6F1.7080100@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45EDD6F1.7080100@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> If you're seriously talking about an ABI, [...]

HELLO, this isnt a hypothetical!! The moment there's a xen_paravirt_ops, =

Linux has DE FACTO committed itself to the Xen ABI: whatever =

functionality the hypercall_page call table plus the int $0x82 interface =

offers.

THE MOMENT any of that goes upstream and ships in a distro it's going to =

be there forever! Try to change paravirt_ops or any core bit of Linux so =

that this ABI cannot be sanely supported: 'fix it, you broke Xen!'. It =

wont matter that paravirt_ops is 'internal' to Linux.

so trying to argue as if there was no ABI imposed on Linux by hiding the =

Xen ABI behind paravirt_ops, and whistling into the air as if nothing =

happened is misguided at best.

	Ingo
