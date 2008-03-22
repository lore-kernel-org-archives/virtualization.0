From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [kvm-devel] [RFC/PATCH 14/15] guest: detect when running on kvm
Date: Sat, 22 Mar 2008 18:25:27 +0100
Message-ID: <20080322172527.GC6367__23478.9602146067$1206206928$gmane$org@osiris.boeblingen.de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030326.6690.65.camel@cotte.boeblingen.de.ibm.com>
	<20080320175357.GA30959@infradead.org>
	<47E2CAFF.3070203@de.ibm.com> <20080320194137.GA9975@infradead.org>
	<47E2D034.4090600@de.ibm.com>
	<20080320212255.GA4225@osiris.boeblingen.de.ibm.com>
	<47E39804.4030605@de.ibm.com>
	<20080321140603.GC4128@osiris.boeblingen.de.ibm.com>
	<1206110009.8363.3.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1206110009.8363.3.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carsten Otte <cotte@de.ibm.com>
Cc: carsteno@linux.vnet.ibm.com, Christian Ehrhardt <EHRHARDT@de.ibm.com>, arnd@arndb.de, hollisb@us.ibm.com, carsteno@de.ibm.com, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, kvm-devel@lists.sourceforge.net, borntrae@linux.vnet.ibm.com, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 21, 2008 at 03:33:29PM +0100, Carsten Otte wrote:
> Am Freitag, den 21.03.2008, 15:06 +0100 schrieb Heiko Carstens:
> > Just introduce something like MACHINE_FLAG_KVM. The rest can be converted
> > later. Unless you're bored and feel like fiddling around with assembly code :)
> I've done that patch this morning already, see below. I agree with HCH
> that we should do that, but after the kvm merge. I don't want kvm-s390
> conflict with Martin's patches. This is just a beautification, and can
> safely wait a release cycle.

That's nice for a start. But you didn't convert the assembly files to use
the new defines. So there is still no connection between setting a bit
in asm code and the new defines.
That's the reason why I said something about fiddling around with asm code.
