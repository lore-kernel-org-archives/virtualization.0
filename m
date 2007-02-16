From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options and disable
	unsupported config options.
Date: Thu, 15 Feb 2007 23:06:11 -0800
Message-ID: <20070215230611.d89e26be.akpm@linux-foundation.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.570154735@goop.org> <45D54BD5.8010707@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D54BD5.8010707@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Dan Hecht <dhecht@vmware.com>
Cc: Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Chris@smtp.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Feb 2007 22:14:45 -0800 Dan Hecht <dhecht@vmware.com> wrote:

> >  config PREEMPT
> >  	bool "Preemptible Kernel (Low-Latency Desktop)"
> > +	depends on !XEN
> >  	help
> >  	  This option reduces the latency of the kernel by making
> >  	  all kernel code (that is not executing in a critical section)
> > =


Oh, so that's why it doesn't break when CONFIG_PREEMPT=3Dy.  In which case
that preempt_disable() I spotted is wrong-and-unneeded.

Why doesn't Xen work with preemption??

> I hate to sound like a broken record, but this really isn't the right =

> way to do this.  If you are going to inhibit config settings when Xen =

> support is compiled, then it should be:
> =

> config XEN
>      depends on !KEXEC && !DOUBLEFAULT && HZ_100 && !PREEMPT
> =


Agree.
