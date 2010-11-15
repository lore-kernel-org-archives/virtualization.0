From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 03/20] x86/ticketlock: Use C for __ticket_spin_unlock
Date: Mon, 15 Nov 2010 11:38:33 -0800
Message-ID: <4CE18C39.4050206__47349.2485042245$1289850091$gmane$org@goop.org>
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

On 11/13/2010 02:05 AM, Am=E9rico Wang wrote:
> On Wed, Nov 03, 2010 at 10:59:44AM -0400, Jeremy Fitzhardinge wrote:
>>  * On PPro SMP or if we are using OOSTORE, we use a locked operation to =
unlock
>>  * (PPro errata 66, 92)
>>  */
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
> This 'if/else' really should be done with #ifdef, even though
> the compiler may be smart enough to remove it.

No, we depend on if/else with constant arguments doing the right thing
all over the kernel.  It is always preferable to use it instead of
#ifdef where possible, so that the two branches of code are always
subjected to compiler checking, even if they're not being used.

>> +
>> +}
>> #else
>> -# define UNLOCK_LOCK_PREFIX
>> +static __always_inline void __ticket_unlock_release(struct arch_spinloc=
k *lock)
>> +{
>> +	barrier();
>> +	lock->tickets.head++;
>> +	barrier();
> The second barrier() is not needed.

Agreed.  It gets removed in a later patch.

    J
