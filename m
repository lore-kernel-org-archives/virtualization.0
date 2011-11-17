From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v3 1/3] virtio_console:  Fix locking of vtermno.
Date: Fri, 18 Nov 2011 00:39:20 +0530
Message-ID: <20111117190920.GD2873@amit-x200.redhat.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
	<20111108214458.28884.86759.stgit@miche.sea.corp.google.com>
	<877h37qo5z.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <877h37qo5z.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>, Miche Baker-Harvey <miche@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>, Mike Waychison <mikew@google.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Eric Northrup <digitaleric@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 11 Nov 2011 [14:57:20], Rusty Russell wrote:
> On Tue, 08 Nov 2011 13:44:58 -0800, Miche Baker-Harvey <miche@google.com> wrote:
> > Some modifications of vtermno were not done under the spinlock.
> > 
> > Moved assignment from vtermno and increment of vtermno together,
> > putting both under the spinlock.  Revert vtermno on failure.
> > 
> > Signed-off-by: Miche Baker-Harvey <miche@google.com>
> 
> Does it matter?  It's normal not to lock in a function called
> "init_XXX", since it's not exposed yet.
> 
> Or is it?

Slight misnomer, I suppose.

We do this init_console_port() as part of add_port() if the port is a
console port.  Should it be named 'mark_console_port()'?  Dunno,
doesn't sound like the right name.  init fits closest.

		Amit
