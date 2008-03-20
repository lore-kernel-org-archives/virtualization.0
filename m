From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [kvm-devel] [RFC/PATCH 14/15] guest: detect when running on kvm
Date: Thu, 20 Mar 2008 22:22:55 +0100
Message-ID: <20080320212255.GA4225__4175.61805011264$1206052565$gmane$org@osiris.boeblingen.de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030326.6690.65.camel@cotte.boeblingen.de.ibm.com>
	<20080320175357.GA30959@infradead.org>
	<47E2CAFF.3070203@de.ibm.com> <20080320194137.GA9975@infradead.org>
	<47E2D034.4090600@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47E2D034.4090600@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: carsteno@de.ibm.com
Cc: Christian Ehrhardt <EHRHARDT@de.ibm.com>, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, borntrae@linux.vnet.ibm.com, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 20, 2008 at 09:59:32PM +0100, Carsten Otte wrote:
> Christoph Hellwig wrote:
> > On Thu, Mar 20, 2008 at 09:37:19PM +0100, Carsten Otte wrote:
> >> Christoph Hellwig wrote:
> >>> On Thu, Mar 20, 2008 at 05:25:26PM +0100, Carsten Otte wrote:
> >>>> @@ -143,6 +143,10 @@ static noinline __init void detect_machi
> >>>>  	/* Running on a P/390 ? */
> >>>>  	if (cpuinfo->cpu_id.machine == 0x7490)
> >>>>  		machine_flags |= 4;
> >>>> +
> >>>> +	/* Running under KVM ? */
> >>>> +	if (cpuinfo->cpu_id.version == 0xfe)
> >>>> +		machine_flags |= 64;
> >>> Shouldn't these have symbolic names?
> >> You mean symbolics for machine_flags? Or symbolics for cpu ids?
> > 
> > Either.
> [...]
> The machine flags do have symbolic names, defined in 
> include/asm-s390/setup.h. And yea, they should be used here. Will 
> change that.

Since when do we have symbolic names for the bits?
It was always on my todo list to do a cleanup and replace the numbers
we use everywhere with names. Especially since we have clashes from time
to time... but that didn't hurt enough yet, obviously.
But now that you volunteered to take care of this... :)
