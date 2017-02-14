From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [Xen-devel] [PATCH v2] x86/paravirt: Don't make
	vcpu_is_preempted() a callee-save function
Date: Tue, 14 Feb 2017 16:18:55 +0000
Message-ID: <5c3c2a13-b397-6e9f-8772-a8aaa3f70771__38874.8171310455$1487089949$gmane$org@citrix.com>
References: <1486741389-8513-1-git-send-email-longman@redhat.com>
	<20170210161928.GI6515@twins.programming.kicks-ass.net>
	<1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
	<14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com>
	<20170213104716.GM6515@twins.programming.kicks-ass.net>
	<20170213105343.GJ6536@twins.programming.kicks-ass.net>
	<3dc50409-60dd-ad47-f971-448191e66038@redhat.com>
	<6f69b112-7ae4-bf8f-b767-29a68fd48632@redhat.com>
	<20170213215220.GN25813@worktop.programming.kicks-ass.net>
	<933ba8c6-4ebe-63e2-3c3a-2e5afef9269a@redhat.com>
	<20170214093946.GM6500@twins.programming.kicks-ass.net>
	<fc65322b-902e-6589-f64c-62be5abdb093@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <fc65322b-902e-6589-f64c-62be5abdb093@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter
	Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 14/02/17 14:46, Waiman Long wrote:
> On 02/14/2017 04:39 AM, Peter Zijlstra wrote:
>> On Mon, Feb 13, 2017 at 05:34:01PM -0500, Waiman Long wrote:
>>> It is the address of &steal_time that will exceed the 32-bit limit.
>> That seems extremely unlikely. That would mean we have more than 4G
>> worth of per-cpu variables declared in the kernel.
> I have some doubt about if the compiler is able to properly use
> RIP-relative addressing for this. Anyway, it seems like constraints
> aren't allowed for asm() when not in the function context, at least for
> the the compiler that I am using (4.8.5). So it is a moot point.

You can work the issue of not having parameters in a plain asm()
statement by using an asm-offset, stringizing it, and have C put the
string fragments back together.

"cmpb $0, " STR(STEAL_TIME_preempted) "(%rax);"

~Andrew
