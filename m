From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] Lguest32 print hex on bad reads and writes
Date: Wed, 4 Apr 2007 23:06:39 -0400
Message-ID: <72C854B9-1A7F-44C5-9D62-B6B63F3A6DE7@mac.com>
References: <1175714071.9371.31.camel@localhost.localdomain>
	<1175742090.12230.630.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1175742090.12230.630.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Apr 04, 2007, at 23:01:30, Rusty Russell wrote:
> On Wed, 2007-04-04 at 15:14 -0400, Steven Rostedt wrote:
>> Currently the lguest32 error messages from bad reads and writes  =

>> prints a decimal integer for addresses. This is pretty annoying.  =

>> So this patch changes those to be hex outputs.
>
> (Erk, I wonder what I was thinking when I wrote that?) Can I ask  =

> for %#x (or 0x%x)?  I'm easily confused.

How about "%p" for pointers?

Cheers,
Kyle Moffett
