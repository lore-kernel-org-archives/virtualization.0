From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Lguest32 print hex on bad reads and writes
Date: Thu, 05 Apr 2007 13:34:17 +1000
Message-ID: <1175744057.12230.632.camel@localhost.localdomain>
References: <1175714071.9371.31.camel@localhost.localdomain>
	<1175742090.12230.630.camel@localhost.localdomain>
	<72C854B9-1A7F-44C5-9D62-B6B63F3A6DE7@mac.com>
	<1175742848.9371.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1175742848.9371.33.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-04-04 at 23:14 -0400, Steven Rostedt wrote:
> On Wed, 2007-04-04 at 23:06 -0400, Kyle Moffett wrote:
> =

> > > (Erk, I wonder what I was thinking when I wrote that?) Can I ask  =

> > > for %#x (or 0x%x)?  I'm easily confused.
> > =

> > How about "%p" for pointers?
> =

> But that would require casting the numbers to pointers.

And the kernel's printk doesn't put 0x on pointers anyway, last I
checked 8(

Rusty.
