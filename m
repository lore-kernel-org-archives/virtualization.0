From: Andi Kleen <ak@muc.de>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: 20 Sep 2006 20:42:09 +0200
Message-ID: <20060920184209.GA61408@muc.de>
References: <1158635617.21726.8.camel@localhost.localdomain>
	<20060920160905.GA47657@muc.de>
	<1158768906.9633.63.camel@mulgrave.il.steeleye.com>
	<200609201822.13488.ak@muc.de>
	<1158770537.9633.82.camel@mulgrave.il.steeleye.com>
	<20060920174927.GA56061@muc.de>
	<1158775832.9633.115.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Date: Wed, 20 Sep 2006 20:42:09 +0200
Content-Disposition: inline
In-Reply-To: <1158775832.9633.115.camel@mulgrave.il.steeleye.com>
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

On Wed, Sep 20, 2006 at 02:10:31PM -0400, James Bottomley wrote:
> On Wed, 2006-09-20 at 19:49 +0200, Andi Kleen wrote:
> > Because it makes it easier to write other code? We don't really
> > want any unnecessary limiting assumptions in arch/i386 just because
> > of some obscure machine with one user.
> =

> Really?  I don't see it that way.  I did a lot of work back in 2000/2001
> to break x86 of its remapped CPU assumptions ... it's been operating
> nicely for 6 years, I don't see a reason to break it now.

There are already CPU #0 assumptions in various paths, although
they might not affect you.

> =

> Also, as we enter the era of hotplug CPUs, when a non voyager x86 system
> tells you CPU3 is overheating, how to you find out exactly which CPU to
> hot unplug?

Right now you can't anyways, but at some point I would expect this
information to be in the SMBIOS (mapped from APIC-ID) and giving
some label that is printed on the motherboard.

We already support this for DIMMs BTW (although it doesn't work
everywhere due to very creative spec interpretation of some vendors) =


-Andi
