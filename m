From: David Hildenbrand <david@redhat.com>
Subject: Re: Design Decision for KVM based anti rootkit
Date: Mon, 18 Jun 2018 21:01:22 +0200
Message-ID: <4f482fce-bf1e-e79d-3b7d-a20c87425236@redhat.com>
References: <CAAGnT3bjYPu9bordn_Dh8z+MW6p5DDLoSsZC9xg8QxQriVus9A@mail.gmail.com>
	<7c7ddb96-e865-53a2-3aa9-b79403c646a9@redhat.com>
	<CAAGnT3avoMOJP9zEdG2WmmxUe7m4S+5mDWezjJerzO4fq11cjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAAGnT3avoMOJP9zEdG2WmmxUe7m4S+5mDWezjJerzO4fq11cjQ@mail.gmail.com>
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
To: Ahmed Soliman <ahmedsoliman0x666@gmail.com>
Cc: riel@redhat.com, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Hossam Hassan <7ossam9063@gmail.com>, Ahmed Lotfy <A7med.lotfey@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 18.06.2018 18:35, Ahmed Soliman wrote:
> Shortly after I sent the first email, we found that there is another
> way to achieve this kind of communication, via KVM Hypercalls, I think
> they are underutilised in kvm, but they exist.
> 
> We also found that they are architecture dependent, but the advantage
> is that one doesn't need to create QEMU<-> kvm interface
> 
> So from our point of view it is either have things easily compatible
> with many architectures out of the box (virtio) VS compatiability with
> almost every front end including QEMU and any other one without
> modification (Hypercalls)?

My gut feeling (I might of course be wrong) is that hypercalls will not
be accepted easily in KVM (I assume only if it is really highly
specialized for e.g. x86 and/or required very early during boot and/or
has very specific performance requirements - e.g. pvspinlocks or kvmclock).

> 
> If it is the case, We might stick to hypercalls at the beginning,
> because it can be easily tested with out modifying QEMU, but then
> later we can move to virtio if there turned out to be clearer
> advantage, especially performance wise.

hypercalls might be good for prototyping, but I assume that the
challenging part will rather be a clean KVM mmu interface. And once you
have that, a kernel interface might not be too hard (I remember some
work being done by malwarebytes).

> 
> Does that sounds like good idea?
> I wanted to make sure because maybe maybe hypercalls aren't that much
> used in kvm for a reason, so I wanted to verify that.

I assume the same.

Another thing to note is performance, having to go via QEMU might be
performance wise not that good. (usually chunking is the answer to
reduce the overhead). But if it is really a "protect once, forget until
reboot" thing, that should not be relevant.

-- 

Thanks,

David / dhildenb
