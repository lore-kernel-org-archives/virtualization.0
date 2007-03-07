From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 10:35:28 -0800
Message-ID: <45EF05F0.7090700@goop.org>
References: <45EDD82F.90204@vmware.com>
	<1173225182.24738.507.camel@localhost.localdomain>
	<45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>
	<1173228544.24738.514.camel@localhost.localdomain>
	<45EE0D10.7070807@vmware.com>
	<1173230305.24738.529.camel@localhost.localdomain>
	<45EE1EA3.90803@vmware.com>
	<1173256666.24738.576.camel@localhost.localdomain>
	<45EEF966.6060902@goop.org> <20070307174957.GA31371@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070307174957.GA31371@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> ugh. Please take it from me: i've watched the Linux time code walk its =

> long, rocky 10+ years road. One of the first mistakes was when we made =

> the TSC the center of the i386-time universe. (incidentally, it was me =

> who did the first steps of that, as a rookie kernel hacker) We got cured =

> out of that in v2.6.19, v2.6.20 and v2.6.21. Granted, Xen is only at the =

> beginning of that same road. Meet in another 10 years? ;)

Yep, the tsc has myriad problems; for Xen its the best of a bad lot. =

Unfortunately in 10 years no clearly better alternative has appeared;
maybe in 10 years there will be one.  It might even be the tsc.

    J
