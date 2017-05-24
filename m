From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 05/10] paravirt: add new PARAVIRT_FULL config item
Date: Wed, 24 May 2017 18:39:50 +0200
Message-ID: <61a3d1ac-8fd2-9f2c-f4b3-b183b62faf1f@suse.com>
References: <20170519154746.29389-1-jgross@suse.com>
	<20170519154746.29389-6-jgross@suse.com>
	<260e7bc9-8cba-bc57-9fe8-0e437562229a@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <260e7bc9-8cba-bc57-9fe8-0e437562229a@oracle.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On 24/05/17 17:40, Boris Ostrovsky wrote:
> On 05/19/2017 11:47 AM, Juergen Gross wrote:
>> Add a new config item PARAVIRT_FULL. It will be used to guard the
>> pv_*_ops functions used by fully paravirtualized guests (Xen pv-guests
>> and lguest) only.
>>
>> Kernels not meant to support those guest types will be able to use many
>> operations without paravirt abstraction while still supporting all the
>> other paravirt features.
>>
>> For now just add the new Kconfig option and select it for XEN_PV and
>> LGUEST_GUEST. Add paravirt_full.c, paravirt_full.h and
>> paravirt_types_full.h which will contain the necessary implementation
>> parts of the pv guest specific paravirt functions.
> 
> Is it not possible to just 'ifdef CONFIG_PARAVIT_FULL' the (ir)relevant
> parts of paravirt.[ch] and paravirt_types.c?

Sure it is possible.

The question is whether we want it. This would be a lot of ifdeffery.

The main reason I did it this way was to have a clear split between the
two levels of paravirtualization. A kernel built without pv-full would
not need to include paravirt[_types]_full.h saving some compilation
time (there are lots of source files which are including the paravirt
header now).

> Separating structures and files into pv and pvfull seems somewhat
> arbitrary (.flush_tlb_others in patch 8 being a good example of one type
> of guest deciding to use something that normally would be considered
> part of a pvfull-type structure).

I was thinking of using that for Xen HVM-guests, too. This should speed
up multi-vcpu guests quite a bit.

In case others think doing it via idefs only would be better I'm ready
to change the patches accordingly.


Juergen
