From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/4] tcm_vhost lock and flush fix
Date: Tue, 12 Mar 2013 09:26:42 +0100
Message-ID: <513EE6C2.1060003@redhat.com>
References: <1363056171-5854-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363056171-5854-1-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 12/03/2013 03:42, Asias He ha scritto:
> Asias He (4):
>   tcm_vhost: Add missed lock in vhost_scsi_clear_endpoint()
>   tcm_vhost: Introduce tcm_vhost_check_endpoint()
>   tcm_vhost: Fix vs->vs_endpoint checking in vhost_scsi_handle_vq()
>   tcm_vhost: Flush vhost_work in vhost_scsi_flush()
> 
>  drivers/vhost/tcm_vhost.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Patch 1, 2, 4:

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
