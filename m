From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCHv2] virtio-pci: add MMIO property
Date: Tue, 20 Mar 2012 16:32:23 +0000
Message-ID: <201203201632.23939.paul__4438.873663503$1332261164$gmane$org@codesourcery.com>
References: <20120319203721.GA9399@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120319203721.GA9399@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, virtualization@lists.linux-foundation.org, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

> @@ -682,10 +733,18 @@ void virtio_init_pci(VirtIOPCIProxy *proxy,
> VirtIODevice *vdev) if (size & (size-1))
>          size = 1 << qemu_fls(size);
>  
> +    proxy->bar0_mask = size - 1;

You'll get better performance if you use page-sized mappings.  You're already 
creating a mapping bigger than the actual data (rounding up to power-of-two), 
so you may as well pick a value that's convenient for qemu to map into the 
address space.

Paul
