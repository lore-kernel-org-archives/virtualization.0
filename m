From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/PATCH 07/15 v3] kvm-s390: interrupt subsystem, cpu timer,
	waitpsw
Date: Mon, 31 Mar 2008 07:43:57 +0200
Message-ID: <200803310743.58580.arnd__8733.37862217358$1206942471$gmane$org@arndb.de>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
	<1206458154.6217.12.camel@cotte.boeblingen.de.ibm.com>
	<1206467246.6507.43.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206467246.6507.43.camel@cotte.boeblingen.de.ibm.com>
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
To: Carsten Otte <cotte@de.ibm.com>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, oliver.paukstadt@millenux.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 25 March 2008, Carsten Otte wrote:

> +	case KVM_S390_SIGP_SET_PREFIX:
> +		VCPU_EVENT(vcpu, 4, "interrupt: set prefix to %x",
> +			   inti->prefix.address);
> +		vcpu->stat.deliver_prefix_signal++;
> +		vcpu->arch.sie_block->prefix = inti->prefix.address;
> +		vcpu->arch.sie_block->ihcpu = 0xffff;
> +		break;

This smells like a security bug. What happens if the guest sets the prefix
to an address outside of its address range?

	Arnd <><
