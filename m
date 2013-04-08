From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V3 1/2] tcm_vhost: Use vq->private_data to indicate if
	the endpoint is setup
Date: Mon, 08 Apr 2013 14:09:24 -0700
Message-ID: <1365455364.24346.89.camel__32035.8521458276$1365455381$gmane$org@haakon2.linux-iscsi.org>
References: <1364969858-9410-1-git-send-email-asias@redhat.com>
	<1364969858-9410-2-git-send-email-asias@redhat.com>
	<20130408071008.GB18339@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130408071008.GB18339@redhat.com>
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

On Mon, 2013-04-08 at 10:10 +0300, Michael S. Tsirkin wrote:
> On Wed, Apr 03, 2013 at 02:17:37PM +0800, Asias He wrote:
> > Currently, vs->vs_endpoint is used indicate if the endpoint is setup or
> > not. It is set or cleared in vhost_scsi_set_endpoint() or
> > vhost_scsi_clear_endpoint() under the vs->dev.mutex lock. However, when
> > we check it in vhost_scsi_handle_vq(), we ignored the lock.
> > 
> > Instead of using the vs->vs_endpoint and the vs->dev.mutex lock to
> > indicate the status of the endpoint, we use per virtqueue
> > vq->private_data to indicate it. In this way, we can only take the
> > vq->mutex lock which is per queue and make the concurrent multiqueue
> > process having less lock contention. Further, in the read side of
> > vq->private_data, we can even do not take the lock if it is accessed in
> > the vhost worker thread, because it is protected by "vhost rcu".
> > 
> > Signed-off-by: Asias He <asias@redhat.com>
> 
> Not strictly 3.9 material itself but needed for the next one.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 

Applied to target-pending/master with a small change to
s/VHOST_FEATURES/VHOST_SCSI_FEATURES

Thanks Asias and MST!

--nab
