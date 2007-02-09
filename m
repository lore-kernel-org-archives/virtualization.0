From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Paravirt-ops VMI / Xen / lrustyvisor merge status
Date: Fri, 09 Feb 2007 18:20:57 +1100
Message-ID: <1171005657.2718.19.camel@localhost.localdomain>
References: <45CC0672.7090201@vmware.com>
	<1171000474.2718.8.camel@localhost.localdomain>
	<45CC10B7.2060100@vmware.com>
	<1171003468.2718.10.camel@localhost.localdomain>
	<45CC1BCA.8060003@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45CC1BCA.8060003@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-02-08 at 22:59 -0800, Zachary Amsden wrote:
> I believe there was a patch that got applied that turned it off by =

> default if CONFIG_PARAVIRT was enabled.  Doing it the cpuid way is the =

> right solution, IMHO.

Ah, yes, the VDSO issue.  This is separate, and does need fixing. =


Basically, if the user doesn't select COMPAT_VDSO, we don't have a
problem.  Currently they don't get offered COMPAT_VDSO if PARAVIRT is
enabled, but we *still* disable vdso in that case (unless vdso=3D1 is on
cmdline).

I think the best choice is to rework COMPAT_VDSO to a general "support
old glibcs" option, which will either (1) map it fixed if !
CONFIG_PARAVIRT, or (2) disable it if CONFIG_PARAVIRT.

I'll send that soon...

Cheers,
Rusty.
