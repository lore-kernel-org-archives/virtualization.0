From: Christoffer Dall <cdall@cs.columbia.edu>
Subject: Re: [PATCH RFC] kvm: add PV MMIO EVENTFD
Date: Thu, 4 Apr 2013 16:32:01 -0700
Message-ID: <CAEDV+gKpCj1Sgn4TYw5ViYK-x4_c=-9nOpBwGfTBXRkJaN=gNg__38304.6311828823$1365119174$gmane$org@mail.gmail.com>
References: <20130404120825.GD17919@redhat.com>
	<959E147D-EB7B-4F4B-9F84-4F1BBA98DEF8@suse.de>
	<20130404123806.GG17919@redhat.com>
	<EF153515-9835-4FB9-B6BC-73D0BDC86492@suse.de>
	<20130404124501.GH17919@redhat.com>
	<1B68D701-103D-4B1A-8F5E-3916753699CB@suse.de>
	<20130404125649.GI17919@redhat.com>
	<8E65D34D-2DA7-4C2E-9C3E-BE3A7DBC3279@suse.de>
	<20130404133318.GI6467@redhat.com>
	<14B443D5-5785-487D-9EA3-0AD20141BC06@suse.de>
	<20130404153629.GN6467@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130404153629.GN6467@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Sasha Levin <sasha.levin@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, Takuya Yoshikawa <yoshikawa_takuya_b1@lab.ntt.co.jp>
List-Id: virtualization@lists.linuxfoundation.org

[...]

>> >> to give us some idea how much performance we would gain from each approach? Thoughput should be completely unaffected anyway, since virtio just coalesces kicks internally.
>> >
>> > Latency is dominated by the scheduling latency.
>> > This means virtio-net is not the best benchmark.
>>
>> So what is a good benchmark?
>
> E.g. ping pong stress will do but need to look at CPU utilization,
> that's what is affected, not latency.
>
>> Is there any difference in speed at all? I strongly doubt it. One of virtio's main points is to reduce the number of kicks.
>
> For this stage of the project I think microbenchmarks are more appropriate.
> Doubling the price of exit is likely to be measureable. 30 cycles likely
> not ...
>
I don't quite understand this point here. If we don't have anything
real-world where we can measure a decent difference, then why are we
doing this? I would agree with Alex that the three test scenarios
proposed by him should be tried out before adding this complexity,
measured in CPU utilization or latency as you wish.

FWIW, ARM always uses MMIO and provides hardware decoding of all sane
(not user register-writeback) instruction, but the hypercall vs. mmio
looks like this:

hvc:  4,917
mmio_kernel: 6,248

But I doubt that an hvc wrapper around mmio decoding would take care
of all this difference, because the mmio operation needs to do other
work not realated to emulating the instruction in software, which
you'd have to do for an hvc anyway (populate kvm_mmio structure etc.)

-Christoffer
