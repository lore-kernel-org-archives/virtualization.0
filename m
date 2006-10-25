From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: RFC: const_udelay in 018-delay functions patch
Date: Wed, 25 Oct 2006 16:03:37 +1000
Message-ID: <1161756217.15099.52.camel@localhost.localdomain>
References: <453EF1EE.2000503@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <453EF1EE.2000503@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-10-24 at 22:11 -0700, Zachary Amsden wrote:
> So I implemented udelay and ndelay through a single paravirt_op, =

> const_udelay, instead of having either two separate paravirt-ops for =

> udelay or ndelay, or a redundant const_udelay paravirt_op.  Anybody have =

> any objection to reworking the patch this way?

Seems saner, but I'm not sure why x86 has an I/O delay separate from
udelay to start with?

Comments: =


> +#if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_IO)
> +#include <asm/paravirt.h>
> +#else =


USE_REAL_IO? Is this defined anywhere?  Or just future-proofing?

Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
