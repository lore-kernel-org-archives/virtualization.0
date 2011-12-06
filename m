From: Raghavendra K T <raghukt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V3 4/4] kvm : pv-ticketlocks support for linux guests
	running on KVM hypervisor
Date: Tue, 06 Dec 2011 12:24:05 +0530
Message-ID: <4EDDBC0D.5090602@linux.vnet.ibm.com>
References: <20111130085921.23386.89708.sendpatchset@oc5400248562.ibm.com>
	<20111130090038.23386.4505.sendpatchset@oc5400248562.ibm.com>
	<20111206032741.GF6647@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111206032741.GF6647@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Xen <xen-devel@lists.xensource.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@linux.vne>
List-Id: virtualization@lists.linuxfoundation.org

On 12/06/2011 08:57 AM, Konrad Rzeszutek Wilk wrote:
>> +static inline void add_stats(enum kvm_contention_stat var, int val)
>
> You probably want 'int val' to be 'u32 val' as that is the type
> in contention_stats.
>

Yes. Thanks for pointing, as its cumulative.   It is indeed u32 in #else 
:).I 'll change that.
