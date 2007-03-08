From: Ingo Molnar <mingo@elte.hu>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 8 Mar 2007 20:17:12 +0100
Message-ID: <20070308191712.GA794@elte.hu>
References: <45EF175D.6030609@vmware.com>
	<1173302503.24738.795.camel@localhost.localdomain>
	<45EF372E.7030600@goop.org>
	<1173308717.24738.898.camel@localhost.localdomain>
	<45EF49E9.7040509@vmware.com>
	<1173313373.24738.937.camel@localhost.localdomain>
	<45EF6077.9090302@vmware.com>
	<20070308182456.GH19575@sequoia.sous-sol.org>
	<45F05999.20803@vmware.com>
	<20070308191409.GI10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070308191409.GI10574@sequoia.sous-sol.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, tglx@linutronix.de, akpm@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


* Chris Wright <chrisw@sous-sol.org> wrote:

> > Chris, would you like to work together on this?  I don't know what =

> > Xen's requirements are for the APIC interface.  Do you think we =

> > could come up with something that would fit both of our needs, and =

> > maybe also be usable for some of the subarch-specific code?
> =

> Sure, we just have a pretty small genapic_xen, and then enough =

> (hackery, this should be sorted out) to use that genapic and have an =

> effective override for __send_IPI_shortcut.

genapic is still too lowlevel: as Thomas mentioned what we want is a =

virtual interrupt controller used by /all/ hypervisors (and mapped to =

their respective hypervisor ABIs via the backend).

	Ingo
