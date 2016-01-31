From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 00/10] virtio DMA API, yet again
Date: Sun, 31 Jan 2016 12:16:18 -0800
Message-ID: <CALCETrUtRx3Lzzsjg3ugictuNVNcQK_9+6LYnH2OUZZV9PiFZQ__41433.0648877241$1454271414$gmane$org@mail.gmail.com>
References: <cover.1454034075.git.luto@kernel.org>
	<20160131201232.GA1643@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160131201232.GA1643@redhat.com>
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
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jan 31, 2016 at 12:12 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jan 28, 2016 at 06:31:13PM -0800, Andy Lutomirski wrote:
>> This switches virtio to use the DMA API on Xen and if requested by
>> module option.
>>
>> This fixes virtio on Xen, and it should break anything because it's
>> off by default on everything except Xen PV on x86.
>>
>> To the Xen people: is this okay?  If it doesn't work on other Xen
>> variants (PVH? HVM?), can you submit follow-up patches to fix it?
>>
>> To everyone else: we've waffled on this for way too long.  I think
>> we should to get DMA API implementation in with a conservative
>> policy like this rather than waiting until we achieve perfection.
>> I'm tired of carrying these patches around.
>
> I agree, thanks for working on this!
>
>> Michael, if these survive review, can you stage these in your tree?
>
> Yes, I'll stage everything except 10/10. I'd rather not maintain a
> module option like this, things work for now and I'm working on a
> clean solution for things like dpdk within guest.

The module option was mainly for testing, but patching in a "return
true" works just as well.

I ran the code through the DMA API debugging stuff and swiotlb=force
with the module option set under KVM (no Xen), and everything seemed
to work.

--Andy
