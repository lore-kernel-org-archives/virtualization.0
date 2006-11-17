From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Fri, 17 Nov 2006 08:38:09 +0100
Message-ID: <200611170838.09146.ak@suse.de>
References: <20061027145650.GA37582@muc.de> <200611170547.22192.ak@suse.de>
	<20061117073338.GM1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061117073338.GM1397@sequoia.sous-sol.org>
Content-Disposition: inline
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
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


> Oh, it can be disabled by runtime (/proc/sys/kernel/vdso_enabled) or boot
> time (vdso=3D0) option already.

So you expect everybody using para virtualization to set this option? =


> And it should be only an interim timeslice =

> that is broken, since earlier glibc could only do int 0x80 and newer glibc
> can cope with non fixed vDSO.  So most users can just leave it enabled.

I'm sure there are quite a lot of people to still use SUSE 9.0 and =

similar time frame RH and debian etc.

To be honest, I don't think this is a particularly useful position.
Nobody wants to set weird command line options. It should just work.
We should value binary compatibility out of the box higher.

I guess i'll just disable the vDSO with CONFIG_PARAVIRT unless someone
comes up with a patch to fix it in a compatible way.

-Andi
