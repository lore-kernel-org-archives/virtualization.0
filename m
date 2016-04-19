From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] fixup! virtio: convert to use DMA api
Date: Tue, 19 Apr 2016 20:49:48 +0300
Message-ID: <20160419204907-mutt-send-email-mst__49399.8938044117$1461088208$gmane$org@redhat.com>
References: <1460994701.3765.23.camel@infradead.org>
	<20160418190203-mutt-send-email-mst@redhat.com>
	<1461004173.3765.73.camel@infradead.org>
	<CALCETrXGC9X6fndftzUKKQ76TXSARHotW8Kz3KcO6opQ-oLaqA@mail.gmail.com>
	<20160419130732-mutt-send-email-mst@redhat.com>
	<CALCETrX72XV25B-0GdaMyJNkJRvvC8MbT4G=L5oGR=D5stpG6w@mail.gmail.com>
	<20160419190520-mutt-send-email-mst@redhat.com>
	<CALCETrWEo12k49kFmPA3NByXrLb8OYQEmDYoYgngQcxMZ=1Mzw@mail.gmail.com>
	<20160419191914-mutt-send-email-mst@redhat.com>
	<1461083204.20056.8.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1461083204.20056.8.camel@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wei Liu <wei.liu2@citrix.com>, Andy Lutomirski <luto@kernel.org>, qemu-block@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, peterx@redhat.com, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 19, 2016 at 12:26:44PM -0400, David Woodhouse wrote:
> On Tue, 2016-04-19 at 19:20 +0300, Michael S. Tsirkin wrote:
> > =

> > > I thought that PLATFORM served that purpose.=A0 Woudn't the host
> > > advertise PLATFORM support and, if the guest doesn't ack it, the host
> > > device would skip translation?=A0 Or is that problematic for vfio?
> > =

> > Exactly that's problematic for security.
> > You can't allow guest driver to decide whether device skips security.
> =

> Right. Because fundamentally, this *isn't* a property of the endpoint
> device, and doesn't live in virtio itself.
> =

> It's a property of the platform IOMMU, and lives there.

It's a property of the hypervisor virtio implementation, and lives there.

-- =

MST
