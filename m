From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] lhype: Add TLS support
Date: Thu, 30 Nov 2006 11:50:43 +1100
Message-ID: <1164847843.5694.32.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0611271823380.14443-100000@redline.boston.redhat.com>
	<1164778643.5694.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1164778643.5694.29.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: James Morris <jmorris@redhat.com>
Cc: virtualization <virtualization@lists.osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-11-29 at 16:37 +1100, Rusty Russell wrote:
> 	Untested, but based on your patch.  Does it work?

Actually, I suspect it won't.  Instead of memset'ing to 0, the TLS
segment descriptors should be set to a valid value, such as copying
USER_DS.

Cheers,
Rusty.
