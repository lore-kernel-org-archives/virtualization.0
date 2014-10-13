From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC 08/11] virtio_blk: use virtio v1.0 endian
Date: Mon, 13 Oct 2014 12:42:52 +0200
Message-ID: <20141013124252.7e9c6549.cornelia.huck@de.ibm.com>
References: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
	<1412692792-12325-9-git-send-email-cornelia.huck@de.ibm.com>
	<878ukkecjb.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <878ukkecjb.fsf@rustcorp.com.au>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 13 Oct 2014 16:28:32 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> > Note that we care only about the fields still in use for virtio v1.0.
> >
> > Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> > Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Hi Cornelia,
> 
>         These patches all look good; 

Cool, thanks.

> I'm a bit nervous about our testing
> missing some conversion, so we'll need qemu patches for PCI so we can
> test on other platforms too.

The devices I looked at (blk and net) are probably OK as ccw needs to
convert always. I agree that we want to test on other platforms as
well, but unfortunately I not familiar enough with other platforms to
feel confident enough to convert virtio-pci and test it :(
