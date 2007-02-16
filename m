From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest implementation for
	paravirt_ops interface
Date: Fri, 16 Feb 2007 13:59:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702161356380.29218@schroedinger.engr.sgi.com>
References: <20070216022449.739760547@goop.org>
	<Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
	<45D61C74.2000601@vmware.com>
	<Pine.LNX.4.64.0702161312460.28871@schroedinger.engr.sgi.com>
	<45D626BB.20007@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D626BB.20007@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 16 Feb 2007, Zachary Amsden wrote:

> Yes, but that is just because the Xen hooks happens to be near the last p=
art
> of the merge.  VMI required some special hooks, as do both Xen and lhype =
(I
> think ... Rusty can correct me if lhype's puppy's have precluded the addi=
tion
> of new hooks).  Xen page table handling is very different, mostly it is t=
rap
> and emulate so writable page tables can work, which means they don't alwa=
ys
> issue hypercalls for PTE updates, although they do have that option, shou=
ld
> the hypervisor MMU model change, or performance concerns prompt a differe=
nt
> model (or perhaps, migration?)

Well looks like there are still some major design issues to be ironed out. =

What is proposed here is to make paravirt_ops a fake generic =

API and then tunnel through it to vendor specific kernel mods.
