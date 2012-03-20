From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio-pci: add MMIO property
Date: Mon, 19 Mar 2012 19:39:23 -0500
Message-ID: <4F67D1BB.7060802__8662.01498215578$1332204016$gmane$org@us.ibm.com>
References: <20120319155650.GA6430@redhat.com> <4F6786C5.3080902@codemonkey.ws>
	<20120319204952.GA9747@redhat.com> <4F67A021.6040601@us.ibm.com>
	<20120319212916.GC9747@redhat.com> <4F67AF72.8080905@codemonkey.ws>
	<877gygqhbp.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <877gygqhbp.fsf@rustcorp.com.au>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On 03/19/2012 06:52 PM, Rusty Russell wrote:
> On Mon, 19 Mar 2012 17:13:06 -0500, Anthony Liguori<anthony@codemonkey.ws>  wrote:
>>> Maybe just make this a hidden option like x-miio?
>>
>> x-violate-the-virtio-spec-to-trick-old-linux-drivers-into-working-on-power?
>
> "To configure the device, we use the first I/O region of the PCI
> device."
>
> Meh, it does sound a little like we are specifying that it's an PCI I/O
> bar.
>
> Let's resurrect the PCI-v2 idea, which is ready to implement now, and a
> nice cleanup?  Detach it from the change-of-ring-format idea which is
> turning out to be a tarpit.

I think that's a sensible approach.

Regards,

Anthony Liguori

> Thanks,
> Rusty.
