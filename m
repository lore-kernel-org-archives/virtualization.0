From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: add MMIO property
Date: Mon, 19 Mar 2012 20:57:23 +0200
Message-ID: <20120319185723.GA8366@redhat.com>
References: <20120319155650.GA6430@redhat.com>
 <4F6773B4.2040209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F6773B4.2040209@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 19, 2012 at 07:58:12PM +0200, Avi Kivity wrote:
> On 03/19/2012 05:56 PM, Michael S. Tsirkin wrote:
> > Currently virtio-pci is specified so that configuration of the device is
> > done through a PCI IO space (via BAR 0 of the virtual PCI device).
> > However, Linux guests happen to use ioread/iowrite/iomap primitives
> > for access, and these work uniformly across memory/io BARs.
> >
> > While PCI IO accesses are faster than MMIO on x86 kvm,
> > MMIO might be helpful on other systems which don't
> > implement PIO or where PIO is slower than MMIO.
> >
> > Add a property to make it possible to tweak the BAR type.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > This is harmless by default but causes segfaults in memory.c
> > when enabled. Thus an RFC until I figure out what's wrong.
> >
> 
> Should be done via an extra BAR (with the same layout, perhaps extended)
> so compatibility is preserved.

No, that would need guest changes to be of use.  The point of this hack
is to make things work for Linux guests where PIO does not work.

> -- 
> error compiling committee.c: too many arguments to function
