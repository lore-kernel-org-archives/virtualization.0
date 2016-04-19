From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] fixup! virtio: convert to use DMA api
Date: Tue, 19 Apr 2016 19:04:43 +0300
Message-ID: <20160419190314-mutt-send-email-mst__42221.120131626$1461081906$gmane$org@redhat.com>
References: <20160418160731-mutt-send-email-mst@redhat.com>
	<1460988232.22654.7.camel@infradead.org>
	<20160418170534-mutt-send-email-mst@redhat.com>
	<1460992923.3765.8.camel@infradead.org>
	<20160418182320-mutt-send-email-mst@redhat.com>
	<1460994701.3765.23.camel@infradead.org>
	<20160418190203-mutt-send-email-mst@redhat.com>
	<1461004173.3765.73.camel@infradead.org>
	<20160419103815-mutt-send-email-mst@redhat.com>
	<CALCETrVBo-XBD53eStOCwJd53F7_VTnrMJ9rY7_cXwnt2Z6AOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrVBo-XBD53eStOCwJd53F7_VTnrMJ9rY7_cXwnt2Z6AOw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Wei Liu <wei.liu2@citrix.com>, kvm list <kvm@vger.kernel.org>, qemu-block@nongnu.org, Amit Shah <amit.shah@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, peterx@redhat.com, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 19, 2016 at 09:00:27AM -0700, Andy Lutomirski wrote:
> On Apr 19, 2016 2:13 AM, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> >
> > I guess you are right in that we should split this part out.
> > What I wanted is really the combination
> > PASSTHROUGH && !PLATFORM so that we can say "ok we don't
> > need to guess, this device actually bypasses the IOMMU".
> 
> What happens when you use a device like this on Xen or with a similar
> software translation layer?

I think you don't use it on Xen since virtio doesn't bypass an IOMMU there.
If you do you have misconfigured your device.

-- 
MST
