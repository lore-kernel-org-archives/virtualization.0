From: Sander Eikelenboom <linux@eikelenboom.it>
Subject: Re: [Xen-devel] [PATCH] xen: remove unused Kconfig parameter
Date: Wed, 10 Jul 2013 00:34:58 +0200
Message-ID: <1382658288.20130710003458__40806.9139499732$1373409890$gmane$org@eikelenboom.it>
References: <1373264904-27053-1-git-send-email-michael.opdenacker@free-electrons.com>
	<20130708192854.GF4927@phenom.dumpdata.com>
	<20130708193457.GA6926@u109add4315675089e695.ant.amazon.com>
	<51DB2134.9040909@zytor.com> <20130708205834.GA481@pd.tnic>
	<1373326534.1438.10.camel@x61.thuisdomein>
	<f5d6bd67-7464-4932-a7ca-6026fe534fc7@email.android.com>
	<51DBDAB802000078000E37C1@nat28.tlf.novell.com>
	<20130709144840.GF24897@phenom.dumpdata.com>
	<20130709150554.GA27579@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130709150554.GA27579@pd.tnic>
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
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Matt Wilson <msw@amazon.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, x86@kernel.org, Paul Bolle <pebolle@tiscali.nl>, virtualization@lists.linux-foundation.org, mingo@redhat.com, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


Tuesday, July 9, 2013, 5:05:54 PM, you wrote:

> On Tue, Jul 09, 2013 at 10:48:40AM -0400, Konrad Rzeszutek Wilk wrote:
>> Then that should be discussed on grub2 to remove said check and modify
>> the code so that it can properly work without regression.

> Actually, the kernel patch removing that symbol should be applied so
> that grub2 breaks faster. One can't possibly rely on kernel internals
> for anything, as it is insanely insane (yep, the tautology is on purpose
> :-)).


How insanely insane is it to be able to determine whether a certain compiled kernel binary supports a certain function ?

Grub does this in it's update script to prevent adding a xen + kernel combination that has no chance of booting when dom0 support has not been configured in the kernel.
That doesn't seem to be a unreasonable thought.

Grepping the accompanied config file in /boot for the xen dom0 Kconfig parameter seems the best possible effort grub can do at the moment.
Especially since the Kconfig parameter naming doesn't change that often.

If you know a better way for grub to determine if a certain function for a kernel binary is supported then please elaborate ..

 --
 Sander
