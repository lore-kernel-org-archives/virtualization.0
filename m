From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: Regression with "arm64: KVM: Skip MMIO insn after emulation" on
	4.4 stable
Date: Thu, 28 Feb 2019 11:13:19 +0000
Message-ID: <6dd1026e-5310-0b41-2e90-716120180956__4330.57641364343$1551352869$gmane$org@arm.com>
References: <CABVzXAnm78j6mwbNF2MWTwkBcXVmCdWYdZfXJBhiThOEK3135w@mail.gmail.com>
	<20190228081605.GB865@kroah.com> <86r2bswb5e.wl-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <86r2bswb5e.wl-marc.zyngier@arm.com>
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
To: Greg KH <gregkh@linuxfoundation.org>, Daniel Verkamp <dverkamp@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 28/02/2019 08:49, Marc Zyngier wrote:
> On Thu, 28 Feb 2019 08:16:05 +0000,
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> Hi both,
> 
>>
>> On Wed, Feb 27, 2019 at 04:36:39PM -0800, Daniel Verkamp wrote:
>>> Hello,
>>>
>>> In my testing of crosvm[1] with Linux 4.4.175, I am observing failures
>>> on a 'kevin' Chromebook (RK3399) device - the guest kernel does not
>>> even get to the point of printing its first messages, and the host
>>> seems to be spinning at 100% CPU in KVM_RUN.
>>>
>>> I narrowed this down to the 4.4 stable backport of "arm64: KVM: Skip
>>> MMIO insn after emulation" - with this patch reverted, I can boot the
>>> guest kernel as normal again.
>>>
>>> Unfortunately, I am unable to easily test with a newer upstream kernel
>>> (this board is using the Chrome OS kernel with many additional patches
>>> applied on top of 4.4), so I'm not sure if this issue was introduced
>>> in the mainline commit or only in the stable branch.  Is it possible
>>> that this patch has other dependencies that were missed in the
>>> backport?  It looks like it was part of a larger series, but only this
>>> patch got pulled for 4.4 stable.
> 
> Thanks for reporting this. I'll have a look ASAP.
> 
>> It looks like this got pulled in by Sasha's bot which is why it was
>> applied.
>>
>> I have no objection to reverting this if it is causing problems, unless
>> someone here really thinks it needs to remain in the tree?
> 
> Can we hold on a tiny bit so that I can verify we haven't regressed
> crosvm all the way into mainline?
> 
> Daniel, is there any chance you could test with kvmtool as well on
> your setup? You can easily compile it as a static binary and run it
> from ChromeOS with:
> 
> lkvm-static run -c 1 -p "earlycon=uart,mmio,0x3f8" -l Image
> 
> which should start a UP guest and drop you to a shell. In the
> meantime, I'm starting to build crosvm on my kevin running mainline.

OK, that wasn't a fun experience. Some build instructions for the mere
mortals (aka non-ChromeOS people) would be nice (and a mention that
crosvm cannot yet deal with GICv3-only systems...)

Anyway, I've got enough of it working that I can boot a trivial Debian
guest on kevin running 5.0-rc7, so I'm pretty confident that mainline is
OK. I'll move back to 4.4, and try to understand what happens there.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
