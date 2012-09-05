From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] virtio-blk: Fix kconfig option
Date: Wed, 05 Sep 2012 12:22:58 +0800
Message-ID: <5046D3A2.3070108@redhat.com>
References: <20120903044133.GA9980@moria.home.lan>
	<87wr0ae26e.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87wr0ae26e.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kent Overstreet <koverstreet@google.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 09/04/2012 02:23 PM, Rusty Russell wrote:
> Kent Overstreet <koverstreet@google.com> writes:
> 
>> CONFIG_VIRTIO isn't exposed, everything else is supposed to select it
>> instead.
> 
> This is a slight mis-understanding.  It's supposed to be selected by
> the particular driver, probably virtio_pci in your case.

virtio_mmio selects virtio as well.

drivers/virtio/Kconfig
config VIRTIO_MMIO
       select VIRTIO
config VIRTIO_PCI
       select VIRTIO

How about this:
config VIRTIO_BLK
       depends on EXPERIMENTAL && (VIRTIO_PCI || VIRTIO_MMIO)

-- 
Asias
