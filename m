From: Ingo Molnar <mingo@elte.hu>
Subject: Xen & VMI?
Date: Tue, 6 Mar 2007 09:19:09 +0100
Message-ID: <20070306081909.GA9331@elte.hu>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45ECC9B6.1060209@goop.org>
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
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


btw., while we have everyone on the phone and talking ;) Technologically =

it would save us a whole lot of trouble in Linux if 'external' =

hypervisors could standardize around a single ABI - such as VMI. Is =

there any deep reason why Xen couldnt use VMI to talk to Linux? I =

suspect a range of VMI vectors could be set aside for Xen's dom0 (and =

other) APIs that have no current VMI equivalent - if there's broad =

agreement on the current 60+ base VMI vectors that center around basic =

x86 CPU capabilities - which make up the largest portion of our =

paravirtualization complexity. Pipe dream?

there are already 5 major hypervisors we are going to support (in =

alphabetical order):

 - KVM
 - lguest
 - Windows
 - VMWare
 - Xen

the QA matrix is gonna be a _mess_. Okay, lguest and KVM is special =

because both the client and the server side is in the same source code, =

so the ABI [if any] is alot easier to manage. That still leaves another =

three...

	Ingo
