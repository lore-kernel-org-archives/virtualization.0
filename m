From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC/PATCH PV_OPS X86_64 00/17] Paravirt_ops for x86_64
Date: Thu, 08 Mar 2007 08:05:07 -0500
Message-ID: <1173359107.25848.23.camel@localhost.localdomain>
References: <1173333704.25848.0.camel@localhost.localdomain>
	<20070308064729.GZ10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070308064729.GZ10574@sequoia.sous-sol.org>
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
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-03-07 at 22:47 -0800, Chris Wright wrote:
> * Steven Rostedt (rostedt@goodmis.org) wrote:
> > Well, it's still kind of crappy, but it's starting to work. So I spent
> > today, pulling out patches related only to paravirt ops from our git
> > repo, and separating them to be readable. Well, here they are.
> =

> Cool.  I had split these up slightly differently, with core changes
> coming first (like places where raw asm is still left behind), followed
> by adding in the paravirt bits.  I think it would be useful to get those
> simple basic changes to the front of the queue, because they can
> largely be merged right away w/out issue.  I'll look through the lot
> tomorrow.

The way I split it, and what took me so long to split it, was that I
wanted each patch to be able to compile. There was one two-way
dependency, I think that was between patches 7 and 8. But the most part,
each addition of a patch allowed for a successful compile.  I didn't
test running those though ;)

I can work on splitting it better. After pushing out the lguest64
patches (coming soon).


-- Steve
