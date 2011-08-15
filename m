From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH] virtio-net: Read MAC only after initializing MSI-X
Date: Tue, 16 Aug 2011 01:17:07 +0300
Message-ID: <1313446627.3004.2.camel__8962.87847213007$1313446755$gmane$org@sasha>
References: <1313225461-24458-1-git-send-email-levinsasha928@gmail.com>
	<878vqw9007.fsf@rustcorp.com.au> <1313330252.2422.12.camel@sasha>
	<87vctz7c7d.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87vctz7c7d.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2011-08-15 at 09:55 +0930, Rusty Russell wrote:
> On Sun, 14 Aug 2011 16:57:32 +0300, Sasha Levin <levinsasha928@gmail.com> wrote:
> > On Sun, 2011-08-14 at 12:23 +0930, Rusty Russell wrote:
> > > On Sat, 13 Aug 2011 11:51:01 +0300, Sasha Levin <levinsasha928@gmail.com> wrote:
> > > > The MAC of a virtio-net device is located at the first field of the device
> > > > specific header. This header is located at offset 20 if the device doesn't
> > > > support MSI-X or offset 24 if it does.
> > > 
> > > Erk.  This means, in general, we have to do virtio_find_single_vq or
> > > config->find_vqs before we examine any config options.
> > > 
> > > Look at virtio_blk, which has the same error.
> > > 
> > > Solutions in order of best to worst:
> > > (1) Enable MSI-X before calling device probe.  This means reserving two
> > >     vectors in virtio_pci_probe to ensure we *can* do this, I think.  Michael?
> > 
> > Do you mean reserving the vectors even before we probed the device for
> > MSI-X support? Wouldn't we need 3 vectors then? (config, input, output).
> 
> We want three, but *need* two: see vp_find_vqs().  Also, the generic
> code doesn't know how many virtqueues we have on the device.

We can just pci_enable_msix() and see if we can get 2 vectors, if we can
- we assume the device has msix on, right?


-- 

Sasha.
