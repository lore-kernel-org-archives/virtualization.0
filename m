From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v1 01/33] mm: introduce common help functions to
	deal with reserved/managed pages
Date: Wed, 6 Mar 2013 17:21:41 +0000
Message-ID: <20130306172140.GS17833__39340.0937355638$1362591373$gmane$org@n2100.arm.linux.org.uk>
References: <1362495317-32682-1-git-send-email-jiang.liu@huawei.com>
	<1362495317-32682-2-git-send-email-jiang.liu@huawei.com>
	<20130305194722.GA12225@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130305194722.GA12225@merkur.ravnborg.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Aurelien Jacquiot <a-jacquiot@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tang Chen <tangchen@cn.fujitsu.com>, David Howells <dhowells@redhat.com>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, Maciej Rutecki <maciej.rutecki@gmail.com>, Jonas Bonn <jonas@southpole.se>, Mark Salter <msalter@redhat.com>, Michel Lespinasse <walken@google.com>, Mikael Starvik <starvik@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 05, 2013 at 08:47:22PM +0100, Sam Ravnborg wrote:
> On Tue, Mar 05, 2013 at 10:54:44PM +0800, Jiang Liu wrote:
> > +static inline void free_initmem_default(int poison)
> > +{
> 
> Why request user to supply the poison argumet. If this is the default
> implmentation then use the default poison value too (POISON_FREE_INITMEM)

That poison value is inappropriate on some architectures like ARM - it's
executable.  The default poison value leads to:

   0:	cccccccc 	stclgt	12, cr12, [ip], {204}	; 0xcc

or

   4:	cccc      	ldmia	r4!, {r2, r3, r6, r7}

And we might as well forget using any kind of poison in that case.

The value which use is an undefined instruction on ARM and Thumb.

Notice the calls to poison_init_mem() in arch/arm/mm/init.c, which are
left by these patches, allowing us to continue using an appropriate
architecture specific value which will help to ensure that people
calling discarded init functions get appropriately bitten.
