From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH v3 kernel 0/7] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Thu, 1 Sep 2016 12:30:20 +0800
Message-ID: <CANRm+Cy=p8PKg8HqRp7apU0D9X=gpnrahtXRq+S+5Gq863VO8g__48308.6500004449$1472704232$gmane$org@mail.gmail.com>
References: <1470638134-24149-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1470638134-24149-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm <kvm@vger.kernel.org>, dave.hansen@intel.com, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

2016-08-08 14:35 GMT+08:00 Liang Li <liang.z.li@intel.com>:
> This patch set contains two parts of changes to the virtio-balloon.
>
> One is the change for speeding up the inflating & deflating process,
> the main idea of this optimization is to use bitmap to send the page
> information to host instead of the PFNs, to reduce the overhead of
> virtio data transmission, address translation and madvise(). This can
> help to improve the performance by about 85%.
>
> Another change is for speeding up live migration. By skipping process
> guest's free pages in the first round of data copy, to reduce needless
> data processing, this can help to save quite a lot of CPU cycles and
> network bandwidth. We put guest's free page information in bitmap and
> send it to host with the virt queue of virtio-balloon. For an idle 8GB
> guest, this can help to shorten the total live migration time from 2Sec
> to about 500ms in the 10Gbps network environment.

I just read the slides of this feature for recent kvm forum, the cloud
providers more care about live migration downtime to avoid customers'
perception than total time, however, this feature will increase
downtime when acquire the benefit of reducing total time, maybe it
will be more acceptable if there is no downside for downtime.

Regards,
Wanpeng Li
