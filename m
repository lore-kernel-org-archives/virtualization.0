From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 5 Mar 2007 21:19:57 +0100
Message-ID: <20070305201957.GA733@elte.hu>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<20070305143437.GF22829@bingen.suse.de>
	<45EC796D.5050705@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45EC796D.5050705@vmware.com>
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
Cc: virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Zachary Amsden <zach@vmware.com> wrote:

> [...]  I can't comment on Ingo's patch as he failed to -cc me on it,

it's on lkml, i'll bounce it to you separately.

> despite the fact that we are the only ones affected by it. [...]

actually, no, my motivation for it was KVM (a Linux based hypervisor and =

its paravirtual interface). You said that VMI wont hinder Linux =

development and design in any way and can adopt to whatever change the =

upstream kernel does, so i'm taking your word for that.

> [...] We are not concerned so much with supporting legacy user land =

> deployments, as we expect for the most part, the install scenario to =

> happen when upgrading to new distros.

that's not really the right argument. This obviously affects the host =

kernel too if it has CONFIG_PARAVIRT enabled. The other option is the =

removal (or temporary disabling) of the whole CONFIG_VMI and =

CONFIG_PARAVIRT stuff if you cannot get into minimal release shape, it's =

experimental stuff after all.

> What we really need to do is to be able to detect an old user land and =

> drop VDSO support when that is found.  [...]

no. What you need is to keep existing mechanisms and not hack off the =

vdso and CONFIG_COMPAT_VDSO...

> [...] But since we can't do that, the next best thing is to allow the =

> hypervisor to choose whatever workaround it wants when it moves the =

> fixmap and compat_vdso was enabled.  In our case, the workaround we =

> will want is a boot option to disable VDSO for old user land, [...]

there's no need to disable the VDSO for old userspace ...

	Ingo
