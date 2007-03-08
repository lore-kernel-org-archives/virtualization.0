From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 17:23:35 -0800
Message-ID: <45EF6597.5060104@goop.org>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	<45ED16D2.3000202@vmware.com>	<20070306084258.GA15745@elte.hu>	<20070306084647.GA16280@elte.hu>	<45ED2C82.3080008@vmware.com>	<1173178774.24738.311.camel@localhost.localdomain>	<45EDD82F.90204@vmware.com>	<1173225182.24738.507.camel@localhost.localdomain>	<45EE0628.1080108@goop.org>	<45EE08E8.2020008@vmware.com>	<1173228544.24738.514.camel@localhost.localdomain>	<45EE0D10.7070807@vmware.com>	<1173230305.24738.529.camel@localhost.localdomain>	<45EE1EA3.90803@vmware.com>	<1173256666.24738.576.camel@localhost.localdomain>	<45EEF966.6060902@goop.org>	<Line.LNX.4.64.0703071304080.1851@d.namei>	<45EF0CF5.5090305@goop.org>	<45EF175D.6030609@vmware.com>	<1173302503.24738.795.camel@localhost.localdomain>	<45EF372E.7030600@goop.org>	<1173308717.24738.898.camel@localhost.localdomain>	<45EF49E9.7040509@vmware.com>	<1173313373.24738.937.ca
 mel@localhost.localdomain>
	<45EF6077.9090302@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45EF6077.9090302@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Daniel Arai <arai@vmware.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Daniel Arai wrote:
> But more importantly, we want a kernel that can run both on native hardwa=
re and =

> in a paravirtualized environment.  Linux doesn't really provide abstracti=
ons for =

>   replacing the appropriate code.  We tried to hook into the source code =
at a =

> level that seemed possible.
>   =


Xen doesn't support any kind of apic emulation, so we'll need to hook
anything which relies on an apic.  The ipi code you quote below will
probably be one of those.

My opinion is that pv_ops shouldn't have raw apic operations, but
instead have appropriate high-level interfaces to achieve the same
ends.  Zach's counter-argument was basically your's: that the VMI code
will use a lot of the native code except for the actual apic operations.

I can live with VMI emulating apics if it wants, so long as it does it
in private and doesn't make a big scene about it.  We'll need the
high-level interfaces regardless.

    J
