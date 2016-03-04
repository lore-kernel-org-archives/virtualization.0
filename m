From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [RFC qemu 2/4] virtio-balloon: Add a new feature to balloon device
Date: Fri, 4 Mar 2016 02:29:19 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E03770F7C@SHSMSX101.ccr.corp.intel.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<1457001868-15949-3-git-send-email-liang.z.li@intel.com>
	<20160303125651.GA21382@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160303125651.GA21382@redhat.com>
Content-Language: en-US
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [RFC qemu 2/4] virtio-balloon: Add a new feature to balloon
> device
> 
> On Thu, Mar 03, 2016 at 06:44:26PM +0800, Liang Li wrote:
> > Extend the virtio balloon device to support a new feature, this new
> > feature can help to get guest's free pages information, which can be
> > used for live migration optimzation.
> >
> > Signed-off-by: Liang Li <liang.z.li@intel.com>
> 
> I don't understand why we need a new interface.
> Balloon already sends free pages to host.
> Just teach host to skip these pages.
> 

I just make use the current virtio-balloon implementation,  it's more complicated to
invent a new virtio-io device...
Actually, there is no need to inflate the balloon before live migration, so the host has
no information about the guest's free pages, that's why I add a new one.

> Maybe instead of starting with code, you should send a high level description
> to the virtio tc for consideration?
> 
> You can do it through the mailing list or using the web form:
> http://www.oasis-
> open.org/committees/comments/form.php?wg_abbrev=virtio
> 

Thanks for your information and suggestion.

Liang
