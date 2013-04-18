From: Asias He <asias@redhat.com>
Subject: Re: [PATCH v5 0/3] tcm_vhost hotplug
Date: Thu, 18 Apr 2013 09:09:15 +0800
Message-ID: <20130418010915.GA1319@hj.localdomain>
References: <1365497499-9172-1-git-send-email-asias@redhat.com>
	<1365808250.26011.68.camel@haakon2.linux-iscsi.org>
	<20130417131726.GA26157@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130417131726.GA26157@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 17, 2013 at 04:17:26PM +0300, Michael S. Tsirkin wrote:
> On Fri, Apr 12, 2013 at 04:10:50PM -0700, Nicholas A. Bellinger wrote:
> > Hi MST,
> > 
> > Ping on this series for use with vhost-scsi-pci code..?
> > 
> > They will need to be heading into target-pending/for-next soon to make
> > the v3.10 window opening in t-minus 9 days.  ;)
> > 
> > --nab
> > 
> > On Tue, 2013-04-09 at 16:51 +0800, Asias He wrote:
> > > Asias He (3):
> > >   tcm_vhost: Introduce tcm_vhost_check_feature()
> > >   tcm_vhost: Add helper to check if endpoint is setup
> > >   tcm_vhost: Add hotplug/hotunplug support
> > > 
> > >  drivers/vhost/tcm_vhost.c | 236 +++++++++++++++++++++++++++++++++++++++++++++-
> > >  drivers/vhost/tcm_vhost.h |  10 ++
> > >  2 files changed, 242 insertions(+), 4 deletions(-)
> > > 
> 
> Okay, Paolo says it's now a sure thing we'll use it in qemu, in fact in
> 1.5, so let's cross the fingers and start merging new code.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Nicholas, please take v7. It contains one hunk belongs to this series.

-- 
Asias
