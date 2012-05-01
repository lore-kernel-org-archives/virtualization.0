From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [Xen-devel] [PATCH RFC V7 0/12] Paravirtualized ticketlocks
Date: Tue, 01 May 2012 18:34:41 +0530
Message-ID: <4F9FDF69.8090101@linux.vnet.ibm.com>
References: <20120419201209.5411.43877.sendpatchset@codeblue>
	<1335876646.6038.101.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1335876646.6038.101.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: Andrew Jones <drjones@redhat.com>, Xen Devel <xen-devel@lists.xensource.com>, KVM <kvm@vger.kernel.org>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/01/2012 06:20 PM, Ian Campbell wrote:
> On Thu, 2012-04-19 at 21:12 +0100, Raghavendra K T wrote:
>> From: Jeremy Fitzhardinge<jeremy.fitzhardinge@citrix.com>
>>
>> This series replaces the existing paravirtualized spinlock mechanism
>> with a paravirtualized ticketlock mechanism. (targeted for 3.5 window)
>
> Which tree is this series going through, tip.git I guess?
>
> I don't see it there.
>
> Ian.
>

Yes you are right.

I am trying to post ticketlock + xen + kvm patches series in one
go. There are some discussions on kvm patches last few days. So I am
putting up all of them together now.  I am planning to post within 
half/one day.
