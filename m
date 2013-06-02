From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V9 1/19]  x86/spinlock: Replace pv spinlocks with
	pv ticketlocks
Date: Sun, 02 Jun 2013 12:24:09 +0530
Message-ID: <51AAEC11.7090203@linux.vnet.ibm.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<20130601192138.5966.62276.sendpatchset@codeblue>
	<51AA5A4E.6090307@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51AA5A4E.6090307@goop.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/02/2013 02:02 AM, Jeremy Fitzhardinge wrote:
> On 06/01/2013 12:21 PM, Raghavendra K T wrote:
>> x86/spinlock: Replace pv spinlocks with pv ticketlocks
>>
>> From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
> I'm not sure what the etiquette is here; I did the work while at Citrix,
> but jeremy@goop.org is my canonical email address.  The Citrix address
> is dead and bounces, so is useless for anything.  Probably best to
> change it.
>

Agreed.
I would change to goop address in the next posting.
I had the same doubt for Vatsa's email also. Even I am not sure about
the practice here. So had kept as is.
