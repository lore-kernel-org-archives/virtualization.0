From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [Xen-devel] [PATCH] xen: remove unused Kconfig parameter
Date: Tue, 09 Jul 2013 01:35:34 +0200
Message-ID: <1373326534.1438.10.camel__19478.6918735646$1373327339$gmane$org@x61.thuisdomein>
References: <1373264904-27053-1-git-send-email-michael.opdenacker@free-electrons.com>
	<20130708192854.GF4927@phenom.dumpdata.com>
	<20130708193457.GA6926@u109add4315675089e695.ant.amazon.com>
	<51DB2134.9040909@zytor.com> <20130708205834.GA481@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130708205834.GA481@pd.tnic>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, Matt Wilson <msw@amazon.com>, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2013-07-08 at 22:58 +0200, Borislav Petkov wrote:
> On Mon, Jul 08, 2013 at 01:29:40PM -0700, H. Peter Anvin wrote:
> > What. The. Fuck.
> 
> This is just marvellous: grub2 has a bunch of scripts in /etc/grub.d
> which rely on the presence of kernel config files in /boot or / and
> greps them in order to do the menu entries based on the built-in
> features it finds in them.

0) I've raised this issue a few months ago, but not on the LKML (see
http://thread.gmane.org/gmane.linux.kernel.virtualization/19126 ).

1) And I also asked whether "userspace [can] require the build system to
keep using some Kconfig symbol" (see
http://article.gmane.org/gmane.linux.kernel.virtualization/19129 ).
Peter and you clearly think userspace can't.

2) But anyhow, unless that grub2 configuration file has changed, this
Kconfig symbol can still be dropped, because grub2's check for it is
actually superfluous.


Paul Bolle
