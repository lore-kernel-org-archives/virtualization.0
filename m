From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 05 Mar 2007 12:11:25 -0800
Message-ID: <45EC796D.5050705@vmware.com>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<20070305143437.GF22829@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070305143437.GF22829@bingen.suse.de>
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
Cc: virtualization <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> But this still means I would need to decide between a PARAVIRT
> kernel that either supports xen/VMI or cannot boot old user land without
> weird options.  I don't think that's the correct solution. The goal
> is a single binary that runs everywhere and is still compatible.
>   =


Rusty's patch looks a step in the right direction to me.  I can't =

comment on Ingo's patch as he failed to -cc me on it, despite the fact =

that we are the only ones affected by it.  We are not concerned so much =

with supporting legacy user land deployments, as we expect for the most =

part, the install scenario to happen when upgrading to new distros.

> What would probably work is to somehow decide at runtime if a hypervisor
> is there or not and then set vdso default based on that. I guess that
> detection would be hypervisor specific though and probably would
> need paravirt ops extensions.
>   =


What we really need to do is to be able to detect an old user land and =

drop VDSO support when that is found.  But since we can't do that, the =

next best thing is to allow the hypervisor to choose whatever workaround =

it wants when it moves the fixmap and compat_vdso was enabled.  In our =

case, the workaround we will want is a boot option to disable VDSO for =

old user land, and a printk warning if you take #GPs and kill the init =

proc, because for us, this is not an expected support scenario.  We =

would much rather support the VDSO by default in paravirt kernels even =

with COMPAT_VDSO turned on.

Zach
