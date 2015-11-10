From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Tue, 10 Nov 2015 15:44:10 -0800
Message-ID: <CALCETrWb9poeyxXhcbAbQkpcP-XYjWtz2w9iSPkKJH8rdzAj-A__31888.2764819593$1447199097$gmane$org@mail.gmail.com>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
	<CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
	<1447133316.31884.67.camel@kernel.crashing.org>
	<CALCETrVPQc04Ah7FXcRMb4RhpUJ1WPCoC_4dbacB8a+u5XpmwA@mail.gmail.com>
	<1447151874.31884.82.camel@kernel.crashing.org>
	<CALCETrVkE3=KCxK-_bf-P8UfTS96Vck+QPE8EsLvP7THxpLe1A@mail.gmail.com>
	<1447194427.31884.100.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447194427.31884.100.camel@kernel.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 10, 2015 at 2:27 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2015-11-10 at 10:54 -0800, Andy Lutomirski wrote:
>>
>> Does that work on powerpc on existing kernels?
>>
>> Anyway, here's another crazy idea: make the quirk assume that the
>> IOMMU is bypasses if and only if the weak barriers bit is set on
>> systems that are missing the new DT binding.
>
> "New DT bindings" doesn't mean much ... how do we change DT bindings on
> existing machines with a FW in flash ?
>
> What about partition <-> partition virtio such as what we could do on
> PAPR systems. That would have the weak barrier bit.
>

Is it partition <-> partition, bypassing IOMMU?

I think I'd settle for just something that doesn't regress
non-experimental setups that actually work today and that allow new
setups (x86 with fixed QEMU and maybe something more complicated on
powerpc and/or sparc) to work in all cases.

We could certainly just make powerpc and sparc continue bypassing the
IOMMU until someone comes up with a way to fix it.  I'll send out some
patches that do that, and maybe that'll help this make progress.

--Andy
