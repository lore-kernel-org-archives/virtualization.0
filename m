From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove unused Kconfig parameter
Date: Thu, 11 Jul 2013 14:24:21 -0400
Message-ID: <20130711182421.GA8056@konrad-lan.dumpdata.com>
References: <1373264904-27053-1-git-send-email-michael.opdenacker@free-electrons.com>
	<20130708192854.GF4927@phenom.dumpdata.com>
	<20130708193457.GA6926@u109add4315675089e695.ant.amazon.com>
	<51DB2134.9040909@zytor.com> <20130708205834.GA481@pd.tnic>
	<1373326534.1438.10.camel@x61.thuisdomein>
	<f5d6bd67-7464-4932-a7ca-6026fe534fc7@email.android.com>
	<1373537338.9708.18.camel@x61.thuisdomein>
	<51DEF1F3.2020900@zytor.com>
	<1373566438.1349.21.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1373566438.1349.21.camel@x61.thuisdomein>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Michael Opdenacker <michael.opdenacker@free-electrons.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, Matt Wilson <msw@amazon.com>, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 11, 2013 at 08:13:58PM +0200, Paul Bolle wrote:
> On Thu, 2013-07-11 at 10:57 -0700, H. Peter Anvin wrote:
> > On 07/11/2013 03:08 AM, Paul Bolle wrote:
> > > But the Kconfig entry for XEN_PRIVILEGED_GUEST reads: 
> > >     # Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
> > >     # name in tools.
> > >     config XEN_PRIVILEGED_GUEST
> > >             def_bool XEN_DOM0
> > > 
> > > In other words: CONFIG_XEN_PRIVILEGED_GUEST should always be equal to
> > > CONFIG_XEN_DOM0. So the two grep commands should always both evaluate to
> > > true or both evaluate to false. One of these two commands can safely be
> > > dropped.
> > 
> > Not necessarily true across kernel versions.
> 
> Correct. But it has actually been true ever since this Kconfig entry was
> introduced in v2.6.37 (commit 6b0661a5e6fbfb159b78a39c0476905aa9b575fe,
> "xen: introduce XEN_DOM0 as a silent option").
> 
> So people need not worry about breaking grub2 by dropping
> XEN_PRIVILEGED_GUEST.

Right, but when we drop the CONFIG_XEN_DOM0 as well (and have instead a
CONFIG_XEN_HARDWARE_DOMAIN_SOMETHING_LIKE_THAT_I_FORGOT_NOW_THE_NAME),
then this will be a problem. Sander's proposal on fixing it "right" in
grub2 using whatever is the proper way (whatever that is) is the right
thing to do first.

Then we can make the Kconfig entries be more in line with the different
divisions of guest types - instead of the simplified
'dump-it-all-in-dom0'. This means more surgery in the Kconfig than the
initial patch posted here. This assuming that both Peter's and Boris's
assertion that CONFIG_* entries do not fall in the "must not break
user-space" category.
