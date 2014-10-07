From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v2 01/15] virtio_pci: fix virtio spec compliance on restore
Date: Tue, 7 Oct 2014 22:24:39 +0530
Message-ID: <20141007165439.GB823__35301.4509579681$1412700902$gmane$org@grmbl.mre>
References: <1412608214-31944-1-git-send-email-mst@redhat.com>
	<1412608214-31944-2-git-send-email-mst@redhat.com>
	<20141007125355.GA5974@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141007125355.GA5974@redhat.com>
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
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 07 Oct 2014 [15:53:55], Michael S. Tsirkin wrote:
> On Mon, Oct 06, 2014 at 06:10:40PM +0300, Michael S. Tsirkin wrote:
> > On restore, virtio pci does the following:
> > + set features
> > + init vqs etc - device can be used at this point!
> > + set ACKNOWLEDGE,DRIVER and DRIVER_OK status bits
> > 
> > This is in violation of the virtio spec, which
> > requires the following order:
> > - ACKNOWLEDGE
> > - DRIVER
> > - init vqs
> > - DRIVER_OK
> > 
> > This behaviour will break with hypervisors that assume spec compliant
> > behaviour.  It seems like a good idea to have this patch applied to
> > stable branches to reduce the support butden for the hypervisors.
> 
> Tested suspend to ram with virtio net and blk.

I'd recommend running a continuous ping for virtio-net and a dd
process running across s3/s4 for testing.

That's what I had run while doing the original set of patches.

		Amit
