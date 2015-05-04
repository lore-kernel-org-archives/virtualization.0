From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/6] x86: reduce paravirtualized spinlock overhead
Date: Mon, 04 May 2015 07:55:07 +0200
Message-ID: <554709BB.7090400@suse.com>
References: <1430391243-7112-1-git-send-email-jgross@suse.com>
	<55425ADA.4060105@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55425ADA.4060105@goop.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, gleb@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 04/30/2015 06:39 PM, Jeremy Fitzhardinge wrote:
> On 04/30/2015 03:53 AM, Juergen Gross wrote:
>> Paravirtualized spinlocks produce some overhead even if the kernel is
>> running on bare metal. The main reason are the more complex locking
>> and unlocking functions. Especially unlocking is no longer just one
>> instruction but so complex that it is no longer inlined.
>>
>> This patch series addresses this issue by adding two more pvops
>> functions to reduce the size of the inlined spinlock functions. When
>> running on bare metal unlocking is again basically one instruction.
>
> Out of curiosity, is there a measurable difference?

I did a small measurement of the pure locking functions on bare metal
without and with my patches.

spin_lock() for the first time (lock and code not in cache) dropped from
about 600 to 500 cycles.

spin_unlock() for first time dropped from 145 to 87 cycles.

spin_lock() in a loop dropped from 48 to 45 cycles.

spin_unlock() in the same loop dropped from 24 to 22 cycles.


Juergen
