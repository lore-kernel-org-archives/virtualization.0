From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 6/7] paravirtualization: Add APIC accessors to
	paravirt-ops.
Date: Thu, 02 Nov 2006 11:46:23 +1100
Message-ID: <1162428383.6848.11.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	<1162178936.9802.34.camel@localhost.localdomain>
	<20061030231132.GA98768@muc.de>
	<1162376827.23462.5.camel@localhost.localdomain>
	<1162376894.23462.7.camel@localhost.localdomain>
	<1162376981.23462.10.camel@localhost.localdomain>
	<1162377043.23462.12.camel@localhost.localdomain>
	<1162377093.23462.14.camel@localhost.localdomain>
	<1162377150.23462.16.camel@localhost.localdomain>
	<20061101153102.a192f6c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061101153102.a192f6c9.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-11-01 at 15:31 -0800, Andrew Morton wrote:
> On Wed, 01 Nov 2006 21:32:30 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> =

> > +static __inline void apic_write(unsigned long reg, unsigned long v)
> > +static __inline void apic_write_atomic(unsigned long reg, unsigned lon=
g v)
> > +static __inline unsigned long apic_read(unsigned long reg)
> =

> Just `inline', please.

akpm says: "Just `inline', please."

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 3a3bc9aed04c include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Thu Nov 02 11:42:22 2006 +1100
+++ b/include/asm-i386/paravirt.h	Thu Nov 02 11:44:15 2006 +1100
@@ -304,17 +304,17 @@ static inline void slow_down_io(void) {
 /*
  * Basic functions accessing APICs.
  */
-static __inline void apic_write(unsigned long reg, unsigned long v)
+static inline void apic_write(unsigned long reg, unsigned long v)
 {
 	paravirt_ops.apic_write(reg,v);
 }
 =

-static __inline void apic_write_atomic(unsigned long reg, unsigned long v)
+static inline void apic_write_atomic(unsigned long reg, unsigned long v)
 {
 	paravirt_ops.apic_write_atomic(reg,v);
 }
 =

-static __inline unsigned long apic_read(unsigned long reg)
+static inline unsigned long apic_read(unsigned long reg)
 {
 	return paravirt_ops.apic_read(reg);
 }
