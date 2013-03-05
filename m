From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] tcm_vhost: Add hotplug/hotunplug support
Date: Tue, 05 Mar 2013 17:31:00 +0800
Message-ID: <5135BB54.8040803@cn.fujitsu.com>
References: <1362475027-12018-1-git-send-email-asias@redhat.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362475027-12018-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/05/2013 05:17 PM, Asias He wrote:
> In commit 365a7150094 ([SCSI] virtio-scsi: hotplug support for
> virtio-scsi), hotplug support is added to virtio-scsi.
> 
> This patch adds hotplug and hotunplug support to tcm_vhost.
> 
> You can create or delate a LUN in targetcli to hotplug or hotplug a LUN

		   s/delate/delete/			   s/hotplug/hotunplug/

> in guest.
