From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 18/24] Xen-paravirt_ops: Some generic early printk &
	boot console fixups
Date: Wed, 21 Feb 2007 19:10:47 -0800
Message-ID: <20070221191047.8d21acaa.akpm@linux-foundation.org>
References: <20070221205254.169835700@goop.org>
	<20070221205323.842917348@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070221205323.842917348@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 21 Feb 2007 12:53:12 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:

> Some generic early printk & boot console fixups
> (already sent to lkml).

hm, this patch series seems to have gone out of its way to cause problems.

This particular (pathetically changelogged) patch is already in my tree,
only in a later, much more comprehensive form.  Similarly the HVC changes
were already in Rusty's stuff and were supposed to be merged by Paulus, but
haven't been yet.

Can we just drop this one?  Does the Xen work actually depend on it?
