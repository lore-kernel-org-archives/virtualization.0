From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Xen-devel] [PATCH] xen: remove unused Kconfig parameter
Date: Wed, 10 Jul 2013 05:20:56 +0200
Message-ID: <20130710032056.GA14873@pd.tnic>
References: <20130708192854.GF4927@phenom.dumpdata.com>
	<20130708193457.GA6926@u109add4315675089e695.ant.amazon.com>
	<51DB2134.9040909@zytor.com> <20130708205834.GA481@pd.tnic>
	<1373326534.1438.10.camel@x61.thuisdomein>
	<f5d6bd67-7464-4932-a7ca-6026fe534fc7@email.android.com>
	<51DBDAB802000078000E37C1@nat28.tlf.novell.com>
	<20130709144840.GF24897@phenom.dumpdata.com>
	<20130709150554.GA27579@pd.tnic>
	<1382658288.20130710003458@eikelenboom.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1382658288.20130710003458@eikelenboom.it>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sander Eikelenboom <linux@eikelenboom.it>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Matt Wilson <msw@amazon.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, x86@kernel.org, Paul Bolle <pebolle@tiscali.nl>, virtualization@lists.linux-foundation.org, mingo@redhat.com, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 10, 2013 at 12:34:58AM +0200, Sander Eikelenboom wrote:
> Grub does this in it's update script to prevent adding a xen + kernel
> combination that has no chance of booting when dom0 support has not
> been configured in the kernel. That doesn't seem to be a unreasonable
> thought.

Actually, I don't see the problem - if there's no such support, then the
boot fails - plain and simple. That's like not building in or adding
into the initrd, support for your root filesystem - it is your own damn
fault. It is not the bootloader's job to sanity check whether your
kernel boots or not.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
