From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: Wed, 20 Sep 2006 12:42:17 -0400
Message-ID: <1158770537.9633.82.camel@mulgrave.il.steeleye.com>
References: <1158635617.21726.8.camel@localhost.localdomain>
	<20060920160905.GA47657@muc.de>
	<1158768906.9633.63.camel@mulgrave.il.steeleye.com>
	<200609201822.13488.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200609201822.13488.ak@muc.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-09-20 at 18:22 +0200, Andi Kleen wrote:
> Well that's your problem then. Just add the remapping array.

I don't see why I should be the one to add unnecessary obfuscation.
Using the current ID scheme, the user always knows exactly where to find
CPU<n> in the chassis (and they are separately installable and
removable).  Why should I make up a new identity scheme that would have
no relation to the hardware?

James
