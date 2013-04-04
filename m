From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH RFC] kvm: add PV MMIO EVENTFD
Date: Thu, 4 Apr 2013 13:57:34 +0200
Message-ID: <6D40C5F1-849E-4F32-B391-E1A1BFA8C59D@suse.de>
References: <20130404104846.GA6227@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130404104846.GA6227@redhat.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Sasha Levin <sasha.levin@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Christoffer Dall <c.dall@virtualopensystems.com>, virtualization@lists.linux-foundation.org, Takuya Yoshikawa <yoshikawa_takuya_b1@lab.ntt.co.jp>
List-Id: virtualization@lists.linuxfoundation.org


On 04.04.2013, at 12:50, Michael S. Tsirkin wrote:

> With KVM, MMIO is much slower than PIO, due to the need to
> do page walk and emulation. But with EPT, it does not have to be: we
> know the address from the VMCS so if the address is unique, we can look
> up the eventfd directly, bypassing emulation.
> 
> Add an interface for userspace to specify this per-address, we can
> use this e.g. for virtio.
> 
> The implementation adds a separate bus internally. This serves two
> purposes:
> - minimize overhead for old userspace that does not use PV MMIO
> - minimize disruption in other code (since we don't know the length,
>  devices on the MMIO bus only get a valid address in write, this
>  way we don't need to touch all devices to teach them handle
>  an dinvalid length)
> 
> At the moment, this optimization is only supported for EPT on x86 and
> silently ignored for NPT and MMU, so everything works correctly but
> slowly.
> 
> TODO: NPT, MMU and non x86 architectures.
> 
> The idea was suggested by Peter Anvin.  Lots of thanks to Gleb for
> pre-review and suggestions.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

This still uses page fault intercepts which are orders of magnitudes slower than hypercalls. Why don't you just create a PV MMIO hypercall that the guest can use to invoke MMIO accesses towards the host based on physical addresses with explicit length encodings?

That way you simplify and speed up all code paths, exceeding the speed of PIO exits even. It should also be quite easily portable, as all other platforms have hypercalls available as well.


Alex
