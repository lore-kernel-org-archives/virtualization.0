From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC/PATCH 05/15 v3] kvm-s390: s390 arch backend for the kvm
	kernel module
Date: Wed, 2 Apr 2008 12:20:05 +0200
Message-ID: <200804021220.05496.borntraeger__47736.098469659$1207131911$gmane$org@de.ibm.com>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
	<1206467240.6507.41.camel@cotte.boeblingen.de.ibm.com>
	<200803310736.58001.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803310736.58001.arnd@arndb.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Carsten Otte <cotte@de.ibm.com>, aliguori@us.ibm.com, EHRHARDT@de.ibm.com, Arnd Bergmann <arnd@arndb.de>, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, oliver.paukstadt@millenux.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Montag, 31. M=E4rz 2008 schrieb Arnd Bergmann:

Hello Arnd,

thanks for the review.

> On Tuesday 25 March 2008, Carsten Otte wrote:
> =

> > +
> > +static inline void __user *__guestaddr_to_user(struct kvm_vcpu *vcpu,
> > +					       u64 guestaddr)
> > +{
> > +	u64 prefix  =3D vcpu->arch.sie_block->prefix;
> > +	u64 origin  =3D vcpu->kvm->arch.guest_origin;
> > +	u64 memsize =3D vcpu->kvm->arch.guest_memsize;
> > +
> > +	if (guestaddr < 2 * PAGE_SIZE)
> > +		guestaddr +=3D prefix;
> > +	else if ((guestaddr >=3D prefix) && (guestaddr < prefix + 2 * =

PAGE_SIZE))
> > +		guestaddr -=3D prefix;
> =

> What happens if prefix is set to 4096? Does this do the right thing
> according to the architecture definition?

The z/architecture and the instructions (spx + sigp set prefix) dont allow =

4096 as prefix address. When setting a prefix, bits 1-18 (IBM numbering =

scheme) are used and appended with 13 zero to the right. That means prefix =

address is always a multiple of 8192.
