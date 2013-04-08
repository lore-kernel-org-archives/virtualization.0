From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V2 0/3] tcm_vhost pending requests flush
Date: Mon, 08 Apr 2013 14:33:59 -0700
Message-ID: <1365456839.24346.99.camel@haakon2.linux-iscsi.org>
References: <1363935329-11796-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363935329-11796-1-git-send-email-asias@redhat.com>
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

On Fri, 2013-03-22 at 14:55 +0800, Asias He wrote:
> Changes in v2:
> - Increase/Decrease inflight requests in
>   vhost_scsi_{allocate,free}_cmd and tcm_vhost_{allocate,free}_evt
> 
> Asias He (3):
>   tcm_vhost: Wait for pending requests in vhost_scsi_flush()
>   tcm_vhost: Wait for pending requests in vhost_scsi_clear_endpoint()
>   tcm_vhost: Fix tv_cmd leak in vhost_scsi_handle_vq
> 
>  drivers/vhost/tcm_vhost.c | 131 ++++++++++++++++++++++++++++++++++++++--------
>  drivers/vhost/tcm_vhost.h |   4 ++
>  2 files changed, 112 insertions(+), 23 deletions(-)
> 

Ditto on this one as v3.10 material.  There is 2 weeks left before the
window opens, which should be enough time to settle on this..

MST, please review.

--nab
