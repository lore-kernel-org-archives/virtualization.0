From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 09:52:22 +0100
Message-ID: <20070306085222.GA17002@elte.hu>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45ED2837.3020108@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


* Gerd Hoffmann <kraxel@suse.de> wrote:

> Ingo Molnar wrote:
> > btw., while we have everyone on the phone and talking ;) Technologicall=
y =

> > it would save us a whole lot of trouble in Linux if 'external' =

> > hypervisors could standardize around a single ABI - such as VMI. Is =

> > there any deep reason why Xen couldnt use VMI to talk to Linux? I =

> > suspect a range of VMI vectors could be set aside for Xen's dom0 (and =

> > other) APIs that have no current VMI equivalent - if there's broad =

> > agreement on the current 60+ base VMI vectors that center around basic =

> > x86 CPU capabilities - which make up the largest portion of our =

> > paravirtualization complexity. Pipe dream?
> =

> IIRC there was some proof-of-concept at least for xen guests.

yes - but de-facto contradicted by the Xen paravirt_ops patches sent to =

lkml ;)

> > there are already 5 major hypervisors we are going to support (in =

> > alphabetical order):
> > =

> >  - KVM
> >  - lguest
> >  - Windows
> >  - VMWare
> >  - Xen
> > =

> > the QA matrix is gonna be a _mess_.
> =

> I fail to see how xen-via-vmirom instead of xen-via-paravirt_ops =

> reduces the QA effort.  You still have 5 Hypervisors you have to test =

> against.

yes, just like we have thousands of separate PC boards to support. But =

as long as the basic ABI is the same, the QA effort on the Linux kernel =

side is alot more focused. (Distros still have 18446744073709551616 =

total combinations to QA, and have to make an educated guess to reduce =

that to a more manageable number.)

	Ingo
