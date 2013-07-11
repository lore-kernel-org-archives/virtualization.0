From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove unused Kconfig parameter
Date: Thu, 11 Jul 2013 10:57:07 -0700
Message-ID: <51DEF1F3.2020900@zytor.com>
References: <1373264904-27053-1-git-send-email-michael.opdenacker@free-electrons.com>
	<20130708192854.GF4927@phenom.dumpdata.com>
	<20130708193457.GA6926@u109add4315675089e695.ant.amazon.com>
	<51DB2134.9040909@zytor.com> <20130708205834.GA481@pd.tnic>
	<1373326534.1438.10.camel@x61.thuisdomein>
	<f5d6bd67-7464-4932-a7ca-6026fe534fc7@email.android.com>
	<1373537338.9708.18.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1373537338.9708.18.camel@x61.thuisdomein>
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
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, Matt Wilson <msw@amazon.com>, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On 07/11/2013 03:08 AM, Paul Bolle wrote:
> On Mon, 2013-07-08 at 20:26 -0400, Konrad Rzeszutek Wilk wrote:
>> Could you explain to me please why the check in the scripts is
>> superfluous?
> 
> The discussion has since moved on a bit, but I haven't answered this
> question yet.
> 
> The check grub2 currently performs in one of its configuration scripts
> is (reformatted):
>     if (grep -qx "CONFIG_XEN_DOM0=y" "${config}" 2> /dev/null ||
>         grep -qx "CONFIG_XEN_PRIVILEGED_GUEST=y" "${config}" 2> /dev/null);
>     then echo -n "$i " ;
>     fi
> 

If only grep supported looking for more than one string at a time.
Maybe we could construct some kind of pattern expression syntax for it,
perhaps based on the theory of regular languages?

> But the Kconfig entry for XEN_PRIVILEGED_GUEST reads: 
>     # Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
>     # name in tools.
>     config XEN_PRIVILEGED_GUEST
>             def_bool XEN_DOM0
> 
> In other words: CONFIG_XEN_PRIVILEGED_GUEST should always be equal to
> CONFIG_XEN_DOM0. So the two grep commands should always both evaluate to
> true or both evaluate to false. One of these two commands can safely be
> dropped.

Not necessarily true across kernel versions.

> Another consequence is that dropping XEN_PRIVILEGED_GUEST doesn't break
> this configuration script. It will still behave as it does now.
> 
> (Whether that script should grep for Kconfig macros in the first place
> is another discussion.)

"Hell no".

	-hpa
