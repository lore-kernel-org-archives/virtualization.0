From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/11] qemu: helper routines for pci access.
Date: Tue, 26 May 2009 09:41:52 +0300
Message-ID: <20090526064152.GH6856__20313.9929952615$1243320451$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<20090525122533.GE5046@redhat.com>
	<20090526023337.GF13076%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090526023337.GF13076%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 26, 2009 at 11:33:37AM +0900, Isaku Yamahata wrote:
> On Mon, May 25, 2009 at 03:25:33PM +0300, Michael S. Tsirkin wrote:
> > Add inline routines for convenient access to pci devices
> > with correct (little) endianness. Will be used by MSI-X support.
>
> Just a minor comment.
> How about to add pci_[sg]et_byte() for consistency?

I don't see that it makes sense - pci_set_long(config, value)
is shorter than *((uint32_t *)config) = cpu_to_le32(value),
but single bytes don't have endianness, and *config = value
is shorter.

-- 
MST
