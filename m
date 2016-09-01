From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v3 kernel 0/7] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Thu, 1 Sep 2016 05:46:40 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A01C59B@shsmsx102.ccr.corp.intel.com>
References: <1470638134-24149-1-git-send-email-liang.z.li@intel.com>
	<CANRm+Cy=p8PKg8HqRp7apU0D9X=gpnrahtXRq+S+5Gq863VO8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CANRm+Cy=p8PKg8HqRp7apU0D9X=gpnrahtXRq+S+5Gq863VO8g@mail.gmail.com>
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
To: Wanpeng Li <kernellwp@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, kvm <kvm@vger.kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [PATCH v3 kernel 0/7] Extend virtio-balloon for fast (de)inflating
> & fast live migration
> 
> 2016-08-08 14:35 GMT+08:00 Liang Li <liang.z.li@intel.com>:
> > This patch set contains two parts of changes to the virtio-balloon.
> >
> > One is the change for speeding up the inflating & deflating process,
> > the main idea of this optimization is to use bitmap to send the page
> > information to host instead of the PFNs, to reduce the overhead of
> > virtio data transmission, address translation and madvise(). This can
> > help to improve the performance by about 85%.
> >
> > Another change is for speeding up live migration. By skipping process
> > guest's free pages in the first round of data copy, to reduce needless
> > data processing, this can help to save quite a lot of CPU cycles and
> > network bandwidth. We put guest's free page information in bitmap and
> > send it to host with the virt queue of virtio-balloon. For an idle 8GB
> > guest, this can help to shorten the total live migration time from
> > 2Sec to about 500ms in the 10Gbps network environment.
> 
> I just read the slides of this feature for recent kvm forum, the cloud
> providers more care about live migration downtime to avoid customers'
> perception than total time, however, this feature will increase downtime
> when acquire the benefit of reducing total time, maybe it will be more
> acceptable if there is no downside for downtime.
> 
> Regards,
> Wanpeng Li

In theory, there is no factor that will increase the downtime. There is no additional operation
and no more data copy during the stop and copy stage. But in the test, the downtime increases
and this can be reproduced. I think the busy network line maybe the reason for this. With this
 optimization, a huge amount of data is written to the socket in a shorter time, so some of the write
operation may need to wait. Without this optimization, zero page checking takes more time,
the network is not so busy.

If the guest is not an idle one, I think the gap of the downtime will not so obvious.  Anyway, the
downtime is still less than the  max_down_time set by the user.

Thanks!
Liang
