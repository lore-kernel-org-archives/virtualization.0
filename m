From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 21:30:18 +0100
Message-ID: <20070306203018.GA21736@elte.hu>
References: <1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de>
	<20070306085222.GA17002@elte.hu>
	<20070306194612.GG19575@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070306194612.GG19575@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization <virtualization@lists.osdl.org>, Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Chris Wright <chrisw@sous-sol.org> wrote:

> What are you driving at?  You seem to be arguing that abstractions are =

> bad unless done via ABI's. [...]

i'm still arguing the same: that doing the same thing via overlapping, =

conflicting, redundant ABIs is crazy and contrary to the basic interests =

of Linux. It's like having 5 different, parallel variants of sys_open(), =

interfaced via a convoluted open_ops.

having data ABI coupling is one thing (filesystems, network formats, =

etc.). But having a 5-way function ABI coupling between system software =

running on the /same piece of hardware/, doing the same thing in essence =

is just madness in my book.

	Ingo
