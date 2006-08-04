From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: A proposal - binary
Date: Fri, 04 Aug 2006 22:26:40 +0100
Message-ID: <1154726800.23655.273.camel@localhost.localdomain>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	<44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	<20060804183448.GE11244@sequoia.sous-sol.org>
	<44D3B0F0.2010409@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44D3B0F0.2010409@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xensource.com, Greg KH <greg@kroah.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, James.Bottomley@steeleye.com, pazke@donpac.ru
List-Id: virtualization@lists.linuxfoundation.org

Ar Gwe, 2006-08-04 am 13:41 -0700, ysgrifennodd Zachary Amsden:
> committed to working on it.  Which is why I wanted feedback on what we =

> have to do to make sure our ESX implementation is done in a way that is =

> acceptable to the community.  I too would like to push for an interface =

> in 2.6.19, and we can't have confusion on this issue be a last minute =

> stopper.

In part thats a legal question so only a lawyer can really tell you what
is and isn't the line for derivative works. =


Philosophically I can see the argument that the moment you hit a
hypervisor trap its akin to running another app (and an app which
communicates via that interface with many othr apps) so your Linux
kernel side code would be GPL and whatever it fires up which handles the
trap come syscall probably isn't. But I'm not a lawyer and neither you
nor anyone else, nor a court reviewing a case should consider the
statement above a guideline of intent.

Alan
