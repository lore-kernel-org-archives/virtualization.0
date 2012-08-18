From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [RFC-v2 3/6] vhost-scsi: add -vhost-scsi host device for use
	with tcm-vhost
Date: Sat, 18 Aug 2012 16:38:12 -0700
Message-ID: <1345333092.25161.369.camel__9120.01394103772$1345333106$gmane$org@haakon2.linux-iscsi.org>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-4-git-send-email-nab@linux-iscsi.org>
	<20120813085929.GI14081@redhat.com>
	<1344978749.22433.116.camel@haakon2.linux-iscsi.org>
	<20120818191028.GA17770@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120818191028.GA17770@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2012-08-18 at 22:10 +0300, Michael S. Tsirkin wrote:
> On Tue, Aug 14, 2012 at 02:12:29PM -0700, Nicholas A. Bellinger wrote:
> > On Mon, 2012-08-13 at 11:59 +0300, Michael S. Tsirkin wrote:
> > > On Mon, Aug 13, 2012 at 08:35:14AM +0000, Nicholas A. Bellinger wrote:

<SNIP>

> > 
> > > > +    if (ret < 0) {
> > > > +        fprintf(stderr, "vhost-scsi: vhost initialization failed: %s\n",
> > > > +                strerror(-ret));
> > > 
> > > errors should go to monitor, here and elsewhere.
> > > 
> > 
> > I think this means using monitor_printf() right..?
> > 
> > Looking at that now..
> 
> 
> error_report is handier.
> 

Converted all fprintf(stderr, ...) -> error_report() usage for RFC-v3.

Thanks MST!
