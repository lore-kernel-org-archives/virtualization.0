From: Andi Kleen <ak@muc.de>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: 20 Sep 2006 18:09:05 +0200
Message-ID: <20060920160905.GA47657@muc.de>
References: <1158635617.21726.8.camel@localhost.localdomain>
	<450FA6FB.9020100@goop.org>
	<1158710822.2480.14.camel@localhost.localdomain>
	<200609200900.17193.ak@muc.de>
	<1158756868.9633.0.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Date: Wed, 20 Sep 2006 18:09:05 +0200
Content-Disposition: inline
In-Reply-To: <1158756868.9633.0.camel@mulgrave.il.steeleye.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 20, 2006 at 08:54:28AM -0400, James Bottomley wrote:
> On Wed, 2006-09-20 at 09:00 +0200, Andi Kleen wrote:
> > boot CPU =3D=3D 0 should be true. You just can't assume anything about =
its
> > APIC ID, but we decouple APIC ID and logical processor id anyways.
> =

> No, it is not.  Voyager has fixed and immutable CPU IDs dependent on CPU
> position in the system.  If CPU 0 is missing or logically deconfigured,
> the boot CPU is definitely non zero.

As APIC ID (hard_smp_processor_id()) possible, but surely not as linux logi=
cal
 processor id (smp_processor_id()). That always starts with 0 and goes up.

-Andi
