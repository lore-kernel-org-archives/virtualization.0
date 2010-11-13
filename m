From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/20] x86/ticketlock: Use C for __ticket_spin_unlock
Date: Sat, 13 Nov 2010 23:34:06 +0100
Message-ID: <4CDF125E.3050803__41756.3424948186$1289837789$gmane$org@redhat.com>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<20092775a9df07a5a75820ac250194b535279d51.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<20101113100527.GG3837@hack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20101113100527.GG3837@hack>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <peterz@infradead.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/13/2010 11:05 AM, Am=E9rico Wang wrote:
> On Wed, Nov 03, 2010 at 10:59:44AM -0400, Jeremy Fitzhardinge wrote:
>>   * On PPro SMP or if we are using OOSTORE, we use a locked operation to=
 unlock
>>   * (PPro errata 66, 92)
>>   */
>> -# define UNLOCK_LOCK_PREFIX LOCK_PREFIX
>> +static __always_inline void __ticket_unlock_release(struct arch_spinloc=
k *lock)
>> +{
>> +	if (sizeof(lock->tickets.head) =3D=3D sizeof(u8))
>> +		asm (LOCK_PREFIX "incb %0"
>> +		     : "+m" (lock->tickets.head) : : "memory");
>> +	else
>> +		asm (LOCK_PREFIX "incw %0"
>> +		     : "+m" (lock->tickets.head) : : "memory");
>
> This 'if/else' really should be done with #ifdef, even though
> the compiler may be smart enough to remove it.

That's a sure path to bitrot.

Paolo
