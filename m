From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH v11 0/4] tcm_vhost hotplug
Date: Thu, 25 Apr 2013 01:19:43 -0700
Message-ID: <1366877983.23737.0.camel__19377.3636514836$1366877885$gmane$org@haakon3.risingtidesystems.com>
References: <1366875323-17639-1-git-send-email-asias@redhat.com>
	<20130425073938.GA7857@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130425073938.GA7857@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-04-25 at 10:39 +0300, Michael S. Tsirkin wrote:
> On Thu, Apr 25, 2013 at 03:35:19PM +0800, Asias He wrote:
> > Changes in v11
> > - Drop change log histroy in commit log
> > 
> > Changes in v10
> > - Drop comments about lun
> > - Add Enable VIRTIO_SCSI_F_HOTPLUG to this series
> > 
> > Changes in v9
> > - Drop tcm_vhost_check_feature
> > - Add Refactor the lock nesting rule to this sereis
> > 
> > Asias He (4):
> >   tcm_vhost: Refactor the lock nesting rule
> >   tcm_vhost: Add hotplug/hotunplug support
> >   tcm_vhost: Add ioctl to get and set events missed flag
> >   tcm_vhost: Enable VIRTIO_SCSI_F_HOTPLUG
> > 
> >  drivers/vhost/tcm_vhost.c | 262 +++++++++++++++++++++++++++++++++++++++++++---
> >  drivers/vhost/tcm_vhost.h |  13 +++
> >  2 files changed, 259 insertions(+), 16 deletions(-)
> 
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 

Applied to target-pending/for-next.

Nice work Asias & MST !

--nab
