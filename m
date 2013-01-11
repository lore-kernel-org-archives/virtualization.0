From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
	implementation
Date: Thu, 10 Jan 2013 20:16:48 -0800
Message-ID: <87ehhsqrpr.fsf@xmission.com>
References: <50DBC856.6030208@zytor.com>
	<791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
	<50DC58C4.3000307@citrix.com> <874nj7qsor.fsf@xmission.com>
	<50E41973.9050705@citrix.com>
	<20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
	<50E6F81D02000078000B3245@nat28.tlf.novell.com>
	<20130104170751.GB3472@host-192-168-1-59.local.net-space.pl>
	<20130104191146.GC6721@phenom.dumpdata.com>
	<20130107123404.GA2927@host-192-168-1-59.local.net-space.pl>
	<20130107162018.GJ3219@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130107162018.GJ3219@phenom.dumpdata.com> (Konrad Rzeszutek
	Wilk's message of "Mon, 7 Jan 2013 11:20:18 -0500")
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
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> writes:

> On Mon, Jan 07, 2013 at 01:34:04PM +0100, Daniel Kiper wrote:
>> I think that new kexec hypercall function should mimics kexec syscall.
>> It means that all arguments passed to hypercall should have same types
>> if it is possible or if it is not possible then conversion should be done
>> in very easy way. Additionally, I think that one call of new hypercall
>> load function should load all needed thinks in right place and
>> return relevant status. Last but not least, new functionality should
>
> We are not restricted to just _one_ hypercall. And this loading
> thing could be similar to the micrcode hypercall - which just points
> to a virtual address along with the length - and says 'load me'.
>
>> be available through /dev/xen/privcmd or directly from kernel without
>> bigger effort.
>
> Perhaps we should have a email thread on xen-devel where we hash out
> some ideas. Eric, would you be OK included on this - it would make
> sense for this mechanism to be as future-proof as possible - and I am not
> sure what your plans for kexec are in the future?

The basic kexec interface is.

load ranges of virtual addresses physical addresses.
jump to the physical address  with identity mapped page tables.

There are a few flags to allow for different usage scenarios like
kexec on panic vs normal kexec.

It is very very simple and very extensible.  All of the weird glue
happens in userspace.

Eric
