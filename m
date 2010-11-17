From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 13/14] x86/ticketlock: add slowpath logic
Date: Wed, 17 Nov 2010 01:05:22 -0800
Message-ID: <4CE39AD2.9080606__21532.9712875702$1289984766$gmane$org@goop.org>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com><cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<97ed99ae9160bdb6477284b333bd6708fb7a19cb.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<4CE3A1060200007800022B04@vpn.id2.novell.com>
	<4CE397C8.9040901@goop.org> <4CE3992E.2070406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CE3992E.2070406@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Xen-devel <xen-devel@lists.xensource.com>, "H. Peter Anvin" <hpa@zytor.com>, xiyou.wangcong@gmail.com, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/17/2010 12:58 AM, Avi Kivity wrote:
>> Actually in this case I'm pretty sure there's already a "set bit"
>> function which will do the job.  set_bit(), I guess, though it takes a
>> bit number rather than a mask...
>>
>
>
> set_bit() operates on a long, while the intel manuals recommend
> against operating on operands of different size, especially with
> locked operations.  I think newer processors have more relaxed
> requirements, though.

Despite its prototype, set_bit() is pretty specifically using "orb" for
a the constant case, or bts otherwise (I don't know what size memory
operation bts is considered to generate).

    J
