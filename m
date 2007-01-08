From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] x86_64 paravirt_ops port
Date: Tue, 09 Jan 2007 10:05:40 +1100
Message-ID: <1168297540.19646.40.camel@localhost.localdomain>
References: <20070108140826.GA1624@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070108140826.GA1624@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-01-08 at 12:08 -0200, Glauber de Oliveira Costa wrote:
> Hi all,
> =

> I've been working on a port of paravirt_ops for the x86_64 architectures
> for a couple of days. Here's the result so far. I'm posting it soon for
> early cooments. The more, the better.

Hi Glauber!

	This looks like a great start!  Note that i386 is heading away from
exporting the entire paravirt_ops structure and just exporting some
wrappers, but that can be retro'd in once you've got it all working.

There's one critical bug which will stop it from booting reliably:
> +    Based on i386 work by Rusty Russel.

Cheers!
Rusty Russell.
