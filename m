From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: add MMIO property
Date: Tue, 20 Mar 2012 16:49:54 +0200
Message-ID: <4F689912.7050605@redhat.com>
References: <20120319155650.GA6430@redhat.com> <4F6773B4.2040209@redhat.com>
	<20120319185723.GA8366@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120319185723.GA8366@redhat.com>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/19/2012 08:57 PM, Michael S. Tsirkin wrote:
> > 
> > Should be done via an extra BAR (with the same layout, perhaps extended)
> > so compatibility is preserved.
>
> No, that would need guest changes to be of use.  The point of this hack
> is to make things work for Linux guests where PIO does not work.

It only works if all guest's PCI layer knows to deal with the bit flip
correctly.  I imagine it isn't true for at least the seabios virtio drivers.

-- 
error compiling committee.c: too many arguments to function
