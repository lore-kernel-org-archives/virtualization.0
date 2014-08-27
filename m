From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: virtio DMA API?
Date: Thu, 28 Aug 2014 07:32:23 +1000
Message-ID: <1409175143.25772.157.camel@pasglop>
References: <CALCETrXaNYA=ffd1M0jUM+Z9Yz_Nhs7W=XCxe9N+0FYT558X6g@mail.gmail.com>
	<87iole89xg.fsf@rustcorp.com.au> <20140827115249.GA16850@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140827115249.GA16850@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@amacapital.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2014-08-27 at 13:52 +0200, Michael S. Tsirkin wrote:

> For x86 as of QEMU 2.0 there's no iommu.
> So a reasonable thing to do for that platform
> might be to always use iommu *if it's there*.
> My understanding is this isn't the case for powerpc?

All 64-bit powerpc have an iommu but not all 32-bit ones.

Also using/emulating one has a cost. Whatever we do shouldn't
impair the fast path of virtio-on-kvm doing direct physical
access.

Cheers,
Ben.
