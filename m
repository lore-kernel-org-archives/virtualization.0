From: Ingo Molnar <mingo@elte.hu>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 7 Mar 2007 18:52:32 +0100
Message-ID: <20070307175232.GB31371@elte.hu>
References: <45EDD82F.90204@vmware.com>
	<1173225182.24738.507.camel@localhost.localdomain>
	<45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>
	<1173228544.24738.514.camel@localhost.localdomain>
	<45EE0D10.7070807@vmware.com>
	<1173230305.24738.529.camel@localhost.localdomain>
	<45EE1EA3.90803@vmware.com>
	<1173256666.24738.576.camel@localhost.localdomain>
	<45EEF966.6060902@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45EEF966.6060902@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> I don't think having a clock implementation for each hypervisor is =

> such a big deal.  The Xen one, for example, is 300 lines of =

> straightforward code.

/For you/ it's certainly no big deal, you dont have to fix it up and you =

dont have to keep it flexible ;)

and really, i'm not expecting miracles, i've never seen any hardware =

vendor argue /against/ support for their own hardware =3DB-)

	Ingo
