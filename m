From: =?iso-8859-2?Q?Pawe=B3?= Zuzelski <pawelz@pld-linux.org>
Subject: Re: PROBLEM: [BISECTED] 2.6.35.5 xen domU panics just
	after	the boot
Date: Fri, 24 Sep 2010 07:40:00 +0200
Message-ID: <20100924054000.GA4689@pzz.touk.pl>
References: <20100921190525.GD4573@davabel.touk.pl> <4C9BEA8C.2030808@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <4C9BEA8C.2030808@goop.org>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, =?iso-8859-2?Q?Pawe=B3?= Zuzelski <pawelz@pld-linux.org>, James Dingwall <james.dingwall@amdocs.com>, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 23 Sep 2010, Jeremy Fitzhardinge wrote:

>  On 09/21/2010 12:05 PM, Pawe=B3 Zuzelski wrote:
> > Hello,
> >
> > kernels 2.6.35.5 and 2.6.32.22 xen domU panics at the very begining o=
f the
> > boot process.
> >
> > I have bisected it to a single commit, and the first bad commit is:
> > [fb412a178502dc498430723b082a932f797e4763] xen: use percpu interrupts=
 for IPIs and VIRQs
> >
> > kernel v2.6.35.5 with reverted this commit works for me.
>=20
> Thanks very much for doing that.  I'll have to work out what's going on
> (obviously it doesn't do it for me).

Have you seen the message from James Dingwall?

He had found the typo in fb412a178502dc498430723b082a932f797e4763
commit and sent the patch to lkml that fixes it.

Please, see https://patchwork.kernel.org/patch/202282/ if you have
not received James' mail. That patch resolves the problem for me and
for James.

--=20
Regards,
Pawe=B3 Zuzelski
