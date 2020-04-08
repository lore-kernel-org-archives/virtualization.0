From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [RFC PATCH 00/26] Runtime paravirt patching
Date: Wed, 8 Apr 2020 15:33:52 +0200
Message-ID: <bcf8206d-5a41-4e6b-1832-75ba1d6367e4@suse.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <20200408120856.GY20713@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200408120856.GY20713@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08.04.20 14:08, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 10:02:57PM -0700, Ankur Arora wrote:
>> Mechanism: the patching itself is done using stop_machine(). That is
>> not ideal -- text_poke_stop_machine() was replaced with INT3+emulation
>> via text_poke_bp(), but I'm using this to address two issues:
>>   1) emulation in text_poke() can only easily handle a small set
>>   of instructions and this is problematic for inlined pv-ops (and see
>>   a possible alternatives use-case below.)
>>   2) paravirt patching might have inter-dependendent ops (ex.
>>   lock.queued_lock_slowpath, lock.queued_lock_unlock are paired and
>>   need to be updated atomically.)
> 
> And then you hope that the spinlock state transfers.. That is that both
> implementations agree what an unlocked spinlock looks like.
> 
> Suppose the native one was a ticket spinlock, where unlocked means 'head
> == tail' while the paravirt one is a test-and-set spinlock, where
> unlocked means 'val == 0'.
> 
> That just happens to not be the case now, but it was for a fair while.

Sure? This would mean that before spinlock-pvops are being set no lock
is allowed to be used in the kernel, because this would block the boot
time transition of the lock variant to use.

Another problem I'm seeing is that runtime pvops patching would rely on
the fact that stop_machine() isn't guarded by a spinlock.


Juergen
