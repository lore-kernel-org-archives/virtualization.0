From: Christopher Covington <cov@codeaurora.org>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Mon, 22 Sep 2014 09:33:41 -0400
Message-ID: <54202535.2030702@codeaurora.org>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<541C765B.5050705@codeaurora.org>
	<CALCETrU_r90=ve4v6xKfZHR_2O5+f05URqD5fzkbSpcuV4tb8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrU_r90=ve4v6xKfZHR_2O5+f05URqD5fzkbSpcuV4tb8A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Theodore Ts'o <tytso@mit.edu>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/19/2014 02:42 PM, Andy Lutomirski wrote:
> On Fri, Sep 19, 2014 at 11:30 AM, Christopher Covington
> <cov@codeaurora.org> wrote:
>> On 09/17/2014 10:50 PM, Andy Lutomirski wrote:
>>> Hi all-
>>>
>>> I would like to standardize on a very simple protocol by which a guest
>>> OS can obtain an RNG seed early in boot.
>>>
>>> The main design requirements are:
>>>
>>>  - The interface should be very easy to use.  Linux, at least, will
>>> want to use it extremely early in boot as part of kernel ASLR.  This
>>> means that PCI and ACPI will not work.
>>
>> How do non-virtual systems get entropy this early? RDRAND/Padlock? Truerand?
>> Could hypervisors and simulators simply make sure these work?
>>
> 
> If RDRAND is available, then Linux, at least, will use it.  The rest
> are too complicated for early use.  Linux on x86 plays some vaguely
> clever games with rdtsc and poking at the i8254 port.

I just wanted to check that it couldn't be as simple as giving one or both of
the timers random initial values.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
