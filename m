From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove unused Kconfig parameter
Date: Tue, 09 Jul 2013 08:09:51 -0700
Message-ID: <51DC27BF.9090606@zytor.com>
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
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Jan Beulich <JBeulich@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, x86@kernel.org, Paul Bolle <pebolle@tiscali.nl>, virtualization@lists.linux-foundation.org, mingo@redhat.com, Matt Wilson <msw@amazon.com>, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/09/2013 08:05 AM, Borislav Petkov wrote:
> On Tue, Jul 09, 2013 at 10:48:40AM -0400, Konrad Rzeszutek Wilk wrote:
>> Then that should be discussed on grub2 to remove said check and modify
>> the code so that it can properly work without regression.
> 
> Actually, the kernel patch removing that symbol should be applied so
> that grub2 breaks faster. One can't possibly rely on kernel internals
> for anything, as it is insanely insane (yep, the tautology is on purpose
> :-)).
> 

Indeed, especially since it inherently assumes something is a kernel
compile-time option... we routinely change things between compile time
and runtime.

	-hpa
