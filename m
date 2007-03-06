From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 22:20:37 +0100
Message-ID: <20070306212037.GB31568@elte.hu>
References: <45ED82D9.6050204@codemonkey.ws>
	<8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>
	<20070306203712.GC21736@elte.hu> <45EDD6F1.7080100@goop.org>
	<20070306211105.GD26348@elte.hu> <45EDD96D.1030108@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45EDD96D.1030108@goop.org>
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

> > so trying to argue as if there was no ABI imposed on Linux by hiding =

> > the Xen ABI behind paravirt_ops, and whistling into the air as if =

> > nothing happened is misguided at best.
> =

> How is the situation even slightly different with a unified hypervisor =

> ABI?

1 sane ABI instead of 4 parallel ones? It's the same difference as the =

difference between 300 system calls and 1200 system calls. Alot more =

focus, alot more integration, alot less pain. Every time i change a =

detail in Linux i have to update (and think about) 1 virtualization =

aspect - not 4 (or more).

	Ingo
