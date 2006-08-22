From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 1/2] paravirt.h header
Date: Tue, 22 Aug 2006 11:06:35 +0200
Message-ID: <20060822110635.d9072621.ak@muc.de>
References: <1156226116.26898.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1156226116.26898.8.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 22 Aug 2006 15:55:15 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> OK, this is the revised paravirt.h (Andi has seen this before), then the
> second is the binary patching stuff.  More things get added to the
> paravirt struct in future patches, but this basic stuff hasn't changed
> for some time.

Thanks. I plan to revisit this after the .19 merge is done.
Currently there is too much noise in the tree and even your =

tree seems to be still changing too quickly.

The patch looks reasonable, except that you still have far too many
of these nasty __s around asm and volatile.

-Andi
