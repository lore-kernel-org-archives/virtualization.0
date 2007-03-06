From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Tue, 6 Mar 2007 08:50:57 +0100
Message-ID: <20070306075057.GA6495@elte.hu>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<20070306073511.GA3938@elte.hu> <45ED1B64.9040104@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45ED1B64.9040104@vmware.com>
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
Cc: virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


* Zachary Amsden <zach@vmware.com> wrote:

> > yeah. (plus my patches of course that remove the current =

> > papering-over hackery and restores COMPAT_VDSO.)
> =

> Yes, I don't have a problem with your patch, I just wish I had been =

> cc'd on it. [...]

(i Cc:-ed you to the other ones - i simply forgot and bounced it to you =

a few hours down the line - sorry!)

> [...] Fixing this is rather tricky, but I believe no strange build =

> magic is required, it can be done in kernel init code.  Still building =

> my SUSE 9.0 guest to test.  SUSE 9.0 is one of those that requires =

> COMPAT_VDSO, yes?

yeah, and a handful of other ones. It depends on the glibc version: =

early vdso glibs were buggy and assumed a few things about the vdso, so =

they would segfault on the new-style vdso which is fully relocatable =

(and hence mergable into the vma space, randomizable, etc.).

	Ingo
