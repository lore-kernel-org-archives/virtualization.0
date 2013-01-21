From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH 0/5] vhost-scsi: Add support for host virtualized target
Date: Mon, 21 Jan 2013 07:28:58 -0600
Message-ID: <87k3r6k6lh.fsf@codemonkey.ws>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<20130117164314.GA19458@redhat.com>
	<1358456841.18551.48.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358456841.18551.48.camel@haakon2.linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

"Nicholas A. Bellinger" <nab@linux-iscsi.org> writes:

> Hi MST & Co,
>
> On Thu, 2013-01-17 at 18:43 +0200, Michael S. Tsirkin wrote:
>> On Fri, Sep 07, 2012 at 06:48:14AM +0000, Nicholas A. Bellinger wrote:
>> > From: Nicholas Bellinger <nab@linux-iscsi.org>
>> > 
>> > Hello Anthony & Co,
>> > 
>> > This is the fourth installment to add host virtualized target support for
>> > the mainline tcm_vhost fabric driver using Linux v3.6-rc into QEMU 1.3.0-rc.
>> > 
>> > The series is available directly from the following git branch:
>> > 
>> >    git://git.kernel.org/pub/scm/virt/kvm/nab/qemu-kvm.git vhost-scsi-for-1.3
>> > 
>> > Note the code is cut against yesterday's QEMU head, and dispite the name
>> > of the tree is based upon mainline qemu.org git code + has thus far been
>> > running overnight with > 100K IOPs small block 4k workloads using v3.6-rc2+
>> > based target code with RAMDISK_DR backstores.
>> > 
>> > Other than some minor fuzz between jumping from QEMU 1.2.0 -> 1.2.50, this
>> > series is functionally identical to what's been posted for vhost-scsi RFC-v3
>> > to qemu-devel.
>> > 
>> > Please consider applying these patches for an initial vhost-scsi merge into
>> > QEMU 1.3.0-rc code, or let us know what else you'd like to see addressed for
>> > this series to in order to merge.
>> > 
>> > Thank you!
>> > 
>> > --nab
>> 
>> OK what's the status here?
>> We missed 1.3 but let's try not to miss 1.4?
>> 
>
> Unfortunately, I've not been able to get back to the conversion
> requested by Paolo for a standalone vhost-scsi PCI device.

Is your git repo above up to date?  Perhaps I can find someone to help
out..

> At this point my hands are still full with iSER-target for-3.9 kernel
> code over the next weeks.  
>
> What's the v1.4 feature cut-off looking like at this point..?

Hard freeze is on february 1st but 1.5 opens up again on the 15th.  So
the release windows shouldn't have a major impact on merging...

Regards,

Anthony Liguori

>
> --nab
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
