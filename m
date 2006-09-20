From: Andi Kleen <ak@muc.de>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: 20 Sep 2006 19:49:27 +0200
Message-ID: <20060920174927.GA56061@muc.de>
References: <1158635617.21726.8.camel@localhost.localdomain>
	<20060920160905.GA47657@muc.de>
	<1158768906.9633.63.camel@mulgrave.il.steeleye.com>
	<200609201822.13488.ak@muc.de>
	<1158770537.9633.82.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Date: Wed, 20 Sep 2006 19:49:27 +0200
Content-Disposition: inline
In-Reply-To: <1158770537.9633.82.camel@mulgrave.il.steeleye.com>
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

On Wed, Sep 20, 2006 at 12:42:17PM -0400, James Bottomley wrote:
> On Wed, 2006-09-20 at 18:22 +0200, Andi Kleen wrote:
> > Well that's your problem then. Just add the remapping array.
> =

> I don't see why I should be the one to add unnecessary obfuscation.
> Using the current ID scheme, the user always knows exactly where to find
> CPU<n> in the chassis (and they are separately installable and
> removable).  Why should I make up a new identity scheme that would have
> no relation to the hardware?

Because it makes it easier to write other code? We don't really
want any unnecessary limiting assumptions in arch/i386 just because
of some obscure machine with one user.


-Andi
