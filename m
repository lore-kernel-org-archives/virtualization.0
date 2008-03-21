From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [kvm-devel] [RFC/PATCH 14/15] guest: detect when running on kvm
Date: Fri, 21 Mar 2008 15:06:03 +0100
Message-ID: <20080321140603.GC4128__24169.8704231114$1206108561$gmane$org@osiris.boeblingen.de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030326.6690.65.camel@cotte.boeblingen.de.ibm.com>
	<20080320175357.GA30959@infradead.org>
	<47E2CAFF.3070203@de.ibm.com> <20080320194137.GA9975@infradead.org>
	<47E2D034.4090600@de.ibm.com>
	<20080320212255.GA4225@osiris.boeblingen.de.ibm.com>
	<47E39804.4030605@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47E39804.4030605@de.ibm.com>
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
Cc: carsteno@linux.vnet.ibm.com, Christian Ehrhardt <EHRHARDT@de.ibm.com>, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heicars2@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, borntrae@linux.vnet.ibm.com, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 21, 2008 at 12:12:04PM +0100, Carsten Otte wrote:
> MAILER-DAEMON@linux.ibm.com wrote:
>> Since when do we have symbolic names for the bits?
>> It was always on my todo list to do a cleanup and replace the numbers
>> we use everywhere with names. Especially since we have clashes from time
>> to time... but that didn't hurt enough yet, obviously.
>> But now that you volunteered to take care of this... :)
> Right. We only have defines for (machine_flags & bit). Looks to me like 
> the bits really should have a name on them. I've created a patch that 
> does this, but I want to talk it over with Martin before sending that one 
> out.

Just introduce something like MACHINE_FLAG_KVM. The rest can be converted
later. Unless you're bored and feel like fiddling around with assembly code :)
