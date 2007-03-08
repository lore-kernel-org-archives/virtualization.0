From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 8 Mar 2007 12:42:21 -0800
Message-ID: <20070308204221.GM10574@sequoia.sous-sol.org>
References: <1173313373.24738.937.camel@localhost.localdomain>
	<45EF6077.9090302@vmware.com>
	<20070308182456.GH19575@sequoia.sous-sol.org>
	<45F06720.8080901@goop.org>
	<20070308194740.GJ10574@sequoia.sous-sol.org>
	<45F06989.8030207@goop.org>
	<20070308201033.GK10574@sequoia.sous-sol.org>
	<45F06FB3.105@goop.org>
	<20070308202350.GL10574@sequoia.sous-sol.org>
	<45F07334.7010207@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45F07334.7010207@goop.org>
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
> Maybe hooking into genapic is the right way to mop up all the uses of
> send_IPI and its variants.  But from a quick grep it doesn't look like
> they get called from too many places...  Most of the callers seem to be
> in arch/i386/kernek/smp.c, so they should be pretty easy to isolate.

Yeah, we'll see once we are crashing and debugging some code ;-)
