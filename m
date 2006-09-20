From: Andi Kleen <ak@muc.de>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: Wed, 20 Sep 2006 18:22:13 +0200
Message-ID: <200609201822.13488.ak@muc.de>
References: <1158635617.21726.8.camel@localhost.localdomain>
	<20060920160905.GA47657@muc.de>
	<1158768906.9633.63.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1158768906.9633.63.camel@mulgrave.il.steeleye.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: James Bottomley <James.Bottomley@steeleye.com>, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 20 September 2006 18:15, James Bottomley wrote:
> On Wed, 2006-09-20 at 18:09 +0200, Andi Kleen wrote:
> > As APIC ID (hard_smp_processor_id()) possible, but surely not as linux =
logical
> >  processor id (smp_processor_id()). That always starts with 0 and goes =
up.
> =

> Voyager is not APIC based.  The SMP hal is constructed so there's no
> such thing as processor translation.  hard and soft processor IDs return
> the same thing.

Well that's your problem then. Just add the remapping array.

-Andi
