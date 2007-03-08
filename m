From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 8 Mar 2007 12:23:50 -0800
Message-ID: <20070308202350.GL10574@sequoia.sous-sol.org>
References: <1173308717.24738.898.camel@localhost.localdomain>
	<45EF49E9.7040509@vmware.com>
	<1173313373.24738.937.camel@localhost.localdomain>
	<45EF6077.9090302@vmware.com>
	<20070308182456.GH19575@sequoia.sous-sol.org>
	<45F06720.8080901@goop.org>
	<20070308194740.GJ10574@sequoia.sous-sol.org>
	<45F06989.8030207@goop.org>
	<20070308201033.GK10574@sequoia.sous-sol.org>
	<45F06FB3.105@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45F06FB3.105@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> I guess by "rest of the kernel" you mean other stuff in arch/i386.  Yes,
> that's a concern, but maybe we can tease it apart in a sensible way.

Yes, that's exactly what I'm saying.  Same with above (the native stuff), s=
ince
we don't want a bunch of apic_read type of pv_ops (oh, wait... ;-)  Of cour=
se,
dom0 will be another can of worms, but one at a time.
