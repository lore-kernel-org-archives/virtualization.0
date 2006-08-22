From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 16:58:13 +0100
Message-ID: <1156262293.27114.24.camel@localhost.localdomain>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<44DB7596.6010503@goop.org>
	<1156254965.27114.17.camel@localhost.localdomain>
	<44EB1BEB.60202@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44EB1BEB.60202@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Ar Maw, 2006-08-22 am 07:59 -0700, ysgrifennodd Jeremy Fitzhardinge:
> out, nothing is actually read-only in the kernel when using a 2M =

> mapping.  It's also ameliorated by the fact that some of the entrypoints =


Thats a loader problem. It ties directly in with things like relocatable
kernels. Arjan has been systematically working to get us "const" objects
and that needs to continue, and the more we can enforce it the more
security we get and the more bugs we catch.

It's also a mistake to assume the read-only doesn't help. Your 2MB
sections penalty isnt true in a virtualised environment.

Alan
