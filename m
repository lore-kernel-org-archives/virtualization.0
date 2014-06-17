From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Using virtio for inter-VM communication
Date: Tue, 17 Jun 2014 07:24:52 +0200
Message-ID: <539FD124.6050007__20359.7379652367$1402982712$gmane$org@redhat.com>
References: <20140610184818.2e490419@nbschild1>	<87r42uq2v8.fsf@rustcorp.com.au>	<53993B7B.7010404@siemens.com>	<87fvj9prdi.fsf@rustcorp.com.au>	<539A98D3.3070601@siemens.com>
	<539ABA41.3070701@redhat.com> <539D3B35.2010706@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <539D3B35.2010706@web.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@web.de>, Rusty Russell <rusty@rustcorp.com.au>, Henning Schild <henning.schild@siemens.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: Jailhouse <jailhouse-dev@googlegroups.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 15/06/2014 08:20, Jan Kiszka ha scritto:
>> > I think implementing Xen hypercalls in jailhouse for grant table and
>> > event channels would actually make a lot of sense.  The Xen
>> > implementation is 2.5kLOC and I think it should be possible to compact
>> > it noticeably, especially if you limit yourself to 64-bit guests.
> At least the grant table model seems unsuited for Jailhouse. It allows a
> guest to influence the mapping of another guest during runtime. This we
> want (or even have) to avoid in Jailhouse.

IIRC implementing the grant table hypercalls with copies is inefficient 
but valid.

Paolo
