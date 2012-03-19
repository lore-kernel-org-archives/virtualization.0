From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio-pci: add MMIO property
Date: Tue, 20 Mar 2012 10:22:42 +1030
Message-ID: <877gygqhbp.fsf__14072.7439582863$1332201762$gmane$org@rustcorp.com.au>
References: <20120319155650.GA6430@redhat.com> <4F6786C5.3080902@codemonkey.ws>
	<20120319204952.GA9747@redhat.com> <4F67A021.6040601@us.ibm.com>
	<20120319212916.GC9747@redhat.com> <4F67AF72.8080905@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F67AF72.8080905@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 19 Mar 2012 17:13:06 -0500, Anthony Liguori <anthony@codemonkey.ws> wrote:
> > Maybe just make this a hidden option like x-miio?
> 
> x-violate-the-virtio-spec-to-trick-old-linux-drivers-into-working-on-power?

"To configure the device, we use the first I/O region of the PCI
device."

Meh, it does sound a little like we are specifying that it's an PCI I/O
bar.

Let's resurrect the PCI-v2 idea, which is ready to implement now, and a
nice cleanup?  Detach it from the change-of-ring-format idea which is
turning out to be a tarpit.

Thanks,
Rusty.
-- 
  How could I marry someone with more hair than me?  http://baldalex.org
