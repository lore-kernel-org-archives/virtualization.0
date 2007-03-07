From: James Morris <jmorris@namei.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 7 Mar 2007 13:11:22 -0500 (EST)
Message-ID: <Line.LNX.4.64.0703071304080.1851@d.namei>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>
	<45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>
	<20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>
	<1173178774.24738.311.camel@localhost.localdomain>
	<45EDD82F.90204@vmware.com>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 7 Mar 2007, Jeremy Fitzhardinge wrote:

> I was very pleased when I saw the clocksource/event mechanisms go into
> the kernel because it means different hypervisors can have a clock*
> implementation to match their own particular time model/interface
> without having to clutter up the pv_ops interface, and still have a
> well-defined interface to the rest of the kernel's time infrastructure.

It seems to me that it could be useful to have a library of common virtual =

time code (entirely separate from pv_ops), to avoid re-implementing some =

apparently common requirements, such as: handling TSC frequency changes, =

stolen time accounting, synthetic programmable clockevent etc.


- James
-- =

James Morris
<jmorris@namei.org>
