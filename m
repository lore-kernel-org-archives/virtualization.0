From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 2/3] hvc_init(): Enforce one-time initialization.
Date: Mon, 21 Nov 2011 15:31:04 +1030
Message-ID: <87lira9ii7.fsf@rustcorp.com.au>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
	<20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
	<874nybqo0o.fsf@rustcorp.com.au>
	<CAB8RdapbaueyWLJuJDE_ZdvLkRNM4sQHTxgmgO=jrnXZ6YPSmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAB8RdapbaueyWLJuJDE_ZdvLkRNM4sQHTxgmgO=jrnXZ6YPSmA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miche Baker-Harvey <miche@google.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>, Amit Shah <amit.shah@redhat.com>, Mike Waychison <mikew@google.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Eric Northrup <digitaleric@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 17 Nov 2011 10:57:37 -0800, Miche Baker-Harvey <miche@google.com> wrote:
> Rusty, Michael, Stephen, et al,
> 
> Thanks for your comments on these patches.
> 
> For what I'm trying to do, all three patches are necessary, but maybe
> I'm going about it the wrong way. Your input would be appreciated.
> I'm in no way claiming that these patches are "right", just that it's
> working for me, and that what's in the current pool is not.

We have to *understand* the code.  If we don't, we need to rewrite the
code so we *do* understand it, or make way for someone who does.

I'm looking at the kvm man page to try to figure out how to have virtio
console, and it's deeply unclear.  What kvm commandline are you using?
I'll try to debug it here, and see what I learn about hvc_console.

Cheers,
Rusty.
