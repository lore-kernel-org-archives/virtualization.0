From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH RFC] fixup! virtio: convert to use DMA api
Date: Mon, 18 Apr 2016 12:24:15 -0700
Message-ID: <CALCETrXGC9X6fndftzUKKQ76TXSARHotW8Kz3KcO6opQ-oLaqA@mail.gmail.com>
References: <1460979793-6621-1-git-send-email-mst@redhat.com>
	<1460980717.12793.43.camel@infradead.org>
	<20160418160731-mutt-send-email-mst@redhat.com>
	<1460988232.22654.7.camel@infradead.org>
	<20160418170534-mutt-send-email-mst@redhat.com>
	<1460992923.3765.8.camel@infradead.org>
	<20160418182320-mutt-send-email-mst@redhat.com>
	<1460994701.3765.23.camel@infradead.org>
	<20160418190203-mutt-send-email-mst@redhat.com>
	<1461004173.3765.73.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1461004173.3765.73.camel@infradead.org>
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
Cc: Wei Liu <wei.liu2@citrix.com>, Andy Lutomirski <luto@kernel.org>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, peterx@redhat.com, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 18, 2016 at 11:29 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> For x86, you *can* enable virtio-behind-IOMMU if your DMAR tables tell
> the truth, and even legacy kernels ought to cope with that.
> FSVO 'ought to' where I suspect some of them will actually crash with a
> NULL pointer dereference if there's no "catch-all" DMAR unit in the
> tables, which puts it back into the same camp as ARM and Power.

I think x86 may get a bit of a free pass here.  AFAIK the QEMU IOMMU
implementation on x86 has always been "experimental", so it just might
be okay to change it in a way that causes some older kernels to OOPS.

--Andy
