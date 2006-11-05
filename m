From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for
	paravirtualizing critical operations
Date: Sat, 4 Nov 2006 22:18:03 -0800
Message-ID: <20061104221803.3871c3d3.akpm@osdl.org>
References: <20061029024504.760769000@sous-sol.org>
	<200611032209.40235.ak@suse.de>
	<1162701815.29777.6.camel@localhost.localdomain>
	<200611050646.15334.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200611050646.15334.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 5 Nov 2006 06:46:15 +0100
Andi Kleen <ak@suse.de> wrote:

> =

> > Andi, the patches work against Andrew's tree, and he's merged them in
> > rc4-mm2.  There are a few warnings to clean up, but it seems basically
> > sound.
> > =

> > At this point I our think time is better spent on beating those patches
> > up, rather than going back and figuring out why they don't work in your
> > tree.
> =

> My tree is basically mainline as base. Sure if you don't care about mainl=
ine
> merges we can ignore it there and keep it forever in -mm* until Andrew
> gets tired of it?
> =

> That's a possible strategy, but only if you want to keep it as a mm-only
> toy forever.
> =


They're in my regular list-of-thing-to-spam-maintainers-with, so we can
transfer them as-is next week sometime.

It would be better to sort out the various warnings and any other nasties f=
irst
though.
