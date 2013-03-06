From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Add hotplug/hotunplug support
Date: Wed, 6 Mar 2013 09:29:31 +0800
Message-ID: <20130306012931.GB20372__360.928549389605$1362533405$gmane$org@hj.localdomain>
References: <1362475027-12018-1-git-send-email-asias@redhat.com>
	<5135BB54.8040803@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5135BB54.8040803@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 05, 2013 at 05:31:00PM +0800, Wanlong Gao wrote:
> On 03/05/2013 05:17 PM, Asias He wrote:
> > In commit 365a7150094 ([SCSI] virtio-scsi: hotplug support for
> > virtio-scsi), hotplug support is added to virtio-scsi.
> > 
> > This patch adds hotplug and hotunplug support to tcm_vhost.
> > 
> > You can create or delate a LUN in targetcli to hotplug or hotplug a LUN
> 
> 		   s/delate/delete/			   s/hotplug/hotunplug/

Thanks. Wrote it too fast ;-)

> > in guest.
> 

-- 
Asias
