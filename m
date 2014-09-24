From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio_pci: fix virtio spec compliance on restore
Date: Wed, 24 Sep 2014 14:59:13 +0300
Message-ID: <20140924115913.GA32179@redhat.com>
References: <1411468217-18130-1-git-send-email-mst@redhat.com>
	<1411522047.3659.10.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1411522047.3659.10.camel@decadent.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 24, 2014 at 02:27:27AM +0100, Ben Hutchings wrote:
> On Tue, 2014-09-23 at 13:32 +0300, Michael S. Tsirkin wrote:
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
> > Cc: stable@vger.kernel.org
> > Cc: Amit Shah <amit.shah@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> [...]
> 
> What concrete problem does this fix, such that it should be applied to
> stable branches?
> 
> Ben.

It will break with hypervisors that assume spec compliant behaviour.
I would like this applied to stable branches so hypervisors don't
need to support broken behaviour forever.

-- 
MST
