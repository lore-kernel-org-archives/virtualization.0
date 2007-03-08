From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 8 Mar 2007 00:45:52 +0000
Message-ID: <20070308004552.2f9a25d6@lxorguk.ukuu.org.uk>
References: <45EDD82F.90204@vmware.com>
	<1173225182.24738.507.camel@localhost.localdomain>
	<45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>
	<1173228544.24738.514.camel@localhost.localdomain>
	<45EE0D10.7070807@vmware.com>
	<1173230305.24738.529.camel@localhost.localdomain>
	<45EE1EA3.90803@vmware.com>
	<1173256666.24738.576.camel@localhost.localdomain>
	<45EEF966.6060902@goop.org> <20070307174957.GA31371@elte.hu>
	<45EF05F0.7090700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45EF05F0.7090700@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

> Yep, the tsc has myriad problems; for Xen its the best of a bad lot. =

> Unfortunately in 10 years no clearly better alternative has appeared;
> maybe in 10 years there will be one.  It might even be the tsc.

TSC is essentially unusable for any kind of time related work. And I'd
disagree about the alternatives - the HPET and ACPI timers are not bad,
the CMOS timer can be used as an interrupting timer source, and there is
the old PC timer chip. All are superior to the TSC.

Finally for performance management work you've got cycle counters in the
debug side (with interrupt on overflow) which allow you to do management
of resources by cpu ticks or by memory bandwidth utilisation (Sun btw
have a fascinating paper somewhere on the latter)

Alan
