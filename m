From: "Glauber Costa" <glommer@gmail.com>
Subject: Re: [PATCH] Do not calculate linear rip in emulation failure report
Date: Fri, 13 Jun 2008 14:37:09 -0300
Message-ID: <5d6222a80806131037u245c66ev902fadaa6d5c4605__14827.1925085739$1213378773$gmane$org@mail.gmail.com>
References: <1213105613-8571-1-git-send-email-gcosta@redhat.com>
	<52d4a3890806131033g56ec2bc0o43442d2c290401f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <52d4a3890806131033g56ec2bc0o43442d2c290401f2@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mohammed Gamal <m.gamal005@gmail.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Glauber Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 13, 2008 at 2:33 PM, Mohammed Gamal <m.gamal005@gmail.com> wrote:
> On Tue, Jun 10, 2008 at 4:46 PM, Glauber Costa <gcosta@redhat.com> wrote:
>> If we're not gonna do anything (case in which failure is already
>> reported), we do not need to even bother with calculating the linear rip.
>>
>> This is a nitpick, but I saw it while doing some testing, so here's
>> the patch.
>>
>> Signed-off-by: Glauber Costa <gcosta@redhat.com>
>> ---
>>  arch/x86/kvm/x86.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 77fb2bd..191fef1 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2026,11 +2026,11 @@ void kvm_report_emulation_failure(struct kvm_vcpu *vcpu, const char *context)
>>        unsigned long rip = vcpu->arch.rip;
>>        unsigned long rip_linear;
>>
>> -       rip_linear = rip + get_segment_base(vcpu, VCPU_SREG_CS);
>> -
>>        if (reported)
>>                return;
>>
>> +       rip_linear = rip + get_segment_base(vcpu, VCPU_SREG_CS);
>> +
>>        emulator_read_std(rip_linear, (void *)opcodes, 4, vcpu);
>>
>>        printk(KERN_ERR "emulation failed (%s) rip %lx %02x %02x %02x %02x\n",
>> --
>> 1.5.4.5
>
> Why return immediately? Shouldn't we report on failure whenever it
> occurs (i.e. by rather removing the if condition)?
>
the kernel ring buffer would be full very quickly, and this is not a
strong enough reason to do that ;-)
Most of the messages would be the same.

What I do think would be useful, and even planned to do (just have
more priority things waiting), is to move
the checking field to the vcpu struct. With the current setup, if you
kill your guest, set things up again, and run it,
you won't see any messages, even if it fails.

So the warning should really be once in the lifetime of the virtual
machine, not once in the lifetime of the kvm module.



-- 
Glauber  Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
