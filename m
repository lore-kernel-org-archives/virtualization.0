From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: fix remove oops
Date: Fri, 25 Apr 2008 05:18:15 +1000
Message-ID: <200804250518.16222.rusty@rustcorp.com.au>
References: <20080424184953.GA14820@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080424184953.GA14820@dmt>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 25 April 2008 04:49:53 Marcelo Tosatti wrote:
> Do not unregister the major at device remove, since there might be
> another device instances around.
>
> (qemu) pci_del 0 11
> (qemu) ACPI: PCI interrupt for device 0000:00:0b.0 disabled
> (qemu) pci_del 0 10
> (qemu) ------------[ cut here ]------------
> WARNING: at block/genhd.c:126 unregister_blkdev+0x74/0x9e()
> ACPI: PCI interrupt for device 0000:00:0a.0 disabled

Thanks, applied!

Rusty.
